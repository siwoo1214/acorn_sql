-- 먼저 prize_LIST 테이블과 데이터를 생성합니다.
CREATE TABLE prize_LIST(
    prize VARCHAR2(50) PRIMARY KEY,
    s_fish NUMBER(2),
    e_fish NUMBER(2)
);

INSERT INTO prize_LIST VALUES ('휴지', 0, 3);
INSERT INTO prize_LIST VALUES ('차량용 방향제', 4, 6);
INSERT INTO prize_LIST VALUES ('휴대폰 거치대', 7, 9);
INSERT INTO prize_LIST VALUES ('귀멸의 칼날 피규어', 10, 12);
INSERT INTO prize_LIST VALUES ('발렌타인 7년산', 13, 15);

SELECT * FROM prize_LIST;

-- FISHERMAN 테이블을 먼저 생성하고 데이터 삽입
CREATE TABLE FISHERMAN (
    a_code CHAR(4) PRIMARY KEY,
    id VARCHAR2(10),
    pw VARCHAR(10),
    name NCHAR(12),
    phone VARCHAR(20) CHECK (phone LIKE '010-____-____'),
    fishes NUMBER(2) DEFAULT 0
);

INSERT INTO FISHERMAN VALUES ('A001', 'user01', 'pass01', '홍길동', '010-1234-5678', 3);
INSERT INTO FISHERMAN VALUES ('A002', 'user02', 'pass02', '김영희', '010-2345-6789', 5);
INSERT INTO FISHERMAN VALUES ('A003', 'user03', 'pass03', '박철수', '010-3456-7890', 2);
INSERT INTO FISHERMAN VALUES ('A004', 'user04', 'pass04', '이민수', '010-4567-8901', 4);
INSERT INTO FISHERMAN VALUES ('A005', 'user05', 'pass05', '최다혜', '010-5678-9012', 1);

SELECT * FROM FISHERMAN;

-- participation_list 테이블을 생성
CREATE TABLE participation_list(	
    P_CODE CHAR(5) PRIMARY KEY,
    F_CODE CHAR(4) REFERENCES FISHERMAN(a_code) ON DELETE CASCADE,
    PRIZE VARCHAR2(50) REFERENCES prize_LIST(prize) ON DELETE CASCADE
);

-- 데이터 삽입
INSERT INTO participation_list (P_CODE, F_CODE, PRIZE) VALUES ('P001', 'A001', '휴지');
INSERT INTO participation_list (P_CODE, F_CODE, PRIZE) VALUES ('P002', 'A002', '차량용 방향제');
INSERT INTO participation_list (P_CODE, F_CODE, PRIZE) VALUES ('P003', 'A003', '휴지');
INSERT INTO participation_list (P_CODE, F_CODE, PRIZE) VALUES ('P004', 'A004', '휴대폰 거치대');
INSERT INTO participation_list (P_CODE, F_CODE, PRIZE) VALUES ('P005', 'A005', '귀멸의 칼날 피규어');
INSERT INTO participation_list (P_CODE, F_CODE, PRIZE) VALUES ('P006', 'A001', '발렌타인 7년산');
INSERT INTO participation_list (P_CODE, F_CODE, PRIZE) VALUES ('P007', 'A003', '차량용 방향제');
INSERT INTO participation_list (P_CODE, F_CODE, PRIZE) VALUES ('P008', 'A002', '휴대폰 거치대');

SELECT * FROM participation_list;

