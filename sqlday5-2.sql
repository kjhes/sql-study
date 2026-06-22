use my_shop;
select * from customers;
select * from orders;

delete from customers
where cus_id =1 ;

insert into orders(cus_id ,prod_id,order_quantity)
value (1,1,10);