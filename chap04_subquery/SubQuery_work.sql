--subQuery_work.sql

/*
형식1)
main query -> 2차 실행
as 
sub query; -> 1차 실행

형식2)
main query 관계연산자 sub query;
*/

--형식1)

CREATE TABLE DEPT01 AS SELECT * FROM DEPT; 
select*from dept01;
insert into DEPT01 values(50,'ACCOUNTING', 'NEW YORK'); 
select * from DEPT01;

--형식2)
select*from dept01 where deptno = (select deptno from emp where ename='SCOTT');



--1. 단일행 서브쿼리

--<실습1> SCOTT과 같은 부서에서 근무하는 사원의 이름과 부서 번호를 출력 하는 SQL 문을 작성해 보시오. (EMP)
select ename,deptno from emp 
where deptno=(select deptno from emp where ename='SCOTT');

--<실습2>SCOTT와 동일한 직속상관(MGR)을 가진 사원을 출력하는 SQL 문을 작성해 보시오. (EMP)
select*from emp 
where mgr=(select mgr from emp where ename='SCOTT');

--<실습3>SCOTT의 급여와 동일하거나 더 많이 받는 사원 명과 급여를 출력하 시오.(EMP)
select ename, sal from emp 
where sal >= (select sal from emp where ename='SCOTT');

--<실습4>DALLAS에서 근무하는 사원의 이름, 부서 번호를 출력하시오. (서브쿼리 : DEPT01, 메인쿼리 : EMP)
select ename,deptno from emp 
where deptno = (select deptno from dept01 where loc='DALLAS');

--<실습5>SALES(영업부) 부서에서 근무하는 모든 사원의 이름과 급여를 출력하시오.(서브쿼리 : DEPT01, 메인쿼리 : EMP
select ename,sal from emp 
where deptno = (select deptno from dept01 where dname='SALES');

--문) 연구부서(RESEARCH)에서 근무하는 모든 사원 정보를 출력하시오.(서브:?, 메인:?)
select*from emp 
where deptno=(select deptno from dept01 where dname='RESEARCH');



--2. 단일행 서브쿼리 (집합함수)

SELECT ENAME, SAL FROM EMP 
WHERE SAL > (SELECT AVG(SAL) FROM EMP) ORDER BY SAL ; 

select sum(sal) from emp;

--문) 평균 이하 급여 수령자 출력하기
select*from emp where sal <= (select avg(sal) from emp);



--3. 다중행 서브쿼리 (IN, ANY, ALL)

--1) IN (list)
SELECT ENAME, SAL, DEPTNO FROM EMP 
WHERE DEPTNO IN 
(SELECT DISTINCT DEPTNO FROM EMP WHERE SAL>=3000);


--<실습7>부서별로 가장 급여를 많이 받는 사원의 정보(사원 번호, 사원이름, 급여, 부서번호)를 출력하시오.(IN, MAX 연산자와 GROUP BY 이용)
select*from emp where sal 
in (select max(sal) from emp group by deptno);

--<실습8>직급(JOB)이 MANAGER인 사람이 속한 부서의 부서 번호와 부서명과 지역을 출력하시오.(DEPT01과 EMP 테이블 이용)
select dname, deptno, loc from dept01 where deptno in (select deptno from emp where job='MANAGER');


--2) ALL : 서브쿼리의 최대값 이상 검색
SELECT ENAME, SAL FROM EMP WHERE SAL > ALL
(SELECT SAL FROM EMP WHERE DEPTNO =30);

--3) ANY(OR) : 서브쿼리의 최솟값 이상 검색
SELECT ENAME, SAL FROM EMP WHERE SAL > ANY 
( SELECT SAL FROM EMP WHERE DEPTNO = 30 );

--<실습9>영업 사원들 보다 급여를 많이 받는 사원들의 이름과 급여와 직급 (담당 업무)를 출력하되 영업 사원은 출력하지 않습니다. 
select ename,sal,job from emp where sal > all 
(select sal from emp where job='SALESMAN') ORDER BY SAL;

--<실습10>영업 사원들의 최소 급여를 많이 받는 사원들의 이름과 급여와 직급(담당 업무)를 출력하되 영업 사원은 출력하 지 않습니다
select ename,sal,job from emp where job<>'SALESMAN' and sal > any 
(select sal from emp where job='SALESMAN')
