-- dml_work.sql

/*
DML : SELECT, INSERT, UPDATE, DELETE
commit : 작업내용 db 반영
commit 대상 : INSRT, UPDATE, DELETE
   -> 기본 쿼리 실습
   -> 서브 쿼리 실습
select : commit 대상 아님
*/

-- table 생성
drop table dept01 purge;

create table dept01(
deptno number(4),
dname varchar(30),
loc varchar(20)
);

-- 1. 레코드 삽입

insert into dept01 (deptno, dname, loc) 
values(10,'ACCOUNTIN','NEW YORK');

--<문제1> 
drop table sam01 purge;
create table sam01 as select empno,ename,job,sal from emp where 1=0;
select*from sam01;

drop table sam02 purge;
create table sam02 as select empno,ename,job,sal from emp;
truncate table sam02;
select*from sam02;

insert into sam01 values(1000,'APPLE','POLICE',10000);
insert into sam01 values(1010,'BANANA','NURSE',15000);
insert into sam01 values(1020,'ORANGE','DOCTOR',25000);
select*from sam01;

-- NULL 입력
-- 1) 암시적  NULL 입력
INSERT INTO DEPT01 (DEPTNO, DNAME) VALUES (30, 'SALES');
-- 2) 명시적 NULL 입력
INSERT INTO DEPT01 VALUES (40, 'OPERATIONS', NULL); 
INSERT INTO DEPT01 VALUES (50, '', 'CHICAGO'); 

SELECT*FROM DEPT01;

--<문제2>
SELECT*FROM SAM01;
INSERT INTO SAM01 VALUES(1030,'VERY','',25000);
INSERT INTO SAM01 VALUES(1040,'CAT',NULL,2000);

-- 서브쿼리를 이용한 레코드 삽입
DROP TABLE DEPT02; 
CREATE TABLE DEPT02
AS 
SELECT * FROM DEPT WHERE 1=0;

SELECT*FROM DEPT02;

INSERT INTO DEPT02 SELECT * FROM DEPT;

SELECT*FROM DEPT02;

--<문제3>
SELECT*FROM SAM01;
INSERT INTO SAM01 SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE DEPTNO=10;
SELECT*FROM SAM01;

-- 2. 다중 테이블에 다중 행 삽입하기

--1) 두개의 TABLE 준비
create table emp_hir 
as
select empno, ename, hiredate from emp where 1=0;

create table emp_mgr 
as
select empno, ename, mgr from emp where 1=0;

--2) 두개의 테이블에 다중 행 입력
insert all 
into emp_hir values(empno,ename,hiredate)
into emp_mgr values(empno,ename,mgr)
select empno,ename,hiredate,mgr from emp where deptno=20;

select*from emp_hir;
select*from emp_mgr;

-- 3. 테이블 내용 수정 : UPDATE

create table emp01 as select*from emp;
UPDATE EMP01 SET DEPTNO=30;
UPDATE EMP01 SET SAL = SAL * 1.1; where deptno=30;
UPDATE EMP01 SET HIREDATE = SYSDATE; 
select*from emp01;

drop table emp01 purge;
create table emp01 as select*from emp;
update emp01 set deptno=30 where deptno=10;
update emp01 set sal=sal*1.1 where sal>=3000;

-- 입사년도에서 년도 수정
update emp01 set hiredate=sysdate where hiredate between '1987/01/01' and '1987/12/31';
UPDATE EMP01 SET HIREDATE = SYSDATE WHERE SUBSTR(HIREDATE, 1, 2)='87';
update emp01 set hiredate=sysdate where hiredate like '81%';

-- 급여 삭감
select*from sam01;
update sam01 set sal=sal-5000 where sal >= 10000;
-- 2개 이상의 칼럼 값 변경
update emp01 set deptno=20, job='MANAGER' where ename='SCOTT';
update emp01 set hiredate=sysdate, sal=50, comm=4000 where ename='SCOTT';
-- 서브쿼리를 이용해 데이터 수정
UPDATE DEPT01 SET LOC=
(SELECT LOC FROM DEPT01 WHERE DEPTNO=10) 
WHERE DEPTNO=20;  -- dept01 테이블에 20번 부서의 지역을 10번 부서의 지역과 동일하게 바꿈

--<문제5>
drop table sam02 purge;
create table sam02 as select ename,sal,hiredate,deptno from emp;
select*from sam02;
--<문제6>
update sam02 set sal=sal+1000 
where deptno=(select deptno from dept where loc='DALLAS');
select*from sam02;
-- 서브쿼리로 두개의 칼럼 값 한번에 변경
select*from dept01;
update dept01 set 
(dname,loc) = (select dname,loc from dept01 where deptno=10) 
where deptno=50;
--<문제7>
update sam02 set (sal,hiredate) =
(select sal,hiredate from sam02 where ename='KING');
select*from sam02;

-- 4. 테이블의 행 삭제 : DELETE 

delete from dept01 where deptno=30;
delete from dept01; -- = truncate table dept01; 테이블의 모든 데이터 지우는데 쓸 수 있는 두가지 함수
select*from dept01;
truncate table dept01;

--<문제8>
delete from sam01 where job is null;
select*from sam01;

--서브쿼리를 이용한 레코드 삭제
DELETE FROM EMP01 WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');
select*from emp01;

