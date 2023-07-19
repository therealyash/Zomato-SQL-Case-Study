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
4. Restaurants with monthly sales > x for
5. Show all with order details for a particular customer in a particular date range
6. Find restaurants with max repeated customers
7. Month over month revenue of Zomato
8. Customer -> favourite food

Extra Questions

1. Find most loyal customers for all restaurants.
2. Month over month revenue growth of a restaurant
3. Most paired products



