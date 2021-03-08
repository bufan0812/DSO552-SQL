-- START Q2
-- Provide a table that has the region for each sales_rep along with their associated
-- accounts. Your final table should include three columns: the region name, the sales rep name, and the
-- account name (call it account_name)
SELECT s.name AS rep, r.name AS region, a.name AS account_name
FROM sales_reps s
JOIN region r ON s.region_id = r.id
JOIN accounts a ON a.sales_rep_id = s.id;

-- END Q2

-- START Q5
-- are the different channels used by account id 1001? Your final table should have only
-- 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down
-- the results to only the unique values.
SELECT DISTINCT name, channel
FROM accounts a
JOIN web_events w ON a.id = w.account_id 
WHERE a.id = 1001;
-- END Q5

-- START Q6
-- Find all the orders that occurred in 2015. Your final table should have 4 columns:
-- occurred_at, account name, order total, and order total_amt_usd.
SELECT occurred_at, name AS account_name, total AS order_total, total_amt_usd
FROM orders o
JOIN accounts a ON o.account_id = a.id
WHERE occurred_at BETWEEN '2015-01-01' AND '2015-12-31';

-- END Q6

-- START Q14
-- What is the average standard_qty spent on by our Ford Motor account
SELECT AVG(standard_qty)
FROM orders o
JOIN accounts a ON o.account_id = a.id
WHERE name = 'Ford Motor';
-- END Q14

-- START Q23
SELECT CONCAT(custfirstname, ' ',custlastname) AS full_name,
        customerid,custzipcode
FROM customers c
LEFT JOIN employees e ON c.custzipcode = e.empzipcode
WHERE employeeid IS NULL;

-- END Q23

-- START Q20
-- Display all order details that have a total quoted value greater than 100, the products
-- in each order, and the amount owed for each product. Provide the order number, product name, and
-- amount owed.
SELECT o.ordernumber,p.productname,
quotedprice * quantityordered AS amount_owed
FROM orders o
JOIN order_details od ON o.ordernumber = od.ordernumber
JOIN products p ON od.productnumber = p.productnumber
WHERE quotedprice * quantityordered > 100;
-- END Q20

-- START Q21
-- Show me the vendors and the products they supply to us for products that cost less
-- than $100 (use wholesaleprice) and take less than 1 week to deliver. Just provide the product name
-- and vendor names.
SELECT productname, vendname
FROM product_vendors pv
JOIN vendors v ON pv.vendorid = v.vendorid
JOIN products p ON p.productnumber = pv.productnumber
WHERE wholesaleprice < 100 AND daystodeliver < 7;
-- END Q21

-- START Q22
-- Show me customers and employees who have the same last name. Provide a report
-- with the customer ID, customer last name, and employee ID.
SELECT customerid,custlastname,employeeid
FROM customers c
JOIN employees e ON c.custlastname = e.emplastname;
-- END Q22

-- START Q24
-- Which products have more than 10 units on hand but have never been ordered?
-- Output the product number, product name, and order number.
SELECT p.productnumber,productname,ordernumber
FROM products p
LEFT JOIN order_details o ON p.productnumber = o.productnumber 
WHERE o.productnumber IS NULL;
-- END Q24

-- START Q25
-- How many customers are based in Texas and have made at least one order?
SELECT DISTINCT c.customerid
FROM customers c
JOIN orders o ON c.customerid = o.customerid
WHERE custstate = 'TX';
-- END Q25
