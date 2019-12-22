ALTER TABLE customers
ADD COLUMN promo numeric;

	--Procedimiento del trigger
create or replace function update_promo() returns trigger as $$
	begin
	update orderdetail o set price = price - (select ((price*NEW.promo)/100) from products p where o.prod_id = p.prod_id) 
    where prod_id in 
    (select prod_id from orderdetail inner join orders on orderdetail.orderid = orders.orderid where orders.status is null and customerid = NEW.customerid);
    --alerta
	perform pg_sleep(60);

	return NEW;
	end;
	$$
	language 'plpgsql';

 --Crear trigger
drop trigger if exists updPromo on customers;
create trigger updPromo after update of promo on customers
	for each row execute procedure update_promo();


/* Sentencias de prueba
SELECT * FROM orders WHERE orderid=174528
SELECT * FROM orderdetail WHERE orderid=174528
UPDATE customers SET promo=20 WHERE customerid=13539
UPDATE orders SET status=null WHERE orderid=174528 */