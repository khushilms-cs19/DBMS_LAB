CREATE DATABASE stud_fac;
USE stud_fac;
CREATE TABLE STUDENT(snum INT PRIMARY KEY,sname VARCHAR(40),major VARCHAR(40),lvl VARCHAR(40),age INT);
CREATE TABLE FACULTY(fid INT PRIMARY KEY,fname VARCHAR(40),deptid INT);
CREATE TABLE CLASS(cname VARCHAR(40) PRIMARY KEY,meets_at timestamp,room VARCHAR(40),fid INT,FOREIGN KEY(fid) REFERENCES faculty(fid));
CREATE TABLE ENROLLED(snum INT,cname VARCHAR(40),PRIMARY KEY(snum,cname),FOREIGN KEY(snum) REFERENCES STUDENT(snum),FOREIGN KEY(cname) references CLASS(cname));

insert into Student values(1,'jhon', 'CS', 'Sr', 19),
                           (2, 'Smith', 'CS', 'Jr', 20),
                           (3 , 'Jacob', 'CV', 'Sr', 20),
                           (4, 'Tom ', 'CS', 'Jr', 20),
                           (5, 'Rahul', 'CS', 'Jr', 20),
                           (6, 'Rita', 'CS', 'Sr', 21);
select * from Student;
insert into faculty values(11, 'Harish', 1000),
                          (12, 'MV', 1000),
                          (13 , 'Mira', 1001),
                          (14, 'Shiva', 1002),
                          (15, 'Nupur', 1000);
select * from Faculty;
insert into Class values('class1', '12/11/15 10:15:16', 'R1', 14),
                    ('class10', '12/11/15 10:15:16', 'R128', 14),
                    ('class2', '12/11/15 10:15:20', 'R2', 12),
                    ('class3', '12/11/15 10:15:25', 'R3', 11),
                    ('class4', '12/11/15 20:15:20', 'R4', 14),
                    ('class5', '12/11/15 20:15:20', 'R3', 15),
                    ('class6', '12/11/15 13:20:20', 'R2', 14),
                    ('class7', '12/11/15 10:10:10', 'R3', 14);
select*from Class;
insert into Enrolled values
(1,'class1'),
(2,'class1'),
(3,'class3'),
(4,'class3'),
(5,'class4'),
(1,'class5'),
(2,'class5'),
(3,'class5'),
(4,'class5'),
(5,'class5');

select * from enrolled;
select*from Class;
select * from Student;
select * from Faculty;

/*i. Find the names of all Juniors (level = JR) who are enrolled in a class taught by Harish */ 
SELECT sname FROM student,faculty,class,enrolled WHERE student.snum= enrolled.snum and enrolled.cname=class.cname and faculty.fid=class.fid and lvl='Jr' and Faculty.fname='Harish'; 

/*ii. Find the names of all classes that either meet in room R128 or have five or more Students enrolled.*/
SELECT class.cname FROM class where room='R128' OR class.cname IN(SELECT enrolled.cname FROM enrolled GROUP BY enrolled.cname having COUNT(*)>=5);

/*iii. Find the names of all students who are enrolled in two classes that meet at the same time.*/
select sname from Student where snum in (select e1.snum from Enrolled e1,Enrolled e2,Class c1,Class c2 where e1.snum=e2.snum and e1.cname=c1.cname and e2.cname=c2.cname and e1.cname<>e2.cname and c1.meets_at=c2.meets_at);/*student no is same and meeting time is the same*/

/*iv. Find the names of faculty members who teach in every room in which some class is taught.*/
SELECT fname FROM faculty WHERE NOT EXISTS(select room from class where room not in(select distinct c.room WHERE faculty.fid=class.fid));/*innner query selects a room in which they do not teach*/

/*v. Find the names of faculty members for whom the combined enrollment of the courses that they 
teach is less than five.*/
SELECT distinct fname FROM faculty WHERE 5>(SELECT count(enrolled.snum) from enrolled,class where enrolled.cname=class.cname AND class.fid=faculty.fid);

/*vi. Find the names of students who are not enrolled in any class.*/ 
select sname from Student where snum not in (select snum from Enrolled);

/*vii. For each age value that appears in Students, find the level value that appears most often. For 
example, if there are more FR level students aged 18 than SR, JR, or SO students aged 18, you 
should print the pair (18, FR).*/

select S.age, S.lvl from Student S group by S.age, S.lvl having S.lvl in (select S1.lvl from Student S1 where S1.age = S.age
group by S1.lvl, S1.age having count(*) >= all (select count(*) from Student S2
where s1.age = S2.age group by S2.lvl, S2.age))