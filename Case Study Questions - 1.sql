SELECT sales.customer_id, sum(menu.price) AS total_amount
FROM sales
JOIN menu ON sales.product_id = menu.product_id
GROUP BY sales.customer_id
ORDER BY total_amount DESC; 