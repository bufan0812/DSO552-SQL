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