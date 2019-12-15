drop index if exists idx_orderdate;
drop index if exists idx_totalamount;
drop index if exists idx_orderdate_totalamount;
drop index if exists idx_totalamount_orderdate;


\echo '\nConsulta sin indices añadidos'
EXPLAIN
SELECT COUNT(DISTINCT C.customerid) as NumClientes
FROM
	customers C
	JOIN orders o ON C.customerid = o.customerid
WHERE
	orderdate < '2015-05-1'
	AND orderdate >= '2015-04-01'
	AND totalamount > 100;


create index idx_orderdate on orders(orderdate);
\echo '\nConsulta con indice en orderdate'
EXPLAIN
SELECT COUNT(DISTINCT C.customerid) as NumClientes
FROM
	customers C
	JOIN orders o ON C.customerid = o.customerid
WHERE
	orderdate < '2015-05-1'
	AND orderdate >= '2015-04-01'
	AND totalamount > 100;


drop index idx_orderdate;
create index idx_totalamount on orders(totalamount);
\echo '\nConsulta con indice en totalamount'
EXPLAIN
SELECT COUNT(DISTINCT C.customerid) as NumClientes
FROM
	customers C
	JOIN orders o ON C.customerid = o.customerid
WHERE
	orderdate < '2015-05-1'
	AND orderdate >= '2015-04-01'
	AND totalamount > 100;


drop index idx_totalamount;
create index idx_orderdate_totalamount on orders(orderdate, totalamount);
\echo '\nConsulta con indice multicolumna como (orderdate, totalamount)'
EXPLAIN
SELECT COUNT(DISTINCT C.customerid) as NumClientes
FROM
	customers C
	JOIN orders o ON C.customerid = o.customerid
WHERE
	orderdate < '2015-05-1'
	AND orderdate >= '2015-04-01'
	AND totalamount > 100;


drop index idx_orderdate_totalamount;
create index idx_totalamount_orderdate on orders(totalamount, orderdate);
\echo '\nConsulta con indice multicolumna como (totalamount, orderdate)'
EXPLAIN
SELECT COUNT(DISTINCT C.customerid) as NumClientes
FROM
	customers C
	JOIN orders o ON C.customerid = o.customerid
WHERE
	orderdate < '2015-05-1'
	AND orderdate >= '2015-04-01'
	AND totalamount > 100;

drop index idx_totalamount_orderdate;