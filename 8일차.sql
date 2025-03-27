--DDL 
--create table, alter table, drop table

--테이블 생성하기
CREATE TABLE MEMBER_ACORN(
	ID varchar2(50) PRIMARY key,
	PWD varchar2(50),
	NAME varchar2(50),
	GENDER char(6), --char은 자릿수를 무조건 채운다
	AGE number(3),
	BIRTHDAY DATE,
	PHONE char(13)
);
SELECT * FROM MEMBER_ACORN;
-- 테이블에서 주키 설정 필수
--CHAR : 고정길이형 문자이기 때문에 빈공간은 빈공백으로 채워짐, 비교할 때 주의 !!!!
-- 한글은 3바이트씩 '홍길동'이면 9바이트가 필요하다는 말임

--테이블 수정하기
create TABLE MEMBER_TEST(
	ID varchar2(7) PRIMARY key,
	name varchar2(10)
);

INSERT INTO member_test(user_id,name) VALUES('TEST2','홍길홍길홍길동');
COMMIT;

SELECT * FROM member_test;

--테이블 수정하기
--ALTER TABLE 테이블명
--컬럼을 추가하기
ALTER TABLE member_test ADD(addr varchar2(50));

--이름 변경하기
ALTER TABLE member_test RENAME column id TO user_id;

--데이터형 수정하기
ALTER TABLE member_test MODIFY name varchar2(30);
SELECT * FROM member_test;
COMMIT;

--컬럼 삭제하기
ALTER TABLE member_test DROP column addr;
COMMIT;
SELECT * FROM member_test;

TRUNCATE TABLE member_test;

-- 테이블 생성시 속성에 기본값 설정하기
CREATE TABLE AA(
	ID varchar2(10),
	WRITEDAY DATE
);

INSERT INTO AA (id) VALUES('TEST01');
SELECT * FROM AA;

CREATE TABLE BB(
	ID varchar2(10),
	WRITEDAY DATE DEFAULT sysdate  --INSERT into에 값을 안줬을 떄 기본값을 주기 위해 사용한다
);

INSERT INTO bb (id) values('TEST01');
SELECT * FROM bb;

-- 테이블 복사하기 (내용과 함께)
SELECT * FROM student;

CREATE TABLE student_new    --select문에서 반환된 테이블과 똑같은 테이블 생성
AS SELECT * FROM student;

SELECT * FROM student_new;

-- 테이블 복사하기 (내용없이 구조만)
CREATE TABLE student_new2
AS SELECT * FROM student
WHERE 1=2;  --where절을 조건을 틀리게 해서 반환되는 값은 없고 스키마만 만들어지게 만든거임

SELECT * FROM student_new2;

-- 연습문제 페이지285
--1.
CREATE TABLE new_emp(
	NO number(5),
	name varchar2(20),
	hiredate DATE,
	bonus number(6,2)
);
COMMIT;

SELECT * FROM new_emp;

--2.
CREATE TABLE new_emp2
AS SELECT NO,name,hiredate FROM new_emp;

SELECT * FROM new_emp2;

--3.
CREATE TABLE new_emp3
AS SELECT * FROM NEW_emp2
WHERE 1=2;

SELECT * FROM new_emp3;

--4.
ALTER TABLE new_emp2 ADD(birthday DATE DEFAULT sysdate);

--5. 컬럼명 변겅
ALTER TABLE new_emp2 RENAME column birthday TO birth;
SELECT * FROM new_emp2;

--6. 컬럼의 데이터형 변경
ALTER TABLE new_emp2 MODIFY no number(7);

--7. 컬럼 삭제
ALTER TABLE new_emp2 DROP column birth;

--8. 스키마 유지&데이터 삭제
TRUNCATE TABLE new_emp2;

--9. 테이블 자체 삭제
DROP TABLE new_emp2;

--10.
--값이 중복해서 들어가지 않는다, 데이터가 key-value쌍으로 들어간다

--테이블 생성하기 (제약조건은 테이블 생성할 때 설정한다)
create table new_emp1 (
   no number(4) 
   constraint emp1_no_pk primary key,
   name varchar2(20) 
   constraint emp1_name_nn not null,
   jumin varchar2(13)
   constraint emp1_jumin_nn  not null 
   constraint emp1_jumin_uk  unique,
   loc_code number(1) 
   constraint emp1_area_ck check( loc_code  <5 ) ,
   deptno varchar2(6)
   constraint emp1_deptno_fk references dept2(dcode)
);

SELECT * FROM dept2;
SELECT * FROM new_emp1;

--- 제약조건에 위해되면 데이터가 들어가지 않는다

-- 제약조건을 만족하면 데이터가 정상적으로 들어감
INSERT INTO NEW_emp1(NO,name,jumin,loc_code,deptno)
values(1,'홍길동','8012105734681',4,'1000');
COMMIT;
SELECT * FROM new_emp1;

-- 키 제약조건 위배 (키 설정 -> 테이블 내에서 유일해야하며, null을 허용하지 않음)
INSERT INTO NEW_emp1(NO,name,jumin,loc_code,deptno)
values(1,'김길동','8012105734681',3,'1000');

--키를 입력하지 않고 등록해보기 (key를 안 넣으면 안된다)
INSERT INTO NEW_emp1(name,jumin,loc_code,deptno)
VALUES('다길동','8012105734681',3,'1000');

--이름(not null)없이 등록하기
INSERT INTO NEW_emp1(NO,jumin,loc_code,deptno)
values(2,'8012105734681',2,'1000');

--주민번호가 같은 것을 등록해보기 unique
INSERT INTO NEW_emp1(NO,name,jumin,loc_code,deptno)
values(2,'조길동','8012105734681',2,'1000');

--주민번호가 다른것 등록해보기 unique
INSERT INTO NEW_emp1(NO,name,jumin,loc_code,deptno)
values(2,'조길동','8012115734681',2,'1000');

--없는 부서 등록해보기 => 외래키가 선언되었는데 reference하는 값이 참조하는 테이블에 값이 없기때문에 
INSERT INTO NEW_emp1(NO,name,jumin,loc_code,deptno)
values(3,'엄길동','8012115732681',2,'3000');

--존재하는 부서 등록하기
INSERT INTO NEW_emp1(NO,name,jumin,loc_code,deptno)
values(3,'엄길동','8012115732681',2,'1000');

SELECT * FROM new_emp1;

create table test_2021_2
 (
 id varchar2(50) null ,
 phone varchar2(20) check (phone like  '010-%-____') not null ,  --체크 제약조건 걸어주기
 email varchar2(50) null
 );

INSERT INTO test_2021_2 (id,phone) values('TEST01','010-1234-1234');
--전화번호 제약조건 위배사건
INSERT INTO test_2021_2 (id,phone) values('TEST02','010-1234-134');
SELECT * FROM test_2021_2;

create table test_2021_0
 (
 id  varchar2(50) not null,
 email varchar2(200) null ,
 phone char(13) not null, 
pwd varchar2(200) default  '111'  , 
grade CHAR(2) CHECK( grade  IN ('01', '02', '03')) 
);

INSERT INTO test_2021_0(id,phone,grade) VALUES('TEST01','010-1234-1234','01');
SELECT * FROM test_2021_0;

--도메인 제약조건 실패해보기(보기중의 값에서 넣어야함, 등록되지 않는다)
INSERT INTO test_2021_0(id,phone,grade) VALUES('TEST01','010-1234-1234','05');

--고객테이블
CREATE TABLE ctbl(
	id varchar2(10) PRIMARY KEY,
	name varchar2(10)
);

INSERT INTO ctbl values('T1','KIM');
INSERT INTO ctbl values('T2','PARK');
INSERT INTO ctbl values('T3','LEE');
COMMIT;

SELECT * FROM ctbl;

--주문테이블
CREATE TABLE otbl(
	NO varchar2(10) PRIMARY KEY,
	id varchar2(10) REFERENCES ctbl (id)
)

INSERT INTO otbl values('o001','T1');
INSERT INTO otbl values('o002','T1');
COMMIT;
SELECT * FROM otbl;

--고객정보삭제하기
DELETE FROM ctbl WHERE id='T1';
DELETE FROM ctbl WHERE id='T2';
--참조하는 부모테이블이나 자식테이블이 있으면 cascade를 선언하고 삭제해야 삭제된다
--cascade는 참조하는 테이블에서 같이 삭제하게 해주는 설정


CREATE TABLE ctbl2(
	id varchar2(10) PRIMARY KEY,
	name varchar2(10)
);

INSERT INTO ctbl2 values('T1','KIM');
INSERT INTO ctbl2 values('T2','PARK');
INSERT INTO ctbl2 values('T3','LEE');
COMMIT;

SELECT * FROM ctbl2;

--참조하는 행이 삭제되면 함께 삭제되게 하는 설정 ON DELETE cascade
CREATE TABLE otbl2(
	NO varchar2(10) PRIMARY KEY,
	id varchar2(10) REFERENCES ctbl2 (id) ON DELETE CASCADE  --아니면 on delete SET null로 바꿔주면 삭제되면 null값으로 남음
);

INSERT INTO otbl2 values('o001','T1');
INSERT INTO otbl2 values('o002','T1');
COMMIT;
SELECT * FROM otbl2;
          
--ctbl2에서 t1고객 삭제
DELETE FROM ctbl2 WHERE id='T1';
SELECT * FROM otbl2;
SELECT * FROM ctbl2;

--참조하는 내용이 있는 경우 테이블 삭제가 되지 않음 CASCADE constraint
--따라서 설정해서 삭제해야함
DROP TABLE ctbl2 CASCADE constraint;
DROP TABLE otbl2;

--테이블 삭제시 참조하는 내용이 있는 경우 삭제되지 읺음