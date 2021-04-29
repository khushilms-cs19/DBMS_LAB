create database bookdealerdb;
use bookdealerdb;

CREATE TABLE author(
author_id int,
name varchar(20),
city varchar(20),
country varchar(20),
primary key(author_id)
);

CREATE TABLE publisher(
publisher_id int,
name varchar(20),
city varchar(20),
country varchar(20),
primary key(publisher_id)
);


CREATE TABLE catalog(
book_id int,
title varchar(20),
author_id int,
publisher_id int,
category_id int,
year int,
price int,
primary key(book_id),
foreign key(author_id) references author(author_id),
foreign key(publisher_id) references publisher(publisher_id),
foreign key(category_id) references category(category_id)
);

CREATE TABLE category(
category_id int,
description varchar(30),
primary key(category_id)
);

CREATE TABLE order_details(
order_no int,
book_id int,
quantity int,
primary key(order_no),
foreign key(book_id) references catalog(book_id) on delete cascade
);

insert into author values(1001,"Teras Chan","CA","USA");
insert into author values(1002,"Stevens","Zombi","Uganda");
insert into author values(1003,"M Mano","Cair","Canada");
insert into author values(1004,"Karthik B P","New York","USA");
insert into author values(1005,"Willian Stalling","Las Vegas","USA");

insert into publisher values(1,"Pearson","New York","USA");
insert into publisher values(2,"EEE","New South Vales","USA");
insert into publisher values(3,"PHI","Delhi","India");
insert into publisher values(4,"Willey","Berlin","Germany");
insert into publisher values(5,"MGH","New York","USA");

insert into category values(1001,"Computer Science");
insert into category values(1002,"Algorithm Design");
insert into category values(1003,"Electronics");
insert into category values(1004,"Programming");
insert into category values(1005,"Operating Systems");

insert into catalog values(11,"Unix System",1001,1,1001,2000,251);
insert into catalog values(12,"Digital Signals",1002,2,1003,2001,425);
insert into catalog values(13,"Login Design",1003,3,1002,1999,225);
insert into catalog values(14,"Server Prg",1004,4,1004,2001,333);
insert into catalog values(15,"Linux OS",1005,5,1005,2003,326);
insert into catalog values(16,"C++ Bible",1005,5,1001,2000,526);
insert into catalog values(17,"Cobol Handbook",1005,4,1001,2000,658);

insert into order_details values(1,11,5);
insert into order_details values(2,12,8);
insert into order_details values(3,13,15);
insert into order_details values(4,14,22);
insert into order_details values(5,15,3);
insert into order_details values(6,17,10);

select * from author;
select * from publisher;
select * from category;
select * from catalog;
select * from order_details;

use bookdealerdb;

--details of the authors having aleast 2 books along with year of publish is greater than 2000

select * from author where author_id in(select author_id from catalog where year>=2000 group by author_id having count(author_id)>=2);

--author names with max sales of books

select a.name from author a, catalog c, order_details o where a.author_id=c.author_id and c.book_id=o.book_id and o.quantity=(select max(quantity) from order_details);

--increase the price of book by 10% of a specified publisher(eg:- publisher_id=5)

update catalog set price=(price+price*0.1) where publisher_id=5;
