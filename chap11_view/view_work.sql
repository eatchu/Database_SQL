-- view_work.sql

-- 뷰(view) : 가상의 테이블
-- 작은 용량으로 물리적은 내용을 볼 수 있음

-- 1. 물리적 테이블 생성
create table db_view_tab(
id varchar(15) primary key,
name varchar(20) not null,
email varchar(50),
regdate date
);
alter table db_view_tab modify(regdate not null);

insert into db_view_tab values('hong','홍길동','hong@naver',sysdate);
insert into db_view_tab values('admin','관리자','admin@naver',sysdate);
select*from db_view_tab;

-- 2. view 생성 : 서브쿼리 이용
create view admin_view --가상테이블
as
select*from db_view_tab --실제테이블
where id='admin'; -- user(scott)가 view를 만들수있는 권한이 없기 때문에 error가 뜸
-- table에서는 사용하지 못하지만 view를 생성할때는 사용 가능한 replace
create or replace view admin_view --view가 없으면 새로 만들고 기존에 존재하면 다시 대체하기
as
select*from db_view_tab 
where id='admin' with read only; -- 읽기 전용 view 생성(수정불가능)

-- view 전체목록 확인가능
select*from user_views;
select view_name, text from user_views;
select*from admin_view;
-- view 삭제하기
drop view admin_view;


--<실습3> 뷰 정의하기 : 물리적테이블=emp
create or replace view emp_view03
as
select empno,ename,deptno
from emp
where deptno=30
with read only;

select*from emp_view03;


-- 3. 뷰의 사용 목적과 용도
/*
 * 1) 복잡한 sql문 사용시
 * 2) 보안 목적 : 접근권한에 따라서 서로 다르게 정보 제공 
 */

-- 1) 복잡한 sql 사용 시
select*from product;
select*from sale;

create or replace view join_view
as
(select p.code,p.name,s.price,s.sdate
from product p, sale s
where p.code=s.code and p.name like '%기')
with read only;

select*from join_view;

-- 2) 보안 목적
select*from emp;
--(1) 영업사원에게 제공하는 view
create or replace view sales_view
as
(select empno, ename, comm from emp
where job='SALESMAN')
order by comm
with read only;
select*from sales_view;
-- 읽기 전용 view 수정하기 : error
delete from sales_view where empno=7499;
--(2) 일반사원에게 제공하는 view
create or replace view clerk_view
as
(select empno,ename,mgr,hiredate,deptno from emp
where job='CLERK')
with read only;
select*from clerk_view;
--(3) 관리자에게 제공하는 view
create or replace view manager_view
as
(select*from emp 
where job IN ('SALESMAN','CLERK','ANALYST'))
with read only;
select*from manager_view;



-- 4. 의사칼럼 (rownum) 이용 view 생성
-- ex) 최초 입사자 top5, 급여 수령자 top3
select rownum, empno, ename from emp
where rownum <= 5;

--(1) 입사일 top5 view 생성
create or replace view top5_hiredate_view
as
select empno, ename, hiredate
from emp order by hiredate
with read only; -- select에 rownum 적용 안됨 : error

select rownum, empno, ename, hiredate
from top5_hiredate_view where rownum <= 5;

select*from top5_hiredate_view;

--(2) 가장 많은 급여 수령자 top3
select*from emp order by hiredate;
create or replace view top3_sal_view
as
select empno,ename,sal
from emp order by sal desc 
with read only;

select rownum, empno, ename, sal
from top3_sal_view
where rownum<=3;

select*from top3_sal_view;






