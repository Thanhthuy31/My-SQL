-- 1. Count of customers
SELECT 
    COUNT(*)
FROM
    customers;
-- 2. Select Distinct last name of customers
USE online_supermarket;
SELECT DISTINCT last_name
FROM customers;
SELECT first_name , last_name
FROM customers
ORDER BY first_name;

-- 3. Find customers with first name as %el% or %eo%
SELECT *
FROM customers
WHERE first_name LIKE '%el%' OR first_name LIKE '%eo%';

-- 4. Count orders for each customers
SELECT 
    customer_id, COUNT(*) AS 'Order times'
FROM orders
GROUP BY customer_id;
-- 5. Count order for each customer last name and first name
SELECT 
    first_name,
    last_name,
    COUNT(*) AS 'CountOrders'
FROM 
    orders o, 
    customers c
WHERE o.customer_id = c.id
GROUP BY first_name, last_name
ORDER BY CountOrders DESC;

-- 6. Choose max quantity ordered of 1 product
SELECT 
    *
FROM
    order_items
WHERE
    quantity = (SELECT 
            MAX(quantity)
        FROM
            order_items);

-- 7. Total price of an order
USE online_supermarket;
SELECT 
       oi.order_id, 
       p.product_name,oi.quantity, 
       p.unit_price, 
       SUM(quantity*unit_price) AS 'Total price'
FROM order_items oi
JOIN products p
ON oi.product_id = p.id
GROUP BY order_id
ORDER BY order_id; 

-- 8. Average for an order
SELECT 
    AVG (quantity*unit_price) AS 'Total price per order'
FROM order_items oi
JOIN products p
ON oi.product_id = p.id;

-- 9. INNER JOIN
SELECT 
    order_id,
    product_id,
    product_name,
    quantity
FROM order_items oi
JOIN products p
ON  oi.product_id=p.id;
-- 10. RIGHT JOIN
SELECT 
    order_id,
    product_id,
    product_name,
    quantity
FROM order_items oi
RIGHT JOIN products p
ON  oi.product_id=p.id;
-- 11. LEFT JOIN
SELECT 
    order_id,
    product_id,
    product_name,
    quantity
FROM products p
LEFT JOIN order_items oi
ON  p.id=oi.product_id;




    




