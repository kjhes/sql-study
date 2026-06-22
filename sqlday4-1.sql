use my_shop;
use db_ex;
CREATE DATABASE db_ex;

CREATE TABLE 학생(
	학번 int PRIMARY KEY,
    이름 VARCHAR(30) NOT NULL,
    학과코드 VARCHAR(30),
    선배 INT,
    성적 INT
    );


drop table 학생;
select * from 학생;

CREATE TABLE 학과 (
   학과코드  VARCHAR(30) PRIMARY KEY,
    학과명 VARCHAR(50)  not null
    );
-- 성적등급 테이블
CREATE TABLE 성적등급 (
   등급 char PRIMARY KEY,
    최저 int not null,
    최고 int not null
    );

select * from 학과;
select * from 성적등급;
select * from 학생;

desc 학생;
desc 학과;
desc 성적등급;

drop table 학생;
drop table 학과;
drop table 성적등급;

-- 학생 데이터 
INSERT INTO 학생 VALUES (15, '한다맨', 'com', NULL, 83);
INSERT INTO 학생 VALUES (16, '이서영', 'han', NULL, 96);
INSERT INTO 학생 VALUES (17, '장효정', 'com', 15, 95);
INSERT INTO 학생 VALUES (19, '주연국', 'han', 16, 75);
INSERT INTO 학생 VALUES (37, '신동진', null, 17, 55);

-- 학과 데이터 
INSERT INTO 학과 VALUES ('com', '컴퓨터');
INSERT INTO 학과 VALUES ('han', '국어');
INSERT INTO 학과 VALUES ('eng', '영어');


-- 성적 데이터
INSERT INTO 성적등급 VALUES ('A',90,100);
INSERT INTO 성적등급 VALUES ('B',80,89);
INSERT INTO 성적등급 VALUES ('C',60,79);
INSERT INTO 성적등급 VALUES ('D',0,59);

-- equi(equal) 조인 1.where 조인 
select 학번 , 이름 , 학생.학과코드 ,학과명  
	from 학생 , 학과
	where 학생.학과코드 =학과.학과코드;

-- 2) nartural join : 반드시 해당 테이블들에 같은 값이 있어야 함.
-- 조건을 쓰지 않아도 자동으로 같은 것끼리 연결 
select 학번,이름,학생.학과코드,학과명
	from 학생 natural join 학과;

-- join~using 
select 학번 , 이름 , 학생.학과코드 ,학과명
	from 학생 join 학과 using(학과코드);

-- no equi 
select 학번 , 이름 ,성적 , 등급 from 학생,성적등급
	where 학생.성적 between 성적등급.최저 and 성적등급.최고;

-- left outer join
select 학번,이름,학생.학과코드,학과명 
	from 학생 left outer join 학과
	on 학생.학과코드 = 학과.학과코드;
-- 왼쪽 테이블(학생) 전부 가져옴, 오른쪽 테이블(학과)는 학과코드가 같은 것만 추출
# 오라클 문법 
-- select 학번 , 이름 , 학생.학과코드 ,학과명 
-- 	from 학생 , 학과
-- 	where 학생.확과코드 = 학과.확과코드(+);

-- 오른쪽 테이블을 전부 가져오고 왼쪽 테이블은 학과코드 같은 것 추출 
select 학번 , 이름 , 학생.학과코드 , 학과명 
	from 학생 right outer join 학과
    on 학생.학과코드 = 학과.학과코드;

# 오라클 문법 
-- select 학번 , 이름 , 학생.학과코드 ,학과명 
-- 	from 학생 , 학과
-- 	where 학생.확과코드(+) = 학과.확과코드;

select 학번 , 이름 , 학생.학과코드 , 학과명
from 학생 left join 학과 on 학생.확과코드 = 확과.확과코드
UNION
select 학번 ,이름 , 학생.확과코드,확과명
from 학생 
right join 학과 on 학생.학과코드 = 학과.확과코드;

-- self join : 같은 테이블에서 2개의 속성을 연결하여 equi join 하는 join 방법
select a.학번 , a.이름 ,b.이름 as 선배
	from 학생 a join 학생 b 
    on a.선배 =b.학번;
-- 하나의 테이블로 조인
-- 학생 테이블을 가상으로 하나 복사하여  사용하는 것처럼 사용 
-- 학생테이블을 a 랑 b 로 두개로 만들었음 