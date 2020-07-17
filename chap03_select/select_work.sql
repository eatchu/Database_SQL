-- select_work.sql

/*
 여러줄의 주석문
*/

--1. 전체 검색 (특정 칼럼 검색)

--테이블 목록확인
select*from tab;
--특정 테이블 조회
select*from emp;
--특정 칼럼만 조회
select empno, ename, sal, job from emp;
--산술표현식(연산자사용)
SELECT ename, sal, sal+300  FROM emp;
SELECT ename, sal+300  FROM emp;
--전체 모든 사원에 급여 10% 인상
select ename, sal, 1.1*sal from emp;

SELECT empno, ename, sal, comm, sal+comm/100 FROM emp;
update emp set comm=0 where comm is null;
SELECT empno, ename, sal, comm, sal+comm/100 FROM emp;
update emp set comm=null where comm=0;
SELECT empno, ename, sal, comm, sal+comm/100 FROM emp;
update emp set comm=0 where empno=7844;
select comm from emp;

--null 처리 함수 이용 : 연봉+수당
select ename,sal,comm,sal*12+NVL(comm,0) from emp;

--열에 별칭(Alias)부여
select ename,sal,comm,sal*12+NVL(comm,0) AS 실급여 from emp;
select ename,sal,comm,sal*12+NVL(comm,0) "실 급" from emp;

--연결 연산자(||)
SELECT ename || ' ' || job from emp;
SELECT ename || ' ' || job AS "employees" FROM emp;
SELECT ename || ' ' || 'is a' || ' ' || job AS "employees Details" FROM emp;
SELECT ename || ': 1 Year salary = ' || sal * 12 Monthly FROM emp;

--distinct : 범주형(집단변수) 칼럼(gender) 적용
select distinct job from emp;
SELECT DISTINCT deptno, job FROM emp;

--2. 조건 검색 (특정 행 검색)
SELECT empno, ename, job, sal FROM emp WHERE sal >= 3000;
SELECT empno, ename, job, sal, deptno FROM emp WHERE job = 'MANAGER';
select empno, ename, job, sal, hiredate, deptno from emp where hiredate >= to_date('1982/01/01','yyyy/mm/dd');

--sql 연산자
--between 연산자 (>=, <=로도 사용가능)
SELECT ename, job, sal, deptno FROM emp WHERE sal BETWEEN 1300 AND 1500;
select ename, job, sal, deptno from emp where sal >= 1300 and sal <= 1500;
--in 연산자 (list와 일치하는 값 찾기)
SELECT empno,ename,job,sal,hiredate FROM emp WHERE empno IN (7902,7788,7566);
SELECT empno,ename,job,sal,hiredate FROM emp WHERE empno not IN (7902,7788,7566);
select * from emp where job in 'MANAGER';

--관계식/논리 연산자
--1982 한 해 입사한 사원 찾기
SELECT empno,ename,job,sal,hiredate,deptno FROM emp where hiredate >= to_date('1982/01/01', 'yyyy/mm/dd') and hiredate <= to_date('1982/12/31', 'yyyy/mm/dd');
SELECT empno,ename,job,sal,hiredate,deptno FROM emp where hiredate between to_date('1982/01/01', 'yyyy/mm/dd') and to_date('1982/12/31', 'yyyy/mm/dd');

--like 연산자 : 포함문자 검새
--입사년도가 87로 시작하는 사람을 검색 (like '87%')
SELECT empno,ename,job,sal,hiredate,deptno FROM emp where hiredate LIKE '87%';
select * from emp where ename like 'M%';
select * from student where name like '%재%';

--논리 연산자 : AND, OR, NOT
select empno, ename, job, sal, hiredate, deptno from emp where sal >= 1100 and job = 'MANAGER';
SELECT empno,ename,job,sal,hiredate,deptno FROM emp WHERE sal >= 1100 OR job = 'MANAGER';
select empno,ename,job,sal,deptno from emp where job not in ('MANAGER','CLERK','ANALYST');
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB IN ('SALESMAN','PRESIDENT') AND SAL > 1500;

--문제)
select * from emp where deptno=10 and sal>=2500;
select * from emp where job='CLERK' or deptno=30;

--IS NULL AND IS NOT NULL
SELECT empno,ename,job,sal,comm,deptno FROM emp WHERE comm IS NULL;
SELECT empno,ename,job,sal,comm,deptno FROM emp WHERE comm IS NOT NULL;

--3. 검색 레코드 정렬

--order by
SELECT hiredate,empno,ename,job,sal,deptno FROM emp ORDER BY hiredate;
SELECT hiredate,empno,ename,job,sal,deptno FROM emp ORDER BY hiredate desc;
--order by 활용 : 다 같은 값임
SELECT empno,ename,job,sal,sal*12 annsal FROM emp ORDER BY annsal; --별칭이용
SELECT empno,ename,job,sal,sal*12 annsal FROM emp ORDER BY sal*12; --수식이용
SELECT empno,ename,job,sal,sal*12 annsal FROM emp ORDER BY 5; --칼럼위치이용
--두개 이상 칼럼으로 정렬
select deptno,sal,empno,ename,job from emp order by deptno asc, sal desc;
select deptno,job,sal,empno,ename,hiredate from emp order by deptno, job, sal desc;


