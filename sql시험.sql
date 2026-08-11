DROP DATABASE IF EXISTS test;
SHOW DATABASES;
CREATE DATABASE exam;
USE exam;

CREATE TABLE 고객 (
	고객번호 VARCHAR(16) PRIMARY KEY NOT NULL,
	이름 VARCHAR(50) NOT NULL,
    비밀번호 VARCHAR(256) NOT NULL
);

CREATE TABLE 주문 (
	주문번호 VARCHAR(16) NOT NULL,
	고객번호 VARCHAR(16) ,
    FOREIGN KEY (고객번호) REFERENCES 고객(고객번호),
    주문일 VARCHAR(8) NOT NULL ,
    주문가격 INT NOT NULL,
    배송도시 VARCHAR(100)
);

INSERT INTO 고객(고객번호,이름,비밀번호) VALUES 
('C0001','홍길동','pass1234'),
('C0002','이순신','pass5678'),
('C0003','강감찬','pass9012');

INSERT INTO 주문(주문번호,고객번호,주문일,주문가격,배송도시) VALUES 
('O1001','C0001','20260801',15000,'서울'),
('O1002','C0001','20260803',45000,'부산'),
('O1003','C0002','20260805',30000,'대전');

SELECT a.고객번호 , a.이름 ,b.주문번호 , b.주문일 ,b.주문가격 ,b.배송도시 FROM 고객 a INNER JOIN 주문 b ON a.고객번호 = b.고객번호 WHERE b.배송도시 = '서울';

SELECT 고객번호 , 이름 FROM 고객 WHERE 고객번호 NOT IN (SELECT 고객번호 FROM 주문);

SELECT 고객.고객번호 ,SUM(주문.주문가격) AS 총주문금액 
FROM 고객 INNER JOIN 주문  on 고객.고객번호 = 주문.고객번호
GROUP BY 고객.고객번호
HAVING SUM(주문.주문가격) > (SELECT avg(주문가격) FROM 주문); 

SELECT avg(주문가격) from 주문;

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
as select 고객.고객번호 ,count(주문.주문번호) as 주문건수 , sum(주문.주문가격) as 총주문금액 ,avg(주문.주문가격) as 평균주문금액 
from 고객 inner join 주문 on 고객.고객번호 = 주문.고객번호
group by 고객.고객번호;

DROP VIEW vw_order;
select * from vw_order;

-- 뷰 활용한 데이터 조회
SELECT 고객번호 , 주문건수 , 총주문금액 from vw_order where 주문건수 >=2 and 총주문금액 >= 60000; 

-- 1. 사용자 생성
CREATE USER 'test_user'@'localhost'
IDENTIFIED BY 'test123';

-- 2. 권한 부여와 회수
GRANT SELECT,INSERT,UPDATE,DELETE ON 주문 TO 'test_user'@'localhost';
REVOKE UPDATE ON 주문 FROM 'test_user'@'localhost';
SHOW GRANTS FOR 'test_user'@'localhost';

-- 3. AUTO COMMIT 해제
SET AUTOCOMMIT = 0;

-- 4. 트랜잭션 시작 -> 변경 -> 복구지점 설정
START TRANSACTION;
SET SQL_SAFE_UPDATES = 0; -- 안전 모드 비활성화
UPDATE 주문 SET 주문가격 = 주문가격 *2 -- 여기서도 안전 모드 꺼야 하는데? 
WHERE 주문번호 = 'O1002';
SAVEPOINT s1;

SET SQL_SAFE_UPDATES = 0; -- 안전 모드 비활성화
DELETE FROM 주문 WHERE 배송도시코드 NOT IN ('서울','부산');

ROLLBACK TO SAVEPOINT s1;
SET SQL_SAFE_UPDATES = 1; -- 안전 모드 활성화

SELECT * FROM 주문;
COMMIT;

DROP USER 'test_user'@'localhost';





