-- <쇼핑몰 테이블>
/*쇼핑몰 테이블 실전 설계
고객 (customers)
- 고객 id, 이름, 이메일, 비밀번호, 주소, 가입 시각 
상품 (products)
- 상품 id, 상품명, 설명, 가격, 재고 수량 
주문 (orders)
- 주문 id, 주문 고객, 주문 상품, 주문 수량, 주문 시각, 주문 상태

- 주문이 등록되면 최초의 주문 상태는 주문상태가 된다
- 한 번의 주문 시에 한 종류의 상품만 주문할 수 있다. 한 종류의 상품을 여러 개 주문하는 것은 가능하다.*/
use my_shop;
drop table customers,products;
desc products;
create table customers (
	cus_id int auto_increment primary key, -- 고객 id , auto_increment: 자동으로 번호 부여 , primary key: 기본키 
    cus_name varchar(50) not null, -- 고객 이름  varchar : 가변적인 길이에 따라 메모리를 차지함 , char : 고정적으로 메모리를 차지함 
    cus_email varchar(100) not null unique, -- 고객 이메일  not null : 공백으로 값을 체워두는 것을 허용하지 않는다 꼭 입력해라
    cus_passwd varchar(255) not null, --  고객 비밀번호 unique : 유일해야함
    cus_address varchar(200) not null, -- 고객 주소 
	cus_jointm datetime default current_timestamp -- date 는 날짜만 나오고 datetime 은 날짜와 시간이 나온다 
	-- default : 입력하지 않아도 기본으로 들어가는 값  
    -- curent timestamp : 현재의 날짜 시간 
);
create table products (
	prod_id int auto_increment primary key ,
    prod_name varchar(100) not null,
    prod_explain text, -- 긴 문자열 바이트로 정하기 애매한(ex 설명) 
    prod_price int not null,
    prod_quantity int not null default 0
);
create table orders (
	cus_id int not null,
    prod_id int not null,
	order_id int auto_increment primary key,
    order_quantity int not null constraint thk_order_quan check(order_quantity >=1 ),
    order_date datetime default current_timestamp not null,
    order_status varchar(20) not null default '주문접수',
    constraint fk_orders_customers foreign key (cus_id)
		references customers(cus_id)
        -- 주문 테이블의 cus_id(외래키) - 고객이름의 cus_id 랑 연결되어져 있음
        -- fk_orders_customer : 제약조건마다 이름을 정해둠 
		on update cascade,
        -- cascade : 부모 테이블이 갱신(수정,삭제)되면 다른 자식 테이블도 같이 삭제 수정 갱신된다 
	constraint fk_orders_products foreign key (prod_id)
		references products(prod_id)
		-- 주문 테이블의 prod_id(외래키) - 고객이름의 prod_id 랑 연결되어져 있음
        on update cascade
	
);	
desc orders;
desc products;
desc customers;
show tables;
set FOREIGN_KEY_CHECKS =0;
set foreign_key_checks =1; 
set sql_safe_updates = 0; # 원래 기본키로만 where 즉 조건을 작성했었는데 하지만 일반 속성으로도 조건을 쓰고 싶으면 safe mode 를 끄고 실행해야 한다
set sql_safe_updates = 1;
drop table customers;
insert into customers (cus_name, cus_email, cus_passwd, cus_address, cus_jointm) 
	values ('이순신', 'sunsin@naver.com', 'password123', '서울특별시 중구 세종대로', '2026-05-01 10:30:00'), ('세종대왕', 'sejong@naver.com', 'password456', '서울특별시 종로구 사직로', '2025-04-01'), ('장영실', 'young@naver.com', 'password789', '부산광역시 동래구 복천동', '2026-03-10'),('강감찬', 'kang@naver.com', 'password777', '인천 남동구 구월동');
INSERT INTO products (prod_name, prod_explain, prod_price, prod_quantity) VALUES
('갤럭시', '최신 AI 기능이 탑재된 고성능 스마트폰', 1000000, 55),
('LG 그램', '초경량 디자인과 강력한 성능을 자랑하는 노트북', 500000, 35),
('아이폰', '직관적인 사용자 경험을 제공하는 스마트폰', 800000, 55),
('에어팟', '편리한 사용성의 무선 이어폰', 200000, 110),
('알뜰폰', NULL, 300000, 100);
INSERT INTO orders (cus_id, prod_id, order_quantity) VALUES
(1, 1, 1), -- 이순신 고객이 갤럭시 1개 주문
(2, 2, 1), -- 세종대왕 고객이 LG 그램 1개 주문
(3, 3, 1), -- 장영실 고객이 아이폰 1개 주문
(1, 4, 2), -- 이순신 고객이 에어팟 2개 추가 주문
(2, 2, 1); -- 세종대왕 고객이 LG 그램 1개 주문(추가 주문)
update customers set cus_id = 10 where cus_id = 4;
update customers set cus_passwd = 'password100' where cus_id = 10;
-- delete from customers where cus_id = 10; : customer 에 있는 것들을 지우겠다(cus_id 가 10인)
insert into customers (cus_email,cus_passwd,cus_address) # cus_name 은 not null 이여서 입력안하면 오류가 난다
value ('aaa@naver.com','pass111','인천 미추홀구 용현동');
insert into customers (cus_name,cus_email,cus_passwd,cus_address) # cus_email 이 unique 값 이여서 안됨
values ('홍길동','kang@naver.com','pass9999','인천 남동구 논현동');
insert into orders(cus_id,prod_id,order_quantity) # 외래키 본체에 cus_id 12번이 없어서 추가가되지 않는다
values (12,1,1);
update customers set cus_passwd = 'pass333' where cus_name = '장영실';
-- 인덱스 생성 
create index i_price on products(prod_price);
select * from products where prod_price >= 500000;



select * from  customers;
select * from products;
select * from orders;  

-- 한 테이블 안에서만 가져와서 뷰를 만드는 방법 
create view v_masking as -- view(뷰): 데이터를 따로 저장 안함, 필요한 것만 가져와서 사용자에게 보내줌 
	select
    cus_id,
    cus_name,
    cus_email,
    cus_jointm
    from customers
    where cus_address like '%서울%'; -- like 와 같다 % - 모든 문자를 대체 (공백도 대체)  
select * from v_masking;

create view abc as
	select 
    prod_name,
    prod_explain,
    prod_price
    from products 
    where prod_explain like '%AI%';
select * from abc;
-- 여러 테이블에서 받아와서 view 만들기 
create view v_order_details as 
	select 
    o.order_id as 주문번호,
	c.cus_name as 고객이름,
    p.prod_name as 상품명 ,
    o.order_date as 주문날짜,
    o.order_status as 주문상태
	from orders o -- orders 를 o 라고 별명 붙임 
	join customers c on o.cus_id = c.cus_id -- customers 를 c라고  on 외래키랑 같은 cus_id 인 것들만 합침 
    join products p on o.prod_id = p.prod_id; -- products 를 p 라고  on 외래키랑 같은 prod_id 인 것들만 합침
select * from v_order_details;	
create view abcd as 
	select 
    a.order_id as 주문번호,
    b.cus_id as 고객번호,
    b.cus_name as 고객명,
    a.order_quantity as 주문량
    from orders a 
    join customers b on a.cus_id = b.cus_id;
select * from abcd ;
drop view v_masking restrict;

select cus_id,cus_address from customers;
select * from products where prod_price >= 700000;
select * from customers 
	where cus_jointm >= '2026-1-1';
select prod_price , prod_quantity from products
	where prod_price >= 500000 and prod_quantity >= 50;
select * from products
	where prod_price not between 500000 and 1000000;
select * from products 
	where prod_name not in ('갤럭시','아이폰','에어팟');
select * from customers
	where cus_name like '%운%';
select * from customers 
	where cus_name like '이__';  -- 및줄은 글자 수 제한이 있음 
select * from customers
	where cus_name like '세___';
    
select * from customers
	where cus_address not like '%서울특별시%';

