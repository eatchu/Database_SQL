--- step01_join_work.sql

-- 조인 : 특정칼럼(외래키)를 이용하여 두 개 이상의 테이블을 연결하는 DB 기법

/*
조인절차
1. 기본키를 갖는 테이블을 생성
2. 레코드 추가
3. 외래키를 갖는 테이블 생성
4. 레코드 추가

조인테이블 삭제 : 위 순서의 역순
강제 테이블 삭제 : drop table name cascade constraint;
*/



-- 단계1 : 기본키를 갖는 테이블 생성
create table product(
code char(4) primary key, --코드
name varchar(30) not null --상품명
);

-- 단계2 : 레코드 삽입
insert into product values('p001','냉장고');
insert into product values('p002','세탁기');
insert into product values('p003','전화기');

-- 단계3 : 외래키를 갖는 테이블 생성
create table sale(
code char(4) not null, --코드
sdate date not null, --판매날짜
price int not null, --가격
foreign key(code) references product(code)
);

-- 단계4 : 레코드 생성
insert into sale values('p001','2020-02-24',850000);
insert into sale values('p002',sysdate,550000);
insert into sale values('p003','2020-02-25',150000);
select*from sale;
-- 무참조 무결성 제약조건에 위배되는 에러 (외래키에 입력되지 않은 레코드)
insert into sale values('p004','2020-02-24',850000);

commit work; --db에 반영

-- 단계5 : join을  이용해서 특정 데이터 조회
select p.code, p.name, s.sdate, s.price
from product p, sale s 
where p.code = s.code and p.name like '%기'; 














