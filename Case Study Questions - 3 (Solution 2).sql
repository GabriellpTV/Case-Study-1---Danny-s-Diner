WITH ordered_sales AS (
	SELECT
		customer_id,
        product_id,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS sale_order
	FROM sales
)
SELECT ordered_sales.customer_id, menu.product_name
FROM ordered_sales
JOIN menu ON ordered_sales.product_id = menu.product_id
WHERE sale_order = 1;
	