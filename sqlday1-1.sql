create database my_shop; -- 데이터 베이스 생성 
use my_shop; # use : 이 데이터 베이스를 사용하겠다
-- 테이블 정의(설계) : 필드 -> 상품 id, 상품이름, 가격, 재고수량, 출시일
create table sample ( -- 표 생성 
	pro_id int primary key, -- 기본키 지정 
    p_name char(100), -- 100비트를 다 잡음  varchar(100) -- 가변 문자형 최대 100까지 되지만 알아서 크기에 맞춰 잡음 
	price int,
    quan int,
    re_date date);
desc sample; -- describe 테이블 이름: 테이블 구조 확인 
show databases; -- show 데이터베이스s : 전체 데이터베이스들을 보여줌
show table status;
drop table sample; -- drop table : 테이블 삭제 (데이터 베이스를 지우기 전에 테이블 먼저 지워야함) 
drop database my_shop; -- drop database : 데이터 베이스 삭제 

