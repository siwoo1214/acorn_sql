SELECT * FROM TBL_TEST_ORDER;

--원하는 정보가 한 개의 테이블에 존재하지 않으면 조인해야함

--표준조인
--주문 테이블, 상품 테이블
SELECT * FROM tbl_test_customer tto;
SELECT * FROM TBL_TEST_GOODS ttg ;
SELECT * FROM TBL_TEST_ORDER tto ;

--on을 기준으로 조인한 테이블은 on의 값이 2번 중복햇 ㅓ나온다
SELECT ttc.NAME , ttg.PNAME, tto.SALE_CNT,ttg.PRICE
FROM tbl_test_order tto
JOIN tbl_test_goods ttg
ON tto.PCODE = ttg.PCODE
JOIN TBL_TEST_CUSTOMER ttc 
ON ttc.id = tto.ID;


SELECT c.name , sum(o.SALE_CNT) 
from tbl_test_order o
JOIN tbl_test_customer c
ON o.ID = c.ID
GROUP BY c.name;

--정렬하기
SELECT c.name , sum(o.SALE_CNT) ||'개' AS cnt
from tbl_test_order o
JOIN tbl_test_customer c
ON o.ID = c.ID
GROUP BY c.name
ORDER BY 2 desc;

--EQUI 	JOIN	 on절에서 같은거 찾는 조인 조건  
--INNER JOIN(내부조인)  :  두 테이블에 모두 존재하는 경우에만 결과에 나온다

--inner join : 양쪽에 모두 있는 것만 조회됨
--고객별로 판매수량의 합계
SELECT o.ODATE ,c.NAME,o.SALE_CNT
from tbl_test_order o
JOIN TBL_TEST_CUSTOMER c        
ON o.ID = c.ID      --연결고리를 걸어주는 역할
;

--전체 합계
SELECT sum(o.SALE_CNT);
from tbl_test_order o
JOIN TBL_TEST_CUSTOMER c        
ON o.ID = c.ID;

--고객별 판매수량의 합계
SELECT c.name,o.sale_cnt
FROM tbl_test_order o
JOIN TBL_TEST_CUSTOMER c
ON o.ID = c.ID;

SELECT c.name,sum(o.sale_cnt)
FROM tbl_test_order o
JOIN TBL_TEST_CUSTOMER c
ON o.ID = c.ID
GROUP BY c.name;


--주문현황
-- 주문, 고객, 상품
SELECT * 
FROM TBL_TEST_ORDER o 
JOIN TBL_TEST_CUSTOMER c ON o.id = c.id
JOIN TBL_TEST_GOODS g ON g.PCODE = o.PCODE;


SELECT o.ODATE, 
		c.NAME, 
		g.PNAME, 
		to_char(g.Price,'999,999') AS 단가, 
		o.SALE_CNT,
		to_char(g.Price*o.SALE_CNT,'999,999')||'원' AS price 
FROM TBL_TEST_ORDER o 
JOIN TBL_TEST_CUSTOMER c ON o.id = c.id
JOIN TBL_TEST_GOODS g ON g.PCODE = o.PCODE;


SELECT  c.NAME, 
		g.PNAME, 
		to_char(g.Price,'999,999') AS 단가
FROM TBL_TEST_ORDER o 
JOIN TBL_TEST_CUSTOMER c ON o.id = c.id
JOIN TBL_TEST_GOODS g ON g.PCODE = o.PCODE;


SELECT c.NAME, sum(g.PRICE * O.SALE_CNT) 합계
FROM TBL_TEST_ORDER o 
JOIN TBL_TEST_CUSTOMER c ON o.id = c.id
JOIN TBL_TEST_GOODS g ON g.PCODE = o.PCODE
GROUP BY c.name;

SELECT * 
FROM TBL_TEST_CUSTOMER ttc 
JOIN TBL_TEST_ORDER tto 
ON ttc.ID = tto.ID;

SELECT * FROM TBL_TEST_customer ;

INSERT INTO TBL_TEST_CUSTOMER VALUES ('H008','박시우','서울 마포구','010-8666-7993');
COMMIT;
UPDATE TBL_TEST_CUSTOMER
SET  = 3
WHERE name='박시우';

DELETE FROM tbl_test_customer
WHERE name='박시우';
COMMIT;

UPDATE emp
SET sal = 3000
WHERE empno = 2000;

--233page
SELECT * FROM emp;
SELECT * FROM dept;

SELECT e.EMPNO,e.ENAME,d.DNAME FROM emp e
JOIN dept d
ON e.DEPTNO = d.deptno;

SELECT * FROM student;
SELECT * FROM PROFESSOR;

SELECT s.NAME,p.NAME FROM student s
JOIN PROFESSOR p
ON s.PROFNO = p.PROFNO;

--이너조인은 겹치는 데이터가 아니면 테이블의 모든 정보가 안나온다
SELECT c.name, o.SALE_CNT 
FROM tbl_test_order o 
JOIN tbl_test_customer c
ON c.ID =o.ID;

SELECT * FROM TBL_TEST_order ;


--outer join
--조인시 일치하지 않는 것도 함께 조회함
SELECT c.name, o.SALE_CNT 
FROM tbl_test_order o 
LEFT OUTER JOIN tbl_test_customer c
ON c.ID =o.ID;
--null값을 0으로 처리한 right outer join
SELECT  C.NAME,  NVL( O.SALE_CNT ,0)
FROM tbl_test_order O
RIGHT OUTER JOIN tbl_test_customer C 
ON  O.ID  = C.ID ;

COMMIT;

SELECT * FROM  tbl_score_200;
SELECT * FROM tbl_join_200;
SELECT * FROM  tbl_mentor_200;

--참가자 조회
SELECT j.join_id "참가자ID" ,j.JOIN_NM "참가자이름", j.BIRTH "생년월일" ,
		decode(j.GENDER,'M','남성'),decode(j.SPECIALTY,'D','댄스','R','랩','V','보컬'),j.CHARM
FROM tbl_join_200 j;

--참가자 조회 완성
SELECT j.join_id "참가자ID" ,j.JOIN_NM "참가자이름", TO_CHAR(TO_DATE(j.BIRTH),'yyyy"년"mm"월"dd"일"') "생년월일" ,
		decode(j.GENDER,'M','남성') "성별",decode(j.SPECIALTY,'D','댄스','R','랩','V','보컬') "실력무대",j.CHARM "매력무대"
FROM tbl_join_200 j;

--참가자 조회 교수님버전------------------------------------------
SELECT * FROM TBL_JOIN_200;

SELECT join_id, 
	JOIN_NM, 
	decode(gender,'M','남자','여자') AS gender,
	decode(SPECIALTY,'D','댄스','V','보컬','R','랩') AS charm, 
	to_char(TO_DATE(BIRTH),'yyyy"월"-mm"월"-dd"일"') AS bitrh,
	charm 
FROM TBL_JOIN_200;

SELECT decode(gender,'M','남자','여자')
FROM TBL_JOIN_200;

SELECT JOIn_id, join_nm, birth,decode(gender,'M','남자','여자')
FROM TBL_JOIN_200;

SELECT birth, to_char(TO_DATE(BIRTH),'yyyy"월"-mm"월"-dd"일"')  --이런식으로 날짜포멧을 맞춰주어야함 
FROM TBL_JOIN_200;

SELECT SPECIALTY , decode(SPECIALTY,'D','댄스','V','보컬','R','랩')
FROM TBL_JOIN_200;


--참가자 점수조회
--일단 전제 다 조인
SELECT *
FROM tbl_score_200 s
JOIN tbl_join_200 j
ON s.ARTISTID= j.JOIN_ID
JOIN tbl_mentor_200 m
ON s.MENTORID = m.MENTOR_ID;

--참가자 점수조회 완성
SELECT s.SCORE_NO "게좌번호",s.ARTISTID "참가자ID",j.JOIN_NM "참가자이름",to_char(TO_DATE(BIRTH),'yyyy"월"-mm"월"-dd"일"') "생년월일",s.SCORE "점수",
		CASE 
			WHEN s.SCORE >= 90 THEN 'A'
			WHEN s.score >= 80 THEN 'B'
			WHEN s.score >= 70 THEN 'C'
			else 'D'
		END "등급",
		m.MENTOR_NM "멘토이름"
FROM tbl_score_200 s
JOIN tbl_join_200 j
ON s.ARTISTID= j.JOIN_ID
JOIN tbl_mentor_200 m
ON s.MENTORID = m.MENTOR_ID;

--교수님 버전
SELECT s.SCORE_NO  ,
s.ARTISTID, 
j.JOIN_NM, 
j.BIRTH, 
CASE WHEN score >= 90 THEN 'A'
					WHEN score >= 80 THEN 'B'
					WHEN score >= 70 THEN 'C'
					ELSE 'D'
			END AS result, 
m.MENTOR_NM 
FROM TBL_SCORE_200 s
JOIN TBL_join_200 j
ON j.JOIN_ID = s.ARTISTID
JOIN TBL_MENTOR_200 m 
ON s.MENTORID = m.MENTOR_ID;


SELECT s.SCORE_NO  , s.ARTISTID, j.JOIN_NM, j.BIRTH, s.SCORE, m.MENTOR_NM 
FROM TBL_SCORE_200 s
JOIN TBL_join_200 j
ON j.JOIN_ID = s.ARTISTID
JOIN TBL_MENTOR_200 m 
ON s.MENTORID = m.MENTOR_ID;

SELECT score , CASE WHEN score >= 90 THEN 'A'
					WHEN score >= 80 THEN 'B'
					WHEN score >= 70 THEN 'C'
					ELSE 'D'
			END AS result
FROM TBL_SCORE_200;



--참가자 등수 조회
SELECT s.ARTISTID, j.JOIN_NM, s.SCORE, s.SCORE
FROM tbl_score_200 s
JOIN tbl_join_200 j
ON s.ARTISTID= j.JOIN_ID
JOIN tbl_mentor_200 m
ON s.MENTORID = m.MENTOR_ID;

--참가자 등수 조회 완성
SELECT s.ARTISTID "참가자ID", j.JOIN_NM "참가자이름", sum(s.SCORE) "종합점수", round(avg(s.SCORE),2) "평균점수", 
		RANK() OVER(ORDER BY AVG(s.SCORE) DESC) AS "순위"
FROM tbl_score_200 s
JOIN tbl_join_200 j
ON s.ARTISTID= j.JOIN_ID
JOIN tbl_mentor_200 m
ON s.MENTORID = m.MENTOR_ID
GROUP BY s.ARTISTID,j.JOIN_NM;

--전체 테이블 조회
SELECT * FROM TBL_JOIN_200;
SELECT * FROM TBL_MENTOR_200;
SELECT * FROM TBL_SCORE_200;


                                                        

--