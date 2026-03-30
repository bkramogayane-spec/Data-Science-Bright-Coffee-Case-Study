-----1.Shows all the data columns to view the first 100 rows of the table
select * from `workspace`.`default`.`1771947830706_bright_coffee_shop_sales` limit 100;

------2. Show the distinct store location
SELECT DISTINCT store_location
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

-------3. Selecting specific columns
SELECT product_category,
       product_type,
       store_location
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;
------4. Using a column Alias
SELECT product_category AS Type_of_product,
       unit_price AS Price_Of_Product
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

-----Practical code 
-- I want to see my table in the coding to start exploryting each column
SELECT *
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;
LIMIT 10;
------------------------------------------------
-- 1. Checking the Date Range
-------------------------------------------------
-- They started collecting the data 2023-01-01
SELECT MIN(transaction_date) AS min_date 
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

-- the duration of the data is 6 months
--  They last collected the data 2023-06-30
SELECT MAX(transaction_date) AS latest_date 
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;
-------------------------------------------------
-- 2. Checking the names of the different stores
------------------------------------------------
-- we have 3 stores and their names are Lower Manhattan, Hell's Kitchen, Astoria
SELECT DISTINCT store_location
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

SELECT COUNT(DISTINCT store_id) AS number_of_stores
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;
-------------------------------------------------
-- 3. Checking products sold at our stores 
------------------------------------------------
SELECT DISTINCT product_category
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

SELECT DISTINCT product_detail
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

SELECT DISTINCT product_type
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

SELECT DISTINCT product_category AS category,
                product_detail AS product_name
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

--- Top 10 Best‑Selling Products
SELECT 
  product_detail,
  SUM(transaction_qty) AS units_sold,
  SUM(CAST(unit_price AS DOUBLE) * transaction_qty) AS Revenue
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`
GROUP BY product_detail
ORDER BY revenue DESC
LIMIT 10;

-------------------------------------------------
-- 1. Checking product prices
------------------------------------------------
SELECT MIN(unit_price) As cheapest_price
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

SELECT MAX(unit_price) As expensive_price
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

------------------------------------------------
SELECT 
COUNT(*) AS number_of_rows,
      COUNT(DISTINCT transaction_id) AS number_of_sales,
      COUNT(DISTINCT product_id) AS number_of_products,
      COUNT(DISTINCT store_id) AS number_of_stores
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

------------------------------------------------
SELECT *
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`
LIMIT 10;

SELECT transaction_id,
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      SUM(transaction_qty * unit_price) AS revenue_per_tnx
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

-----------------------------------------------------
SELECT COUNT(*)
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`;

SELECT 
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      COUNT(DISTINCT transaction_id) AS Number_of_sales,
      SUM(CAST(unit_price AS DOUBLE) * transaction_qty) AS Revenue
      
---Day Classification
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`
GROUP BY 
         transaction_date,
         Dayname(transaction_date),
         Monthname(transaction_date);

SELECT
  transaction_time,
  typeof(transaction_time)
FROM `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`
LIMIT 5;

--- Final Code
Select transaction_date,
       dayname(transaction_date) AS day_name,
       CASE
       WHEN dayname(transaction_date) IN ('Sun','Sat') THEN 'Weekend'
       ELSE 'Weekday'
       END AS day_classification,
       MONTHNAME(transaction_date) AS month_name,
       
       transaction_time,
       CASE
         WHEN date_format(transaction_time, 'HH:mm:ss') < '06:00:00' THEN 'Early Morning'
         WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '06:00:00' AND '08:59:59' THEN 'Morning'
         WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '09:00:00' AND '11:59:59' THEN 'MidDay'
         WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '14:59:59' THEN 'Noon'
         WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '15:00:00' AND '17:59:59' THEN 'Afternoon'
         WHEN date_format(transaction_time, 'HH:mm:ss') >= '18:00:00' THEN 'Evening'
         ELSE 'Unknown'
       END AS time_classification,
       ---HOUR(transaction_time) AS hour_of_day,
       store_location,
       product_category,
       product_detail,
       product_type,

       ---ID's
       COUNT(DISTINCT transaction_id) AS number_of_sales,
       ---Revenue calculation
       SUM(CAST(unit_price AS DOUBLE) * transaction_qty) AS Revenue,

---Daily revenue bucket
CASE
  WHEN SUM(CAST(unit_price AS DOUBLE) * transaction_qty) < 100 THEN 'Low Day'
  WHEN SUM(CAST(unit_price AS DOUBLE) * transaction_qty) BETWEEN 100 AND 299 THEN 'Medium Day'
  WHEN SUM(CAST(unit_price AS DOUBLE) * transaction_qty) BETWEEN 300 AND 499 THEN 'High Day'
  WHEN SUM(CAST(unit_price AS DOUBLE) * transaction_qty) >= 500 THEN 'Very High Day'
END AS daily_spending_bucket
       
From `workspace`.`default`.`1771947830706_bright_coffee_shop_sales`
GROUP BY ALL;
