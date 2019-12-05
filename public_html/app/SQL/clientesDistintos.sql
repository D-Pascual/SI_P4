--create index idx_orderdate on orders(orderdate)
--

--EXPLAIN
SELECT COUNT(*)
FROM (
SELECT DISTINCT
	C.customerid,
	firstname,
	lastname
FROM
	customers C
	JOIN orders o ON C.customerid = o.customerid
WHERE
	orderdate < '2015-05-1'
	AND orderdate >= '2015-04-01'
	AND totalamount > 100
GROUP BY
	C.customerid,
	firstname,
	lastname) as A