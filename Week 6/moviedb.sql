create database moviedb;
use moviedb;
create table actor(
act_id int,
act_name varchar(20),
act_gender varchar(3),
primary key(act_id)
);

create table director(
dir_id int,
dir_name varchar(20),
dir_phone int,
primary key(dir_id)
);

create table movies(
mov_id int,
mov_title varchar(30),
mov_year int,
mov_lang varchar(20),
dir_id int,
primary key(mov_id),
foreign key(dir_id) references director(dir_id) on delete cascade on update cascade
);

create table movie_cast(
act_id int,
mov_id int,
role varchar(20),
primary key(act_id,mov_id),
foreign key(act_id) references actor(act_id) on delete cascade on update cascade,
foreign key(mov_id) references movies(mov_id) on delete cascade on update cascade
);

create table rating (
mov_id int,
rev_stars real,
foreign key(mov_id) references movies(mov_id) on delete cascade on update cascade
);


insert into actor values
(100,"Steve Carrel","M"),
(101,"John Krasinski","M"),
(102,"Jenna Fischer","F"),
(103,"Ed Helms","M"),
(104,"Mindy Kaling","F");

insert into actor values
(105,"Jamie Bell","M"),
(106,"Tom Hanks","M"),
(107,"Christian Bale","M"),
(108,"Laura Dern","F");

insert into director values
(1,"Greg Daniels",459876),
(2,"Steven Spielberg",465462),
(3,"Tom Shadyac",465423),
(4,"Christopher Nolan",898434),
(5,"David Lynch",134657);

insert into movies values
(1000,"The Office",2005,"English",1),
(1001,"TinTin",2011,"English",2),
(1002,"The Terminal",2004,"English",2),
(1003,"The Dark Night",2008,"English",4),
(1004,"Evan Almighty",2007,"English",3),
(1005,"Blue Velvet",1986,"English",5);


insert into movie_cast values
(100,1000,"Michael Scott"),
(105,1001,"TinTin"),
(106,1002,"Victor"),
(107,1003,"Bruce Wayne"),
(100,1004,"Evan Baxter"),
(108,1005,"Sandy Williams");

insert into rating values
(1000,8.8),
(1001,7.5),
(1002,8.9),
(1003,8.7),
(1004,0.5),
(1005,7.7);


/* Ques 1 */

select m.mov_id,m.mov_title,m.mov_year from movies m
inner join director d
on d.dir_id=m.dir_id
where dir_name="Steven Spielberg";

/* Ques 2 */

select m.mov_id,m.mov_title,m.mov_year from movie_cast mc
inner join movies m 
on m.mov_id=mc.mov_id
where mc.act_id=(
select mci.act_id from movie_cast mci 
group by mci.act_id
having count(mci.act_id)>=2
);

/*  Ques 3 */

select a.act_name,m.mov_title from movie_cast mc
inner join actor a 
on a.act_id=mc.act_id
inner join movies m 
on mc.mov_id=m.mov_id
where m.mov_year>=2015 or m.mov_year<=2000;

/* Ques 4 */
select m.mov_title,r.rev_stars as "Rating" from movies m 
inner join rating r 
on r.mov_id=m.mov_id 
where r.rev_stars>=1
order by r.rev_stars;

/* Ques 5 */
update rating r
set r.rev_stars= 5
where mov_id=any(
select distinct m.mov_id from movies m
inner join director d
on d.dir_id=m.dir_id
where d.dir_name="Steven Spielberg"
);

update rating r 
set r.rev_stars=8.9
where r.mov_id=1002;
