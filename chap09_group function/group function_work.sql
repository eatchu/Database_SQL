-- groupfunction _ work

-- 1. 그룹함수 : 숫자형에만 적용됨
-- 1) sum()
select sum(sal) from emp;
select sum(distinct deptno) from emp;
select sum(substr(hiredate,4,2)) from emp where hiredate like '82%';
select sum(comm) from emp; --null은 포함 안함
-- 2) avg()
select avg(sal) from emp;
select avg(comm) from emp;
-- 3,4) max,min
select max(sal), min(sal) from emp;
select max(sal) from emp where deptno in (30) ;
--<문제1> 
select max(hiredate), min(hiredate) from emp;
-- 5) count : null 제외
select count(comm) from emp;
select count(hpage) from professor;
--<문제2-1>
select count(comm) from emp where deptno in (10);
--<문제2-2> scott 사원과 같은 부서에 근무하는 사원에 대한 급여 합계와 평균
select sum(sal), avg(sal) from emp 
where deptno=(select deptno from emp where ename='SCOTT');

-- 6) 분산/표준편차 : 산포도
select stddev(bonus) from professor; -- 표준편차 standard deviation : 분산의 양의 제곱근
select sqrt(variance(bonus)) from professor; -- 표준편차와 같은 값이 나옴

select variance(bonus) from professor; -- 분산 : 편찬^2 총합/ 변수 개수



-- 2. Group by 절 : 범주형 칼럼 (집단형)
-- 동일한 집단별로 묶어서 집단별 집계를 구한다
select deptno from emp group by deptno;
select deptno, round(avg(sal),2) 평균급여 from emp group by deptno;
select deptno, max(sal),min(sal) from emp group by deptno;

-- 부서별로 사원 수와 커미션을 받는 사원들의 수 계산하기
select deptno, count(*), count(comm) from emp group by deptno;
-- 교수 테이블에서 직급별 교수의 평균 급여 계산
select position 직급,round(avg(pay),2) 평균급여 from professor group by position;


-- SQL 조건절 순서
-- select from where order by
-- select from group by having


-- 3. Having 조건 : group by에서 조건절을 사용하고 싶을때  where 대신 쓰는 함수
select avg(sal) from emp group by deptno having avg(sal) >= 2000;
select avg(sla) from emp group by deptno having deptno in (10,20);
select deptno, max(sal), min(sal) from emp group by deptno having max(sal) >= 2900;

--<문제3> 학생 테이블에서 몸무게 평균이 60 이상인 학생 정보 조회하기 (다시)
select avg(weight) from student group by grade having avg(weight)>=60;
--<문제4> 교수테이블에서 학과별 급여의 평균이 300미만인 교수 정보 조회하기
(select deptno, avg(pay) from professor group by deptno having avg(pay) <= 300);





