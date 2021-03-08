-- START Q4
SELECT id,account_id,occurred_at
FROM orders

-- START Q7
SELECT id,occurred_at,total_amt_usd
FROM orders
ORDER BY occurred_at 
LIMIT 10
-- END Q8

-- START Q8
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5
-- END Q8

-- START Q9
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 5
-- END Q9

-- START Q11
-- Write a query that returns the top 5 rows from orders ordered according newest to
-- oldest, but with the largest total_amt_usd for each date listed first for each date. (Return only id,
-- occured_at, total_amt_used)
SELECT id,occurred_at::DATE,total_amt_usd
FROM orders
ORDER BY occurred_at::DATE DESC, total_amt_usd DESC
LIMIT 5

-- END Q11

-- START Q13
-- Write a query to pull the first 5 rows and all columns from the orders table that have
-- a total_amt_usd less than or equal to 500.

SELECT *
FROM orders
WHERE total_amt_usd <= 500
LIMIT 5

-- END Q13


-- START Q16
-- Create a column that divides the standard_amt_usd by the standard_qty to find the
-- unit price for standard paper for each order. Limit the results to the first 5 orders, and include the id
-- and account_id fields.
SELECT id,account_id,standard_amt_usd/standard_qty as unit_price_std_paper
FROM orders
LIMIT 5

-- END Q16

-- START Q18
-- Use the accounts table to find all companies whose names contain the string ‘one’
-- somewhere in the name.

SELECT *
FROM accounts
WHERE name LIKE '%one%'

-- END Q18

-- START Q19
-- Use the accounts table to find all the companies whose names start with ‘C’.

SELECT *
FROM accounts
WHERE name LIKE 'C%'

-- END Q19

-- START Q21
-- Use the web_events table to find all information regarding individuals who were
-- contacted via the channel of organic or adwords.

SELECT *
FROM web_events
WHERE channel in ('organic','adwords')

-- END Q21

-- START Q23
-- Use the web_events table to find all information regarding individuals who were
-- contacted via any method except using organic or adwords methods.
SELECT *
FROM web_events
WHERE channel not in ('organic','adwords')

-- END Q23

-- START Q24
-- Use the accounts table to find all the companies whose names do not start with ‘C’.
SELECT *
FROM accounts
WHERE name not LIKE 'C%'

-- END Q24

-- START Q26
-- Write a query that returns all the orders where the standard_qty is over 1000, the
-- poster_qty is 0, and the gloss_qty is 0.

SELECT *
FROM orders
WHERE standard_qty > 1000 and poster_qty = 0 and gloss_qty = 0

-- END Q26

-- START Q27
-- Use the web_events table to find all information regarding individuals who were
-- contacted via organic or adwords and started their account at any point in 2016 sorted from newest to
-- oldest.
SELECT *
FROM web_events
WHERE channel in ('organic','adwords') and occurred_at between '2016-01-01' and '2016-12-31'
ORDER BY occurred_at DESC

-- END Q27

-- START Q30
-- Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only
-- include the id field in the resulting table.
SELECT id
FROM orders
WHERE gloss_qty > 4000 or poster_qty > 4000

-- END Q30




