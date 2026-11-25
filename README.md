# Amazon Sales Data Analysis (MySQL and Power BI)

Analysis of an Amazon product dataset (prices in Indian rupees, from amazon.in product pages). The data is loaded into MySQL, queried with SQL, and summarized in a Power BI dashboard.

## Dataset
- `amazon_raw.csv`: raw data, 1,465 lines and 16 columns (product, category path, prices, discount, rating, rating count, product description, user reviews, links).
- `amazon_cleaned.csv`: cleaned data, 1,463 rows and 8 columns: `product_id`, `product_name`, `Main_Category`, `discounted_price`, `actual_price`, `discount_percentage`, `rating`, `rating_count`. Prices are plain numbers (no currency symbol) and the category path is reduced to its main category.

## SQL analysis (`amazon_analysis.sql`)
Loads the cleaned CSV into a MySQL table (`amazon_cleaned`) and answers:
- Which main categories have the most products
- Average discounted price per main category
- The 5 highest-priced products
- The most-rated products, and the best-rated products with more than 1,000 ratings
- The 5 biggest discounts

## Power BI dashboard (`Amazon_Sales_Dashboard.pbix`, `Amazon_Sales_Dashboard.pdf`, `dashboard_preview.png`)
Key figures shown in the dashboard:
| Measure | Value |
|---|---|
| Products (distinct) | 1,349 |
| Average discounted price | 3.13K |
| Average rating | 4.10 |
| Average discount | 47.65% |

Products per main category: Electronics 526, Computers&Accessories 451, Home&Kitchen 448 (these three make up almost all rows), then OfficeProducts 31.
The dashboard also shows the top 5 rated products, average discounted price by category, and the most popular products by rating count.

## Tools
MySQL, Power BI, Excel/CSV.

## Author
Saif Eldeen Mohamed
