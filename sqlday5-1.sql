CREATE USER 'test_user'@'localhost' IDENTIFIED BY 'sql12345';
--  새로운 아이디와 비밀번호 부여 
GRANT SELECT ON my_shop.* TO 'test_user'@'localhost';  -- grant : 권한 부여  select : 조회 권한 만약 수정이나 삭제가 하고 싶다 delete insert 모든 걸 하고 싶다 all = *
-- on table 어떤 테이블에 권한 부여 여기서는 *이기 때문에 my_shop 안에 있는 모든 테이블에 대한 select 권한을 test_user 한테 부여

-- 권한 새로고침  
FLUSH PRIVILEGES ;
--  
REVOKE SELECT 
on my_shop.*
from 'test_user'@'localhost';

flush PRIVILEGES;


GRANT ALL PRIVILEGES 
ON my_shop.*
to 'test_user'@'localhost';

REVOKE ALL PRIVILEGES
ON my_shop.*
from 'test_user'@'localhost';

FLUSH PRIVILEGES;

GRANT SELECT ON my_shop.* to 'test_user'@'localhost'
WITH GRANT OPTION; -- 다른 사용자에게 select 권한을 부여할 수 있게 허용 

revoke all PRIVILEGES , grant option from 'test_user'@'localhost';
-- 다른 사람에게 부여한 권한도 회수 

drop user 'test_user'@'localhost';
 -- 아이디 삭제 
