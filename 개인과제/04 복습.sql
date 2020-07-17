-- 1. 서브쿼리의 기본 개념
-- 2. 단일 행 서브쿼리 : 서브쿼리의 값이 1개만 나올때
select*from emp where mgr = (select mgr from emp where ename='SCOTT');
select ename,sal from emp where sal >= (select sal from emp where ename='SCOTT');
-- 3. 다중 행 서브쿼리 : 서브쿼리의 값이 2개 이상일때 - 이때는 다중 행 연산자를 사용해야함

--부서별로 가장 급여를 많이 받는 사원의 정보(사원 번호, 사원이름, 급여, 부서번호)를 출력하시오.
--(IN, MAX 연산자와 GROUP BY 이용) --group by 칼럼이름 
-- *********
select*from emp where sal in (select max(sal) from emp group by deptno);
-- *********



--영업 사원들의 최소 급여를 많이 받는 사원들의 이름과 급여와 직급(담당 업무)를 출력하되 
--영업 사원은 출력하 지 않습니다.
SELECT ENAME,SAL,JOB FROM EMP WHERE JOB <> 'SALESMAN' AND SAL > any
(SELECT SAL FROM EMP WHERE JOB ='SALESMAN');
