-- Mengambil laporan penjualan bulanan berdasarkan produk
WITH report_monthly_orders_product_agg AS (
    SELECT 
        EXTRACT(YEAR FROM o.created_at) AS order_year,  -- Mengambil tahun dari tanggal pesanan
        EXTRACT(MONTH FROM o.created_at) AS order_month, -- Mengambil bulan dari tanggal pesanan
        oi.product_id,                                     -- ID produk dari order_items
        p.name,                                          -- Nama produk dari products
        SUM(oi.quantity) AS total_quantity,              -- Menghitung total kuantitas yang terjual
        SUM(oi.price * oi.quantity) AS total_sales       -- Menghitung total penjualan (harga * kuantitas)
    FROM 
        `bigquery-public-data.thelook_ecommerce.orders` o  -- Mengakses tabel orders
    JOIN 
        `bigquery-public-data.thelook_ecommerce.order_items` oi  -- Mengakses tabel order_items
    ON 
        o.order_id = oi.order_id  -- Menghubungkan tabel orders dan order_items berdasarkan order_id
    JOIN 
        `bigquery-public-data.thelook_ecommerce.products` p  -- Mengakses tabel products
    ON 
        oi.product_id = p.id  -- Menghubungkan tabel order_items dan products berdasarkan product_id
    GROUP BY 
        order_year, order_month, oi.product_id, p.product_name  -- Mengelompokkan hasil berdasarkan tahun, bulan, ID produk, dan nama produk
)

-- Mengambil data dari CTE
SELECT *
FROM report_monthly_orders_product_agg
ORDER BY order_year, order_month, total_sales DESC;  -- Mengurutkan hasil berdasarkan tahun, bulan, dan total penjualan tertinggi
