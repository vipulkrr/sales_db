use sales_db_v1;
select * from customers;
select * from orders;
------------------------------------SINGLE-ROW SUBQUERY---------------------------------
--EXAMPLE----Find the email address of the customer who made the first order?--
---single row multiple column ---
SELECT c.email, c.name, c.id
FROM customers c
WHERE c.id =(
SELECT o.customer_id
FROM orders o
WHERE id = 1
);
---find the name of the customer who made an order for a product with the highest price.--
SELECT name
FROM customers
WHERE id = (
	SELECT o.customer_id
	FROM orders o
	WHERE price = (
		SELECT max(o.price)
		FROM orders o
		)
	LIMIT 1
);
---find the names of the customers who have Made an order on a specific date.---
SELECT name 
FROM customers 
WHERE id = (
	SELECT customer_id
	FROM orders
	WHERE date_ordered = '2022-01-02'
	LIMIT 1
    );
---find the names of the customers who have made more than one order.---
SELECT name, id
FROM customers 
WHERE id IN (
	SELECT customer_id
	FROM orders
	GROUP BY customer_id
	HAVING COUNT(*) > 1
);
---Find the names of the customers who have never made an order.---
SELECT name
FROM customers
WHERE id NOT IN (
	SELECT customer_id
	FROM orders
);
---Find the names of the customers who have made orders for products that cost more than $20.---
SELECT name
FROM customers
WHERE id IN (
	SELECT DISTINCT customer_id
	FROM orders
	WHERE price > 20
    );
    ---Find the total amount spent by each customer.---
    SELECT u.id, u.name,(
	SELECT SUM(price)
FROM orders o
WHERE o.customer_id = u.id
GROUP BY o.customer_id
)AS total_spent
FROM customers u;




