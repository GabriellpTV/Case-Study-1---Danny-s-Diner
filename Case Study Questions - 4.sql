SELECT menu.product_name, COUNT(sales.product_id) AS sales_quantity
FROM sales
JOIN menu ON sales.product_id = menu.product_id
GROUP BY product_name
ORDER BY 
  sales_quantity DESC
LIMIT 1;
