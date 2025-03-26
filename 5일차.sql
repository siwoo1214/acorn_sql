--03/24--

-row_number()

--누적합
--전체합

--누적합
SELECT name,point,sum(point) OVER()
FROM ACORNTBL2;

SELECT * FROM ACORNTBL a ;

--누적(첫 행에서 현재 행까지 누적)
SELECT name,point, sum(point) over(ORDER BY point)
FROM ACORNTBL;

SELECT name,point, sum(point) over(ORDER BY 어트리뷰트명) --정렬하고싶은 
FROM acorntbl;

--range bertween은 같은 값으로 한번에 다 계산해버리는 함수
SELECT name,point, sum(point) over(ORDER BY 어트리뷰트명 Range BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) ,  --얘네가 기본값이어서 
FROM acorntbl;                                                                                   --바꿀 수 있다 같은 값이면 한번에 더해져서
                                                                                --나오게 되는거여서 디테일하게 하려면 바꿀 필요가 있음

--rows between 으로 하게 되면 따로따로 각각 행 마다 계산하게 된다
SELECT name,point, sum(point) over(ORDER BY 어트리뷰트명 rows BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) ,
FROM acorntbl;                                                                                   
                      

--고객등급별 포인트 누적합
SELECT m_name,m_grade,m_point,sum(m_point) OVER (PARTITION BY m_grade ORDER BY m_point)
FROM member_tbl_11;

--roll up(부분합 구하기) - 선행조건이 group by한 후에 집계를 내고싶을 때 사용
SELECT * FROM member_tbl_11;

SELECT sum(m_point) FROM member_tbl_11;

SELECT m_grade, sum(m_point)
FROM member_tbl_11
GROUP BY m_grade;

--집계 함
--roll up (마지막에 합산 구하는 함수) 
SELECT m_grade, sum(m_point)
FROM member_tbl_11
GROUP BY roll_up(m_grade);

SELECT * 
FROM TBL_TEST_ORDER;

SELECT * FROM TBL_TEST_GOODS;

SELECT * 
FROM TBL_TEST_ORDER o
JOIN TBL_TEST_GOODS g
ON o.PCODE = g.PCODE;

-- 상품별 판매수량 합계 구하기
SELECT g.PNAME ,g.PRICE, o.SALE_CNT
FROM TBL_TEST_ORDER o
JOIN TBL_TEST_GOODS g
ON o.PCODE = g.PCODE;


SELECT nvl(g.PNAME ,'total'),sum(g.PRICE * o.SALE_CNT) sum
FROM TBL_TEST_ORDER o
JOIN TBL_TEST_GOODS g
ON o.PCODE = g.PCODE
GROUP BY ROLLUP(g.PNAME)
ORDER BY sum;


--고객별 제품별 판매금액
--일단 전체 조인
SELECT * 
FROM TBL_TEST_ORDER o
JOIN TBL_TEST_CUSTOMER c 
ON o.id = c.ID
JOIN TBL_TEST_GOODS g 
ON o.PCODE = g.PCODE;

SELECT c.NAME, g.PNAME, g.PRICE * o.SALE_CNT   
FROM TBL_TEST_ORDER o
JOIN TBL_TEST_CUSTOMER c 
ON o.id = c.ID
JOIN TBL_TEST_GOODS g 
ON o.PCODE = g.PCODE;

SELECT c.NAME, g.PNAME, sum(g.PRICE * o.SALE_CNT)
FROM TBL_TEST_ORDER o
JOIN TBL_TEST_CUSTOMER c 
ON o.id = c.ID
JOIN TBL_TEST_GOODS g 
ON o.PCODE = g.PCODE
GROUP BY ROLLUP(c.NAME, g.PNAME)  --이름별 제품별
ORDER BY 1;

--고객별 합계
--고객별 제품별 합계
--전체 합계

SELECT c.NAME, g.PNAME, sum(g.PRICE * o.SALE_CNT)
FROM TBL_TEST_ORDER o
JOIN TBL_TEST_CUSTOMER c 
ON o.id = c.ID
JOIN TBL_TEST_GOODS g 
ON o.PCODE = g.PCODE
GROUP BY ROLLUP(c.NAME, g.PNAME)  --이름별 제품별
ORDER BY 1;

--lag() 함수 :  이전행의 값을 가져올 때 사용 (판매실적)
SELECT name,point,lag(point, 1,0) over(ORDER BY point) 
FROM acorntbl;

--lead()함수 : 다음행의 값을 가져올 때 사용
SELECT name,point ,lead(point,1,0) OVER(ORDER BY point) --lead(뭐의 뒤꺼를,몇번째 뒤꺼를, 없으면 뭐를) over(뭐를 기준으로)
FROM ACORNTBl2;

--pivot 테이블 만들기 like decode
SELECT * 
FROM emp;

--decode로 부서별 직급별 사원의 수 구하기

SELECT decode(job,'CLERK',1), decode(job,'SALESMAN',2)
FROM emp;

SELECT count(job), count(decode(job,'CLERK',1)) clerk ,count( decode(job,'SALESMAN',2)) salesman
FROM emp;

SELECT deptno,decode(job,'CLERK',1), decode(job,'SALESMAN',2)
FROM emp;



SELECT deptno,count(decode(job,'CLERK',1)) clerk, count(decode(job,'SALESMAN',2)) SALESMAN
FROM emp
GROUP BY EMP.DEPTNO 
ORDER BY 1;

--
SELECT * FROM (SELECT deptno, job,empno FROM emp)
pivot(
	count(empno) FOR job IN('CLERK' AS "CLERK", 'MANAGER' AS "MANAGER", 'SALESMAN' AS "SALESMAN", 'ANALYST' AS "ANALYST", 'PRESIDENT' AS "PRESIDENT")
	); 


-- number 
 

SELECT nvl( to_char(DEPTNO),' '),
    SUM(NVL(DECODE(JOB, 'CLERK', SAL, 0), 0)) AS CLERK,
    SUM(NVL(DECODE(JOB, 'MANAGER', SAL, 0), 0)) AS MANAGER,
    SUM(NVL(DECODE(JOB, 'PRESIDENT', SAL, 0), 0)) AS PRESIDENT,
    SUM(NVL(DECODE(JOB, 'ANALYST', SAL, 0), 0)) AS ANALYST,
    SUM(NVL(DECODE(JOB, 'SALESMAN', SAL, 0), 0)) AS SALESMAN,
    SUM(DECODE(JOB, NULL, 0, SAL)) AS TOTAL
FROM EMP
GROUP BY ROLLUP(DEPTNO)
ORDER BY DEPTNO;

SELECT * FROM TBL_SCORE_200 s
JOIN TBL_JOIN_200 j
ON s.ARTISTID = j.JOIN_ID;

SELECT s.ARTISTID, j.JOIN_NM, s.SCORE 
FROM TBL_SCORE_200 s
JOIN TBL_JOIN_200 j
ON s.ARTISTID = j.JOIN_ID;


SELECT s.ARTISTID, j.JOIN_NM ,sum(score) , avg(SCORE), rank() over(ORDER BY avg(score) desc)
FROM TBL_SCORE_200 s
JOIN TBL_JOIN_200 j
ON s.ARTISTID = j.JOIN_ID
GROUP BY s.ARTISTID, j.JOIN_NM;


SELECT s.ARTISTID, j.JOIN_NM ,
		sum(score) , 
		round(avg(SCORE),2), 
		rank() over(ORDER BY avg(score) desc)
FROM TBL_SCORE_200 s
JOIN TBL_JOIN_200 j
ON s.ARTISTID = j.JOIN_ID
GROUP BY s.ARTISTID, j.JOIN_NM;

--rank() over() :  순위구하기
--sum() over() : 누적합 구하기
--lag() over()  : 이전행 가져오기
--lead() over() : 다음행 가져오기
--rollup() : 집계(선행조건이 group by가 되어야함)
--ratio_to_report() over()
--pivot()

SELECT * FROM emp;

SELECT EMP.DEPTNO  
FROM emp
GROUP BY EMP.DEPTNO
ORDER BY DEPTNO ;


--4번 문제 해결
SELECT nvl(to_char(emp.DEPTNO),'총 합계') AS deptno , 
		sum(decode(job,'CLERK',sal,0)) AS clerk,
		sum(decode(job,'MANAGER',sal,0)) AS manager,
		sum(decode(job,'PRESIDENT',sal,0)) AS president,
		sum(decode(job,'ANALYST',sal,0)) AS analyst,
		sum(decode(job,'SALESMAN',sal,0)) AS salesman,
		sum(sal) total
FROM emp
WHERE JOB IS NOT NULL
GROUP BY ROLLUP(EMP.DEPTNO)
ORDER BY DEPTNO;


--5번
SELECT * FROM emp;

SELECT EMP.DEPTNO ,EMP.ENAME , EMP.SAL , sum(sal) over(ORDER BY emp.SAL) total
FROM emp;

--7번
SELECT * FROM student;

SELECT count(tel)||'EA', 
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 02,'SEOUL'))||'EA' seoul,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 031,'GYEONGGI'))||'EA' gyeonggi,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 051,'BUSAN'))||'EA' BUSAN,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 052,'ULSAN'))||'EA' ULSAN,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 053,'DAEGU'))||'EA' DAEGU,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 055,'GYEONGNAM'))||'EA' GYEONGNAM
FROM student;

SELECT count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 02,'경기'))
FROM student;

SELECT 'SQL'||'Server'||'2025'  AS str1 FROM dual;

SELECT count(tel)||'EA'||' ('|| (ratio_to_report(count(tel)) over())*100 ||'%)', 
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 02,'SEOUL'))||'EA'||' 
		('|| (count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 02,'SEOUL'))/count(*))*100 ||'%)' seoul,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 031,'GYEONGGI'))||'EA' gyeonggi,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 051,'BUSAN'))||'EA' BUSAN,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 052,'ULSAN'))||'EA' ULSAN,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 053,'DAEGU'))||'EA' DAEGU,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 055,'GYEONGNAM'))||'EA' GYEONGNAM
FROM student;

SELECT count(tel)||'EA'||' ('|| (ratio_to_report(count(tel)) over())*100 ||'%)' total, --20개 카운트, 전체 개수에 대한 전체 개수의 비율
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 02,'SEOUL'))||'EA'|| --지역번호가 02면 seoul & EA 같이 출력하고
		' ('|| (count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 02,'SEOUL'))/count(*))*100 ||'%)' seoul,--나누기로 비율 출력
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 031,'GYEONGGI'))||'EA'||
		' ('|| (count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 031,'GYEONGGI'))/count(*))*100 ||'%)'gyeonggi,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 051,'BUSAN'))||'EA'||
		' ('|| (count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 051,'BUSAN'))/count(*))*100 ||'%)'BUSAN,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 052,'ULSAN'))||'EA'||
		' ('|| (count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 052,'ULSAN'))/count(*))*100 ||'%)'ULSAN,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 053,'DAEGU'))||'EA'||
		' ('|| (count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 053,'DAEGU'))/count(*))*100 ||'%)'DAEGU,
		count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 055,'GYEONGNAM'))||'EA'||
		' ('|| (count(decode(substr(STUDENT.TEL,1,INSTR(STUDENT.TEL,')')-1), 055,'GYEONGNAM'))/count(*))*100 ||'%)'GYEONGNAM
FROM student;

--8번
SELECT * FROM EMP;

SELECT EMP.DEPTNO , EMP.ENAME , EMP.SAL , sum(sal) over(PARTITION BY emp.DEPTNO ORDER BY emp.SAL) AS total
FROM emp
ORDER BY DEPTNO ;

--9번
SELECT EMP.DEPTNO ,EMP.ENAME , sal, 
		sum(sal) over() AS total,  --over() : 그냥 누적합을 바로 출력해줌
		round(RATIO_TO_REPORT(sal) over() *100 ,2) AS "%"
FROM emp
ORDER BY sal desc;