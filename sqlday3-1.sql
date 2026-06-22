use my_shop;
select * from customers;
select * from products
	where prod_name like '아__'; -- 밑줄은 글자 한 자리를 의미 한다. 
select * from products
	where prod_name like '아%'; -- 아로 시작하는 모든 이름 
select * from products
	where prod_price < 500000 or prod_price > 800000; -- 50만 미만 or 80만 초과 
select * from products
	where prod_price between 300000 and 500000; -- between 30만 ~ 50만 

-- order by ( 정렬 ) asc(오름차순, 기본으로 생략이 가능하다) desc(내림차순) 

-- customers -> cus_jointm(가입 일시)최근순으로 나열 
select * from customers
	order by cus_jointm desc; 

-- 
select * from products
	order by prod_price asc;

-- 다중 열 정렬
select * from products 
	order by prod_quantity desc, prod_price asc; -- 1차적으로 재고 수량으로 내림차순을 하고 수량이 같음에 한해서 2차 정렬로 가격으로 오름차순을 한다 

--  가격이 가장 비싼 상품 나열 +@ 갯수 제한(limit)
select * from products 
	order by prod_price desc limit 2;
    
-- 재고수량이 작은 상품 3개
select * from products
	order by prod_quantity asc limit 3;
-- 1부터 시작 x  
select * from products
	order by prod_id asc  limit 2,2; -- 2부터 2개
    
-- DISTINCT   - 중복 제거 , 속성명(열이름) 앞에 씀
select DISTINCT cus_id from orders;
SELECT DISTINCT prod_id FROM orders;

-- null 값을 감시하기 위해서는 is null 사용 
select * from products
	where prod_explain is null;  -- null : 알 수 없음( ' ' ) 참이나 거짓의 계산식이 불가능함 

-- 반대로 null 이 아닌 것을 찾기 위해선 is not null 사용 
select * from products
	where prod_explain is not null;
    
-- prod_explain is null 이면 null 이면 1 아니면 0으로 출력 
select prod_id , prod_name , prod_explain is null from products;

-- desc(설명) 을 오름차순으로 정렬
select * from products -- null 값이 제일 위로 나옴 왜냐 null 값은 가장 작은 값에 해당함
	order by prod_explain asc;
    
select cus_name , cus_address from customers
	where cus_address like '%인천%';
    
select cus_name , cus_address from customers
	where cus_name in (select cus_name from customers where cus_address like '인천%');
-- orders 중에서 prod_id 가 3인 상품을 찾아서 prod_name 과 prod_price 를 출력한다,
-- 주문 테이블의 상품 번호가 3인것의 상품 코드를 가져와서 상품 테이블의 상품 번호와 일치하는 것만 찾아서 출력한다
-- 그니까 prod_id 가 prodcuts 와 orders 에서 일치해야한다 
select prod_name , prod_price from products 
	where prod_id in (select prod_id from orders where prod_id  =3);

SELECT prod_name , prod_price , prod_quantity from products
where prod_name not in ('갤럭시','아이패드');

SELECT * from products
where prod_id 
in ( SELECT prod_id from orders);


