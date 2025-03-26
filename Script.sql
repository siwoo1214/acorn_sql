
create table  acorntbl (
    id  varchar2(10) primary key,
    pw  varchar2(10) ,
    name varchar2(10)
);


--crud   => create(insert ) , read( select ), u(update) , d(delete) 

select *  from  acorntbl ;  
insert into acorntbl values('test', '1234', '홍길동');  
commit;
