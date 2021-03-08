-- START Q1
-- Show the top 5 countries with the highest number of Customers. However, do
-- not include customers from Oregon (OR) or Texas (TX) in the counts for USA.
SELECT c.country, COUNT(*) numberofcustomers
FROM customers c
WHERE region NOT IN ('OR','TX') OR region IS NULL
GROUP BY c.country
ORDER BY numberofcustomers DESC
LIMIT 5;
-- END Q1

-- START Q2
SELECT c.categoryname, COUNT(*) totalproducts
FROM categories c
JOIN products p ON p.categoryid = c.categoryid
GROUP BY c.categoryname
ORDER BY totalproducts DESC;
-- END Q2

-- START Q3
-- Northwind Traders will prioritze re-ordering a certain product if: (1) UnitsIn-
-- Stock plus UnitsOnOrder are less than or equal to ReorderLevel, (2) the product is not
-- discontinuted (Discontinued = 0), and 3) the product has been ordered more than 1 time.
-- Which products need to be prioritized for reordering?
SELECT p.productid,p.productname
FROM products p
JOIN order_details o ON o.productid = p.productid
GROUP BY p.productid
HAVING (unitsinstock + unitsonorder <= reorderlevel) AND (discontinued = 0) 
AND COUNT(o.productid) >1;
-- END Q3

-- START Q4
-- How many orders were shipped by United Package and Speedy Express (combined)
-- in 1997? (Hint: shipvia is the shipper id in the orders table)
SELECT DATE_PART('year',o.shippeddate) ship_year, COUNT(*) total
FROM orders o
JOIN shippers s ON o.shipvia = s.shipperid
WHERE (o.shippeddate BETWEEN '1997-01-01' AND '1997-12-31') 
AND s.companyname IN ('United Package','Speedy Express')
GROUP BY DATE_PART('year',o.shippeddate);
-- END Q4

-- START Q5
-- Northwind’s operations team has noted the high cost of freight charges for
-- Speedy Express shipments. For 1996, return the three ship countries with the highest
-- average freight overall, in descending order by average freight, for orders fulfilled by
-- Speedy Express.
SELECT o.shipcountry, AVG(freight) avg_freight
FROM orders o
JOIN shippers s ON s.shipperid = o.shipvia
WHERE companyname = 'Speedy Express' AND o.shippeddate BETWEEN '1996-01-01' AND '1996-12-31'
GROUP BY o.shipcountry
ORDER BY avg_freight DESC;
-- END Q5


-- START Q6
-- Some salespeople have more orders arriving late than other salespeople (defined
-- as RequiredDate <= ShippedDate). Which salespeople have at least 5 orders arriving late?
-- Do not show any employees with less than 5 late orders
SELECT e.lastname,e.firstname, COUNT(o.employeeid) totallateorders 
FROM orders o
JOIN employees e ON e.employeeid = o.employeeid
WHERE requireddate <= shippeddate
GROUP BY e.lastname,e.firstname
HAVING COUNT(o.employeeid) >= 5
ORDER BY totallateorders DESC;
-- END Q6

-- START Q7
-- Suppose that the company wants to send all of the high-value customers a
-- special VIP gift. A high-value customer is anyone who’ve made at least 1 order with a
-- total value (quantity x unit price) equal to $10,000 or more. Query all of these high-value
-- customer in 1996.
SELECT c.companyname, o.orderid, SUM(unitprice*quantity) as total
FROM orders o
JOIN customers c ON c.customerid = o.customerid
JOIN order_details od ON od.orderid = o.orderid
GROUP BY c.companyname, o.orderid
HAVING (o.orderdate BETWEEN '1996-01-01' AND '1996-12-31') 
AND SUM(unitprice*quantity) >= 10000
ORDER BY total DESC；
-- END Q7

-- START Q8
-- Northwind’s inventory supply chain team wants a report each day of products
-- that have unit prices above the average unit price for all products but below average
-- units in stock. This helps them better plan restock and purchasing decisions. Product
-- this report for them.
SELECT productname,unitprice,unitsinstock
FROM products
WHERE unitprice >(SELECT AVG(unitprice)
				 FROM products)
AND unitsinstock < (SELECT AVG(unitsinstock)
				   FROM products);
-- END Q8

-- START Q9
-- What is the average number of orders processed by a Northwind employee?
SELECT AVG(num_orders)
FROM (SELECT o.employeeid, COUNT(DISTINCT o.orderid) num_orders
FROM orders o
JOIN employees e ON e.employeeid = o.employeeid
GROUP BY o.employeeid) AS Table1;
-- END Q9

-- START Q10
-- Which product categories have the above average line item total discounted
-- value (this is defined as discount * unitprice‘ * quantity at the order details level). Hint:
-- first find the average total discounted value for all order details, you’ll then need to plug
-- plug this into a HAVING filter.
SELECT c.categoryname,AVG(o.unitprice*o.discount*o.quantity) avg_line_item_discount
FROM order_details o
JOIN products p ON p.productid = o.productid
JOIN categories c ON c.categoryid = p.categoryid
GROUP BY c.categoryname
HAVING AVG(o.unitprice*o.discount*o.quantity) > (SELECT AVG(unitprice*quantity*discount)
											 FROM order_details);
-- END Q10






