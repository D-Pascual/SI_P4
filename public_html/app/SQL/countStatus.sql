--recien creada la DB

explain
select count(*)
from orders
where status is null;

explain
select count(*)
from orders
where status ='Shipped';

-- CREATE INDEX 
create index idx_status on orders(status);

explain
select count(*)
from orders
where status is null;

explain
select count(*)
from orders
where status ='Shipped';

-- analyze
analyze

explain
select count(*)
from orders
where status is null;

explain
select count(*)
from orders
where status ='Shipped';

-- otras sentencias

explain
select count(*)
from orders
where status ='Paid';

explain
select count(*)
from orders
where status ='Processed';