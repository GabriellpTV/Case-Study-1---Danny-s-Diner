WITH sales_points AS (
	SELECT
		sales.customer_id,
        sales.order_date,
        sales.product_id,
        menu.product_name,
        menu.price,
        CASE
			WHEN menu.product_name = 'sushi' THEN menu.price * 20
            WHEN sales.customer_id = members.customer_id AND sales.order_date >= members.join_date AND sales.order_date < members.join_date + 7 THEN menu.price * 20
            ELSE menu.price * 10
		END AS points
        FROM sales
		JOIN menu ON sales.product_id = menu.product_id
        JOIN members ON sales.customer_id = members.customer_id
)
SELECT 
    customer_id,
    SUM(points) AS total_points
FROM sales_points
WHERE MONTH(order_date) IN (1)
GROUP BY customer_id
ORDER BY customer_id
