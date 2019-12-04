-- clientesDistintos 
 Finalize GroupAggregate  (cost=4986.78..5077.99 rows=909 width=272)
   Group Key: c.customerid
   Filter: (sum(o.totalamount) > '100'::numeric)
   ->  Gather Merge  (cost=4986.78..5057.67 rows=535 width=272)
         Workers Planned: 1
         ->  Partial GroupAggregate  (cost=3986.77..3997.47 rows=535 width=272)
               Group Key: c.customerid
               ->  Sort  (cost=3986.77..3988.11 rows=535 width=272)
                     Sort Key: c.customerid
                     ->  Hash Join  (cost=670.09..3962.53 rows=535 width=272)
                           Hash Cond: (o.customerid = c.customerid)
                           ->  Parallel Seq Scan on orders o  (cost=0.00..3291.03 rows=535 width=36)
                                 Filter: ((orderdate < '2015-05-01'::date) AND (orderdate >= '2015-04-01'::date))
                           ->  Hash  (cost=493.93..493.93 rows=14093 width=240)
                                 ->  Seq Scan on customers c  (cost=0.00..493.93 rows=14093 width=240)
(15 rows)

-- clientesDistintos index orderdate
HashAggregate  (cost=2180.36..2194.00 rows=909 width=272)
   Group Key: c.customerid
   Filter: (sum(o.totalamount) > '100'::numeric)
   ->  Hash Join  (cost=691.83..2173.55 rows=909 width=272)
         Hash Cond: (o.customerid = c.customerid)
         ->  Bitmap Heap Scan on orders o  (cost=21.74..1501.07 rows=909 width=36)
               Recheck Cond: ((orderdate < '2015-05-01'::date) AND (orderdate >= '2015-04-01'::date))
               ->  Bitmap Index Scan on idx_orderdate  (cost=0.00..21.51 rows=909 width=0)
                     Index Cond: ((orderdate < '2015-05-01'::date) AND (orderdate >= '2015-04-01'::date))
         ->  Hash  (cost=493.93..493.93 rows=14093 width=240)
               ->  Seq Scan on customers c  (cost=0.00..493.93 rows=14093 width=240)
(11 rows)

