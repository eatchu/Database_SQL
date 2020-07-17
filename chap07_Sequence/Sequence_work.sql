--sequnce_work.sql

-- 1. 테이블 생성
select*from dept01;
drop table dept01;
purge recyclebin;

create table dept01 as select*from dept where 0=1;

-- 2. sequence 생성
create sequence dept_deptno_seq increment by 1 start with 1;

-- 3. 레코드 삽입
insert into dept01 values(dept_deptno_seq.nextval,'test','서울시');
insert into dept01 values(dept_deptno_seq.nextval,'test2','대전시');
select*from dept01;

-- 4. 사용자가 생성한 sequence의 목록 보기
select*from user_tables; --전체 테이블 목록
select*from user_sequences; --전체 시퀀스 목록
select*from seq;

SELECT DEPT_DEPTNO_SEQ.NEXTVAL FROM DUAL; --다음 시퀀스 값 확인가능
SELECT DEPT_DEPTNO_SEQ.CURRVAL FROM DUAL; --현재 시퀀스 값 확인가능

-- 실습
CREATE SEQUENCE EMP_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 100000 ; 

DROP TABLE EMP01;
CREATE TABLE EMP01(
EMPNO NUMBER(4) PRIMARY KEY,
ENAME VARCHAR2(10),
HIREDATE DATE
);

INSERT INTO EMP01
VALUES(EMP_SEQ.NEXTVAL, 'JULIA' , SYSDATE);
insert into emp01 values(emp_seq.nextval,'julia2',sysdate);
select*from emp01;
delete from emp01 where empno=2; --시퀀스 번호를 한번 삭제하면 복원이 안됨
insert into emp01 values(emp_seq.nextval,'julia3',sysdate); --행을 만들었을때 1다음순서인 2가 아닌 3이 나옴 (2의 행은 앞에서 이미 지웠기 때문)

-- 5. 시퀀스 제거
DROP SEQUENCE DEPT_DEPTNO_SEQ;
insert into dept01 values(5,'test3','대전시'); -- 시퀀스를 지었기 때문에 deptno자리에 사용자가 직접 값을 입력해야함 
select*from dept01;

-- 6. 문자열 + 시퀀스 숫자
drop table board purge;
create table board(
bno varchar(20) primary key, --게시물번호
writer varchar(20) not null --작성자
);

create sequence bno_seq start with 1001 increment by 1;
--생성된 시퀀스는 숫자타입이고 기본키는 문자타입이므로 시퀀스를 문자열로 바꿔준다

insert into board values('홍길동'||to_char(bno_seq.nextval),'홍길동');
insert into board values('홍길동'||to_char(bno_seq.nextval),'홍길동');
select*from board;
insert into board values('이순신'||to_char(bno_seq.nextval),'이순신');










