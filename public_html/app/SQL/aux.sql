UPDATE customers SET promo = 20 WHERE customerid=5751;
SELECT * FROM orderdetail inner join orders on orders.orderid = orderdetail.orderid where orders.orderid=74873 or orders.orderid=1065;