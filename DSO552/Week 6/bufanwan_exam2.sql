
-- START Q1
WITH t1 AS (SELECT u.user_id, COUNT(*) number_reviews
FROM users u
JOIN reviews r ON u.user_id = r.user_id
GROUP BY 1
HAVING COUNT(*) > 2 )
SELECT r.user_id, AVG(r.stars) avgerage_star_rating
FROM users u
JOIN reviews r ON u.user_id = r.user_id
GROUP BY 1
HAVING r.user_id IN (SELECT user_id FROM t1)
ORDER BY 2 DESC,user_id 
LIMIT 5;
-- END Q1


-- START Q2

WITH t1 AS (SELECT business_id,review_count,stars,categories,string_to_array(categories, ', ') AS category_array
FROM businesses)
SELECT unnest(category_array) AS category, SUM(review_count*stars)/SUM(review_count) AS weighted_average_stars, COUNT(*) num_businesses
FROM t1
GROUP BY 1
HAVING COUNT(*) > 3
ORDER BY 2 DESC;

-- END Q2

-- START Q3

WITH t1 AS (SELECT u.user_id userid,u.name username,b.name businessname
FROM users u
JOIN tips t ON u.user_id = t.user_id
JOIN reviews r ON r.user_id = t.user_id
JOIN businesses b ON b.business_id = r.business_id),
t2 AS (SELECT u.user_id,u.name,t.date,b.name businessname
FROM users u
JOIN tips t USING(user_id)
JOIN businesses b ON b.business_id = t.business_id
WHERE u.name IN (SELECT username FROM t1)
GROUP BY 1,2,3,4),
t3 AS (SELECT u.user_id,u.name,r.date,b.name businessname
FROM users u
JOIN reviews r USING(user_id)
JOIN businesses b ON b.business_id = r.business_id
WHERE u.name IN (SELECT username FROM t1)
GROUP BY 1,2,3,4),
review AS (SELECT user_id,name,businessname,COUNT(*) reviews_left 
FROM t3
GROUP BY 1,2,3),
tip AS (SELECT user_id,name, businessname,COUNT(*) tips_left
FROM t2
GROUP BY 1,2,3)
SELECT t.name,t.businessname,tips_left,reviews_left
FROM tip t
JOIN review r ON t.user_id = r.user_id
ORDER BY businessname,name,tips_left DESC;

-- END Q3


-- START Q4
SELECT u.user_id,fans,u.name username,text
FROM users u
JOIN reviews r ON r.user_id = u.user_id
JOIN businesses b ON b.business_id = r.business_id
WHERE b.name = 'Burlington Coat Factory' AND fans >= 5;

-- END Q4

-- START Q5
WITH t1 AS (SELECT u.user_id
FROM users u
LEFT JOIN tips t ON t.user_id = u.user_id
WHERE t.user_id IS NULL),
t2 AS (SELECT 'Users without tips' AS type_of_user, AVG(stars) avg_stars
FROM users u
JOIN reviews r ON r.user_id = u.user_id
WHERE u.user_id IN (SELECT * FROM t1)),
t3 AS (SELECT 'Users with tips' AS type_of_user, AVG(stars) avg_stars
FROM users u
JOIN reviews r ON r.user_id = u.user_id
WHERE u.user_id NOT IN (SELECT * FROM t1))
(SELECT * FROM t2)
UNION
(SELECT * FROM t3);

-- END Q5

-- START Q6
SELECT COALESCE(attributes::JSON ->> 'BusinessAcceptsCreditCards','False') AS accepts_credit_cards,
COALESCE(attributes::JSON ->> 'RestaurantsTakeOut','False') AS offers_takeout,
AVG(stars) average_stars
FROM businesses
GROUP BY 1,2
ORDER BY 3 DESC;

-- END Q6

-- START Q7
WITH t1 AS (SELECT entertainerid,startdate,contractprice, ROW_NUMBER () OVER (PARTITION BY entertainerid ORDER BY startdate)
FROM engagements),
t2 AS (SELECT 'First Five Engagements' AS engagement_category, ROUND(AVG(contractprice),3) avg
FROM t1
WHERE row_number <= 5),
t3 AS (SELECT '6th and Beyond Engagements' AS engagement_category, ROUND(AVG(contractprice),3) avg
FROM t1
WHERE row_number > 5)
SELECT * FROM t3
UNION
SELECT * FROM t2;

-- END Q7

-- START Q8
WITH t1 AS (SELECT AVG(contractprice) global_average
FROM engagements),
t2 AS (SELECT AVG(contractprice) OVER() avg_contract_price, startdate most_recent_start_date, COUNT(*) OVER() num_engagements
FROM engagements
WHERE contractprice > (SELECT * FROM t1)
ORDER BY 2 DESC
LIMIT 1)
SELECT ROUND(avg_contract_price,3) avg_contract_price , most_recent_start_date,num_engagements
FROM t2;
-- END Q8

-- START Q9
SELECT gender,stylename, COUNT( DISTINCT m.memberid) num_members
FROM members m
JOIN entertainer_members em USING (memberid)
JOIN entertainer_styles es USING(entertainerid)
JOIN musical_styles ms USING(styleid)
GROUP BY 1,2
HAVING COUNT( DISTINCT m.memberid) > 4
ORDER BY num_members DESC;

-- END Q9

-- START Q10
WITH t1 AS (SELECT c.customerid,startdate,contractprice, 
			ROW_NUMBER() OVER (PARTITION BY c.customerid,DATE_TRUNC('month',startdate) ORDER BY DATE_TRUNC('day',startdate))
FROM customers c
JOIN engagements e ON c.customerid = e.customerid
JOIN agents a ON a.agentid = e.agentid
WHERE agtfirstname != 'Karen'),
t2 AS (SELECT *, CASE WHEN row_number >= 3 THEN 0.9
				ELSE 1 END AS discount
FROM t1),
t3 AS (SELECT *, contractprice*discount AS actual_paid
	  FROM t2)
SELECT customerid, SUM(actual_paid) total_paid
FROM t3
GROUP BY 1
ORDER BY 2 DESC;


-- END Q10
