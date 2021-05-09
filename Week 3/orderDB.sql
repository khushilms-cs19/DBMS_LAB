create database orderdb;
use orderdb;


create table CUSTOMER(
cust_no int,
cname varchar(20),
city varchar(20),
primary key(cust_no)
);

create table ordertb(
order_no int,
odate date,
cust_no int,
order_amount int,
primary key(order_no),
foreign key(cust_no) references CUSTOMER(cust_no)
);

create table item(
item_no int,
unit_price int,
primary key(item_no)
);

create table ORDER_ITEM(
order_no int,
item_no int,
qty int,
foreign key(order_no) references ordertb(order_no),
foreign key(item_no) references item(item_no),
primary key(order_no,item_no)
);

create table warehouse(
warehouse_no int,
city varchar(20),
primary key(warehouse_no)
);

create table shipment(
order_no int,
warehouse_no int,
odate date,
foreign key(order_no) references ordertb(order_no),
foreign key(warehouse_no) references warehouse(warehouse_no),
primary key(order_no,warehouse_no)
);

insert into customer values(771,"Pushpa K","Bangalore");
insert into customer values(772,"Suman","Mumbai");
insert into customer values(773,"Sourav","Calicut");
insert into customer values(774,"Laila","Hyderabad");
insert into customer values(775,"Faizal","Bangalore");

insert into ordertb values(111,"2002-01-22",771,18000);
update ordertb set order_no=111 where order_no="111";
insert into ordertb values(112,"2002-07-30",774,6000);
insert into ordertb values(113,"2003-04-03",775,9000);
insert into ordertb values(114,"2003-11-03",775,29000);
insert into ordertb values(115,"2002-12-10",773,29000);
insert into ordertb values(116,"2004-08-19",772,56000);
insert into ordertb values(117,"2004-09-10",771,20000);
insert into ordertb values(118,"2004-11-20",775,29000);
insert into ordertb values(119,"2005-02-13",774,29000);
insert into ordertb values(120,"2005-10-13",775,29000);

insert into item values(5001,503);
insert into item values(5002,750);
insert into item values(5003,150);
insert into item values(5004,600);
insert into item values(5005,890);

insert into order_item values(111,5001,50);
insert into order_item values(112,5003,20);
insert into order_item values(113,5002,50);
insert into order_item values(114,5005,60);
insert into order_item values(115,5004,90);
insert into order_item values(116,5001,10);
insert into order_item values(117,5003,80);
insert into order_item values(118,5005,50);
insert into order_item values(119,5002,10);
insert into order_item values(120,5004,45);

insert into warehouse values(1,"Delhi");
insert into warehouse values(2,"Mumbai");
insert into warehouse values(3,"Chennai");
insert into warehouse values(4,"Bangalore");
insert into warehouse values(5,"Bangalore");
insert into warehouse values(6,"Delhi");
insert into warehouse values(7,"Mumbai");
insert into warehouse values(8,"Chennai");
insert into warehouse values(9,"Delhi");
insert into warehouse values(10,"Bangalore");

insert into shipment values(111,1,"2002-02-10");
insert into shipment values(112,5,"2002-09-10");
insert into shipment values(113,8,"2003-02-10");
insert into shipment values(114,3,"2003-12-10");
insert into shipment values(115,9,"2004-01-19");
insert into shipment values(116,1,"2004-09-20");
insert into shipment values(117,5,"2004-09-10");
insert into shipment values(118,7,"2004-11-30");
insert into shipment values(119,7,"2005-04-30");
insert into shipment values(120,6,"2005-12-21");

use orderdb;
select * from customer;
select * from ordertb;
select * from item;
select * from order_item;
select * from warehouse;
select * from shipment;


use orderdb;
/*Question 1*/
select c.cname,count(o.order_no),avg(o.order_amount) from customer c
inner join ordertb o
on c.cust_no=o.cust_no
group by c.cust_no;

/*Question 2*/
select o.order_no,w.city from ordertb o 
inner join shipment s 
on o.order_no=s.order_no 
inner join warehouse w 
on s.warehouse_no=w.warehouse_no
-- where w.city="Delhi"--/*This can be added to specify the city to be viewed*/
order by w.city;

/*Question 3*/
delete from order_item where order_no=120;