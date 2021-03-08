-- START Q1
-- Show me the list of entertainers based in ‘Bellevue’, ‘Redmond’, or ‘Woodinville’
-- who do not have a registered email address.
SELECT entstagename,entphonenumber,entcity
FROM entertainers
WHERE entcity in ('Bellevue','Redmond','Woodinville') AND entemailaddress IS NULL;
-- END Q1

-- START Q2
-- Show me all the engagements that started in September 2017 and ran for four
-- days. Consider the enddate as inclusive. Note that you can subtract two date fields to
-- get the days difference between them.
SELECT engagementnumber,startdate,enddate
FROM engagements
WHERE startdate BETWEEN '2017-09-01' AND '2017-09-30'AND (enddate-startdate) = 3;

-- END Q2

-- START Q3
-- Display agents’ first and last name, and the engagement dates they booked,
-- sorted by booking start date with the most recent bookings listed first.
SELECT CONCAT(agtfirstname,' ',agtlastname) AS agtfullname,startdate
FROM agents a
JOIN engagements e ON a.agentid = e.agentid
ORDER BY startdate DESC;

-- END Q3

-- START Q4
-- Find the agents and entertainers who live in the same postal code. Report the
-- names as well as the postal code.
SELECT CONCAT(agtfirstname,' ',agtlastname) AS agtfullname,entstagename,agtzipcode
FROM agents a
JOIN entertainers e ON a.agtzipcode = e.entzipcode;
-- END Q4

-- START Q5
-- Show me entertainers, the start and end dates of their contracts, and the contract
-- price.
SELECT entstagename, startdate,enddate,contractprice
FROM entertainers ent
JOIN engagements eng ON ent.entertainerid = eng.entertainerid;
-- END Q5


-- START Q6
-- Find the entertainers who played engagements for customers Berg or Hallmark.
SELECT DISTINCT entstagename
FROM engagements eng
JOIN entertainers ent ON ent.entertainerid = eng.entertainerid
JOIN customers c on c.customerid = eng.customerid
WHERE custlastname in ('Berg','Hallmark');
-- END Q6

-- START Q7
-- How many engagements that started at 1pm in the afternoon have been booked
-- in 2017?
SELECT COUNT(*)
FROM engagements
WHERE starttime = '13:00:00' AND startdate BETWEEN '2017-01-01' AND '2017-12-31';

-- END Q7

-- START Q8
-- List all entertainers and any engagements they have booked that had contract
-- prices above 1000.
SELECT eng.entertainerid,entstagename,engagementnumber,startdate,customerid
FROM engagements eng
JOIN entertainers ent ON ent.entertainerid = eng.entertainerid 
WHERE contractprice > 1000
ORDER BY entertainerid,engagementnumber DESC;
-- END Q8


-- START Q9
-- Count the number of customers with no bookings
SELECT Count(*)
FROM customers c
LEFT JOIN engagements eng ON c.customerid = eng.customerid
WHERE eng.customerid IS NULL;
-- END Q9


-- START Q10
-- List entertainers who have either never been booked or do not have a webpage
-- or email address.
SELECT ent.entertainerid,entstagename
FROM entertainers ent
LEFT JOIN engagements eng ON ent.entertainerid = eng.entertainerid 
WHERE eng.entertainerid IS NULL OR entwebpage IS NULL OR entemailaddress IS NULL;
-- END Q10

