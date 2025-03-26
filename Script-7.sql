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

