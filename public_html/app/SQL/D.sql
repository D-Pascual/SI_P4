create index idx_status on orders(status)
analyze

                           QUERY PLAN                            
-----------------------------------------------------------------
 Aggregate  (cost=3507.17..3507.18 rows=1 width=8)
   ->  Seq Scan on orders  (cost=0.00..3504.90 rows=909 width=0)
         Filter: (status IS NULL)
(3 rows)

                           QUERY PLAN                            
-----------------------------------------------------------------
 Aggregate  (cost=3961.65..3961.66 rows=1 width=8)
   ->  Seq Scan on orders  (cost=0.00..3959.38 rows=909 width=0)
         Filter: ((status)::text = 'Shipped'::text)
(3 rows)

despues del index:

                                    QUERY PLAN                                    
----------------------------------------------------------------------------------
 Aggregate  (cost=1496.52..1496.53 rows=1 width=8)
   ->  Bitmap Heap Scan on orders  (cost=19.46..1494.25 rows=909 width=0)
         Recheck Cond: (status IS NULL)
         ->  Bitmap Index Scan on idx_status  (cost=0.00..19.24 rows=909 width=0)
               Index Cond: (status IS NULL)
(5 rows)

                                    QUERY PLAN                                    
----------------------------------------------------------------------------------
 Aggregate  (cost=1498.79..1498.80 rows=1 width=8)
   ->  Bitmap Heap Scan on orders  (cost=19.46..1496.52 rows=909 width=0)
         Recheck Cond: ((status)::text = 'Shipped'::text)
         ->  Bitmap Index Scan on idx_status  (cost=0.00..19.24 rows=909 width=0)
               Index Cond: ((status)::text = 'Shipped'::text)
(5 rows)

despues del analyze

                                     QUERY PLAN                                     
------------------------------------------------------------------------------------
 Aggregate  (cost=7.31..7.32 rows=1 width=8)
   ->  Index Only Scan using idx_status on orders  (cost=0.42..7.31 rows=1 width=0)
         Index Cond: (status IS NULL)
(3 rows)

                                       QUERY PLAN                                       
----------------------------------------------------------------------------------------
 Finalize Aggregate  (cost=4210.60..4210.61 rows=1 width=8)
   ->  Gather  (cost=4210.49..4210.60 rows=1 width=8)
         Workers Planned: 1
         ->  Partial Aggregate  (cost=3210.49..3210.50 rows=1 width=8)
               ->  Parallel Seq Scan on orders  (cost=0.00..3023.69 rows=74719 width=0)
                     Filter: ((status)::text = 'Shipped'::text)
(6 rows)

otras consultas:

                                     QUERY PLAN                                      
-------------------------------------------------------------------------------------
 Aggregate  (cost=2336.44..2336.45 rows=1 width=8)
   ->  Bitmap Heap Scan on orders  (cost=369.21..2289.73 rows=18682 width=0)
         Recheck Cond: ((status)::text = 'Paid'::text)
         ->  Bitmap Index Scan on idx_status  (cost=0.00..364.54 rows=18682 width=0)
               Index Cond: ((status)::text = 'Paid'::text)
(5 rows)

                                     QUERY PLAN                                      
-------------------------------------------------------------------------------------
 Aggregate  (cost=2940.35..2940.36 rows=1 width=8)
   ->  Bitmap Heap Scan on orders  (cost=712.08..2850.14 rows=36085 width=0)
         Recheck Cond: ((status)::text = 'Processed'::text)
         ->  Bitmap Index Scan on idx_status  (cost=0.00..703.06 rows=36085 width=0)
               Index Cond: ((status)::text = 'Processed'::text)
(5 rows)

