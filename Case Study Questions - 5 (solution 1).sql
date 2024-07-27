WITH sales_count AS (
  SELECT
    customer_id,
    product_id,
    COUNT(product_id) AS count
  FROM
    sales
  GROUP BY
    customer_id, product_id
),
ranked_sales AS (
  SELECT
    customer_id,
    product_id,
    RANK() OVER (PARTITION BY customer_id ORDER BY count DESC) AS position
  FROM
    sales_count
)
SELECT ranked_sales.customer_id, menu.product_name
FROM ranked_sales 
JOIN menu ON ranked_sales.product_id = menu.product_id
WHERE
  position = 1
ORDER BY customer_id
