-- SEQUENCE

-- <function>
-- increment by n
-- start with n
-- cycle (nocycle이 기본값)
-- mixvalue n (10^27이 기본값)
-- minvalue n

-- 시퀀스 목록 확인하기
select*from seq;
-- 시퀀스 기본 정보 확인하기
select sequence_name, min_value, max_value,
increment_by, cycle_flag from user_sequences;
-- 시퀀스 생성
create sequence dudu 
start with 100
increment by 10;
-- 시퀀스 수정
alter sequence dudu
start with 100
increment by 1
maxvalue 10000;
-- 시퀀스 삭제
drop sequence dudu;
-- 시퀀스 값 확인 (가상의 의사칼럼을 이용 : dual)
select dudu.nextval from dual;

