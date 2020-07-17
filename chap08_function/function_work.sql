-- 1. 숫자함수

-- 1) 절댓값 함수 ABS
select -10, abs(-10) from dual;
-- 2) 소숫점 자릿수  FLOOR/ROUND/TRUNC
SELECT 34.5678, FLOOR(34.5678) FROM DUAL;
SELECT 34.5678, ROUND(34.5678) FROM DUAL;
select 12.345, round(12.345,2) from dual;
select 34.5678, round(34.5678,-1) from dual;
--3) 나머지 값 구하기 MOD
select*from professor where mod(deptno, 2)=0;
--<문제1> 사번이 홀수인 사람들을 검색해 보십시오.(EMP 테이블)
select*from emp;
select*from emp where mod (empno,2) = 1;



-- 2. 문자처리함수

-- 1) 대문자 변환 UPPER
-- 2) 소문자 변환 LOWER
-- 3) 단어 시작만 대문자 변환 INITCAP

--<문제2> 다음과 같이 쿼리문을 구성하면 직급이 'manager'인 사원을 검색할까? 
select empno,ename,job from emp where job=upper('manager');

-- 4) 문자길이 구하기
select length('oracle'), length('오라클') from dual;
select lengthb('oracle'), lengthb('오라클') from dual;
select ename, length(ename), lengthb(ename) from emp; -- 영어 1자의 바이트는 1바이트
select name, length(name), lengthb(name) from student; -- 한글 1자의 바이트는 3바이트
-- 5) 문자열 일부 추출
select substr('welcome to oracle',5,8) from dual; -- ome to o
select substr('welcome to oracle',-13,8) from dual; -- ome to o
SELECT SUBSTR(HIREDATE, 1, 2) 년도, SUBSTR(HIREDATE, 4, 2) 달 FROM EMP;

--<문제3> 9월에 입사한 사원을 출력해보세요. (EMP 테이블)
select*from emp where substr(hiredate,4,2)=09;


-- 6) 특정 문자 위치 찾기
-- 7) 문자 공백 지우기 : TRIM, LTRIM, RTRIM
select LTRIM('   Oracle'   ) from dual;
select RTRIM('   Oracle'   ) from dual;
select TRIM('   Oracle'   ) from dual;



-- 3. 날짜 함수

-- 1) SYSDATE
select sysdate from dual;
select sysdate-1 어제, sysdate 오늘, sysdate+1 내일 from dual;
-- 2) ADD_MONTHS
select birthday from student;
select add_months(birthday,6) from student;
-- 3) NEXT_DAY
select sysdate, next_day(sysdate,'금요일') from dual;



-- 4. 형 변환 함수 : 기존자료형 -> 다른자료형

-- 1) to_char : 날짜형,숫자형 -> 문자형
select sysdate, to_char(sysdate,'mon/day') from dual;
select hiredate, to_char(hiredate,'yy/mon/day') from emp where hiredate not like '82%';
select ename,sal,to_char(sal,'L99,999') from emp;
-- 2) to_date : 숫자형,문자형 -> 날짜형
select ename, hiredate from emp where hiredate=to_date(19810220,'yyyymmdd');
select trunc(sysdate-to_date('2008/01/01','yyyy/mm/dd')) from dual;
-- 3) to_number : 문자형 -> 숫자형
select to_number('20,000','99,999')-to_number('10,000','99,999') from dual;
select 20000-10000 from dual;



-- 5. NULL 처리 함수
/*
 * NVL(칼럼명,값) : 해당 칼럼의 레코드가 null이면 null값이 설정한 값으로 대체됨
 * NVL2(칼럼명,값1,값2) : 해당 칼럼의 레코드가 null이면 null값이 값2로 대체, not null이면 값1로 대체
 */

select name,pay,bonus,nvl2(bonus,bonus*2,0) from professor where deptno=101;



-- 6. DECODEE() 함수
-- 형식) decode(칼럼명,값,디코딩값)
select ename, deptno, decode(deptno,10,'기획실',20,'연구실','영업부') 부서명
from emp;
select*from emp;


