SELECT COLUMN_NAME, DATA_TYPE, NULLABLE
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'T_EMP';

--JOIN
SELECT * FROM TBL_TEST_ORDER;
SELECT * FROM TBL_TEST_goods;
SELECT * FROM TBL_TEST_customer;

--에이콘 쇼핑몰 정보

-- inner join : 양쪽에 같은 것들이 있어야 다 나온다
--equal inner join : 열의 개수는 그냥 +가 되고 행의 개수는 맞는 행의 개수에 의해 결정된다
SELECT * FROM TBL_TEST_order o
JOIN TBL_TEST_customer c
ON o.id = c.id;  --얘네를 기준으로 같은 것들을 갖고온다

--join은 inner join, inner 생략 가능함
SELECT c.name, sum(o.sale_cnt)
FROM TBL_TEST_ORDER o
INNER join TBL_TEST_CUSTOMER c
ON o.id = c.ID
GROUP BY c.name;

--고객별 주문수량의 합계, 주문하지 않은 고객도 함께 조회

--outer join

--
SELECT *
FROM TBL_TEST_ORDER;

SELECT *
FROM TBL_TEST_customer;


SELECT c.name, o.SALE_CNT
FROM TBL_TEST_ORDER o
right OUTER JOIN TBL_TEST_CUSTOMER c
ON o.id = c.ID;


--고객별 판매수량의 합계 (주문하기 않은 고객도 포함되도록)
SELECT c.name, nvl(sum(o.SALE_CNT),0) total_cnt
FROM TBL_TEST_ORDER o
right OUTER JOIN TBL_TEST_CUSTOMER c
ON o.id = c.ID
GROUP BY c.name
ORDER BY 1;

--글(테이블)
--댓글(테이블)

--inner join
--outer join

--on절 조인의 조건이 무엇이냐
--equi join  =
--non equi join  >,<

SELECT * FROM customer;
SELECT * FROM gift;

SELECT *
FROM customer c
JOIN gift g
ON c.point >= g.G_START AND c.POINT <=g.G_END;

SELECT * FROM score;
SELECT * FROM hakjum;
SELECT * FROM STUDENT;

SELECT stu.NAME,sc.total
FROM student stu
JOIN score sc
ON stu.STUDNO = sc.studno;

SELECT s.name stu_name, o.total score, h.grade credit
FROM STUDENT s 
JOIN score o
ON s.STUDNO  = o.studno
JOIN HAKJUM h 
ON o.total >= h.MIN_POINT AND o.total <= h.MAX_POINT  --on절로 조건줘서 조인하는 시점에 점수 판별&점수에 맞는 등급이 나오게 조인
ORDER BY total;

--outer join 1.
SELECT s.NAME stu_name, nvl(p.NAME,' ') prof_name FROM STUDENT s 
LEFT OUTER JOIN PROFESSOR p 
ON s.PROFNO = p.PROFNO;

--outer join 2.
SELECT nvl(s.NAME,' ') stu_name, p.NAME prof_name FROM STUDENT s 
right OUTER JOIN PROFESSOR p 
ON s.PROFNO = p.PROFNO;

--cross join (자연조인)
--join의 조건이 없는 조인 (on절이 없는 조인)
SELECT * FROM TBL_TEST_ORDER tto 
CROSS JOIN TBL_TEST_CUSTOMER ttc;
-- n*n개가 만들어짐

--self join
SELECT * FROM emp;

SELECT empno,ename,nvl(TO_CHAR(mgr),' ')
FROM emp;

SELECT b.empno,a.ename,nvl(TO_CHAR(a.mgr),' ')
FROM emp a
JOIN emp b
ON a.mgr = b.EMPNO;

--inner join(생략가능)
--outer join -left outer right outer full outer
--cross join
--self join

--배드민턴 예약프로그램
--문제 조회만들기

--254page 1,2,3,4

--배드민턴
SELECT * FROM TBL_CUST_202301 tc;
SELECT * FROM TBL_RESV_202301 tr;
SELECT * FROM TBL_COURT_202301 tc;

--배드민턴 1번
SELECT tc.CUST_NO , tc.CUST_NAME , count(tc.CUST_NO )
FROM TBL_CUST_202301 tc
JOIN TBL_RESV_202301 tr
ON tc.CUST_NO = tr.CUST_NO
GROUP BY tc.CUST_NO,tc.CUST_NAME;

--배드민턴 2번
SELECT 
FROM TBL_CUST_202301 tc
JOIN TBL_RESV_202301 tr
ON tc.CUST_NO = tr.CUST_NO
JOIN TBL_COURT_202301 tc
ON tc.COURT_NO = tr.COURT_NO
WHERE tc.COURT_NO = 'C005' AND tc.CUST_NAME = '김선수';


--1번
SELECT * FROM student;
SELECT * FROM department;

SELECT s.NAME stud_name, s.DEPTNO1 deptno1, d.DNAME dept_name
FROM student s
JOIN DEPARTMENT d
ON d.DEPTNO = s.DEPTNO1;

--2번
SELECT * FROM Emp2;
SELECT * FROM p_grade;

SELECT e.NAME name, e."POSITION" , e.PAY , p.S_PAY "Low Pay" ,p.E_PAY "High Pay" 
FROM EMP2 e JOIN P_GRADE p
ON e."POSITION" = p."POSITION";

--3번
SELECT * FROM emp2;
SELECT * FROM p_grade;

SELECT name,to_char(sysdate,'yyyy') - to_char( e.BIRTHDAY ,'yyyy') - 12 AS age
FROM emp2 e;

SELECT e1.NAME , e1.AGE ,e1."POSITION" curr_position, p."POSITION"
FROM (
	SELECT name,
			e."POSITION" ,
			to_char(sysdate,'yyyy')-to_char(e.BIRTHDAY ,'yyyy')-12 AS age
	FROM emp2 e
	) e1
left OUTER JOIN P_GRADE p
ON e1.AGE BETWEEN p.S_AGE AND p.E_AGE
ORDER BY AGE ;


--4번
SELECT * FROM customer;
SELECT * FROM gift;

SELECT COLUMN_NAME, DATA_TYPE, NULLABLE
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'CUSTOMER';

SELECT COLUMN_NAME, DATA_TYPE, NULLABLE
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'GIFT';

SELECT c.GNAME cust_name, c.POINT point, g.GNAME gift_name
FROM customer c
JOIN gift g
ON c.POINT >= g.G_start
WHERE g.GNAME = 'Notebook';

SELECT c.GNAME cust_name, c.POINT point, g.GNAME gift_name
FROM customer c
JOIN gift g
ON g.GNAME = 'Notebook'
WHERE c.POINT >= 600000 AND c.POINT <= 700000 or c.POINT >= 900000;

SELECT c.GNAME cust_name, c.POINT point, g.GNAME gift_name
FROM customer c
JOIN gift g
ON g.GNAME = 'Notebook'
WHERE c.POINT BETWEEN g.G_START AND g.G_END  or c.POINT >= 900000
GROUP BY c.GNAME,c.POINT, g.GNAME;

  select  c.gname, c.point , g.gname
    from customer c
    join gift g
    on g.g_start <= c.point
    where g.gname= 'Notebook';



