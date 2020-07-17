-- dataType.sql : Oracle 주요 자료형 

drop table student purge;

create table student(
sid int primary key,            -- 학번 (정수만입력가능, 기본키(null값,중복 불가)
name varchar(25) not null,  -- 이름 (가변길이 문자형, null값 사용x)
phone varchar(30) unique,  -- 전화번호 (가변길이 문자형, 중복불가)
email char(50),                  -- 이메일 (고정길이 문자형)
enter_date date not null     -- 입학년도 (날짜형(날짜/시간), null값 사용x)
);


/*
 * Oracle 주요 자료형 
 *  1. number(n) : n 크기 만큼 숫자 저장 
 *  2. int : 4바이트 정수 저장 
 *  3. varchar2(n) : n 크기 만큼 가변길이 문자 저장 - 메모리를 효율적으로 사용가능
 *  4. char(n) : n 크기 만큼 고정길이 문자 저장
 *  5. date : 날짜/시간 저장 - sysdate : system의 날짜/시간 저장 
 */

/*
 * 제약조건 
 *  1. primary key : 해당 칼럼을 기본키로 지정(중복불가+null불가)
 *  2. not null : null값 허용 불가 
 *  3. unique : 중복 불가(null 허용)
 */

/*
 * sequence?
 *  - 시작값을 기준으로 일정한 값이 증가하는 객체 
 *  - 형식) create sequence 이름 increment by 증가값 start with 시작값;
 */
drop sequence seq_sid;

create sequence seq_sid increment by 1 start with 2020001;

insert into student values(seq_sid.nextval,'홍길동','010-1234-5678','hong@naver.com',sysdate);
insert into student values(seq_sid.nextval,'이순신','010-1234-5679','jng@naver.com',sysdate);
insert into student values(seq_sid.nextval,'유관순','010-1234-6678','hhong@naver.com',sysdate);
insert into student values(seq_sid.nextval,'강감찬','010-1235-6678','hhong@naver.com',sysdate);
select * from student;
commit work;
select * from student;
