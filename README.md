# BI_SQL_Project-
# Business Intelligence SQL Project – Customer Orders Analysis
This project demonstrates core **SQL skills** used in Business Intelligence (BI) roles

You’ll find end-to-end query examples using **PostgreSQL**, ranging from basic selects to advanced **window functions**, designed for business analytics.

##  Project Overview

The project is based on a fictional e-commerce scenario with the following tables:
- `customers`
- `products`
- `orders`

We answer business questions like:
- Who are the top customers by revenue?
- What are the monthly revenue trends?
- Which product categories perform best?
- What's the running total of revenue over time?

## 💡 Skills Covered

| Skill                | Concepts Used                               |
|---------------------|---------------------------------------------|
| SQL Basics           | SELECT, WHERE, ORDER BY, LIMIT              |
| Joins & Aggregation  | INNER JOIN, GROUP BY, HAVING                |
| Subqueries & Logic   | Subqueries, CASE, NULL handling             |
| Advanced Analytics   | ROW_NUMBER(), RANK(), SUM() OVER()         |
| BI Relevance         | Insights for dashboards and KPIs           |

## 🧪 Sample Query

### 🔹 Top 3 Products by Revenue
```sql
SELECT p.product_name, SUM(o.quantity * p.price) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 3;
