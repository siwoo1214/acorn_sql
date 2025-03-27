CREATE TABLE ANGLER (
	ID VARCHAR2(10) PRIMARY key,
	NAME NCHAR(12),
	CODE CHAR(4),
	FISHES NUMBER(2),
	FOOD_PRICE NUMBER(6)
);

CREATE TABLE FISHING_FLATFORM (
	F_NUM NUMBER(4) PRIMARY key,
	PRICE NUMBER(6)
);

CREATE TABLE BOOKING (
	B_CODE CHAR(5) PRIMARY key,
	F_NUM NUMBER(4) REFERENCES fishing_flatform(f_num) ON DELETE cascade,
	ID VARCHAR2(10) REFERENCES angler(id) ON DELETE cascade,
	DAYS NUMBER(2) DEFAULT 1,
	b_date date
);

CREATE TABLE RESTAURANT
	MENU VARCHAR2(30) PRIMARY key,
	PRICE NUMBER(7)
);

CREATE TABLE FOOD_ORDER (
    O_NUM VARCHAR2(4) PRIMARY KEY,
    ID VARCHAR2(10) REFERENCES ANGLER(ID) ON DELETE CASCADE,
    MENU VARCHAR2(30) REFERENCES RESTAURANT(MENU) ON DELETE CASCADE
);


CREATE TABLE EVENT (
	START_FISH NUMBER(2),
	END_FISH NUMBER(2),
	PRIZE VARCHAR2(50)
);


ALTER TABLE "FOOD_ORDER" ADD CONSTRAINT "PK_FOOD_ORDER" PRIMARY KEY (
	"Key3",
	"Key"
);

ALTER TABLE "FISHING_FLATFORM" ADD CONSTRAINT "PK_FISHING_FLATFORM" PRIMARY KEY (
	"Key"
);

ALTER TABLE "RESTAURANT" ADD CONSTRAINT "PK_RESTAURANT" PRIMARY KEY (
	"Key"
);

ALTER TABLE "ANGLER" ADD CONSTRAINT "PK_ANGLER" PRIMARY KEY (
	"Key"
);

ALTER TABLE "BOOKING" ADD CONSTRAINT "PK_BOOKING" PRIMARY KEY (
	"Key",
	"Key2",
	"Key3"
);

ALTER TABLE "FOOD_ORDER" ADD CONSTRAINT "FK_ANGLER_TO_FOOD_ORDER_1" FOREIGN KEY (
	"Key3"
)
REFERENCES "ANGLER" (
	"Key"
);

ALTER TABLE "FOOD_ORDER" ADD CONSTRAINT "FK_RESTAURANT_TO_FOOD_ORDER_1" FOREIGN KEY (
	"Key"
)
REFERENCES "RESTAURANT" (
	"Key"
);

ALTER TABLE "BOOKING" ADD CONSTRAINT "FK_FISHING_FLATFORM_TO_BOOKING_1" FOREIGN KEY (
	"Key2"
)
REFERENCES "FISHING_FLATFORM" (
	"Key"
);

ALTER TABLE "BOOKING" ADD CONSTRAINT "FK_ANGLER_TO_BOOKING_1" FOREIGN KEY (
	"Key3"
)
REFERENCES "ANGLER" (
	"Key"
);

