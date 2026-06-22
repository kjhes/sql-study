-- CRUD(넣고/읽고/수정/삭제) - 기본작업
create database my_shop; 
use my_shop;
create table sample ( 
	pro_id int primary key, 
    p_name char(100), 
	price int,
    quan int,
    re_date date);
desc sample; 
show databases;
show tables;

-- c(입력) : insert 
insert into sample (pro_id,p_name,price,quan,re_date) value (1,'새우깡',3000,100,'2026-05-03');
insert into sample (pro_id,p_name,price,quan,re_date) value (2,'양파링',2500,300,'2026-04-01');

-- r(읽기) : select
select * from sample;
select pro_id,p_name from sample;

-- (갱신, 수정) :update
update sample set price = 5000 where pro_id = 1; 

-- 양파링의 수량 1000개로 수정
update sample set quan = 1000 where pro_id = 2; 

-- d(삭제) : delete
delete from sample where pro_id = 2;


 
