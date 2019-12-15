/* ALTER TABLE customers
ADD COLUMN promo numeric; */

--Procedimiento del trigger
create or replace function update_promo() returns trigger as $$
	begin
	update orderdetail o set price = price - (select ((price*NEW.promo)/100) from products p where o.prod_id = p.prod_id) 
    where prod_id in 
    (select prod_id from orderdetail inner join orders on orderdetail.orderid = orders.orderid where customerid = NEW.customerid);
    
    --alerta

	return NEW;
	end;
	$$
	language 'plpgsql';

/* --Crear trigger
create trigger updPromo after update of promo on customers
	for each row execute procedure update_promo(); */