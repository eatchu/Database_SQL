-- ddl_work.sql

/*
 * DDL : 테이블 생성(제약조건), 구조변경, 삭제
 * - 자동 커밋(AUTO COMMIT)
 */

-- 1. 의사칼럼 (rownum, rowid)

select*from emp; --14개의 행을 가지고 있음
--rownum : 레코드 순번 (1-10row)
SELECT ROWNUM, EMPNO, ENAME, ROWID
FROM EMP WHERE ROWNUM <=10 ;
--rownum : 5-10 조회
SELECT ROWNUM, EMPNO, ENAME, ROWID
FROM EMP WHERE ROWNUM between 5 and 10 ; --결과값이 안나옴
--특정 범위의 행 검색 : 의사칼럼 + 서브쿼리
--서브쿼리에서 별칭 만듬 -> select 절에 사용 -> where 절에 사용
select rnum,empno,ename from (select empno,ename,rownum rnum from emp)
where rnum between 5 and 10;

-- 2. 실수형 데이터 저장 테이블

CREATE TABLE EMP01(
EMPNO NUMBER(4),
ENAME VARCHAR2(20),
SAL NUMBER(7, 2)); -- (전체자리수,소숫점 이하 자리수)

insert into emp01 values(1,'홍길동',1234.1);
insert into emp01 values(2,'이순신',1234.123);
insert into emp01 values(2,'이순신',1234.125); --소수 3자리에서 반올림 한 값이 나옴 (전체자리숫자가 7이 맞아 소수자리가 넘더라도 입력가능)
insert into emp01 values(3,'강감찬',123456.12); --전체자리 숫자가 7이 넘기때문에 입력 불가능
select*from emp01;
delete from emp01 where empno=2;
select*from emp01;
insert into emp01 values(2,'이순신',1234.123);
insert into emp01 values(2,'이순신',1234.125);
select*from emp01;
delete from emp01 where sal=1234.13;
insert into emp01 values(3,'강감찬',1234.125);

-- 3. 서브쿼리를 이용해 테이블 복제

create table emp02 -- 메인
as select * from emp; -- 서브
select * from emp02 -- 내용 + 구조 복제

-- 특정 칼럼과 내용만 복제하기
drop table emp03 purge;
create table emp03 
as select empno, ename,sal,comm from emp;
select*from emp03;


--<과제1> 
create table emp04 as select empno,ename,sal from emp;
select*from emp04;

-- 테이블의 특정 행의 구조와 내용 복제
CREATE TABLE EMP05
AS
SELECT * FROM EMP
WHERE DEPTNO=10; 
select*from emp05;

create table emp_test as select*from emp where job='MANAGER';
select*from emp_test;

-- 테이블의 구조만 복제
CREATE TABLE EMP06
AS
SELECT * FROM EMP WHERE 1=0;
select*from emp06;

-- <과제2> 
create table dept02 as select*from dept where 10=20;

-- 4. 제약조건

-- 1) 기본키(Primary key) : 널, 중복 불가
create table test_tab1( --칼럼 레벨
id number(2) primary key,
name varchar2(30)
);

create table test_tab2( --테이블 레벨
id number(2),
name varchar2(30),
primary key(id)
);

insert into test_tab1 values(11,'홍길동');
insert into test_tab1 values(12,'유관순');
--null 허용 안됨 : id는 PK이기 때문에
insert into test_tab1(id,name) values(null,'유관순');
--중복 허용 안됨
insert into test_tab1 values(12,'유관순');

--2) 외래키 (foreign key)

--작업절차 : 기본키 테이블 생성 -> 외래키 테이블 생성
--기본키 테이블 생성
create table dept_tab(
deptno number(2) primary key, --기본키로 설정했기때문에 다른 테이블에 외래키로 사용가능함
dname varchar(10) not null,
loc varchar(10) not null
);
--레코드 삽입
insert into dept_tab values(10,'기획','대전');
insert into dept_tab values(20,'총무','서울');
insert into dept_tab values(30,'판매','미국');
select*from dept_tab;

--외래키 테이블 생성
drop table emp_tab purge;

create table emp_tab(
empno number(4) primary key, --기본키
ename varchar(30),
sal number(7),
deptno number(2) not null,
foreign key(deptno) references dept_tab(deptno)
);

insert into emp_tab values(1111,'홍길동',1500000,10);
insert into emp_tab values(2222,'이순신',2500000,20);
insert into emp_tab values(3333,'유관순',3500000,30);
--외래키 참조 무결성 위배
insert into emp_tab values(4444,'강감찬',4500000,40); --dept_tab의 deptno 칼럼에 40이라는 데이터가 존재하지 않기때문에

--문) 서브쿼리를 이용하여 2222사번을 갖는 사원의 부서 정보 출력하기 (서브 emp_tab, 메인 dept_tab)
select*from dept_tab where deptno in 
(select deptno from emp_tab where empno=2222);

--3) 유일키 설정 (UNIQUE KEY)

CREATE TABLE UNI_TAB1 (
DEPTNO NUMBER(2) UNIQUE, --칼럼 레벨 , null값 허용 가능
DNAME CHAR(14),
LOC CHAR(13)
);

insert into uni_tab1 values(11,'영업부','서울');
insert into uni_tab1 values(22,'기획부','대전');
insert into uni_tab1(dname,loc) values('기획실','대전'); --null값은 허용가능
--error
insert into uni_tab1 values(11,'영업부','서울'); --중복값은 허용불가능

select*from uni_tab1;

--4) NOT NULL 설정 : 칼럼 레벨에서만 사용 가능

--5) CHECK
CREATE TABLE CK_TAB1 (
DEPTNO NUMBER(2) NOT NULL CHECK (DEPTNO IN (10,20,30,40,50)),
DNAME CHAR(14),
LOC CHAR(13)
);

insert into ck_tab1 values(10,'회계','서울');
insert into ck_tab1 values(22,'연구부','대전'); --체크 제약조건에 위배됨 error
insert into ck_tab1(dname,loc) values('회계','서울'); --not null 제약조건에 위배됨 error

CREATE TABLE CK_TAB2 (
DEPTNO NUMBER(2) NOT NULL,
DNAME CHAR(14),
LOC CHAR(13),
CONSTRAINT CK_TAB_DEPTNO_CK CHECK (DEPTNO IN (10,20,30,40,50))
);

-- 5. 테이블 구조 변경 (alter table)

--1) 새로운 칼럼 추가 : ADD column
select*from tab;
select*from emp01;
alter table emp01 add(job varchar(9));
-- 기존에 테이블이 만들어진 상태에서 칼럼을 추가할때 not null이라는 제약조건은 포함할 수 없음 : error
alter table emp01 add(job2 varchar(9) not null);
--<과제3> 
alter table dept02 add(DMGR VARCHAR(10));
select*from dept02;

--2) 기존 칼럼 수정 : MODIFY column - 칼럼명 수정은 불가능 (datatype이나 제약조건만 변경가능)
alter table emp01 modify(job varchar(30));
desc emp01; -- 이클립스에선 확인 불가능, command line에서 확인 가능
--<과제4>
alter table dept02 modify(DMGR number(4));

--3) 기존 칼럼 삭제 : DROP column
alter table emp01 drop column job;
select*from emp01;
--<과제5>
alter table dept02 drop column DMGR;
select*from dept02;

-- 6. 테이블의 모든 row(레코드) 제거
select*from emp01;
truncate table emp01;

-- 7. 테이블의 구조 삭제 : drop table
drop table emp01; -- 테이블만 삭제
drop table emp01 purge; --테이블 및 임시파일까지 전부 삭제
purge recyclebin; -- 임시파일만 삭제

select*from tab;

