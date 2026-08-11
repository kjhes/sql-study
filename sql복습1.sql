CREATE DATABASE test;
USE test;
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
DESC 주문; -- describe 구조를 보여줌 

INSERT INTO 고객(고객번호,이름,비밀번호) VALUES 
('C0001','홍길동','pass1234'),
('C0002','이순신','pass5678'),
('C0003','강감찬','pass9012');

INSERT INTO 주문(주문번호,고객번호,주문일,주문가격,배송도시) VALUES 
('O1001','C0001','20260801',15000,'서울'),
('O1002','C0001','20260803',45000,'부산'),
('O1003','C0002','20260805',30000,'대전');

SELECT * FROM 고객; 
SELECT * FROM 주문;
-- DELETE FROM 
-- inner join
SELECT 고객.고객번호 , 고객.이름 , 주문.주문번호 , 주문.주문일 , 주문.주문가격
FROM 고객 INNER JOIN 주문 ON 고객.고객번호 = 주문.고객번호
WHERE 고객.이름 = '홍길동'; 

-- 서브 쿼리 문법 
SELECT 고객번호 , 이름 FROM 고객 
WHERE 고객번호 NOT IN ( SELECT 고객번호 FROM 주문);

SELECT 고객.고객번호 ,고객.이름 ,sum(주문.주문가격) as 총주문금액
FROM 고객  INNER JOIN 주문 ON 고객.고객번호 = 주문.고객번호
GROUP BY 고객.고객번호 , 고객.이름 
HAVING 총주문금액 >= 30000
ORDER BY 총주문금액 ASC;



SELECT a.고객번호 ,a.이름 ,sum(b.주문가격) as 총주문금액
FROM 고객 a INNER JOIN 주문 b ON a.고객번호 = b.고객번호
GROUP BY a.고객번호 
HAVING 총주문금액 >= 30000
ORDER BY 총주문금액 ASC;