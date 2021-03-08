-- START Q8
SELECT f.name, COUNT(*) num_bookings
FROM facilities f
JOIN bookings b
USING (facid)
GROUP BY 1;
-- END Q8


-- START Q9
SELECT memid,firstname,surname, SUM(membercost) total_revenue
FROM facilities f
NATURAL JOIN bookings b
NATURAL JOIN members m
GROUP BY 1,2,3
ORDER BY total_revenue DESC
LIMIT 3;
-- END Q9


-- START Q11
SELECT mems.firstname memfname,mems.surname memsname,recs.firstname recfname,recs.surname recsname
FROM members mems
JOIN members recs ON mems.recommendedby = recs.memid
ORDER BY 2,1;
-- END Q11

-- START Q18
SELECT standard_amt_usd,SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year',occurred_at) 
													ORDER BY occurred_at) AS running_total
FROM orders;
-- END Q18

-- START Q20
SELECT DISTINCT r.*, COUNT(*) OVER (PARTITION BY r.name)
FROM region r
JOIN sales_reps s ON r.id = s.region_id
ORDER BY id DESC;
-- END Q20

-- START Q21
SELECT standard_qty, DATE_TRUNC('year',occurred_at)::date AS month,
SUM(standard_qty) OVER (PARTITION BY DATE_TRUNC('year',occurred_at) ORDER BY occurred_at)
FROM orders;
-- END Q21


