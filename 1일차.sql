create table  acorntbl (
    id  varchar2(10) primary key,
    pw  varchar2(10) ,
    name varchar2(10)
);

DESC acorntbl1;

select *  from  acorntbl ;  
insert into acorntbl values('test2', '1234', '홍길동2');  
commit;

SELECT * FROM emp;