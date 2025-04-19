SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

--------------------------SQL Basics + Joins--------------------------

--List all orders with customer name and product name
SELECT o.order_id, c.name AS customer_name, p.product_name, o.order_date, o.quantity
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id

--Total sales amount for each order (price × quantity)
SELECT o.order_id, c.name AS customer_name, p.product_name,
       o.quantity, p.price, (o.quantity * p.price) AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id

--Total sales by each customer
SELECT c.name AS customer_name, SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC

--Total sales by city
SELECT c.city,SUM(o.quantity * p.price) AS total_sales
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.city
ORDER BY total_sales DESC

--Top 3 products by revenue
SELECT p.product_name,sum(o.quantity * p.price) AS revenue 
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY product_name
ORDER BY revenue DESC
limit 3

--Monthly revenue trends
SELECT 
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(o.quantity * p.price) AS monthly_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY month
ORDER BY month

--Customer who placed the highest order
SELECT 
    c.name AS customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1

--Most selling product category
SELECT 
    p.category,
    SUM(o.quantity) AS total_quantity_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_quantity_sold DESC
LIMIT 1

--------------- Subqueries, CASE & NULL Handling-----------------------

--SUBQUERIES: Find products sold above average price
SELECT product_name,price FROM products
WHERE price>(SELECT AVG(price) FROM products)

--CASE: Tag high/medium/low quantity orders
SELECT o.order_id,o.quantity,
       CASE
	       WHEN o.quantity >=4 THEN 'high'
		   WHEN o.quantity =2 OR o.quantity=3 THEN 'medium'
		   ELSE 'low'
	   END AS order_volume
FROM orders o

--Handle NULLs: Customers who haven’t placed any orders
SELECT c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL

--------------------------Window Functions------------------------------

--Rank customers by total purchase amount
SELECT c.name AS customer_name,
		SUM(o.quantity* p.price)AS total_spent,
		RANK() OVER(ORDER BY SUM(o.quantity* p.price) DESC)AS rank_by_spending
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name;

--ROW_NUMBER for each order by customer
SELECT 
		c.name AS customer_name,
		o.order_id,
		o.order_date,
		ROW_NUMBER() OVER(PARTITION BY c.customer_id ORDER BY o.order_date)AS order_number
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id

--Running total of revenue over time
SELECT 
    o.order_date,
    (o.quantity * p.price) AS order_revenue,
    SUM(o.quantity * p.price) OVER (ORDER BY o.order_date) AS running_total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id


