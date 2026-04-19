-- ============================================
-- E-Commerce Sales Analysis Project
-- ============================================



-- ============================================
-- Analysis 1: Total Revenue
-- Question: What is the total revenue generated across all orders?
--
-- Insight:
-- Shows the overall revenue of the business. This is the main baseline
-- used to compare all other metrics.
-- ============================================
SELECT FORMAT(SUM(quantity * unit_price), 'C') AS Total_Revenue
FROM ecom;



-- ============================================
-- Analysis 2: Revenue by Product
-- Question: Which products generate the highest total revenue?
--
-- Insight:
-- Identifies top-performing products. These are the main drivers
-- of revenue and likely the most valuable items.
-- ============================================
SELECT product_id, product_name, FORMAT(SUM(quantity * unit_price), 'C') AS Item_Revenue
FROM ecom
GROUP BY product_id, product_name
ORDER BY SUM(quantity * unit_price) DESC;



-- ============================================
-- Analysis 3: Revenue by Category
-- Question: Which product categories contribute the most to overall revenue?
--
-- Insight:
-- Highlights which categories perform best. Helps understand where
-- most of the business revenue is coming from.
-- ============================================
SELECT category, FORMAT(SUM(quantity * unit_price), 'C') AS Item_Revenue
FROM ecom
GROUP BY category
ORDER BY SUM(quantity * unit_price) DESC;



-- ============================================
-- Analysis 4: Top Customers
-- Question: Which customers generate the highest total revenue?
--
-- Insight:
-- Shows which customer groups spend the most. Useful for targeting
-- high-value segments.
-- ============================================
SELECT age_group, FORMAT(SUM(quantity * unit_price), 'C') AS Item_Revenue
FROM ecom
GROUP BY age_group
ORDER BY SUM(quantity * unit_price) DESC;



-- ============================================
-- Analysis 5: Order Volume Over Time
-- Question: How does the number of orders change over time (monthly or yearly)?
--
-- Insight:
-- Tracks how order activity changes over time. Helps spot trends,
-- growth, or slow periods.
-- ============================================
SELECT FORMAT(order_date, 'yyyy-MM') AS year_month, COUNT(*) AS Num_Orders
FROM ecom
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY year_month ASC;



-- ============================================
-- Analysis 6: Revenue Over Time
-- Question: How does total revenue change over time?
--
-- Insight:
-- Shows how revenue changes each month. Useful for spotting
-- growth patterns or drops.
-- ============================================
SELECT FORMAT(order_date, 'yyyy-MM') AS year_month, FORMAT(SUM(quantity * unit_price), 'C') AS Revenue
FROM ecom
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY year_month ASC;



-- ============================================
-- Analysis 7: Average Order Value
-- Question: What is the average value of an order?
--
-- Insight:
-- Gives the average revenue per transaction. Helps understand
-- how much customers typically spend.
-- ============================================
SELECT FORMAT(AVG(quantity * unit_price), 'C') AS Avergae_Order_Revenue
FROM ecom;



-- ============================================
-- Analysis 8: Payment Method Analysis
-- Question: Which payment methods are used most frequently and generate the most revenue?
--
-- Insight:
-- Shows which payment methods are most common and which bring
-- in the most revenue.
-- ============================================
SELECT payment_method, COUNT(*) AS Count, FORMAT(SUM(quantity * unit_price), 'C') AS Payment_Revenue
FROM ecom
GROUP BY payment_method;



-- ============================================
-- Analysis 9: Customer Behavior
-- Question: How many customers place repeat orders versus one-time purchases?
--
-- Insight:
-- Compares one-time vs repeat customers. Helps understand
-- customer retention.
-- ============================================
WITH cte_name  AS (
    SELECT customer_id, COUNT(*) AS cnt
    FROM ecom
    GROUP BY customer_id
)
SELECT 
COUNT(CASE WHEN cnt = 1 THEN 1 END) AS One_Time, 
COUNT(CASE WHEN cnt > 1 THEN 1 END) AS Repeat_Purchases
FROM cte_name;



-- ============================================
-- Analysis 10: Product Performance
-- Question: Which products are high-volume but low-revenue, and vice versa?
--
-- Insight:
-- Compares how much products sell vs how much they earn.
-- Helps identify cheap fast sellers vs high-value items.
-- ============================================
SELECT product_name AS Product, SUM(quantity) AS Total, FORMAT(SUM(quantity * unit_price), 'C') AS Product_revenue
FROM ecom
GROUP BY product_name
ORDER BY SUM(quantity) DESC;