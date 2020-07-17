-- DDL

-- 1. 테이블 생성
-- 1) 데이터 타입 : varchar(), char(), number(),date
-- 2) 의사칼럼 : 실제테이블에 존재하지 않는 가짜 컬럼
select rownum, food, rowid from dueui where rownum <=3;
select "number", food, price from 
(select rownum as "number", food, price from dueui)
where "number" between 2 and 4;
-- 3) 여러가지 방법으로 테이블 생성하기 : 전체복사/특정칼럼복사/특정행복사/구조만복사



-- 2. 테이블 제약조건
-- 1) primary key : not null + unique
-- 2) foreign key 
create table du (
name varchar(20),
foreign key(name) references dueui(food),
money int,
other varchar(30)
);
-- 3) unique key : 중복x
-- 4) not null : 공백x
-- 5) check
 CREATE TABLE CK_TAB1 ( 
 DEPTNO NUMBER(2) CHECK (DEPTNO IN (10,20,30,40,50)), -- 이 5개의 숫자만 레코드 삽입 가능
 DNAME CHAR(14), 
 LOC CHAR(13)
 );
 
 
-- 3. 테이블 구조 변경
-- 표에서 세로형, 즉 족에 관여하는 함수
-- 1) 칼럼 추가 
 alter table name add(column_name,데이터타입);
-- 2) 칼럼 데이터타입 변경
 alter table name modify(column_name 변경하고자 하는 데이터타입) --데이터 타입 변경
-- 3) 기존 칼럼 삭제
alter table name drop column column_name;
-- 4) 모든 데이터 삭제 : 구조만 남김
truncate table name;
truncate table emp01;
select*from emp01;
-- 5) 테이블 삭제 : 아예 삭제
drop table name;
drop table name purge;
purge recyclebin;




