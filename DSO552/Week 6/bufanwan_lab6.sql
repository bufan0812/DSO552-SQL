-- START Q3

WITH Table1 AS(
SELECT *,
(
REPLACE(
REPLACE(
REPLACE(
REPLACE(
(attributes::JSON ->> 'Ambience'),
'''', '"'), 
'False', '"False"'),
'True', '"True"'), 
'None','"None"'))::JSON Ambience_json
FROM businesses),

Table2 as(
SELECT *
FROM Table1
WHERE ambience_json ->> 'casual' = 'True')

SELECT ROUND(COUNT(*)*1.0/(SELECT COUNT (*) FROM Table1),2) AS percentage_casual
FROM Table2;

-- END Q3

-- START Q4

WITH t1 AS (
SELECT business_id,name,stars,review_count,string_to_array(categories, ', ') AS category_array
FROM businesses),
t2 AS(
SELECT business_id,name,stars,review_count,unnest(category_array) AS category
FROM t1)
SELECT t.name, AVG(r.stars) average_rating, COUNT(*) num_ratings
FROM t2 t
JOIN reviews r ON r.business_id = t.business_id
WHERE category = 'Shopping'
GROUP BY 1
ORDER BY average_rating DESC
LIMIT 3;

-- END Q4

-- START Q5
WITH t1 as (
SELECT business_id, string_to_array(date, ', ') AS date_array
FROM checkins),
t2 as (
SELECT business_id, unnest(date_array) AS checkin_date
FROM t1),
t3 as(
SELECT business_id,checkin_date,COUNT(*) OVER (PARTITION BY business_id 
											   ORDER BY checkin_date) AS checkin_number
FROM t2)
SELECT *
FROM t3
WHERE checkin_number = 100;

-- END Q5

------------------------------------------------------------------------------------------------------

-- START Q1

CREATE INDEX tips_business_id_index ON bufanwan.tips USING btree(business_id);

-- END Q1

-- START Q2

CREATE INDEX tips_compliment_count_index ON bufanwan.tips USING btree(compliment_count);

-- END Q2


