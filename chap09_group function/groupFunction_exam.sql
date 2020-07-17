/*
 * 집합 함수(COUNT,MAX,MIN,SUM,AVG) 
 * 작업 대상 테이블 : EMP, STUDENT, PROFESSOR
 */

--Q1. EMP 테이블에서 소속 부서별 최대 급여와 최소 급여 구하기
select max(sal),min(sal) from emp group by deptno;

--Q2. EMP 테이블에서 JOB의 수 출력하기
select count(distinct job) from emp;

--Q3. EMP 테이블에서 전체 사원의 급여에 대한 분산과 표준편차 구하기
select varience(sal),stddev(sal) from emp;

--Q4. Professor 테이블에서 학과별 급여(pay) 평균이 400 이상 레코드 출력하기
select avg(pay) from professor group by deptno having avg(pay) >= 400;

--Q5. Professor 테이블에서 학과별,직위별 급여(pay) 평균 구하기
select deptno, round(avg(pay),2), position from professor 
group by deptno, position order by deptno;


--Q6. Student 테이블에서 학년(grade)별로 
-- weight, height의 평균값, 최대값, 최소값을 구한 
-- 결과에서 키의 평균이 170 이하인 경우 구하기
select grade,avg(weight),max(weight),min(weight),avg(height),max(height),min(height) from student
from student group by grade having avg(height)<=170;

