SELECT sales.customer_id, menu.product_name, MIN(sales.order_date)
FROM sales
JOIN menu ON sales.product_id = menu.product_id
WHERE sales.order_date = (
    SELECT MIN(order_date)
    FROM sales
    WHERE product_id = menu.product_id
)
GROUP BY customer_id, product_name
