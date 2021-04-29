create database insurancedb;
use insurancedb;

CREATE TABLE PERSON(
driver_id varchar(10),
name varchar(20),
address varchar(15),
primary key(driver_id));

CREATE TABLE CAR(
regno varchar(10),
model varchar(20),
Year int,
primary key(regno));


CREATE TABLE ACCIDENT(
report_no int,
adate date,
location varchar(15),
primary key(report_no));

CREATE TABLE OWNS(
driver_id varchar(10),
regno varchar(10),
primary key(driver_id,regno),
foreign key(driver_id) references PERSON(driver_id) on delete cascade,
foreign key(regno) references CAR(regno) on delete cascade);

CREATE TABLE PARTICIPATED(
driver_id varchar(10),
regno varchar(10),
report_no int,
damage_amt float,
foreign key(driver_id,regno) references OWNS(driver_id,regno) on delete cascade,
foreign key(report_no) references ACCIDENT(report_no)on delete cascade);

show tables;
insert into PERSON values("1111","Ramu","K,S Layout");
insert into PERSON values("2222","John","Indiranagar");
insert into PERSON values("3333","Priya","Jayanagar");
insert into PERSON values("4444","Gopal","Whilefield");
insert into PERSON values("5555","Latha","Vijaynagar");

insert into CAR values("KA04Q2301","Maruthi-dx",2000);
insert into CAR values("KA05P1000","Fordicon",2000);
insert into CAR values("KA03L1234","Zen-VXI",1999);
insert into CAR values("KA03L9999","Maruthi-DX",2002);
insert into CAR values("KA01P4020","Indica-VX",2002);

insert into ACCIDENT values(12,"2002-05-01","M G Road");
insert into ACCIDENT values(200,"2002-12-10","Double Road");
insert into ACCIDENT values(300,"1999-07-23","M G Road");
insert into ACCIDENT values(25000,"2000-06-11","Residency Road");
insert into ACCIDENT values(26500,"2001-10-16","Richmond Road");

insert into OWNS values("1111","KA04Q2301");
insert into OWNS values("1111","KA05P1000");
insert into OWNS values("2222","KA03L1234");
insert into OWNS values("3333","KA03L9999");
insert into OWNS values("4444","KA01P4020");

insert into PARTICIPATED values("1111","KA04Q2301",12,20000);
insert into PARTICIPATED values("2222","KA03L1234",200,500);
insert into PARTICIPATED values("3333","KA03L9999",300,10000);
insert into PARTICIPATED values("4444","KA01P4020",25000,2375);
insert into PARTICIPATED values("2222","KA03L9999",12,10000);

update PARTICIPATED set damage_amt=25000 where report_no=12 and regno="KA03Q2301";

select count(*) from ACCIDENT where adate like "2002-__-__";

select count(a.report_no) from ACCIDENT A, PARTICIPATED P, CAR C
where A.report_no=P.report_no and P.regno=c.regno and C.model="Maruthi-DX";




