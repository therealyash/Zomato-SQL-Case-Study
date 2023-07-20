# Zomato-SQL-Case-Study
Zomato SQL Case Study

### Case Study: Improving Operational Efficiency at Zomato Using SQL

#### Introduction:
Zomato is a leading online food delivery and restaurant aggregator platform, serving millions of customers worldwide. As the company expands, it faces challenges in managing the massive amount of data generated from orders, deliveries, and customer interactions. To optimize its operations and enhance customer experience, Zomato aims to leverage SQL (Structured Query Language) to analyze and manipulate data efficiently.

#### Objective:
The primary objective of this case study is to explore how SQL can be utilized to improve operational efficiency at Zomato. We will focus on specific business scenarios and provide SQL queries to address the questions raised.

![png-transparent-zomato-hd-logo](https://github.com/therealyash/Zomato-SQL-Case-Study/assets/114616305/f6021ba4-7b3a-4f16-bcbf-bc63d9eb6535)

### 1. Find customers who have never ordered. 
```
SELECT name 
FROM users
WHERE user_id NOT IN (SELECT user_id FROM orders)
```

### 2. Average Price/Dish
```
SELECT f_name, ROUND(AVG(price),2) AS 'avg_price'
FROM menu m
JOIN food f
ON m.f_id = f.f_id
GROUP BY 1
ORDER BY 2 DESC
```
### 3. Find top restaurants in terms of orders for a given month
```
SELECT r_name, COUNT(order_id) AS orders
FROM restaurants r
JOIN orders o 
ON r.r_id = o.r_id
WHERE MONTHNAME(date) = 'June'
GROUP BY r_name
ORDER BY 2 DESC
LIMIT 1
```
### 4. Restaurants with monthly sales > x for
```
SELECT r_name, SUM(amount) AS revenue
FROM orders o
JOIN restaurants r
ON o.r_id = r.r_id
WHERE MONTHNAME(date) LIKE 'July' 
GROUP BY 1
HAVING SUM(amount) > 499
ORDER BY 2 DESC
```
### 5. Show all with order details for a particular customer in a particular date range
```
SELECT o.order_id, r.r_name, f.f_name
FROM orders o
JOIN restaurants r
ON o.r_id = r.r_id
JOIN order_details od
ON od.order_id = o.order_id
JOIN food f
ON f.f_id = od.f_id
WHERE user_id = (SELECT user_id FROM users
                 WHERE name LIKE 'Ankit')
AND date > '2022-06-10' AND date < '2022-07-10'
```

### 6. Find restaurants with max repeated customers

```
SELECT t.r_id, r.r_name, COUNT(*) AS 'loyal customers'
FROM 
      (
            SELECT r_id, user_id, COUNT(*) AS 'visits'
            FROM orders
            GROUP BY r_id, user_id
            HAVING visits > 1
      ) t
JOIN restaurants r 
ON r.r_id = t.r_id
GROUP BY 1,2
ORDER BY 2 DESC LIMIT 1
```
### 7. Month over month revenue of Zomato
```
SELECT month, ((revenue - previous)/previous)*100 AS 'growth'
FROM 
(

      WITH sales AS 
(
      SELECT MONTHNAME(date) AS 'month', SUM(amount) AS revenue
      FROM orders
      GROUP BY 1
      ORDER BY MONTH(date)
)
SELECT month, revenue, LAG(revenue, 1) OVER(ORDER BY revenue) AS 'previous' FROM sales
) t
```
8. Customer -> favourite food
```
WITH temp AS
(
      SELECT o.user_id, od.f_id, COUNT(*) AS frequency
      FROM orders o 
      JOIN order_details od 
      ON o.order_id = od.order_id
      GROUP BY o.user_id, od.f_id

)

SELECT u.user_id, u.name, f.f_name, t1.frequency FROM temp t1
JOIN users u 
ON u.user_id = t1.user_id
JOIN food f 
ON f.f_id = t1.f_id
WHERE t1.frequency = 
(
      SELECT MAX(frequency) 
      FROM temp t2 
      WHERE t2.user_id = t1.user_id
)
```
#### Conclusion:
Through this case study, we aim to demonstrate the power of SQL in helping Zomato make data-driven decisions, optimize operations, and enhance customer satisfaction. By leveraging SQL to answer the provided questions, Zomato can gain valuable insights into their business and implement strategies to further improve their services, drive growth, and stay competitive in the dynamic food delivery industry.
