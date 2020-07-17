-- JOIN

--cross join
select*from table1, table2; --족1+족2 , 행1*행2

-- scottd이란 사원이 소속된 부서명을 알고 싶을때
--1. 서브쿼리 이용하기 : dept 테이블에 있는 칼럼 레코드만 출력가능
select dname from dept where deptno=
(select deptno from emp where ename='SCOTT');
--2. 조인 이용하기 : INNER JOIN
-- dept,emp 테이블 모두에 들어가는 scott에 대한 정보 출력가능
select e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno=d.deptno and e.ename='SCOTT';

-- 두 테이블이 가지는 동일한 칼럼명을 출력하지 않는다면 table의 별칭은 없어도됨
select name, dname
from student, department 
where student.deptno1 = department.deptno;

--*NON-EQUI JOIN

--*SELF JOIN
--매니저가 KING인 사원들의 이름과 직급을 출력하시오. 
--1)서브쿼리 사용
SELECT ENAME,JOB FROM EMP WHERE MGR = 
(SELECT EMPNO FROM EMP WHERE ENAME='KING');
--2)셀프조인 사용
SELECT E.ENAME,E.JOB FROM EMP E, EMP M 
WHERE E.MGR=M.EMPNO AND M.ENAME='KING';
--SCOTT과 동일한 근무지에서 근무하는 사원의 이름을 출력하시오.
SELECT M.ENAME FROM EMP E, EMP M
WHERE E.DEPTNO=M.DEPTNO AND E.ENAME='SCOTT';

--*OUTER JOIN : LEFT, RIGHT (+)사용
--*FULL OUTER JOIN : ANSI 표준만 사용 가능


