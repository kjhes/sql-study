-- 속성명과 테이블 길이 변경 
ALTER TABLE 주문 RENAME COLUMN 배송도시 TO 배송도시코드;
ALTER TABLE 주문 MODIFY 배송도시코드 VARCHAR(256);
DESC 주문;

-- 인덱스 생성 
CREATE INDEX idx_order_date on 주문(주문일);
ALTER TABLE 주문 DROP INDEX idx_order_date;
-- DROP INDEX idx_order_date on 주문; 

-- 뷰 생성
CREATE VIEW vw_order 
as select 고객.고객번호 ,count(주문.주문번호) as 주문양 , sum(주문.주문가격) as 총주문금액 
from 고객 inner join 주문 on 고객.고객번호 = 주문.고객번호
group by 고객.고객번호;

DROP VIEW vw_order;
select * from vw_order;

-- 뷰 활용한 데이터 조회
SELECT 고객번호 , 주문양 , 총주문금액 from vw_order where 총주문금액 >= 50000; 






