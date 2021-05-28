create database bankingdb;
use bankingdb;
CREATE TABLE branch
     ( branch_name VARCHAR(15),
       branch_city VARCHAR(15),
       assets float,
       PRIMARY KEY(branch_name)
     );

     CREATE TABLE account
     ( accno INT,
       branch_name VARCHAR(15),
       balance float,
       PRIMARY KEY(accno),
       FOREIGN KEY(branch_name) REFERENCES branch(branch_name)ON DELETE CASCADE
     );

    CREATE TABLE customer
    ( customer_name VARCHAR(15),
      customer_street VARCHAR(15),
      customer_city VARCHAR(15),
      PRIMARY KEY(customer_name)
    );

    CREATE TABLE loan
    ( loan_number INT,
      branch_name VARCHAR(15),
      amount float,
      PRIMARY KEY(loan_number),
      FOREIGN KEY(branch_name) REFERENCES branch(branch_name)
    );

    CREATE TABLE depositor
    ( customer_name VARCHAR(15),
      accno INTEGER,
      PRIMARY KEY(customer_name, accno),
      FOREIGN KEY(customer_name) REFERENCES customer(customer_name),
      FOREIGN KEY(accno) REFERENCES account(accno)
    );

    CREATE TABLE borrower
    ( customer_name  VARCHAR(15),
      loan_number INT,
      PRIMARY KEY(customer_name, loan_number),
      FOREIGN KEY(customer_name) REFERENCES customer(customer_name),
      FOREIGN KEY(loan_number) REFERENCES loan(loan_number)
    );
    
    
INSERT INTO BRANCH VALUES
("SBI PD NAGAR", "BANGALORE", 200000),
("SBI RS NAGAR", "BANGALORE" ,500000),
("SBI JAYANAGAR" ,"CHENNAI",60000),
("SBI VIJAYNAGAR" ,"DELHI", 870000),
("SBI GBROAD" ,"DELHI", 550000);

INSERT INTO ACCOUNT VALUES
(1000,"SBI PD NAGAR",5000),
(1001,"SBI RS NAGAR",5000),
(1002,"SBI JAYANAGAR",5000),
(1003,"SBI VIJAYNAGAR",40000),
(1004,"SBI GBROAD" ,4000);

INSERT INTO ACCOUNT VALUES
(1005,"SBI GBROAD",5500),
(1006,"SBI VIJAYNAGAR",2500);


INSERT INTO CUSTOMER VALUES
("RAM","BSTREET 45","BANGALORE"),
("SHYAM","BSTREET 46","BANGALORE"),
("RAJAT","CSTREET 55","CHENNAI"),
("AAKASH","DSTREET 65","DELHI"),
("SURESH","DSTREET 66","DELHI");


INSERT INTO DEPOSITOR VALUES
("RAM",1000),
("SHYAM",1001),
("RAJAT",1002),
("AAKASH",1003),
("SURESH",1004);

INSERT INTO DEPOSITOR VALUES
("SURESH",1005),
("AAKASH",1006);

INSERT INTO LOAN VALUES
(10,"SBI PD NAGAR",10000),
(11,"SBI RS NAGAR",20000),
(12,"SBI JAYANAGAR",30000),
(13,"SBI VIJAYNAGAR",40000),
(14,"SBI GBROAD" ,50000);

INSERT INTO BORROWER VALUES
("RAM",10),
("SHYAM",11),
("RAJAT",12),
("AAKASH",13),
("SURESH",14);

/*QUES 1*/
SELECT customer_name
            FROM depositor d,account a
            WHERE d.accno=a.accno
            /*AND a.branch_name='SBI VIJAYNAGAR'*//*THIS CAN BE ADDED TO SPECIFY BRANCH NAME*/
            GROUP BY d.customer_name
            HAVING COUNT(d.customer_name)>=2;

/*QUES 2*/
SELECT d.customer_name FROM account a,branch b,depositor d
	WHERE b.branch_name=a.branch_name AND
	a.accno=d.accno AND
	b.branch_city='CHENNAI'
	GROUP BY d.customer_name
	HAVING COUNT(distinct b.branch_name)=(
	SELECT COUNT(branch_name)
	FROM branch
	WHERE branch_city='CHENNAI');
    
    
/*QUES 3*/
DELETE FROM account WHERE branch_name IN(SELECT branch_name FROM branch WHERE branch_city='CHENNAI');    

