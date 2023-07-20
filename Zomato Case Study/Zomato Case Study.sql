Zomato Case Study

1. Find customers who have never ordered. 

SELECT name 
FROM users
WHERE user_id NOT IN (SELECT user_id FROM orders)

2. Average Price/Dish

SELECT f_name, ROUND(AVG(price),2) AS 'avg_price'
FROM menu m
JOIN food f
ON m.f_id = f.f_id
GROUP BY 1
ORDER BY 2 DESC

3. Find top restaurants in terms of orders for a given month

SELECT r_name, COUNT(order_id) AS orders
FROM restaurants r
JOIN orders o 
ON r.r_id = o.r_id
WHERE MONTHNAME(date) = 'June'
GROUP BY r_name
ORDER BY 2 DESC
LIMIT 1

4. Restaurants with monthly sales > x for

SELECT r_name, SUM(amount) AS revenue
FROM orders o
JOIN restaurants r
ON o.r_id = r.r_id
WHERE MONTHNAME(date) LIKE 'July' 
GROUP BY 1
HAVING SUM(amount) > 499
ORDER BY 2 DESC

5. Show all with order details for a particular customer in a particular date range

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

6. Find restaurants with max repeated customers

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

7. Month over month revenue of Zomato

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


8. Customer -> favourite food

Extra Questions

1. Find most loyal customers for all restaurants.
2. Month over month revenue growth of a restaurant
3. Most paired products



