USE pizza_db;

-- -------------------------------------------------------------
-- 1. TOTAL REVENUE
-- -------------------------------------------------------------
SELECT ROUND(SUM(total_price), 2) AS total_revenue 
FROM pizza_sales;

-- -------------------------------------------------------------
-- 2. AVERAGE ORDER VALUE (AOV)
-- -------------------------------------------------------------
SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS avg_order_value 
FROM pizza_sales;

-- -------------------------------------------------------------
-- 3. TOTAL PIZZAS SOLD
-- -------------------------------------------------------------
SELECT SUM(quantity) AS total_pizzas_sold 
FROM pizza_sales;

-- -------------------------------------------------------------
-- 4. TOTAL ORDERS
-- -------------------------------------------------------------
SELECT COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales;

-- -------------------------------------------------------------
-- 5. AVERAGE PIZZAS PER ORDER
-- -------------------------------------------------------------
SELECT ROUND(SUM(quantity) / COUNT(DISTINCT order_id), 2) AS avg_pizzas_per_order 
FROM pizza_sales;

-- -------------------------------------------------------------
-- 6. DAILY TREND
-- -------------------------------------------------------------
SELECT 
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date)
ORDER BY total_orders DESC;

-- -------------------------------------------------------------
-- 7. HOURLY TREND
-- -------------------------------------------------------------
SELECT 
    HOUR(order_time) AS order_hour,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY order_hour;

-- -------------------------------------------------------------
-- 8. % of Sales by Pizza Size
-- -------------------------------------------------------------

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


-- -------------------------------------------------------------
-- 9. PERCENTAGE OF SALES BY CATEGORY
-- -------------------------------------------------------------
SELECT 
    pizza_category,
    ROUND(SUM(total_price), 2) AS total_sales,
    ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS pct_of_sales
FROM pizza_sales
GROUP BY pizza_category
ORDER BY pct_of_sales DESC;


-- -------------------------------------------------------------
-- 10. Total Pizzas Sold by Pizza Category
-- -------------------------------------------------------------

SELECT 
    pizza_category, 
    SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- -------------------------------------------------------------
-- 11. TOP 5 BEST SELLERS
-- -------------------------------------------------------------
SELECT 
    pizza_name,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold DESC
LIMIT 5;

-- -------------------------------------------------------------
-- 12. BOTTOM 5 WORST SELLERS
-- -------------------------------------------------------------
SELECT 
    pizza_name,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold ASC
LIMIT 5;

-- -------------------------------------------------------------
-- 13. Filtered by Month (e.g., January = 1, April = 4)
-- -------------------------------------------------------------
SELECT 
    DAYNAME(order_date) AS order_day, 
    COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY DAYNAME(order_date)
ORDER BY total_orders DESC;

-- -------------------------------------------------------------
-- 14. Filtered by Quarter (e.g., Quarter 1 = 1, Quarter 3 = 3)
-- -------------------------------------------------------------
SELECT 
    DAYNAME(order_date) AS order_day, 
    COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
WHERE QUARTER(order_date) = 1
GROUP BY DAYNAME(order_date)
ORDER BY total_orders DESC;

-- -------------------------------------------------------------
-- 15. Filtered by Week (e.g., Week 1 to 52)
-- -------------------------------------------------------------
SELECT 
    DAYNAME(order_date) AS order_day, 
    COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
WHERE WEEK(order_date) = 1
GROUP BY DAYNAME(order_date)
ORDER BY total_orders DESC;