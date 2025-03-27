CREATE TABLE usertbl(
	name varchar2(20),
	ID varchar2(20) PRIMARY KEY,
	pw varchar2(20),
	addr number(7)
);
DROP TABLE snaks;
CREATE TABLE snacks(
	snack_num number(4) PRIMARY key,
	snack_name varchar2(20),
	price NUMBER(4)
);
DROP TABLE ordersnack;
CREATE TABLE ordersnack(
	order_num number(4) PRIMARY KEY,
	id varchar2(20) REFERENCES usertbl(id) ON DELETE cascade,
	snack_num number(4) REFERENCES snacks(snack_num) ON DELETE cascade,
	entity number(2)
);

INSERT INTO usertbl values('박시우','siwoo1214','1214',1234567);
INSERT INTO usertbl values('노홍철','hongchul123','7777',7654321);
INSERT INTO usertbl values('박명수','myungsoon','4444',1726354);

INSERT INTO snacks values('0001','눈을감자','2100');
INSERT INTO snacks values('0002','프링글스','2600');
INSERT INTO snacks values('0003','먹태깡','1700');
INSERT INTO snacks values('0004','초코파이','4600');

INSERT INTO ordersnack values('9999','siwoo1214','0003',4);
INSERT INTO ordersnack values('9998','hongchul123','0001',8);
INSERT INTO ordersnack values('9997','myungsoon','0004',7);

SELECT * FROM usertbl;
SELECT * FROM snacks;
SELECT * FROM ordersnack;

SELECT o.ID AS "주문자 아이디",s.SNACK_NAME "과자 이름",o.ENTITY*s.PRICE AS "주문가격"
FROM ordersnack o
JOIN SNACKS s 
ON o.SNACK_NUM = s.SNACK_NUM;

