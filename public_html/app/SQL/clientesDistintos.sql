--create index idx_orderdate on orders(orderdate);
--drop index if exists idx_totalamount;
--create index idx_totalamount on orders(totalamount);
--drop index idx_orderdate;
--drop index idx_doble;
create index idx_doble2 on orders(totalamount, orderdate);


EXPLAIN
SELECT COUNT(DISTINCT C.customerid) as NumClientes
FROM
	customers C
	JOIN orders o ON C.customerid = o.customerid
WHERE
	orderdate < '2015-05-1'
	AND orderdate >= '2015-04-01'
	AND totalamount > 100