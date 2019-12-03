SELECT
	C.customerid,
	firstname,
	lastname,
	SUM(totalamount) ta
FROM
	customers C
	JOIN orders o ON C.customerid = o.customerid
WHERE
	orderdate < '2015-05-1'
	AND orderdate >= '2015-04-01'
GROUP BY
	C.customerid,
	firstname,
	lastname
HAVING
	SUM(totalamount) > 100