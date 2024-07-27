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
), 
ranked_sales_unique AS (
  SELECT 
    customer_id, 
    position, 
    COUNT(position) AS quantity
  FROM 
    ranked_sales 
  WHERE 
    position = (SELECT MIN(position) FROM ranked_sales) 
  GROUP BY 
    customer_id, position
),
ranked_sales_quant AS (
	SELECT ranked_sales.customer_id, ranked_sales.product_id, ranked_sales.position, ranked_sales_unique.quantity
    FROM ranked_sales
    JOIN ranked_sales_unique ON ranked_sales. customer_id = ranked_sales_unique.customer_id
)
SELECT ranked_sales_quant.customer_id, menu.product_name
FROM ranked_sales_quant 
LEFT JOIN menu ON ranked_sales_quant.product_id = menu.product_id AND ranked_sales_quant.position = 1
WHERE ranked_sales_quant.quantity = 1
GROUP BY customer_id, product_name





