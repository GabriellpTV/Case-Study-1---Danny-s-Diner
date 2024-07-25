SELECT customer_id, COUNT(DISTINCT order_date) AS number_of_visits
FROM sales
GROUP BY customer_id