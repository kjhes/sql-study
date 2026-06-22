use my_shop;
select * from sample;
set sql_safe_updates = 0; -- sql_safe_update  수정 / 삭제 할 수 있도록 비활성화 - 한번에 업데이트 하는걸 끔
start TRANSACTION; -- 취소가 가능하도록 안전구역 설정 한번에 실행되도록 해서
delete from sample; -- set sql_safe_update 가 꺼져 있고 transcation 이 없으면 이걸 실행하면 모든 sample 의 데이터가 날아감 
select * from sample;
ROLLBACK; -- 실행취소 transaction 을 지정했기 때문에 가능 
commit; -- transaction 확정 이제 rollback 안됨
set sql_safe_updates = 1; 