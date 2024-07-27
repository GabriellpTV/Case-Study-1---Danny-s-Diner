WITH non_member_sales AS (
    SELECT 
    sales.customer_id, 
    sales.product_id, 
    COUNT(sales.product_id) as quantity,
    menu.price
    FROM sales
    JOIN members ON sales.customer_id = members.customer_id
    JOIN menu ON sales.product_id = menu.product_id
	WHERE sales.order_date < members.join_date
    GROUP BY customer_id, product_id, price
)
SELECT 
    customer_id, 
    SUM(quantity) AS total_items, 
    SUM(price * quantity) AS amount_spent
FROM non_member_sales
GROUP BY customer_id
ORDER BY customer_id