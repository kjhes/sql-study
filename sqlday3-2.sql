use my_shop;
-- SELECT ~ FROM = > where /order by 
	-- 			between and
	--          in /not in
	--       	like '%_'
	--    		(select) 다중검색
	-- 			distinct
    
select prod_name , prod_price,  prod_quantity , prod_price * prod_quantity as value
from products;

-- 상품 가격에 택베비 3000원 추가
select prod_name , prod_price , prod_price + 3000 as value
from products; 

-- 상품 가격을 10으로 나눠서 무이자 할부시 월 납부엑 구학
select prod_name , prod_price, prod_price / 10 as `월 납부액` -- 백틱(`) 
from products; 
 
 -- 문자열 함수
-- concat : 문자 연결
select cus_name , cus_email  from customers;

select concat(cus_name , '(' , cus_email , ')') as `이름과 메일` from customers;

select cus_email , upper(cus_email) as `대문자메일`
from customers;

select cus_name , char_length(cus_name) as `글자 수` ,length(cus_name) as 바이트수
from customers;

select prod_name , ifnull(prod_explain, '상품설명 없음') as 설명  -- null 값이 라면 이걸로 체워넣어라 백틱 안됨 
from products;

select cus_email, substring_index(cus_email , '@',1) as 아이디 -- email 을 @를 중심으로 쪼갬 1이면 왼쪽걸 가져오고 -1 이면 오른쪽 걸 가져옴 
from customers;

