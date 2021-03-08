-- START Q9
-- Which account (by name) placed the earliest order? Your solution should have the account name and
-- the date (occurred_at) of the order.
SELECT a.name, MIN(o.occurred_at)
FROM orders o
JOIN accounts a ON o.account_id = a.id
GROUP BY a.name
ORDER BY 2
LIMIT 1;
-- END Q9

-- START Q10
-- Find the total sales in usd for each account. You should include two columns: the
-- total sales for each company’s orders in usd and the company name (column names should be name and
-- total_sales)
SELECT a.name, SUM(total_amt_usd) total_sales
FROM orders o
JOIN accounts a ON o.account_id = a.id
GROUP BY a.name;

-- END Q10

-- START Q12
-- Find the total number of times each type of channel from the web_events was used.
-- Your final table should have two columns - channel (the channel name) and times_used (the number
-- of times the channel was used).
SELECT w.channel, COUNT(W.id)
FROM web_events w
GROUP BY w.channel;

-- END Q12

-- START Q15
-- Find the number of sales reps in each region. Your final table should have two columns
-- - name (the region name) and num_reps (the number of sales_reps). Order from fewest reps to most
-- reps
SELECT r.name, COUNT(sr.id)
FROM region r
JOIN sales_reps sr ON sr.region_id = r.id
GROUP BY r.name;

-- END Q15

-- START Q18
-- Determine the number of times a particular channel was used in the web_events table
-- for each region. Your final table should have three columns - the region name, the channel, and the
-- number of occurrences. Order your table with the highest number of occurrences first.
SELECT r.name,we.channel, COUNT(DISTINCT we.id)
FROM region r
JOIN sales_reps sr ON r.id = sr.region_id
JOIN accounts a ON sr.id = a.sales_rep_id
JOIN web_events we ON a.id = we.account_id
GROUP BY r.name,we.channel
ORDER BY 3 DESC;

-- END Q18

-- START Q20
-- How many accounts assigned to sales reps in the Midwest region have placed an order?
-- You should be returning one row, with one column called midwest_accounts.
SELECT COUNT(DISTINCT a.id)
FROM region r
JOIN sales_reps sr ON r.id = sr.region_id
JOIN accounts a ON a.sales_rep_id = sr.id
JOIN orders o ON o.account_id = a.id
WHERE r.name = 'Midwest';

-- END Q20


-- START Q25
-- Which account has spent the most with us? Provide three columns in your answer -
-- id (the account ID), name (name of the account), and total_spent. Use total_amt_usd to calculate
-- spend.
SELECT a.id, a.name, SUM(total_amt_usd) total_spent
FROM accounts a
JOIN orders o ON o.account_id = a.id
GROUP BY a.id, a.name
ORDER BY 3 DESC
LIMIT 1;
-- END Q25

-- SATRT Q33
-- We would like to understand 3 different branches of customers based on the amount
-- associated with their purchases. The top branch includes anyone with a Lifetime Value (total sales
-- of all orders) greater than 200,000 usd. The second branch is between 200,000 and 100,000 usd. The
-- lowest branch is anyone under 100,000 usd. Provide a table that includes the level associated with each
-- account. You should provide a column called name (account name), total_spent, the total sales of all
-- orders for the customer, and customer_level (the level categorization of the customer). Order with
-- the top spending customers listed first.
SELECT a.name, 
       SUM(total_amt_usd) total_spent,
	   CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
	        WHEN SUM(total_amt_usd) > 100000 THEN 'middle'
            ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a ON a.id = o.account_id
GROUP BY a.name
ORDER BY 2 DESC;

-- END Q33

-- START Q22
-- How many accounts have more than 20 orders?
SELECT COUNT(*)num_account
FROM (SELECT a.name, COUNT(a.id) num_orders
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY a.name
HAVING COUNT(a.id) >20) Table1; 

-- END Q22

