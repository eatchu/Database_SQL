-- transaction_work.sql
select*from tab;
modify
abs
create or replace 

-- 1. TABLE 생성
create table dept_test
as
select*from dept;

select*from dept_test;

-- 2. SAVEPOINT
savepoint s1;
delete from dept_test where deptno=40; 
select*from dept_test;

savepoint s2;
delete from dept_test where deptno=30; 
select*from dept_test;

savepoint s3;
delete from dept_test where deptno=20; 
select*from dept_test;

-- 3. ROLLBACK : 레코드 복원
rollback to s3;
select*from dept_test;

rollback to s1;
select*from dept_test;

-- 4. COMMIT : DB에 반영 (rollback 불가능)
delete from dept_test where deptno = 40;
commit; --db에 반영

savepoint s4;
delete from dept_test where deptno = 30;

rollback to s4;
select*from dept_test;


delete from dept_test where deptno=20;
rollback;
select*from dept_test;