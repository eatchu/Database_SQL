-- <연습문제3>
-- 문1) hiredate가 1981년 2월 20과 1981년 5월 1일 사이 hiredate 순으로 출력
select ename,job,hiredate from emp 
where hiredate between '1981/02/20' and '1981/05/01' 
order by hiredate;

select ename,job,hiredate from emp 
where hiredate >= '1981/02/20' and hiredate <= '1981/05/01' 
order by 3;

-- 문2) deptno가 10,20인 사원의 모든 정보를 ename 기준으로 내림차순 출력
select * from emp where deptno in (10,20) order by ename desc;