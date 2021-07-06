create database airlinedb;
use airlinedb;
create table flights(
flno int,
from_loc varchar(20),
to_loc varchar(20),
distance int,
departs time,
arrives time,
price int,
primary key(flno)
);

create table aircraft(
aid int,
aname varchar(20),
cruisingrange int,
primary key(aid)
);

create table certified(
eid int,
aid int,
foreign key(aid) references aircraft(aid),
foreign key(eid) references employee(eid),
primary key(aid,eid)
);

create table employee(
eid int,
ename varchar(20),
salary int,
primary key(eid)
);


insert into flights values
(1000,"Chicago","Tulsa",268,"22:30:00","01:15:00",500),
(1001,"Madison","Albuquerque",500,"12:30:00","14:00:00",100),
(1002,"Albuquerque","New York",450,"14:30:00","16:00:00",300),
(1003,"Madison","Philadelphia",400,"12:30:00","15:00:00",450),
(1004,"Philadelphia","New York",120,"16:10:00","17:30:00",200),
(1005,"New York","Nashville",670,"19:30:00","01:00:00",100),
(1006,"El Paso","Santa Fe",300,"05:20:00","09:15:00",350);

insert into flights values
(1007,"Bangalore","Frankfurt",10000,"10:30:00","22:00:00",2000),
(1008,"Bangalore","Frankfurt",10000,"01:20:00","10:45:00",1500),
(1009,"Bangalore","Frankfurt",10000,"06:55:00","23:35:00",2000);

insert into flights values
(1010,"Bangalore","Chennai",236,"06:55:00","23:35:00",200),
(1011,"Chennai","New Delhi",2387,"06:55:00","23:35:00",400),
(1012,"Bangalore","Mumbai",800,"06:55:00","23:35:00",100),
(1013,"Mumbai","New Delhi",780,"06:55:00","23:35:00",150);

insert into flights values
(1014,"Bangalore","New Delhi",1800,"06:55:00","23:35:00",120);

update flights 
set flights.distance=1800
where flights.flno=1014;

update flights 
set flights.to_loc="New Delhi"
where flights.flno=1014;

insert into aircraft values
(100,"Boeing 747-400",2000),
(101,"Boeing 777-200",3000),
(102,"Boeing 777-300",1500),
(103,"AirBus A380-800",4000),
(104,"AirBus A380-plus",5000),
(105,"Airbus A350-500",3700),
(106,"Fly High-500",1000),
(107,"Cruise Perfect-200",1700),
(108,"Cruise Perfect-500",4000),
(109,"Fly High-400",7800);

insert into employee values
(10,"Alex",10000),
(11,"Sam",14000),
(12,"Jonas",17500),
(13,"John",10600),
(14,"Michael",9000),
(15,"Stanley",2000),
(16,"Chris",4000),
(17,"Verstappen",16000),
(18,"Perez",13000),
(19,"Hamilton",1300);

insert into employee values
(20,"Norris",12300),
(21,"Riccardo",13000),
(22,"Lincoln",18000),
(23,"Cole",14000);

insert into employee values
(24,"Ryan",600),
(25,"Jan",800),
(26,"Gareth",1100);


insert into certified values
(10,100),
(11,101),
(12,104),
(13,103),
(14,104),
(20,105),
(20,106),
(20,107),
(21,108),
(17,102),
(17,109),
(17,107);


/* QUES 1 (changed the salary from Rs.80,000 to $14,000)*/

select a.aname from certified c 
inner join aircraft a 
on a.aid=c.aid
inner join employee e
on e.eid=c.eid
where e.salary>14000;



/* QUES 2 */

select e.eid,max(a.cruisingrange) from certified c 
inner join employee e
on e.eid=c.eid
inner join aircraft a
on a.aid=c.aid
group by c.eid having count(c.eid)>=3;

/* QUES 3 */

select e.ename from employee e
where e.salary<(select min(f.price) from flights f
where from_loc="Bangalore"and to_loc="Frankfurt");


/* Ques 4 (Changed the cruising range from 1000 to 3000 for conveniece)*/

select a.aname, avg(e.salary) from certified c
inner join aircraft a
on a.aid=c.aid
inner join employee e
on e.eid=c.eid
where a.cruisingrange>3000
group by a.aid;

/* QUES 5 */
select e.ename, a.aname from certified c
inner join aircraft a
on a.aid=c.aid
inner join employee e
on e.eid=c.eid
where a.aname like "Boeing%";

/*QUES 6*/
select a.aid from aircraft a 
where a.cruisingrange>=(select f.distance from flights f
where from_loc="Bangalore" and to_loc="New Delhi");




