SELECT * FROM emp;

--데이터베이스 2차시

--문자함수
--concat() 함수 연결함수, || 연산자와 동일

select * from emp;

select ename || ' ' || job from emp;

select concat(ename ,'님') from emp;
select concat(ename ,job) from emp;

--substr() : 문자열의 일부를 가져올 때
select substr('00121132132421',1,6) from dual;
--dual은 연습용 데이터 (아무것도 없고 그냥 테이블만 지정)

--instr() : 문자열에서 특정 문자의 위치를 반환
select instr('02)876-1324',')') from dual;

--LPAD() : 전체 자리수에서 왼쪽부터 원하는 문자로 채운다
select id from student;
select * from acorntbl2;
select lpad(id,10,'0') from student;
select rpad(pw,10,'*') from acorntbl2;

--trim, ltrim(), rtrim()  공백제거, 특정문자 제거
select name,ltrim(name)from acorntbl2;

--replace() : 문자열에서 문자1, 문자2로 변환해줌
select pw,replace(pw,'1234','****') from acorntbl2;


select trim(name) from acorntbl2;

select replace(name,'김','KIM') from acorntbl2;

--이름의 첫글자가 별로 replace되로독 하기
select replace(name,'이','*') from acorntbl2;
select replace(name,'오','*') from acorntbl2;

--이름의 첫글자만 가져오기 substr()
select replace(name,substr(trim(name),1,1),'*') from acorntbl2;
--함수 여러개 합치는 과정은 좀 연습좀 해봐야 할 것 같음

--이름만 바꾸기
select trim(replace(name,substr(trim(name),2,2),'*')) from acorntbl2;


--책 실습 1번
SELECT ename,REPLACE(ename,substr(EMP.ENAME,2,2),'--') FROM EMP WHERE EMP.DEPTNO = 20;

--책 실습 3번
SELECT STUDENT.NAME,STUDENT.TEL, REPLACE(tel,substr(tel,instr(STUDENT.TEL,')')+1,3),'***') FROM STUDENT WHERE STUDENT.DEPTNO1 = 102;

--책 실습 4번
SELECT STUDENT.NAME,STUDENT.TEL, REPLACE(tel,substr(tel,instr(STUDENT.TEL,'-')+1,4),'****') FROM STUDENT WHERE STUDENT.DEPTNO1 = 101;
SELECT STUDENT.NAME,STUDENT.TEL, REPLACE(tel,substr(tel,-4),'****') FROM STUDENT WHERE STUDENT.DEPTNO1 = 101;
--첫번째 거는 -의 위치를 찾아서 구한거고 두번쨰꺼는 뒤에서부터 시작해서 4개를 별로 변경한 것

--숫자 관련 함수
--round,trunc,floor,ceil,mod

SELECT 987.43 FROM dual;
--소숫점 반올림
SELECT round(987.47) FROM dual; --987
--소수 둘째자리에서 반올림
SELECT round(987.47,1) FROM dual; --098.5
--첫번째 자리에서 반올림
SELECT round(987.47,-1) FROM dual;

--trunc : 얘는 반올림도 아니고 그냥 버림
SELECT trunc(987.47,-1) FROM dual;
SELECT trunc(987.47,1) FROM dual;

--floor,ceil (천장, 바닥함수)
SELECT floor(5.65) FROM dual;
SELECT ceil(5.65) FROM dual;

SELECT floor(-5.65) FROM dual;
SELECT ceil(-5.65) FROM dual;

--mod() : 두개 나눠서 나머지 구하기
SELECT MOD(10,3) FROM dual;

--power()  : 제곱수 구하기
SELECT power(2,3) FROM dual;

--날짜 관련 함수
--현재 날짜 구하가
SELECT ALL SYSDATE FROM dual;

--개월 수 구하기
SELECT months_BETWEEN('2025-03-20','2025-01-07') FROM dual;

--마지막 날 구하기
SELECT last_day('2025-03-20') FROM dual;

--ADD_months : 주어진 날짜에다가 숫자만큼 달을 추가
SELECT ADD_MONTHS('2025-03-20',3) FROM dual;

--형변환 함수

--묵시적 형변환
SELECT 2+'2' FROM dual;
--'2' -> 숫자로 묵시적 형변환

--명시적 형변환
SELECT 2+to_number('2') FROM dual;

--날짜
CREATE TABLE students (
    id INT NOT NULL AUTO_INCREMENT,  
    name VARCHAR(50) NOT NULL,          
    birth_date DATE NOT NULL,           
    enrollment_date DATETIME DEFAULT CURRENT_TIMESTAMP,  
    PRIMARY KEY (id)  
);



-- 샘플 데이터 삽입 (10명)
--INSERT INTO students (name, birth_date) VALUES
--('김철수', '2000-05-15'),
--('이영희', '1998-11-22'),
--('박민수', '2002-03-08'),
--('최다혜', '2001-07-19'),
--('정우진', '1999-02-25'),
--('한지민', '2003-09-12'),
--('송강호', '1997-06-30'),
--('이도연', '2000-12-05'),
--('배수지', '2002-08-14'),
--('오세훈', '1995-04-20');


--요일
SELECT sysdate, to_char(sysdate,'dy') FROM dual;

SELECT to_char(sysdate,'yyyy"년"mm"일"dd"일"') FROM dual;

SELECT * FROM Album;

--숫자를 문자로 변환
SELECT 25600 FROM dual;
SELECT to_char(25600,'999,999') FROM dual;
SELECT to_char(25600,'0999,999') FROM dual;
SELECT to_char(25600,'$999,999') FROM dual;
SELECT to_char(25600,'L999,999') FROM dual;
SELECT to_char(25600,'L999,999.99') FROM dual;


--to_number()
SELECT TO_number('1300'), to_number('1200')+100 FROM dual;

--to_date() : 날짜형식으로 변환
SELECT TO_DATE('2025-03-20') FROM dual;

--일반함수
--decode() : 값의 케이스별로 등급 먹여주기, 프로그램에서 if문에서 같은 조건으로 비교할 때 사용 가능
--nvl,nvl2 : 
SELECT DEPTNO,decode(DEPTNO,'20','국어국문학과','30','경제학과','10','컴퓨터공학과') FROM emp;
SELECT * FROM emp;

-- 유형예제1
SELECT PROFESSOR.DEPTNO , PROFESSOR.NAME , decode(PROFESSOR.DEPTNO , '101', 'Computer Science', ' ') AS DNAME FROM PROFESSOR;

-- 유형예제2
SELECT PROFESSOR.DEPTNO , PROFESSOR.NAME , decode(PROFESSOR.DEPTNO , '101', 'Computer Science','ETC') AS DNAME FROM PROFESSOR;

-- 120page 1번
SELECT * FROM student;
SELECT STUDENT.NAME ,STUDENT.JUMIN , decode(substr(STUDENT.JUMIN ,7,1),'1','MAN','WOMAN') AS Gender 
FROM student WHERE STUDENT.DEPTNO1 ='101';

-- 120page 2번
SELECT * FROM student;
SELECT STUDENT.NAME, STUDENT.TEL, 
	DECODE(SUBSTR(STUDENT.TEL, 1, INSTR(STUDENT.TEL, ')') - 1),
        '02', 'SEOUL',
        '051', 'BUSAN',
        '052', 'ULSAN',
        '055', 'GYEONGNAM')
AS location FROM student WHERE STUDENT.DEPTNO1 = '101';

-- nvl : nvl(널이 아니면,널이면)
-- nvl2

-- null : 값이 정해지지 않은 상태    여기서 1000을 더하면  => null
-- null에 연산을 하면 결과는 null
SELECT * FROM STUDENT;

SELECT STUDENT.HEIGHT+1000 FROM STUDENT;
INSERT INTO  student VALUES();
SELECT nvl(STUDENT.HEIGHT,0) AS height_nullException FROM STUDENT;
SELECT nvl(height+100,0) AS height1 FROM STUDENT;

--case when
SELECT STUDENT.WEIGHT , CASE WHEN weight>80 THEN '뭄무게 좀 많이 나가긴해'
							 WHEN weight>60 THEN '평균정도긴해'
							 else '저체중이니까 밥좀 많이 먹어라'
							 END AS "result!! "  --이렇게ㅐ 하면 어트리뷰트명을 지정해서 저장할 수 있음
FROM student;

--
SELECT * FROM CUST_INFO;

--1번
SELECT CUST_INFO.ID , DECODE(substr(ID,7,1),'1','남자','여자') gender FROM CUST_INFO;

--2번
SELECT ID , LOWER(LAST_NM) lastname FROM CUST_INFO;

--3번
SELECT CUST_INFO.LAST_NM || ', ' || CUST_INFO.FIRST_NM name 
FROM CUST_INFO;

--4번
SELECT ID , round(ANNL_PERF,1) 수익 FROM CUST_INFO;

--5번
SELECT id, TRUNC(annl_perf,1) 수익 FROM CUST_INFO;

--6번
SELECT SYSDATE FROM DUAL;

--7번
SELECT ID, CASE WHEN ANNL_PERF>300 THEN '고수익'
				WHEN ANNL_PERF>100 THEN '일반수익'
				WHEN ANNL_PERF<0 THEN '손해'
				ELSE '변동없음'
				END AS result
FROM CUST_INFO;

--8번
SELECT concat(LAST_NM,first_nm) AS 고객이름, NVL(ANNL_PERF,0) AS 포인트 FROM CUST_INFO;

SELECT sysdate, next_day(sysdate,'월') FROM dual;

--복수행 함수

--교재 210p 1번
SELECT * FROM emp;

SELECT max(nvl(EMP.COMM,0) + EMP.SAL) max , 
	min(nvl(EMP.COMM,0) + EMP.SAL) min , 
	round(avg(nvl(EMP.COMM,0) + EMP.SAL),1) avg 
FROM emp;

--2번
SELECT * FROM student;

SELECT count(decode(instr(STUDENT.BIRTHDAY,'-'))) FROM student;

SELECT substr(STUDENT.BIRTHDAY,4,2) FROM student; --생일 월 뽑아오기

SELECT count(*)||'EA' "TOTAL",
	   count(decode(substr(STUDENT.BIRTHDAY,4,2),'01',1))||'EA' "JAN",
       count(decode(substr(STUDENT.BIRTHDAY,4,2),'02',1))||'EA' "FEB",
       count(decode(substr(STUDENT.BIRTHDAY,4,2),'03',1))||'EA' "MAR",
       count(decode(substr(STUDENT.BIRTHDAY,4,2),'04',1))||'EA' "APR",
       count(decode(substr(STUDENT.BIRTHDAY,4,2),'05',1))||'EA' "MAY",
       count(decode(substr(STUDENT.BIRTHDAY,4,2),'06',1))||'EA' "JUN",
       count(decode(substr(STUDENT.BIRTHDAY,4,2),'07',1))||'EA' "JUL",
       count(decode(substr(STUDENT.BIRTHDAY,4,2),'08',1))||'EA' "AUG",
       count(decode(substr(STUDENT.BIRTHDAY,4,2),'09',1))||'EA' "SEP",
       count(decode(substr(STUDENT.BIRTHDAY,4,2),'10',1))||'EA' "OCT",
       count(decode(substr(STUDENT.BIRTHDAY,4,2),'11',1))||'EA' "NOV",
       count(decode(substr(STUDENT.BIRTHDAY,4,2),'12',1))||'EA' "DEC"
FROM student;

--3번
SELECT * FROM student;

SELECT substr(STUDENT.TEL ,1,instr(STUDENT.TEL,')')-1) FROM student;  --닫는 소괄호 앞 지역번호만 추출


SELECT count(*) "TOTAL",
	   count(decode(substr(STUDENT.TEL ,1,instr(STUDENT.TEL,')')-1),'02',1)) "SEOUL",
       count(decode(substr(STUDENT.TEL ,1,instr(STUDENT.TEL,')')-1),'031',1)) "GYEONGGI",
       count(decode(substr(STUDENT.TEL ,1,instr(STUDENT.TEL,')')-1),'051',1)) "BUSAN",
       count(decode(substr(STUDENT.TEL ,1,instr(STUDENT.TEL,')')-1),'052',1)) "ULSAN",
       count(decode(substr(STUDENT.TEL ,1,instr(STUDENT.TEL,')')-1),'053',1)) "DAEGU",
       count(decode(substr(STUDENT.TEL ,1,instr(STUDENT.TEL,')')-1),'055',1)) "GYEONGNAM"
FROM student;


--4번
INSERT INTO emp(empno,deptno,ename,sal) VALUES (1000,10,'Tiger',3600);
INSERT INTO emp(empno,deptno,ename,sal) VALUES (2000,10,'Cat',3600);

UPDATE emp
SET sal = 6000
WHERE empno = 7902;
COMMIT;

SELECT * FROM EMP;
SELECT EMP.EMPNO ,EMP.ENAME ,EMP.JOB ,EMP.SAL  FROM EMP ORDER BY EMP.EMPNO ;


SELECT job,sum(sal )
FROM EMP
WHERE job IS NOT null
GROUP BY job;


SELECT EMP.DEPTNO  , sum(EMP.SAL) AS "TOTAL"
FROM EMP
WHERE job IS NOT null
GROUP BY deptno
ORDER by deptno asc;

SELECT EMP.DEPTNO , sum(CASE WHEN EMP.JOB ='CLERK' THEN sal ELSE 0 end) AS "CLERK" ,
					sum(CASE WHEN EMP.JOB ='MANAGER' THEN sal ELSE 0 end) AS "MANAGER" ,
					sum(CASE WHEN EMP.JOB ='PRESIDENT' THEN sal ELSE 0 end) AS "PRESIDENT" ,
					sum(CASE WHEN EMP.JOB ='ANALYST' THEN sal ELSE 0 end) AS "ANALYST" ,
					sum(CASE WHEN EMP.JOB ='SALESMAN' THEN sal ELSE 0 end) AS "SALESMAN" ,
					sum(EMP.SAL) AS "TOTAL"
FROM EMP
WHERE job IS NOT null
GROUP BY deptno
ORDER by deptno asc;

SELECT * FROM emp;
SELECT sal,comm FROM emp;



SELECT * FROM tbl_test_customer;
 

--표준 조인 문법
SELECT  name, address, tel, odate, pname, sale_cnt, price, sale_cnt * price
FROM   tbl_test_order o
JOIN     tbl_test_customer c
ON       o.id = c.id
JOIN     tbl_test_goods g
ON       o.pcode = g.pcode ;

SELECT * FROM tbl_test_customer;