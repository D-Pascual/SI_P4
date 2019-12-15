1:
                            QUERY PLAN                             
-------------------------------------------------------------------
 Seq Scan on customers  (cost=3961.65..4490.81 rows=7046 width=4)
   Filter: (NOT (hashed SubPlan 1))
   SubPlan 1
     ->  Seq Scan on orders  (cost=0.00..3959.38 rows=909 width=4)
           Filter: ((status)::text = 'Paid'::text)
(5 rows)
2:
                                QUERY PLAN                                 
---------------------------------------------------------------------------
 HashAggregate  (cost=4537.41..4539.41 rows=200 width=4)
   Group Key: customers.customerid
   Filter: (count(*) = 1)
   ->  Append  (cost=0.00..4462.40 rows=15002 width=4)
         ->  Seq Scan on customers  (cost=0.00..493.93 rows=14093 width=4)
         ->  Seq Scan on orders  (cost=0.00..3959.38 rows=909 width=4)
               Filter: ((status)::text = 'Paid'::text)
(7 rows)

3:
                                    QUERY PLAN                                     
-----------------------------------------------------------------------------------
 HashSetOp Except  (cost=0.00..4640.83 rows=14093 width=8)
   ->  Append  (cost=0.00..4603.32 rows=15002 width=8)
         ->  Subquery Scan on "*SELECT* 1"  (cost=0.00..634.86 rows=14093 width=8)
               ->  Seq Scan on customers  (cost=0.00..493.93 rows=14093 width=4)
         ->  Subquery Scan on "*SELECT* 2"  (cost=0.00..3968.47 rows=909 width=8)
               ->  Seq Scan on orders  (cost=0.00..3959.38 rows=909 width=4)
                     Filter: ((status)::text = 'Paid'::text)
(7 rows)

