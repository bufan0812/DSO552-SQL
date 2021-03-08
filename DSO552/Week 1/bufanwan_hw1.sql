-- START Q1

--Which companies do Northwind Traders use for shipping their products? Provide
-- the names of these companies, as well as their IDs
SELECT shipperid,companyname
FROM shippers

-- END Q1

-- START Q2

-- Find the first name, last name, and the hiring date of all employees with the
-- title “Sales Representative” or “Inside Sales Coordinator”.
SELECT firstname,lastname,hiredate
FROM employees
WHERE title in ('Sales Representative','Inside Sales Coordinator')

-- END Q2

-- START Q3

-- Create a report showing the first name, last name, and country of all employees
-- not in the United States. Order result alphabetically, by last name.

SELECT firstname,lastname,country
FROM employees
WHERE country != 'USA'
ORDER BY lastname

-- END Q3

-- START Q4

-- Query all employee names (first and last) who are hired before Jan 1, 1994. Sort
-- your results from the newest hire to the oldest to find out who is the newest hire.
SELECT firstname,lastname,hiredate
FROM employees
WHERE hiredate < '1994-01-01'
ORDER BY hiredate DESC

-- END Q4

-- START Q5

-- Show all orders (and return all columns) that happened in Madrid in year 1996.

SELECT *
FROM orders
WHERE shipcity = 'Madrid' and (shippeddate >= '1996-01-01' and shippeddate <= '1996-12-31')

-- END Q5

-- START Q6
-- Find and return only the product id and name for all “queso” products that
-- have a unit price greater than 30

SELECT productid,productname
FROM products
WHERE productname LIKE 'Queso%' AND unitprice >30

-- END Q6

-- START Q7
-- Query all the orders (order id, customer id, and shipcountry) shipping to the
-- following countries in Latin America (Brazil, Mexico, Argentina, Venezuela). Sort by
-- freight value, with the heaviest freight first. Show the first 10 results only.
SELECT orderid,customerid,shipcountry,freight
FROM orders
WHERE shipcountry in ('Brazil','Mexico','Argentina','Venezuela')
ORDER BY freight DESC
LIMIT 10
-- END Q7

-- START Q8
-- Create a report that shows the company name, contact title, city and country
-- of all customers in Mexico, Brazil, or in any city in Spain except Madrid.
SELECT companyname,contacttitle,city,country
FROM customers
WHERE country in ('Spain','Mexico','Brazil') AND city != 'Madrid'

-- END Q8

-- START Q9
-- What is the most expensive discontinued product that currently has units in
-- stock? (Hint: A product is discontinued if the the value of the value of discontinued in
-- the table is 1 otherwise it is 0 if the product is not discontinued). Show all columns from
-- the products table and order your results from most expensive to least expensive.
SELECT *
FROM products
WHERE discontinued = 1 AND unitsinstock != 0
ORDER BY unitprice DESC

-- END Q9

-- START 10
-- Which order (order id) has the highest total value after the discount? Return
-- the orderid, productid, unitprice, quantity, discount, and total value of the order (in a
-- column called totalvalue). Order the results in descending order of total value.
SELECT orderid,productid, unitprice, quantity, discount, (unitprice*quantity)*(1-discount) as totalvalue
FROM order_details
ORDER BY totalvalue DESC
LIMIT 1
-- END 10



