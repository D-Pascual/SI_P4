                                     QUERY PLAN                                      
-------------------------------------------------------------------------------------
 Aggregate  (cost=2940.35..2940.36 rows=1 width=8)
   ->  Bitmap Heap Scan on orders  (cost=712.08..2850.14 rows=36085 width=0)
         Recheck Cond: ((status)::text = 'Processed'::text)
         ->  Bitmap Index Scan on idx_status  (cost=0.00..703.06 rows=36085 width=0)
               Index Cond: ((status)::text = 'Processed'::text)
(5 rows)

