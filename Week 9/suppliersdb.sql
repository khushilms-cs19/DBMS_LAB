create database suppliersdb;
use supplier;
/*q1*/
SET FOREIGN_KEY_CHECKS=0;
create table suppliers(sid INT PRIMARY KEY,sname VARCHAR(40),address VARCHAR(40));
/*q2*/
INSERT INTO suppliers(sid,sname,address) VALUES(10001,'Acme Widget','Bangalore'),
(10002,'Johns','Kolkata'),
(10003,'Vimal','Mumbai'),
(10004,'Reliance','Delhi');

create table parts(pid INT PRIMARY KEY,pname VARCHAR(40),color varchar(40));
INSERT INTO parts(pid,pname,color) VALUES
(20001,'Book','Red'),
(20002,'Pen','Red'),
(20003,'Pencil','Green'),
(20004,'Mobile','Green'),
(20005,'Charger','Black');
create table catalog(sid INT,pid INT,COST real,primary key(sid,pid),FOREIGN KEY(sid) REFERENCES suppliers(sid),FOREIGN KEY(pid) REFERENCES parts(pid));
show tables;
DESC catalog;
DESC parts;
DESC suppliers;

INSERT INTO catalog(sid,pid,COST) VALUES
(10001,20001,10),
(10001,20002,10),
(10001,20003,30),
(10001,20004,10),
(10001,20005,10),
(10002,20001,10),
(10002,20002,20),
(10003,20003,30),
(10004,20003,40);

SELECT*FROM catalog;
SELECT*FROM parts;
SELECT*FROM suppliers;
/*1)Find the pnames of parts for which there is some supplier.*/
SELECT distinct pname FROM parts,catalog WHERE parts.pid=catalog.pid;
/*2)Find the snames of suppliers who supply every part.*/
SELECT sname FROM suppliers,parts,catalog WHERE suppliers.sid=catalog.sid GROUP BY Catalog.sid AND catalog.pid=ALL(SELECT distinct pid FROM parts) ;
/*3) Find the snames of suppliers who supply every red part.*/
SELECT DISTINCT sname FROM suppliers,catalog,parts WHERE suppliers.sid=catalog.sid AND catalog.pid=PARTS.pid AND parts.color='red';

/*4)Find the pnames of parts supplied by Acme Widget Suppliers and by no one else.*/
select pname from Parts,Catalog,Suppliers where Catalog.pid=Parts.pid and Catalog.sid=Suppliers.sid and Suppliers.sname='Acme Widget' and Catalog.pid not in (select c.pid from Catalog c ,Suppliers s where s.sid=c.sid and s.sname<>'Acme Widget');/*not equal <>*/

/*5) Find the sids of suppliers who charge more for some part than the average cost of that part (averaged 
over all the suppliers who supply that part).*/
SELECT distinct c.sid FROM catalog c WHERE c.cost>(SELECT AVG(c1.cost) FROM catalog c1 WHERE c1.pid=c.pid);/*doing self join so that it sums up only costs of dif suppliers*/

/*6) For each part, find the sname of the supplier who charges the most for that part.*/
SELECT p.pid,s.sname from parts p,suppliers s,Catalog c where c.pid=p.pid and c.sid=s.sid and c.cost=(select max(c1.cost) from catalog c1 where c1.pid=p.pid);