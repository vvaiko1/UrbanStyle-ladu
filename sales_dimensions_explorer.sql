-- DACA Week 1
-- Role: Sales Dimensions Explorer
-- UrbanStyle sales analysis

-- 1. Find all sales channels
SELECT DISTINCT channel
FROM sales;

-- 2. Find all store locations
SELECT DISTINCT store_location
FROM sales;

-- 3. Find all payment methods
SELECT DISTINCT payment_method
FROM sales;

-- 4. Show the 15 most expensive online sales
SELECT *
FROM sales
WHERE channel = 'online'
ORDER BY total_price DESC
LIMIT 15;

-- 5. Count transactions without a store location
SELECT COUNT(*) AS puuduv_asukoht
FROM sales
WHERE store_location IS NULL;