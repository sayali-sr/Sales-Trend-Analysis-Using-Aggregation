CREATE TABLE onlinesales (
    customer_id VARCHAR,
    order_date TEXT,
    product_id VARCHAR,
    category_id VARCHAR,
    category_name TEXT,
    product_name TEXT,
    quantity INT,
    price NUMERIC,
    payment_method VARCHAR,
    city VARCHAR,
    review_score FLOAT,
    gender VARCHAR,
    age INT
);

SELECT * FROM onlinesales


-- Add year and month Columns
ALTER TABLE onlinesales
ADD COLUMN year INT,
ADD COLUMN mONTH INT;


-- Convert order_date to DATE

-- First, add a new column to hold the converted date
ALTER TABLE onlinesales
ADD COLUMN order_date_converted DATE;

-- Then update it by casting the text to DATE
UPDATE onlinesales
SET order_date_converted = TO_DATE(order_date, 'YYYY-MM-DD');


-- Extract Year and Month from the Converted Date
UPDATE onlinesales
SET 
    year = EXTRACT(YEAR FROM order_date_converted),
    month = EXTRACT(MONTH FROM order_date_converted);


-- Monthly Revenue & Order Volume
SELECT 
    year,
    month,
    SUM(price * quantity) AS total_revenue,
    COUNT(*) AS total_orders
FROM 
    onlinesales
GROUP BY 
    year, month
ORDER BY 
    year, month;


-- Top 3 months by revenue
SELECT 
    year,
    month,
    SUM(price * quantity) AS total_revenue
FROM 
    onlinesales
GROUP BY 
    year, month
ORDER BY 
    total_revenue DESC
LIMIT 3;


-- Monthly Average Review Score
SELECT 
    year,
    month,
    AVG(review_score) AS avg_review
FROM 
    onlinesales
WHERE 
    review_score IS NOT NULL
GROUP BY 
    year, month
ORDER BY 
    year, month;
	
	
-- Total Revenue by Payment Method (Monthly Breakdown)
SELECT 
    year,
    month,
    payment_method,
    SUM(price * quantity) AS total_revenue
FROM 
    onlinesales
GROUP BY 
    year, month, payment_method
ORDER BY 
    year, month, total_revenue DESC;
	
	
-- Top 5 Selling Products by Quantity (All Time)
SELECT 
    product_name,
    SUM(quantity) AS total_quantity_sold
FROM 
    onlinesales
GROUP BY 
    product_name
ORDER BY 
    total_quantity_sold DESC
LIMIT 5;


--  Monthly Unique Customers Count
SELECT 
    year,
    month,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM 
    onlinesales
GROUP BY 
    year, month
ORDER BY 
    year, month;
	
	
-- Average Order Value per Month
SELECT 
    year,
    month,
    SUM(price * quantity) / COUNT(DISTINCT order_date) AS avg_order_value
FROM 
    onlinesales
GROUP BY 
    year, month
ORDER BY 
    year, month;
	
	
-- Monthly Sales by Category
SELECT 
    year,
    month,
    category_name,
    SUM(price * quantity) AS total_category_sales
FROM 
    onlinesales
GROUP BY 
    year, month, category_name
ORDER BY 
    year, month, total_category_sales DESC;
	
	
-- Top 3 Revenue-Generating Cities Each Month
SELECT 
    year,
    month,
    city,
    SUM(price * quantity) AS total_revenue
FROM 
    onlinesales
GROUP BY 
    year, month, city
ORDER BY 
    year, month, total_revenue DESC;
	
	
-- Monthly Sales Volume by Gender
SELECT 
    year,
    month,
    gender,
    COUNT(DISTINCT customer_id) AS customer_count,
    SUM(price * quantity) AS total_sales
FROM 
    onlinesales
GROUP BY 
    year, month, gender
ORDER BY 
    year, month, gender;
	
	
