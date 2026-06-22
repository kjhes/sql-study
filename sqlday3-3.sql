-- 주문 통계 테이블 

use my_shop;
CREATE TABLE order_stat (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    category VARCHAR(50), -- 카테고리
    product_name VARCHAR(100),
    price INT,
    quantity INT,
    order_date DATE
);
INSERT INTO order_stat (customer_name, category, product_name, price, quantity, order_date) VALUES
('이순신', '전자기기', '프리미엄 기계식 키보드', 150000, 1, '2025-05-10'),
('세종대왕', '도서', 'SQL 마스터링', 35000, 2, '2025-05-10'),
('신사임당', '가구', '인체공학 사무용 의자', 250000, 1, '2025-05-11'),
('이순신', '전자기기', '고성능 게이밍 마우스', 80000, 1, '2025-05-12'),
('세종대왕', '전자기기', '4K 모니터', 450000, 1, '2025-05-12'),
('장영실', '도서', '파이썬 데이터 분석', 40000, 3, '2025-05-13'),
('이순신', '문구', '고급 만년필 세트', 200000, 1, '2025-05-14'),
('세종대왕', '가구', '높이조절 스탠딩 데스크', 320000, 1, '2025-05-15'),
('신사임당', '전자기기', '노이즈캔슬링 블루투스 이어폰', 180000, 1, '2025-05-15'),
('장영실', '전자기기', '보조배터리 20000mAh', 50000, 2, '2025-05-16'),
('홍길동', NULL, 'USB-C 허브', 65000, 1, '2025-05-17'); 
-- 카테고리가 NULL인 데이터 추가

SELECT * from order_stat;

select count(customer_name) from order_stat;

select count(category) from order_stat;

select count(*) from order_stat;

SELECT sum(price * quantity) as 총매출액 , round (AVG((price * quantity))) as 평균매출액 from order_stat;

-- truncate table : 테이블 구조는 그대로 면서 내용만 전부 삭제 
-- truncate(AVG(price * quantity),1) : 함수 소수 1째 자리수 빼고 밑에 다 버림
-- 소수이하 버리는 함수    round 대신 truncate 를 사용하면 반올림이 아니라 버림
-- 집계함수(count , sum , avg , max , min )

SELECT min(order_date) as `최초 주문일` , max(order_date) as `가장 최근 주문일` from order_stat; 

select  count(customer_name) as 총주문수, 
	 count(distinct customer_name) as 순수고객수 
	from order_stat;

-- group by : 그룹으로 묶기 
-- 카테고리별 주문 건수 
select 
	category,
    count(*) as `카테고리별 건수`
from order_stat -- 테이블 명 
GROUP BY category; -- 카테고리별로 묶음 


select  -- 3번 
	customer_name,
    count(*) as `주문 횟수`,
    sum(quantity) as `총 주문 수량`,
    sum(price * quantity) as `총 구매 금액`
from order_stat  -- 1번 
group by customer_name -- 2번 
order by `총 구매 금액` desc;  -- 4번 

-- 1단계 : 고객변 총 주문 횟수 집계하기
-- 2단계 : HAVING 절을 추가하여 주문 횟수 3회 이상인 그룹 필터링 하기
-- HAVING : 그룹에 대한 조건을 필터링(걸러냄) 

select 
	customer_name,
	count(*) as `총 주문 횟수`
	
from order_stat
group by customer_name
HAVING count(*) >= 3 ; -- 조건인데 group by 에 쓰는 조건 

select  -- 5 
	category , 
    count(*) as `주문횟수`
from order_stat -- 1
where price >= 100000  -- 2
GROUP BY category  -- 3 
HAVING count(*) >=2;  -- 4  

-- where 전체 대상으로 할 수 있는 조건
-- having 이 그룹에 대한 조건  

select  -- 5 
	customer_name,  -- group by 기준이 되는 항목이라 괜찮음 
    -- product_name,  -- 집계함수가 아니여서 출력이 되지 않음 
	-- price,
    -- quantity,
    sum(price * quantity ) as  총구매금액
from order_stat -- 1 
where order_date < '2025-05-14' -- 2 
group by customer_name -- 3 
having count(*) >= 2 --  4
order by 총구매금액 desc-- 6
limit 1 ;   -- 7 


