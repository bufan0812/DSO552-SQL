--Q1
SELECT *
FROM sms_events
-- Q2
CREATE TABLE bufanwan.high_freight_orders AS
SELECT *
FROM public.orders
WHERE freight > 30

--SELECT COUNT(*) total_orders, COUNT(DISTINCT customerid) AS total_customers
FROM bufanwan.high_freight_orders

-- Q3
CREATE TABLE bufanwan.customers_adapted AS
SELECT *
FROM public.customers



INSERT INTO bufanwan.customers_adapted
VALUES ('ALA','ADFAD','TONY Mike','SALES','OBERE','London','SP',1010,'UK',394-202-2929,0241-40394),
	   ('AL','ADFAD','TONY Mike','SALES','OBERE','London','SP',1010,'UK',394-202-2929,0241-40394);

--SELECT city, COUNT(DISTINCT customerid)
FROM bufanwan.customers_adapted
GROUP BY 1
HAVING city = 'London'


-- START Q4

WITH t1 AS (
	SELECT *
	FROM public.order_details od
	JOIN products p ON p.productid = od.productid)
SELECT (COUNT(*))/cast (COUNT(DISTINCT orderid) as float) average_line_items_per_order 
FROM t1;
	
-- END Q4

-- START Q5
WITH t1 AS(
	SELECT AVG(discount)
	FROM public.order_details),
t2 AS(
	SELECT e.employeeid,o.orderid--,od.quantity*od.unitprice*od.discount as discount_values
	FROM public.employees e
	JOIN public.orders o ON e.employeeid = o.employeeid
	JOIN public.order_details od ON o.orderid = od.orderid
	WHERE od.discount > (SELECT * FROM t1)
	GROUP BY e.employeeid,o.orderid)
SELECT employeeid, COUNT(DISTINCT orderid)
FROM t2
GROUP BY employeeid
ORDER BY count DESC
LIMIT 5;
-- END Q5

-- Q6
CREATE VIEW bufanwan.most_recent_shipped_orders AS
SELECT *
FROM public.orders o
WHERE shippeddate IS NOT NULL
ORDER BY shippeddate DESC
LIMIT 10


--SELECT orderid, customerid, employeeid, orderdate, shipvia, shipname, shippeddate
FROM bufanwan.most_recent_shipped_orders;

--Q7
CREATE TABLE new_regions AS
SELECT *
FROM region

INSERT INTO bufanwan.new_regions
VALUES (5,'Northeast'),
	   (6,'Southwest')

--SELECT *
FROM bufanwan.new_regions

--Q8
CREATE MATERIALIZED VIEW most_popular_orders AS
SELECT p.productname, SUM(quantity) total_times_ordered
FROM public.products p
JOIN public.order_details o ON p.productid = o.productid
WHERE o.unitprice > (SELECT AVG(unitprice)
				   FROM public.order_details)
GROUP BY 1
ORDER BY total_times_ordered DESC


--SELECT * 
FROM bufanwan.most_popular_orders 
LIMIT 5;

-- Q9
CREATE TABLE bufanwan.order_details AS
SELECT *
FROM public.order_details od
WHERE productid != 60

--SELECT COUNT(*)
FROM bufanwan.order_details od
JOIN products p ON p.productid = od.productid
WHERE p.productname = 'Camembert Pierrot'

--Q10
CREATE VIEW late_orders_by_month AS
SELECT DATE_TRUNC('month',orderdate)::date AS month, COUNT(*) late_orders
FROM orders
WHERE shippeddate > requireddate 
GROUP BY 1
ORDER BY 1

--SELECT AVG(late_orders) FROM bufanwan.late_orders_by_month;


