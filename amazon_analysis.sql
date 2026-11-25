USE amazon_db;

-- تفريغ الجدول من الداتا الناقصة
TRUNCATE TABLE amazon_cleaned;

-- سحب الملف كامل بالترميز الصح
LOAD DATA LOCAL INFILE "C:/Users/CompuMarts/Downloads/MYSQL Scripts/Amazon_Dataset/amazon_cleaned.csv"
INTO TABLE amazon_cleaned
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

ALTER TABLE amazon_cleaned
DROP COLUMN MyUnknownColumn;

Select *
from amazon_cleaned;

#What are the Most important main categories according to
#the number of products?

Select Main_category, Count(*) as total_products
from amazon_cleaned
group by Main_Category
Order by total_products desc
limit 5;

# Avg Prices after Discount
SELECT main_category, ROUND(AVG(discounted_price), 0) AS avg_price
FROM amazon_cleaned
GROUP BY main_category;

#Heighest-priced products

SELECT product_name, main_category, discounted_price
FROM amazon_cleaned
ORDER BY discounted_price DESC
LIMIT 5;

# The best rated products

SELECT product_name, rating_count, rating, discounted_price
FROM amazon_cleaned 
ORDER BY rating_count DESC 
LIMIT 5;

SELECT product_name, rating, rating_count, discounted_price 
FROM amazon_cleaned 
WHERE rating_count > 1000 
ORDER BY rating DESC, rating_count DESC 
LIMIT 5;

#The biggest Discount

SELECT product_name, actual_price, discounted_price, discount_percentage 
FROM amazon_cleaned 
ORDER BY discount_percentage DESC 
LIMIT 5;

#The Master View

SELECT main_category, 
       COUNT(product_id) AS total_products, 
       ROUND(AVG(rating), 1) AS avg_rating, 
       ROUND(AVG(discount_percentage), 0) AS avg_discount_percentage
FROM amazon_cleaned 
GROUP BY main_category;

SELECT 
    product_name, 
    main_category, 
    discounted_price,
    RANK() OVER(PARTITION BY main_category ORDER BY discounted_price DESC) as price_rank
FROM amazon_cleaned;

WITH StoreAverage AS (
    -- الجزء الأول: بنحسب متوسط السعر للمتجر كله
    SELECT AVG(discounted_price) AS overall_avg
    FROM amazon_cleaned
),
CategoryAverage AS (
    -- الجزء التاني: بنحسب متوسط السعر لكل قسم لوحده
    SELECT main_category, AVG(discounted_price) AS cat_avg
    FROM amazon_cleaned
    GROUP BY main_category
)
-- الجزء التالت: بنقارن الاتنين ببعض ونطلع النتيجة
SELECT c.main_category, ROUND(c.cat_avg, 2) AS category_average
FROM CategoryAverage c
JOIN StoreAverage s
ON c.cat_avg > s.overall_avg;