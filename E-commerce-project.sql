
CREATE DATABASE ecommerce_analysis;

CREATE TABLE orders (
order_id VARCHAR(20),
order_date DATE,
customer_name VARCHAR(100),
region VARCHAR(50),
product_name VARCHAR(200),
category VARCHAR(50),
quantity INT,
sales DECIMAL(10,2),
profit DECIMAL(10,2)
);


SELECT *
FROM orders;

SELECT SUM(sales) AS total_sales
FROM orders;

# catogrioeswise sales
SELECT category,
SUM(sales) AS total_sales
FROM orders
GROUP BY category
ORDER BY total_sales DESC;

SELECT region,
SUM(profit) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_profit DESC;

# finde that top selling products

SELECT Product_name,
SUM(quantity) AS total_quantity
FROM orders
GROUP BY Product_name
ORDER BY total_quantity DESC
LIMIT 10;

# lets check montly sales
SELECT
MONTH(order_date) AS month,
SUM(sales) AS monthly_sales
FROM orders
GROUP BY month
ORDER BY month;

# finde top 5 profitable product
SELECT product_name,
SUM(profit) AS profit
FROM orders
GROUP BY product_name
ORDER BY profit DESC
LIMIT 5;


DELIMITER $$
CREATE PROCEDURE GetRegionSales()
BEGIN
SELECT region, SUM(sales) AS total_sales
FROM orders
GROUP BY region;
END $$
DELIMITER ;

CALL GetRegionSales();


# finde how customer ordered
SELECT 
o.order_id,
c.customer_name,
c.region,
o.product_name,
o.sales
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;

# rise wise top sales
SELECT 
c.region,
SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.region;