# Report: Monthly Orders Product Aggregation

This repository contains SQL code for generating a monthly product sales report using the BigQuery public dataset `bigquery-public-data.thelook_ecommerce`.

## Purpose
The goal of this report is to aggregate sales data for each product on a monthly basis, allowing businesses to identify the best-performing products for each month.

## Query
Refer to the `report_monthly_orders_product_agg.sql` file for the SQL code.

## Output
- **order_month**: Month of the orders.
- **product_id**: ID of the product.
- **total_sales**: Total sales amount for the product in the given month.
- **total_orders**: Total number of orders for the product in the given month.

## Instructions
1. Open Google Cloud Console.
2. Load the SQL code in BigQuery.
3. Run the query to generate the report.

## Dataset
- Source: [Google BigQuery Public Dataset: The Look Ecommerce](https://console.cloud.google.com/marketplace/product/bigquery-public-data/thelook-ecommerce)


Penjelasan Kode
WITH monthly_orders_product_agg AS:

Membuat temporary table untuk menyimpan data agregasi bulanan berdasarkan produk.
Data ini akan digunakan untuk menghasilkan laporan penjualan.
FORMAT_TIMESTAMP('%Y-%m', TIMESTAMP(order_date)) AS order_month:

Mengonversi kolom order_date menjadi format YYYY-MM untuk pengelompokkan data berdasarkan bulan.
SUM(sale_price) AS total_sales:

Menghitung total penjualan (sale_price) per produk untuk setiap bulan.
COUNT(order_id) AS total_orders:

Menghitung total pesanan (order_id) per produk untuk setiap bulan.
JOIN:

Bergabung dengan tabel products untuk memastikan data yang relevan dari tabel produk diikutsertakan.
WHERE sale_price IS NOT NULL:

Hanya menyertakan data dengan nilai penjualan yang valid.
GROUP BY order_month, product_id:

Mengelompokkan data berdasarkan bulan (order_month) dan produk (product_id).
ORDER BY order_month, total_sales DESC:

Mengurutkan data berdasarkan bulan dan total penjualan tertinggi untuk memudahkan identifikasi produk terbaik.
