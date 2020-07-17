-- DML

-- 1. 레코드 입력 : INSERT INTO
-- 1) 칼럼 갯수에 맞게 values값 추가 (칼럼명 생략가능)
-- 2) 특정 칼럼명에만 values값 추가 (칼럼명 필수) - 해당되지 않은 칼럼에는 null값이 자동 적용됨 
-- 3) 명시적으로 null값 추가 (null/'')
-- 4) 서브쿼리로 레코드 삽입
insert into name select*from name2; -- name2의 모든 레코드 값을 name에 넣기
insert into sam00(ename,job) select ename,job from sam01; -- 특정 칼럼에만 레코드 복사
insert into sam00(empno) select empno from sam01 where empno is null; --공백의 칼럼에 다시 복사
--SAM01 테이블에 서브 쿼리문을 사용하여 EMP 에 저장된 사원 중 10번 부서 소속 사원의 정보를 추가하시오.
insert into sam01 (select empno, ename, job, sal from emp where deptno=10); 



-- 2. 다중 테이블에 다중 행 입력 : INSERT ALL INTO
INSERT ALL 
INTO EMP_HIR VALUES(EMPNO, ENAME, HIREDATE) 
INTO EMP_MGR VALUES(EMPNO, ENAME, MGR) SELECT EMPNO, ENAME, HIREDATE, MGR 
FROM EMP WHERE DEPTNO=20;



-- 3. 테이블 내용 수정 : UPDATE SET
-- 데이터 타입을 수정하는게 아니라 레코드 값을 바꾸는것
update name set column_name=value1, column_name2=value2 ... where conditions;
-- 서브쿼리 사용해서 데이터 수정
UPDATE DEPT01 SET LOC=
(SELECT LOC FROM DEPT01 WHERE DEPTNO=10) WHERE DEPTNO=20;
-- 실습
update sam02 set sal=sal+1000 where deptno = 
(select deptno from dept where loc='DALLAS');
-- 한번에 두개 이상의 칼럼값 변경
UPDATE DEPT01 SET (DNAME,LOC) = 
(SELECT DNAME,LOC FROM DEPT01 WHERE DEPTNO=10) 
WHERE DEPTNO=50;



-- 4. 테이블의 레코드 삭제 : 가로의 행을 삭제
delete from name where conditions;




