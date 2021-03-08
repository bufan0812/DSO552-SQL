-- START Q1
SELECT c.categoryname,s.supplierid, unitsinstock AS remainingunits
FROM products p
JOIN categories c ON c.categoryid = p.categoryid
JOIN suppliers s ON s.supplierid = p.supplierid
WHERE discontinued = 0 AND unitsinstock = 0;
-- END Q1

-- START Q2
SELECT e.firstname||' '||e.lastname AS employeename, o.orderid, o.orderdate,c.companyname AS customername
FROM employees e
JOIN orders o ON e.employeeid = o.employeeid
JOIN customers c ON c.customerid = o.customerid
ORDER BY o.orderdate DESC
LIMIT 5;

-- END Q2

-- START Q3
SELECT c.customerid, c.companyname,c.contactname,c.contacttitle
FROM orders o
JOIN customers c ON c.customerid = o.customerid
GROUP BY c.customerid
HAVING COUNT(DISTINCT o.orderid) < 5;
-- END Q3

-- START Q4
SELECT c.country, COUNT(*)
FROM orders o
LEFT JOIN customers c ON c.customerid = o.customerid
GROUP BY c.country
HAVING o.orderid IS NULL;
-- END Q4

-- START Q5
SELECT c.categoryname, COUNT(*) number_of_products
FROM products p
JOIN categories c ON c.categoryid = p.categoryid
WHERE unitprice > 20 AND unitsinstock >0
GROUP BY c.categoryname;
-- END Q5


-- START Q6
SELECT COUNT(DISTINCT o.customerid) num_customers
FROM categories c
JOIN products p ON c.categoryid = p.categoryid
JOIN order_details od ON od.productid = p.productid
JOIN orders o ON o.orderid = od.orderid
WHERE c.categoryname = 'Seafood';
-- END Q6


-- START Q7
SELECT firstname,lastname,COUNT(report) reportsto
FROM employees
GROUP BY firstname,lastname, reportsto


-- END Q7

-- START Q8
SELECT e.employeeid, e.firstname||' '||e.lastname AS employeename, SUM(od.unitprice*od.quantity) total_ordered_value
FROM employees e
JOIN orders o ON e.employeeid = o.employeeid
JOIN order_details od ON od.orderid = o.orderid
WHERE e.title != 'Vice President of Sales'
GROUP BY e.employeeid
ORDER BY total_ordered_value DESC
LIMIT 3;
-- END Q8

-- START Q10
SELECT s.companyname, COUNT(DISTINCT o.orderid) shipped_orders
FROM orders o
JOIN shippers s ON s.shipperid = o.shipvia
GROUP BY s.companyname
ORDER BY shipped_orders 
LIMIT 1;
-- END Q10

-- START Q9
SELECT c.companyname, COUNT(DISTINCT o.orderid) total_orders, COUNT(SELECT orderid
																    FROM orders
																    WHERE shippeddate < requireddate) on_time_orders
FROM customers c
JOIN orders o ON o.customerid = c.customerid
GROUP BY c.companyname;

-- END Q9

-- START Q11
SELECT e.firstname||' '||e.lastname AS employeename, COUNT(DISTINCT o.orderid) num_orders,
                                                     CASE WHEN COUNT(DISTINCT o.orderid) > 75 THEN 'High Performer'
													 WHEN COUNT(DISTINCT o.orderid) > 50 THEN 'Mid Tier'
													 ELSE 'Low Performer' END AS performance_rating
FROM employees e
JOIN orders o ON e.employeeid = o.employeeid
GROUP BY e.firstname, e.lastname;

-- END Q11
