-- 1. SELECT문 기본
-- NVL 활용하기
select ename, sal, sal+300 from emp;
select empno,ename,sal,comm,sal+comm/100 from emp;
select empno,ename,sal,comm,sal+nvl(comm,0)/100 from emp;
-- distinct 활용하기 
select distinct job from emp; --중복되지 않은 job의 데이터를 출력
select distinct deptno,job from emp; --emp테이블에서 deptno별로 job을 한번씩 출력





-- 2. 조건검색 (WHERE사용)
-- EMP 테이블에서 hiredate가 1982년 01월 01일 이후 인 사원의 ename 출력 
select ename from emp 
where hiredate >= to_date('1982/01/01','yyyy/mm/dd');
--or
select empno,ename,job,sal,hiredate,deptno from emp 
where hiredate >= '1982/01/01';
--EMP 테이블에서 empno가 7902,7788,7566인 사원의 ename를 출력
--IN 연산자 사용하는 문제인데 다른 함수 사용해서 같은 값 도출하기
select ename from emp where empno=7902 or empno=7788 or empno=7566;
select ename from emp where empno in
(select empno from emp where empno in (7902,7788,7566));
--EMP 테이블에서 hiredate가 1982년인 사원의 ename를 출력
select ename from emp where hiredate like '82%';
--emp 테이블에서 job이 SALESMAN 이거나 PRESIDENT이고 sal이 1500이 넘는 사원의 ename출력
SELECT ename FROM emp 
WHERE job = 'SALESMAN' OR job = 'PRESIDENT' AND sal > 1500; -- X
SELECT ename FROM emp 
WHERE (job = 'SALESMAN' OR job = 'PRESIDENT') AND sal > 1500; -- O
--EMP 테이블에서 hiredate가 1982년인 사원의 모든 정보를 출력하는 SELECT 문을 작성 
select*from emp where hiredate like '82%';
--or
select * from emp 
where hiredate 
between to_date('1982/01/01','yyyy/mm/dd') and to_date('1982/12/31','yyyy/mm/dd');
--or
select * from emp 
where hiredate between '1982-01-01' and '1982-12-30';
--EMP 테이블에서 job이 CLERK이거나 ANALYST이고 
--sal이 1000,3000,5000이 아닌 모든 사원의 정보를 출력하는 SELECT 문을 작성
select*from emp 
where (job='CLERK' OR JOB='ANALYST') AND SAL NOT IN (1000,3000,5000);
--or
select*from emp 
where job IN ('CLERK','ANALYST') AND sal not in (1000,3000,5000);
--EMP 테이블에서 ename에 L이 두 자가 있고 deptno가 30이거나 또는 mgr이 7782인 사원의 모든 정보를 출력하는 SELECT 문을 작성.
select*from emp where ename like '%L%L%' and (deptno=30 or mgr=7782);




-- 3. 검색 레코드 정렬 : order by (asc, desc)










