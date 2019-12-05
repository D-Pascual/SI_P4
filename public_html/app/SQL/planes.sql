-- clientesDistintos 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=5240.13..5240.14 rows=1 width=8)
   ->  Gather  (cost=1000.28..5239.37 rows=303 width=4)
         Workers Planned: 1
         ->  Nested Loop  (cost=0.29..4209.07 rows=178 width=4)
               ->  Parallel Seq Scan on orders o  (cost=0.00..3558.37 rows=178 width=4)
                     Filter: ((orderdate < '2015-05-01'::date) AND (orderdate >= '2015-04-01'::date) AND (totalamount > '100'::numeric))
               ->  Index Only Scan using customers_pkey on customers c  (cost=0.29..3.66 rows=1 width=4)
                     Index Cond: (customerid = o.customerid)
(8 filas)



-- clientesDistintos index orderdate
----------------------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=2174.83..2174.84 rows=1 width=8)
   ->  Hash Join  (cost=691.68..2174.08 rows=303 width=4)
         Hash Cond: (o.customerid = c.customerid)
         ->  Bitmap Heap Scan on orders o  (cost=21.59..1503.19 rows=303 width=4)
               Recheck Cond: ((orderdate < '2015-05-01'::date) AND (orderdate >= '2015-04-01'::date))
               Filter: (totalamount > '100'::numeric)
               ->  Bitmap Index Scan on idx_orderdate  (cost=0.00..21.51 rows=909 width=0)
                     Index Cond: ((orderdate < '2015-05-01'::date) AND (orderdate >= '2015-04-01'::date))
         ->  Hash  (cost=493.93..493.93 rows=14093 width=4)
               ->  Seq Scan on customers c  (cost=0.00..493.93 rows=14093 width=4)
(10 filas)


-- clientesDistintos index totalamount
-------------------------------------------------------------------------------------------------
 Aggregate  (cost=4546.07..4546.08 rows=1 width=8)
   ->  Hash Join  (cost=1797.07..4545.31 rows=303 width=4)
         Hash Cond: (o.customerid = c.customerid)
         ->  Bitmap Heap Scan on orders o  (cost=1126.97..3874.42 rows=303 width=4)
               Recheck Cond: (totalamount > '100'::numeric)
               Filter: ((orderdate < '2015-05-01'::date) AND (orderdate >= '2015-04-01'::date))
               ->  Bitmap Index Scan on idx_totalamount  (cost=0.00..1126.90 rows=60597 width=0)
                     Index Cond: (totalamount > '100'::numeric)
         ->  Hash  (cost=493.93..493.93 rows=14093 width=4)
               ->  Seq Scan on customers c  (cost=0.00..493.93 rows=14093 width=4)
(10 filas)

-- clientesDistintos index orderdate, totalamount
-------
 Aggregate  (cost=1480.42..1480.43 rows=1 width=8)
   ->  Hash Join  (cost=697.95..1479.66 rows=303 width=4)
         Hash Cond: (o.customerid = c.customerid)
         ->  Bitmap Heap Scan on orders o  (cost=27.86..808.78 rows=303 width=4)
               Recheck Cond: ((orderdate < '2015-05-01'::date) AND (orderdate >= '2015-04-01'::date) AND (totalamount > '100'::numeric))
               ->  Bitmap Index Scan on idx_doble  (cost=0.00..27.78 rows=303 width=0)
                     Index Cond: ((orderdate < '2015-05-01'::date) AND (orderdate >= '2015-04-01'::date) AND (totalamount > '100'::numeric))
         ->  Hash  (cost=493.93..493.93 rows=14093 width=4)
               ->  Seq Scan on customers c  (cost=0.00..493.93 rows=14093 width=4)
(9 filas)

-- clientesDistintos index totalamount, orderdate
 Aggregate  (cost=3150.52..3150.53 rows=1 width=8)
   ->  Hash Join  (cost=2368.05..3149.76 rows=303 width=4)
         Hash Cond: (o.customerid = c.customerid)
         ->  Bitmap Heap Scan on orders o  (cost=1697.96..2478.88 rows=303 width=4)
               Recheck Cond: ((totalamount > '100'::numeric) AND (orderdate < '2015-05-01'::date) AND (orderdate >= '2015-04-01'::date))
               ->  Bitmap Index Scan on idx_doble2  (cost=0.00..1697.88 rows=303 width=0)
                     Index Cond: ((totalamount > '100'::numeric) AND (orderdate < '2015-05-01'::date) AND (orderdate >= '2015-04-01'::date))
         ->  Hash  (cost=493.93..493.93 rows=14093 width=4)
               ->  Seq Scan on customers c  (cost=0.00..493.93 rows=14093 width=4)
(9 filas)




