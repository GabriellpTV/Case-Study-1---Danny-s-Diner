WITH non_member_sales AS (
    SELECT sales.customer_id, sales.order_date, sales.product_id, members.join_date
    FROM sales
    JOIN members ON sales.customer_id = members.customer_id
    WHERE sales.order_date < members.join_date
)
SELECT customer_id, order_date, product_id
FROM non_member_sales
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MAX(order_date)
    FROM non_member_sales
    GROUP BY customer_id
);