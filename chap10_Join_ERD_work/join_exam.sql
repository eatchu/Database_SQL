-- 1. 고객 테이블 
create table user_data(
user_id int primary key,        -- 고객 id
gender number(1) not null,     -- 성별
age number(3) not null,     -- 나이
house_type number(1) not null,  -- 집 유형
resident varchar(10) not null, --거주지
job number(1) not null          --직업번호
);

create sequence seq_id increment by 1 start with 1001;

insert into user_data values(seq_id.nextval, 1, 35,	1,	'전북', 	6);
insert into user_data values(seq_id.nextval, 2, 45,	3,	'경남', 	2);
insert into user_data values(seq_id.nextval, 1, 55,	3,	'경기', 	6);
insert into user_data values(seq_id.nextval, 1, 43,	3,	'대전', 	1);
insert into user_data values(seq_id.nextval, 2, 55,	4,	'경기', 	2);
insert into user_data values(seq_id.nextval, 1, 45,	1,	'대구', 	1);
insert into user_data values(seq_id.nextval, 2, 39,	4,	'경남', 	1);
insert into user_data values(seq_id.nextval, 1, 55,	2,	'경기', 	6);
insert into user_data values(seq_id.nextval, 1, 33,	4,	'인천', 	3);
insert into user_data values(seq_id.nextval, 2, 55,	3,	'서울', 	6);
select * from user_data;


-- 2. 지불 테이블 
create table pay_data(
user_id int not null,            -- 고객 id (외래키 with user_data)
product_type number(1) not null,  -- 구매상품 유형
pay_method varchar(20) not null,  -- 지불방법
price int not null,               -- 가격
foreign key(user_id)             
references User_data(user_id)
);

insert into pay_data values(1001, 1, '1.현금', 153000);
insert into pay_data values(1002, 2, '2.직불카드', 120000);
insert into pay_data values(1003, 3, '3.신용카드', 780000);
insert into pay_data values(1003, 4, '3.신용카드', 123000);
insert into pay_data values(1003, 5, '1.현금', 79000);
insert into pay_data values(1003, 1, '3.신용카드', 125000);
insert into pay_data values(1007, 2, '2.직불카드', 150000);
insert into pay_data values(1007, 3, '4.상품권', 78879);
select * from pay_data;


-- 3. 반품 테이블  
create table return_data(
user_id int not null,        --고객 id (외래키 with user_data)    
return_code number(1) not null,  
foreign key(user_id) 
references User_data(user_id)    
);

insert into return_data values(1003, 1);
insert into return_data values(1003, 4);
insert into return_data values(1007, 1);
insert into return_data values(1009, 2);

select * from return_data;

commit work;


-- 문1) 고객(user_data)테이블과 지불(pay_data)테이블을 inner join하여 다음과 같이 출력하시오.
-- 조건1) 고객ID, 성별, 연령, 직업유형, 상품유형, 지불방법, 구매금액 칼럼 출력  
-- 조건2) 고객ID 오름차순 정렬
-- [해설] 전체 고객 중에서 상품을 구매한 고객만 확인하고 싶을때
select u.user_id 고객,u.gender 성별,u.age 연령,u.job 직업유형,p.product_type 상품유형,p.pay_method 지불방법,p.price 구매금액
from user_data u, pay_data p
where u.user_id=p.user_id 
order by u.user_id;

select u.user_id 고객,u.gender 성별,u.age 연령,u.job 직업유형,p.product_type 상품유형,p.pay_method 지불방법,p.price 구매금액
from user_data u inner join pay_data p
on u.user_id=p.user_id 
order by u.user_id;



-- 문2) 문1)의 결과에서 성별이 '여자'이거나 지불방법이 '1.현금'인 경우만 출력하시오.
-- [해설] 구매한 고객 중에서 성별이 여자거나 현금으로 지불한 고객 등 특정고객만 확인하고 싶을때
select u.user_id 고객,u.gender 성별,u.age 연령,u.job 직업유형,p.product_type 상품유형,p.pay_method 지불방법,p.price 구매금액
from user_data u, pay_data p
where u.user_id=p.user_id and (u.gender=2 or p.pay_method='1.현금') --괄호 유무에 대해서 더 고민해보기
order by u.user_id;



-- 문3) 고객(user_data)테이블과 지불(pay_data)테이블을 left outer join하여 다음과 같이 출력하시오.
-- 조건) 고객ID, 성별, 나이, 상품유형, 지불방법 칼럼 출력   
-- [해석] 전체고객을 기준으로 상품 구매에 대한 정보까지 전부 출력하고 싶을 때
select u.user_id 고객,u.gender 성별,u.age 연령,p.product_type 상품유형,p.pay_method 지불방법
from user_data u, pay_data p
where u.user_id=p.user_id(+) 
order by u.user_id;

select u.user_id 고객,u.gender 성별,u.age 연령,p.product_type 상품유형,p.pay_method 지불방법
from user_data u left outer join pay_data p
on u.user_id=p.user_id(+) 
order by u.user_id;


-- 문4) 고객(user_data)테이블과 반품(return_data)테이블을 이용하여 left outer join하여 다음과 같이 출력하시오.
-- 조건1) 고객ID, 성별, 나이, 거주지역, 반품코드 칼럼 출력   
-- 조건2) 반품한 고객만 출력
-- [해석] 전체 고객중에서 물건을 반품하거나 반품하지 않은 정보까지 같이 출력 혹은 반품만 한 고객 정보 출력하고 싶을때
select u.user_id 고객,u.gender 성별,u.age 연령,u.resident 거주지역,r.return_code 반품코드
from user_data u, return_data r
where u.user_id=r.user_id(+) and r.return_code is not null
order by u.user_id;

select u.user_id 고객,u.gender 성별,u.age 연령,u.resident 거주지역,r.return_code 반품코드
from user_data u left outer join return_data r
on u.user_id=r.user_id(+) and r.return_code is not null
order by u.user_id; --오류 다시확인

select u.user_id 고객,u.gender 성별,u.age 연령,u.resident 거주지역,r.return_code 반품코드
from user_data u, return_data r
where u.user_id(+)=r.user_id
order by u.user_id;




-- 문5) ERD를 시각화 하시오.
-- 파일명 : user_pay_return


-- 추가문제) 여성, 남성, 특정 고객에 대한 것 등 내가 원하는 검색 결과 출력해보기





