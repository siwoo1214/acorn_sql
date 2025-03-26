SELECT * FROM student;

SELECT * FROM PROFESSOR;

SELECT s.STUDNO, p.PROFNO
FROM student s
LEFT OUTER JOIN professor p
ON s.PROFNO = p.PROFNO

SELECT * FROM emp;

SELECT e.DEPTNO, sum(e.SAL)
FROM emp e
GROUP BY rollup(e.DEPTNO);


--연습
SELECT * FROM emp;

SELECT COLUMN_NAME, DATA_TYPE, NULLABLE
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'T_EMP';  -- 테이블명은 반드시 대문자로 입력


SELECT e.DEPTNO "학과 번호", nvl(e.sal,0), 
       nvl(RATIO_TO_REPORT(e.sal) OVER()*100, 0)  AS "비율"  
FROM emp e
WHERE sal IS NOT null
GROUP BY ROLLUP(e.DEPTNO, e.sal); --집계함수 앞에있는 요소들은 모두 GROUP by로 묶어줘야함
--근데 왜 아래 3개의 열이 0으로 나오고 총 합도 0으로 나오는지 모르겠음 nvl로 널값은 0으로 처리했는데도 불구하고 왜그러는지 모르겠음

SELECT e.DEPTNO "학과 번호", nvl(e.sal,0), 
       nvl(RATIO_TO_REPORT(e.sal) OVER()*100, 0)  AS "비율"  
FROM emp e
WHERE sal IS NOT null
GROUP BY ROLLUP(nvl(to_char(e.DEPTNO),'총합'), e.sal);

--grouping : 그 행이 집계된 행인지 아닌지 판별. 집계된 행이면 1반환 아니면 0반환
SELECT 
    CASE 
        WHEN GROUPING(e.DEPTNO) = 1 THEN '총합' 
        ELSE TO_CHAR(e.DEPTNO) 
    END AS "학과 번호",
    NVL(e.sal, 0) AS "급여",
    NVL(RATIO_TO_REPORT(e.sal) OVER() * 100, 0) AS "비율"
FROM emp e
WHERE sal IS NOT NULL
GROUP BY ROLLUP(e.DEPTNO, e.sal);



------------ 03/25 시작 --------------
SELECT * FROM t_emp;
SELECT * FROM T_DEPT;

--단순뷰 만들기
CREATE VIEW v_emp
AS 
SELECT ename, deptno
FROM t_emp;

SELECT * FROM v_emp;
--

SELECT o.ODATE, g.PNAME, o.SALE_CNT, g.PRICE
FROM TBL_TEST_ORDER o
JOIN TBL_TEST_GOODS g
ON o.PCODE = g.PCODE;

--복합뷰 만들기 (조인해서 만든 뷰)
CREATE VIEW V_ORDER_TEST
	as
		SELECT o.ODATE, g.PNAME, o.SALE_CNT, g.PRICE
		FROM TBL_TEST_ORDER o
		JOIN TBL_TEST_GOODS g
		ON o.PCODE = g.PCODE;

SELECT * FROM v_order_test;

SELECT * FROM v_order_test
WHERE sale_cnt>=4;
COMMIT;

-- 뷰의 종류
-- 단순뷰 (한 개의 테이블로 뷰 만들기)
-- 복합뷰 (조인테이블로 뷰 만들기)
-- 인라인뷰 -> 서브쿼리의 종류

--TBL_TEST_ORDER
--TBL_TEST_GOODS
--TBL_TEST_CUSTOMER
SELECT * FROM TBL_TEST_CUSTOMER;

--인라인뷰 경험하기
--고객별 판매수량 합계 구하기
-- 1) 고객별 판매수량의 합계 구하기
-- 2) 고객테이블과 조인하여 결과 만들기

SELECT * FROM TBL_TEST_ORDER;

SELECT id,SALE_CNT 
FROM TBL_TEST_ORDER;

SELECT id,sum(SALE_CNT )
FROM TBL_TEST_ORDER
GROUP BY id;

SELECT c.NAME, A.CNT     --from절에 뷰를 만들 수도 있는데 이걸 인라인뷰라고 한다
FROM (
	SELECT id,sum(SALE_CNT ) cnt  --from절 안에 있는 쿼리문도 단독으로 실행될 수 있어야 한다
	FROM TBL_TEST_ORDER
	GROUP BY id
	) A
	JOIN TBL_TEST_CUSTOMER c
	ON A.ID =c.ID;
	
-- 서브쿼리 : 하나의 쿼리 안에 또 다른 쿼리가 있는 것을 서브쿼리라고 한다 (인라인뷰도 서브쿼리에 포함된다)

-- 뷰만들기
-- CREATE VIEW 뷰미읆
-- AS
-- select절

-- (테이블 한개 - 단순뷰)
-- (테이블 여러개 - 복합뷰)

-- from절 뒤에 오는 서브쿼리 (인라인 뷰)라고 한다

-- 서브 쿼리
-- 쿼리안에 들어가는 서브쿼리 먼저 작성을 완료하고 바깥 쿼리를 작성해라
SELECT * FROM t_emp;

-- 신동엽 사원보다 급여가 더 많은 사원의 이름, 급여, 상여금 조회하시오
SELECT salary FROM T_EMP WHERE ename='신동엽';

SELECT * FROM T_EMP te 
WHERE salary>280;

-- 단일행 서브쿼리
SELECT * FROM T_EMP te 
WHERE salary > (SELECT salary FROM T_EMP WHERE ename='신동엽');

-- 단일행 서브쿼리 연산자 = , <>, >= , <= , < , >
SELECT * FROM student;


--단일행 서브쿼리로 
SELECT STUDENT.NAME , STUDENT.DEPTNO1  FROM student
WHERE STUDENT.DEPTNO1  = (SELECT STUDENT.DEPTNO1  FROM student WHERE STUDENT.NAME = 'Anthony Hopkins');

--join use
SELECT NAME , d.DNAME  FROM student s
JOIN department d
ON s.DEPTNO1 = d.DEPTNO
WHERE s.DEPTNO1 = (SELECT student.DEPTNO1 
					FROM student
					WHERE student.name='Anthony Hopkins');

DROP VIEW department;
COMMIT;

SELECT * FROM department;

--다중행 서브쿼리
SELECT * FROM t_emp;
SELECT * FROM t_dept;

--다중행 서브쿼리란? 서브쿼리의 결과가 여러행을 반환하는 서브쿼리를 말한다 -> in을 사용한다
SELECT salary FROM T_EMP te WHERE salary >= 280

SELECT * FROM T_EMP te 
WHERE te.SALARY IN (SELECT salary FROM T_EMP te WHERE salary >= 280);

--이거랑 똑같은 결과가 반환된다
SELECT * FROM T_EMP te 
WHERE te.SALARY IN (280,290,300);

-- >ANY <ANY 이중에 하나라도 만족하면 ok (최소값)
-- >ALL <ALL 얘네들이 다 만족해야지 ok (반환되는 값중에 최대값보다 커야지 만족한다 즉 최대값만 반환한다)

-- any : 서브쿼리의 여러 행의 값의 하나라도 만족하면 됨
SELECT * FROM T_EMP te 
WHERE te.SALARY <= ANY(SELECT salary FROM T_EMP te WHERE salary >= 280);
-- all : 서브쿼리의 여러 행의 값에 모두 만족하면 됨
SELECT * FROM T_EMP te 
WHERE te.SALARY >= ALL(SELECT salary FROM T_EMP te WHERE salary >= 280);

-- exist(sub query)
-- 서브쿼리가 존재하면 메인쿼리를 실행한다, 서브쿼리 결과가 존재하지 않으면 실행되지 않는다
SELECT * FROM t_emp
WHERE exists (SELECT deptno FROM T_DEPT WHERE DEPTNO = 70);

-- 다중 컬럼
SELECT grade,weight FROM student;

SELECT grade,max(weight) 
FROM student
GROUP BY grade;

SELECT grade, name, weight
FROM student
WHERE (grade, weight) IN (SELECT grade,max(weight) 
						FROM student
						GROUP BY grade
						);

SELECT * FROM student;

-- from절 뒤에 오는 서브쿼리 (인라인뷰 서브쿼리라고 함) 하나의 뷰가 만들어짐

-- 쿼리가 복잡해질 때 view를 사용하거나
-- from절 뒤에 서브쿼리로 사용할 수 있다 (인라인 뷰 라고 함)

-- 고객별 판매수량의 함계
-- 권지언 9
-- 이동우 6
-- 오윤석 2
-- 윤현기 5
-- 임형택 3
-- 1) 고객별 판매수량의 합계 구하기
-- 2) 1)번의 쿼리결과와 고객테이블을 조인해서 전체 쿼리를 완성
SELECT id,sale_cnt FROM TBL_TEST_ORDER;

SELECT a.ID,c.NAME,a.CNT
FROM (
SELECT id,sum(sale_cnt) cnt
FROM TBL_TEST_ORDER
group BY id) A
JOIN TBL_TEST_CUSTOMER c
ON A.ID = c.ID;

SELECT * FROM TBL_TEST_CUSTOMER ;

--430page
SELECT deptno1 , avg(weight)
FROM student
WHERE deptno1='201'
GROUP BY deptno1;

--완성
SELECT s.NAME,s.WEIGHT 
FROM student s
WHERE weight > (SELECT avg(weight)
		FROM student
		WHERE deptno1='201'
		GROUP BY deptno1);

--420page
SELECT * FROM professor;
SELECT * FROM department;

--view 생성
CREATE VIEW v_prof_dept2
	AS
	SELECT p.profno,p.name,d.dname  FROM professor p
	JOIN department d
	ON p.deptno = d.deptno;

SELECT * FROM v_prof_dept2;

--2번
SELECT * FROM student;
SELECT * FROM department;

-- 서브쿼리
SELECT s.DEPTNO1,max(s.HEIGHT),max(s.WEIGHT) 
FROM student s
GROUP BY s.DEPTNO1;

-- 메인
SELECT * FROM department;

-- 합체
SELECT d.DNAME,maxValues.MAX_HEIGHT,maxValues.MAX_WEIGHT
FROM (SELECT s.DEPTNO1,max(s.HEIGHT) max_height,max(s.WEIGHT) max_weight 
		FROM student s
		GROUP BY s.DEPTNO1) maxValues
JOIN DEPARTMENT d 
ON d.DEPTNO = maxValues.DEPTNO1;

-- 420pg 3번 --
select tb.dname, tb.newmax as max_height , st.name , st.height
from ( select d.dname, max(s.height) as newmax, s.deptno1
       from student s
       join department d
       on s.deptno1 = d.deptno
       group by deptno1 , dname 
     )tb, student st
where st.height = tb.newmax and st.deptno1 = tb.deptno1;

--교수님 풀이
--1) 학과별 가장 큰 키 조회하기
--2) 1번쿼리의 내용을 학생테이블로 조인하여 학과별 가장 큰 키의 학생정보를 조회하기 (같은 학과, 키가 같아야 함)
--3) 학과테이블 조인하여 학과명 가져오기

SELECT *
FROM student
ORDER BY deptno1;

SELECT deptno1,height
FROM student;

--학과별 가장 큰 키 조회하기
SELECT deptno1,max(height)
FROM student
GROUP BY deptno1;

SELECT d.DNAME ,s.NAME,A.MAX_HEIGHT,s.HEIGHT                 --서브쿼리에 alias를 줘서 본인의 값에 접근할 수 있음
FROM (
	SELECT deptno1,max(height) max_height
	FROM student
	GROUP BY deptno1
	) A
JOIN student s
ON A.DEPTNO1  = s.DEPTNO1 AND A.MAX_HEIGHT =s.HEIGHT
JOIN DEPARTMENT d 
ON d.DEPTNO = A.DEPTNO1;

SELECT * FROM department;

-- 서브쿼리
-- 연관쿼리 : 서브쿼리에서 메인쿼리의 내용을 사용하는 쿼리
-- 비연관쿼리 : 서브쿼리에서 메인쿼리의 내용을 사용 안함

-- 비연관쿼리 
-- 평균 salary보다 많이 받는 사람 조회하기
SELECT * FROM T_EMP
WHERE salary>=(
	SELECT avg(salary) FROM T_EMP
	);

-- 연관서브쿼리
-- 자신이 속한 부서의 평균
SELECT *
FROM T_EMP e
WHERE salary = (SELECT max(salary) 
				FROM T_EMP te
				WHERE e.DEPTNO  = te.DEPTNO);

-- 자신이 속한 부서의 평균 급여보다 많이 받는 사람
SELECT *
FROM T_EMP e
WHERE salary = (SELECT max(salary) 
				FROM T_EMP te
				WHERE e.DEPTNO  = te.DEPTNO);

--SQL DDL,DML,DCL
--DML  (데이터 조작언어) crud라고도 한다
--SELECT (read)
--INSERT (create)
--UPDATE (update)
--DELETE (delete)

SELECT * FROM ACORNTBL2 a ;

--홍길동 
INSERT INTO ACORNTBL2 (id,pw,name,point) values('hong','1234','홍길동',100);
INSERT INTO ACORNTBL2 values('hong2','1214','홍길순',200);
COMMIT;

--변경하기 (update로 변경하기 - where절 없으면 모든 행이 변경됨, where절 잘 확인하기)
UPDATE ACORNTBL2 
SET point=point+400
WHERE ACORNTBL2.NAME = '김유민';

--비밀번호 
--che 아이디를 가진 회원의 비밀번호 변경하기

UPDATE ACORNTBL2 a 
SET pw='0409'
WHERE id='che';

--여러개 변경
UPDATE ACORNTBL2 a 
SET pw='0448', point=5000
WHERE a.ID ='boseong00';
COMMIT;

--데이터 삭제하기 ,where절 주의 , where절 없으면 테이블의 모든 행을 삭제하게됨 .. 주의하기!!
DELETE FROM ACORNTBL2 
WHERE id='hong';
SELECT * FROM ACORNTBL2 a ;

--421page 4번
SELECT * FROM student
ORDER BY GRADE ;

--학년별 평균키
SELECT grade,avg(height )
FROM student
GROUP BY grade
ORDER BY GRADE ;

--총 조회
SELECT grade,name,height 
FROM student
ORDER BY GRADE ;

SELECT grade,avg(height)
FROM (
	SELECT grade,name,height 
	FROM student
	ORDER BY GRADE
	) s1
right OUTER JOIN student s2
ON s1.NAME = s2.NAME
GROUP BY grade;



SELECT grade,name,height 
FROM student
ORDER BY GRADE;

SELECT grade,avg(height )
FROM student
GROUP BY grade
ORDER BY GRADE;

--test
SELECT grade,avg(height )
FROM student
GROUP BY grade
ORDER BY GRADE;

SELECT s2.grade,name, height , avg_height
FROM (
	SELECT grade,avg(height ) avg_height
	FROM student
	GROUP BY grade
	ORDER BY GRADE
	) s1
JOIN STUDENT s2
ON s1.GRADE =s2.GRADE
WHERE height>s1.AVG_HEIGHT 
ORDER BY GRADE;

--430page 3번
SELECT * FROM student;

--첫번쨰조건 1전공이 201인 학과의 평균 몸무게
SELECT s.DEPTNO1 , avg(s.WEIGHT) 
FROM STUDENT s
WHERE s.DEPTNO1 ='201'
GROUP BY s.DEPTNO1 ;

SELECT name,weight
FROM student s1
WHERE s1.WEIGHT >any (
		SELECT avg(s.WEIGHT) avg_weight
		FROM STUDENT s
		WHERE s.DEPTNO1 ='201'
		);

--434page 
SELECT * FROM emp2;
--emp2 테이블 없어서 skip
SELECT table_name FROM all_tables WHERE owner = 'SCOTT';
SELECT table_name FROM user_tables;

--한양 cu
SELECT * FROM goods_tbl_500;
SELECT * FROM store_tbl_500;
SELECT * FROM sale_tbl_500 sale  --판매 취소된 것들만 계산
WHERE sale.SALE_FG = 1;

--상품목록    to_char() 포맷 기억하기
SELECT to_char(goods_price,'999,999') ,to_char(in_date,'yyyy"년/"mm"월/"dd"일"')
FROM GOODS_TBL_500;

SELECT to_char(in_date,'yyyy"년/"mm"월/"dd"일"')
FROM goods_tbl_500;




--점포명/현금매출/카드매출/총매출
SELECT srt.STORE_NM 
FROM STORE_TBL_500 srt 
JOIN SALE_TBL_500 slt 
ON srt.STORE_CD = slt.STORE_CD
JOIN GOODS_TBL_500 gt 
ON gt.GOODS_CD = slt.GOODS_CD
GROUP BY srt.STORE_NM;
-------------------------------------------------------------------------------------
--교수님꺼
--현금 => 현금&카드
SELECT srt.STORE_NM ,slt.SALE_CNT * gt.GOODS_PRICE , slt.PAY_TYPE ,
		decode(slt.PAY_TYPE,'01',slt.SALE_CNT * gt.GOODS_PRICE,0),
		decode(slt.PAY_TYPE,'02',slt.SALE_CNT * gt.GOODS_PRICE,0)
FROM STORE_TBL_500 srt 
JOIN SALE_TBL_500 slt 
ON srt.STORE_CD = slt.STORE_CD
JOIN GOODS_TBL_500 gt 
ON gt.GOODS_CD = slt.GOODS_CD;

--현금 => 현금&카드&총합
SELECT srt.STORE_NM ,slt.SALE_CNT * gt.GOODS_PRICE , slt.PAY_TYPE ,
		decode(slt.PAY_TYPE,'01',slt.SALE_CNT * gt.GOODS_PRICE,0),
		decode(slt.PAY_TYPE,'02',slt.SALE_CNT * gt.GOODS_PRICE,0),
		slt.SALE_CNT * gt.GOODS_PRICE
FROM STORE_TBL_500 srt 
JOIN SALE_TBL_500 slt 
ON srt.STORE_CD = slt.STORE_CD
JOIN GOODS_TBL_500 gt 
ON gt.GOODS_CD = slt.GOODS_CD;

--현금 => 현금&카드&총합 => group by&rollup
SELECT nvl(srt.STORE_NM,'총합') "점포명" ,
		sum(decode(slt.PAY_TYPE,'01',slt.SALE_CNT * gt.GOODS_PRICE,0)) "현금결제",
		sum(decode(slt.PAY_TYPE,'02',slt.SALE_CNT * gt.GOODS_PRICE,0)) "카드결제",
		sum(slt.SALE_CNT * gt.GOODS_PRICE) "합계"
FROM STORE_TBL_500 srt 
JOIN SALE_TBL_500 slt 
ON srt.STORE_CD = slt.STORE_CD
JOIN GOODS_TBL_500 gt 
ON gt.GOODS_CD = slt.GOODS_CD
GROUP BY ROLLUP(srt.STORE_NM) ;

--카드 
SELECT srt.STORE_NM ,slt.SALE_CNT * gt.GOODS_PRICE , slt.PAY_TYPE ,
		decode(slt.PAY_TYPE,'02',slt.SALE_CNT * gt.GOODS_PRICE,0)
FROM STORE_TBL_500 srt 
JOIN SALE_TBL_500 slt 
ON srt.STORE_CD = slt.STORE_CD
JOIN GOODS_TBL_500 gt 
ON gt.GOODS_CD = slt.GOODS_CD;
-------------------------------------------------------------------------------------

--서브쿼리
SELECT st.STORE_CD , 
		sum(decode(st.PAY_TYPE ,'01',nvl(gt.GOODS_PRICE,1) * nvl(st.SALE_CNT,1))) AS "현금결제",
		sum(decode(st.PAY_TYPE,'02',nvl(gt.GOODS_PRICE,1) * nvl(st.SALE_CNT ,1))) AS "카드결제"
FROM GOODS_TBL_500 gt
JOIN SALE_TBL_500 st 
ON gt.GOODS_CD = st.GOODS_CD
WHERE st.SALE_FG ='1'
GROUP BY st.STORE_CD;

-- 1번 합체
SELECT store.STORE_NM "점포명", nvl(merged.현금매출,0) "현금매출" , nvl(merged.카드매출,0) "카드매출", 
		nvl(merged.현금매출,0)+nvl(merged.카드매출,0 ) "총매출"
FROM (SELECT st.STORE_CD , 
		sum(decode(st.PAY_TYPE ,'01',nvl(gt.GOODS_PRICE,1) * nvl(st.SALE_CNT,1))) "현금매출",
		sum(decode(st.PAY_TYPE,'02',nvl(gt.GOODS_PRICE,1) * nvl(st.SALE_CNT ,1))) "카드매출"
	FROM GOODS_TBL_500 gt
	JOIN SALE_TBL_500 st 
	ON gt.GOODS_CD = st.GOODS_CD
	GROUP BY st.STORE_CD
	) merged
JOIN STORE_TBL_500 store
ON store.STORE_CD = merged.STORE_CD;
-------------------------------------------

--2번 start
SELECT * FROM sale_tbl_500 sale;
SELECT * FROM goods_tbl_500;
SELECT * FROM store_tbl_500;

SELECT * FROM GOODS_TBL_500 gt
JOIN SALE_TBL_500 st 
ON gt.GOODS_CD = st.GOODS_CD
WHERE st.SALE_FG ='1';


--서브쿼리
SELECT sale.SALE_NO "판매번호", 
		sale.SALE_FG "판매구분", 
		sale.SALE_YMD "판매일자", 
		sale.SALE_CNT "판매수량",  --가격이랑 곱해서 판매금액으로 바꿀꺼임
		sale.PAY_TYPE "수취구분",
		sale.GOODS_CD "상품코드" 
FROM sale_tbl_500 sale
WHERE sale.SALE_FG ='1' AND sale.PAY_TYPE = '02' AND sale.SALE_NO = '0001' OR sale.SALE_NO = '0004';

--합체
SELECT decode(modi.판매구분,'1','판매') "판매구분",
		modi.판매번호,
		to_char(modi.판매일자,'yyyy-mm-dd') "판매일자",
		st.GOODS_NM "상품명",
		modi.판매수량,
		modi.판매수량 *st.GOODS_PRICE "판매금액",
		decode(modi.수취구분,'02','카드') "수취구분"
FROM (SELECT sale.SALE_NO "판매번호", 
		sale.SALE_FG "판매구분", 
		sale.SALE_YMD "판매일자", 
		sale.SALE_CNT "판매수량",
		sale.PAY_TYPE "수취구분",
		sale.GOODS_CD "상품코드"
	FROM sale_tbl_500 sale
	WHERE sale.SALE_FG ='1' AND sale.PAY_TYPE = '02' AND sale.SALE_NO = '0001' OR sale.SALE_NO = '0004'
	) modi
JOIN goods_TBL_500 st 
ON modi.상품코드 = st.GOODS_CD;