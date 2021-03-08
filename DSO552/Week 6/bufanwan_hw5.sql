-- START Q1
SELECT customerid, COUNT(*) top_quartile_engagements
FROM (SELECT c.customerid, contractprice, NTILE (4) OVER (ORDER BY e.contractprice ) AS ranking
FROM customers c
JOIN engagements e USING(customerid)) t1
WHERE ranking = 4
GROUP BY customerid;
-- END Q1

-- START Q2
SELECT engagementnumber,entstagename,contractprice*1.1 adjusted_contractprice
FROM (SELECT en.engagementnumber,et.entstagename, contractprice, row_number() OVER (
             PARTITION BY et.entstagename ORDER BY startdate)
FROM engagements en
JOIN entertainers et USING(entertainerid)) t1
WHERE row_number = 10
ORDER BY engagementnumber;
-- END Q2

-- START Q3
WITH Table1 AS (SELECT entertainerid
FROM (SELECT en.entertainerid, COUNT(*) AS number_of_booking
FROM engagements en
JOIN entertainers et USING(entertainerid)
GROUP BY 1) T1
WHERE number_of_booking >=10),
Table2 AS (SELECT engagementnumber,startdate,CASE WHEN entertainerid in (SELECT * FROM Table1) 
										THEN contractprice*0.08
										ELSE contractprice*0.1 END AS agency_revenue
FROM engagements en
JOIN entertainers et USING(entertainerid)
ORDER BY startdate,engagementnumber)

SELECT engagementnumber,startdate,agency_revenue, SUM(agency_revenue) OVER (ORDER BY startdate,engagementnumber )
FROM Table2;
-- END Q3

-- START Q4
(SELECT 'agent' AS type, a.agtfirstname ||' '||a.agtlastname AS name,COUNT(*) num_engagements
FROM agents a
JOIN engagements e USING (agentid)
GROUP BY 2
ORDER BY num_engagements DESC
LIMIT 5)
UNION
(SELECT 'musical_style' AS type, stylename as name, COUNT(*) num_engagements
FROM engagements e
JOIN entertainer_styles es USING (entertainerid)
JOIN musical_styles ms USING (styleid)
GROUP BY stylename
ORDER BY num_engagements DESC,name
LIMIT 5)
ORDER BY num_engagements DESC;
-- END Q4

-- START Q5
WITH Table1 AS(SELECT RIGHT(LEFT(custphonenumber,6),2) type_block
FROM customers
UNION ALL
SELECT RIGHT(LEFT(agtphonenumber,6),2) type_block
FROM agents),
Table2 AS (SELECT type_block, CASE WHEN type_block::INTEGER > 25 THEN 'landline'
				ELSE 'mobile' END AS phone_types
FROM Table1)
SELECT phone_types, COUNT (*)
FROM Table2
GROUP BY 1；
-- END Q5

-- START Q6
SELECT agentid,salary,commission,high_performer_bonus,(salary+commission)*(1+high_performer_bonus) final_compensation
FROM (SELECT a.agentid,salary, SUM(commissionrate*contractprice) commission,
                 CASE WHEN COUNT(*) > 15 THEN 0.1
				 ELSE 0 END AS high_performer_bonus			 
FROM agents a
JOIN engagements e USING (agentid)
GROUP BY 1) T1；
-- END Q6

