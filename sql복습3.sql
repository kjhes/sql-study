-- 1. 사용자 생성
CREATE USER 'user1'@'localhost'
IDENTIFIED BY 'sql123';

-- 2. 권한 부여와 회수
GRANT SELECT,INSERT ON 주문 TO 'user1'@'localhost';
SHOW GRANTS FOR 'user1'@'localhost';
REVOKE INSERT ON 주문 FROM 'user1'@'localhost';

DROP USER 'user1'@'localhost';

-- 3. AUTO COMMIT 해제
SET AUTOCOMMIT = 0;

-- 4. 트랜잭션 시작 -> 변경 -> 복구지점 설정
START TRANSACTION;
UPDATE 주문 SET 주문가격 = 20000
WHERE 주문번호 = 'O1001';
SELECT * FROM 주문;
SAVEPOINT p1;

SET SQL_SAFE_UPDATES = 0; -- 안전 모드 비활성화
DELETE FROM 주문 WHERE 주문번호='O1003';
SELECT * FROM 주문;
ROLLBACK TO SAVEPOINT p1;
SELECT * FROM 주문 WHERE 주문번호 = 'O1001';
COMMIT;

DROP USER 'user1'@'localhost';

show grants;