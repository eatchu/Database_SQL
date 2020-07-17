-- step02_ join_work.sql

/*
카티전 조인(cartesial join)
 - 물리적 join 없이 논리적으로 테이블을 연결하는 기법 (공통칼럼기준)
 - [종류]
 1. inner join
 - 조인 대상의 테이블에 모두 데이터가 존재하는 경우
 2. outer join
 - 두개의 테이블 중 하나의 테이블에만 데이터가 존재하는 경우
 - left outer join, right outer join, full outer join
*/





-- 1. inner join : 학생(student) vs 학과(department)
select*from student; --deptno1(주전공)
select*from department; --deptno(학과번호)

select s.name, s.deptno1, d.dname
from student s, department d
where s.deptno1 = d.deptno; -- 두 테이블 다 null값 없음 = inner join의 조건

-- ANSI 표준 : inner join
select s.name, s.deptno1, d.dname
from student s inner join department d
on s.deptno1 = d.deptno; -- 앞에 함수의 결과값과 동일하게 나옴

--[문제1] 학생 테이블과 교수 테이블 조인 
--<조건1> 조인 칼럼 : 교수번호(profno)
--<조건2> 학생 이름(name), 학과번호(deptno1), 교수명(name), 교수번호(profno) -> 4개의 칼럼 조회
select*from student;
select*from professor;
select s.name 학생이름, s.deptno1 학과번호, p.name 교수이름, p.profno 교수번호
from student s, professor p
where s.profno = p.profno;

--[문제2] 101학과의 학생만 검색될 수 있도록 해라
select s.name 학생이름, s.deptno1 학과번호, p.name 교수이름, p.profno 교수번호
from student s, professor p
where s.profno = p.profno and s.deptno1=101;

-- 2개 이상 테이블 join하기 : student, department, professor
-- join 조긴 : department - (deptno) - student - (profno) - professor
select s.deptno1 학과번호, s.name 학생이름, d.dname 학과명, p.profno 교수번호, p.name 교수명
from student s, department d, professor p
where s.deptno1 = d.deptno and s.profno = p.profno;






-- 2. outer join

-- 1) left outer join : 학생(기준) vs 교수
--    join조건 : 학생  <- profno -> 교수
select s.name, p.name, p.profno
from student s, professor p
where s.profno = p.profno(+); -- 왼쪽기준 : +없는 table이 기준으로 들어감 
-- ANSI 표준 : left outer join
select s.name, p.name, p.profno
from student s left outer join professor p
on s.profno = p.profno(+);

-- 2) right outer join : 학생 vs 교수(기준)
--    join조건 : 학생  <- profno -> 교수
select s.name, p.name, p.profno
from student s, professor p
where s.profno(+) = p.profno; -- 오른쪽 기준
-- ANSI 표준 : right outer join
select s.name, p.name, p.profno
from student s right outer join professor p
on s.profno(+) = p.profno;

-- 3) full outer join : ANSI 표준으로만 사용가능 
select s.name, p.name, p.profno
from student s, professor p
where s.profno(+) = p.profno(+); -- error
-- ANSI 표준
select s.name, p.name, p.profno
from student s full outer join professor p
on s.profno = p.profno;


