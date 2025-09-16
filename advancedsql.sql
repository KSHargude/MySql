create database kshuss;

use kshuss;

***************************************
# Stored procedures
***************************************

=========================================
# write a store procedure which will compare two number 
# will display message which one is greater.
===========================================

delimiter //
CREATE DEFINER=`root`@`localhost` PROCEDURE `comparisonOfnos`(
in n1 int,
in n2 int)
BEGIN
declare msg text;
if n1>n2 then
     set msg = "num1 is greater";
else
     set msg = "num2 is greater";
end if;
END //
delimiter ;

call comparisonOfnos(2,3);

=================================================
# create a store procedure which will insert the record in table
=================================================

# creating table

create table sbiaccount(
firstname varchar(40),
lastname varchar(40),
balance decimal);

delimiter //
create procedure insertdata(
in cfirstname varchar(50),
in clastname varchar(50),
in balance decimal)
begin 

insert into sbiaccount(firstname,lastname,balance)
 values(cfirstname,clastname,balance);
select * from sbiaccount;
end //
delimiter ;

call insertdata("krutika", "Hargude", 2000);

=========================================================
# write a store procedure to delete record from account table
=========================================================

delimiter //

create procedure deletedata(
in firstname varchar(40))
begin 

delete from sbiaccount where firstname = firstname;
select * from sbiaccount;
end //
delimiter ;

SET SQL_SAFE_UPDATES = 0;

call deletedata("krutika");

=====================================================
# write a store procedure to update record from account table
=======================================================

insert into sbiaccount values("krutika", "hargude", 2000)

delimiter //
create procedure updatedepositbalance(
in firstname varchar(30),
in amount decimal)
begin 
update sbiaccount set balance= balance+amount where firstname = "krutika";
select * from sbiaccount;
end //
delimiter ;

call updatedepositbalance("krutika", 200000);
/*
krutika	hargude	202000
*/

============================================================
# create a store procedure which will decide whether number is even or odd.
=================================================================
delimiter //
create procedure even_odd(in number int)
begin
declare msg text;
if number%2=0 then
 set msg="even number";
    select msg;
else
 set msg="Odd Number";
    select msg;
end if;
end //
delimiter;

call even_odd(39);
/*
Odd Number
*/

=====================================================================
# write a store procedure which will perform addition two number.
=================================================================

delimiter //
create procedure additionof2nos(
in num1 int,
in num2 int,
out result int)
begin
set result = num1 + num2;
select result;
end //
delimiter ;

call addition(20,39, @result);

===============================================================
# create a store procedure which will perform basic arithematic operation
===================================================================
delimiter $$
create procedure calculator(
in n1 int ,
in n2 int,
out addition int,
out substraction int,
out division int,
out multiplication int
)
begin 
set addition = n1+n2;
set substraction=n1-n2;
set division=n1/n2;
set multiplication=n1*n2;
end $$
delimiter :

call calculator(20, 30, @addition, @substraction, @division, @multiplication)
select @addition
/*
50
*/
=============================================================================
# write a store proecedure which will have square of number
================================================================
delimiter //
create procedure square(inout number int)
begin 
set number = number*number;
end //
delimiter ;

set @number = 6;
call square(@number);
select @number;

/*
36
*/

=====================================================================
# write a store procedure which will display data from multiple
=====================================================================

create table baby(bid int, bname varchar(20), bweight decimal);

insert into baby values(1,"A", 2.5),(2,"B",3.5);

select * from baby;
/*
1	A	3
2	B	4
*/

delimiter //
create procedure display()
begin
select * from baby;
select * from sbiaccount;
end //
delimiter ;

call display;

/*
result 1

1	A	3
2	B	4

result 2

krutika	hargude	202000
*/

==========================================================================
# write a store procedure which will display top records depending on the requirement
=========================================================================
delimiter //
create procedure toprecord(in number int)
begin
select * from baby limit number;
end //
delimiter ;

call toprecord(1);

/*
1	A	3
*/

=====================================================================
# write a store procedure to display employee details using id
================================================================

create table emp(eid int primary key, ename varchar(30));
insert into emp values (1,"A"),(2,"B"),(3,"C");

delimiter //
create procedure displayrecordusingid(in number int)
begin
select * from emp where eid = number;
end //
delimiter ;

call displayrecordusingid(1);

/*
1	A
*/

=======================================================================
# write a store procedure to compare two text are same or not.
===================================================================

delimiter //
create procedure textmatching(
in text1 varchar(20),
in text2 varchar(30))
begin
declare msg text;
if "text1" = "text2"  then
    set msg = "text are same";
    select msg;
else
	set msg = "texts are diff";
    select msg;
end if;
end //
delimiter ;

call textmatching(" ", " ");
/*
texts are diff
*/

===========================================================
# write a store procedure to print 1 to 10.
==================================================

CREATE PROCEDURE PRINT1TO10()
BEGIN
DECLARE i INT DEFAULT 1;
declare number int;
WHILE i <= 10 DO
   SELECT i AS number;
   SET i = i+1;
END WHILE;
END //
 DELIMITER;

========================================================

/*create definer = 'root'@localhost
declare counter int default 1;
create temporary table number1(num int);
     while counter <= 10 do
            insert into number1(num) values (counter);
            set counter = counter + 1;
	end while;
    select * from number1;
end*/

===============================================================
#create stored procedure which will do sum of 1 to 10 number
===============================================================
delimiter //
create procedure sum1to10()
begin
declare counter int default  1 ;
declare sum int default 0;
while counter <= 10 do
       set sum = sum + counter;
       set counter = counter + 1;
end while;
      select sum;
end //
delimiter ;

call kshuss.sum1to10();
/*
55
*/


=========================================================
#create stored procedure which will print table of 10
=========================================================
delimiter //
create procedure tableOf10new()
begin
declare i int default  1 ;
while i <= 10 do
       select concat(i, " * 10 = ", i * 10);
       set i = i + 1;
end while;
end //
delimiter ;

call kshuss.tableOf10new();

/*
result 1
1 * 10 = 10

result 2
2 * 10 = 20

.
.
.

result 3
10 * 10 = 100

*/

===================================================
# write A store procedure to print odd number. which is also divisible by 7. range 1 to 50
============================================================

delimiter //
create procedure oddanddivisibleby7()
begin
declare i int default 1;
while i <= 50 do 
      if i % 2 != 0 and i % 7 = 0 then
	       select concat (i, " is odd number and also deivisible by 7 " );
	   end if;
       set  i = i + 1;
end while;
end //
delimiter ;

call oddanddivisibleby7()

DROP procedure oddanddivisibleby7;

/*
result 1
7 is odd number and also deivisible by 7 

result 2
21 is odd number and also deivisible by 7 

result 3
35 is odd number and also deivisible by 7 

result 4
49 is odd number and also deivisible by 7 

*/


+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Function
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


CREATE FUNCTION  greeting()
RETURNS varchar(100) deterministic
BEGIN
declare msg varchar(100);
set msg = "welcome to function";

RETURN msg;
END

====

USE `kshuss`;
DROP function IF EXISTS `greeting`;

DELIMITER $$
USE `kshuss`$$
CREATE FUNCTION  greeting()
RETURNS varchar(100) deterministic #try to predict output of function
BEGIN
declare msg varchar(100);
set msg = "welcome to function";

RETURN msg;
END$$

DELIMITER ;

====

select kshuss.greeting();

/*
result 1

welcome to function

*/

======================================
CREATE FUNCTION dynamicgreeting( msg varchar(100))
RETURNS varchar(100) deterministic 
BEGIN

RETURN msg;
END

====

USE `kshuss`;
DROP function IF EXISTS `dynamicgreeting`;

DELIMITER $$
USE `kshuss`$$
CREATE FUNCTION dynamicgreeting( msg varchar(100))
RETURNS varchar(100) deterministic 
BEGIN

RETURN msg;
END$$

DELIMITER ;

====

select kshuss.dynamicgreeting('hi everyone');

/*

hi everyone

*/

===================================================
function to check even odd numer
===============================================

CREATE FUNCTION evenodd(num int)
RETURNS varchar(200) deterministic
BEGIN
declare msg varchar(100);
if num % 2 = 0 then
    set msg = "even";
else 
	set msg = "odd";
end if;
RETURN msg;
END

====

USE `kshuss`;
DROP function IF EXISTS `evenodd`;

DELIMITER $$
USE `kshuss`$$
CREATE FUNCTION evenodd(num int)
RETURNS varchar(200) deterministic
BEGIN
declare msg varchar(100);
if num % 2 = 0 then
    set msg = "even";
else 
	set msg = "odd";
end if;
RETURN msg;
END$$

DELIMITER ;

====

select kshuss.evenodd(234)  as evenORodd;

/*
even
*/

#============================================
# classify id as odd or even if it is odd or even respectively
#=====================================================

create table football( id int primary key auto_increment ,
fname varchar(20

insert into football (fname)  values ("A"),("B"),("C"),("D"),("E");

select * from football;
/*
1	A
2	B
3	C
4	D
5	E
*/

            ------------
select id , evenodd(id) as odd_even ,fname from football;
            ------------
/*
1	odd	A
2	even	B
3	odd	C
4	even	D
5	odd	E
*/

#=============================================================
# to classify salary of sbiaccount table employess as good, average, ....
#sal<20000 lowest , sal>=20000 and sal<=50000 good salary , sal>50000 heavy
#==============================================================

select * from sbiaccount;
/*
krutika	hargude	202000
*/
#====
select balance, evenodd(balance) as even_odd , firstname, lastname from sbiaccount;
/*
202000  even	krutika	hargude
*/
#====

create table employee(eid int primary key auto_increment, 
ename varchar(30) not null,
salary decimal);

insert into employee (ename,salary) values ("A",30000),("B",49999),("C",478888),("D",30400),("E",40000);

select * from employee;

/*
1	A	30000
2	B	49999
3	C	478888
4	D	30400
5	E	40000
*/

delimiter //
create function classify(salary int)
returns varchar (30) deterministic
begin
declare msg varchar(100);
    if salary < 20000 then
         set msg = "lowest";
	elseif salary >= 20000 and salary <= 50000 then
         set msg = "good";
	else
         set msg = "heavy salaried emp";
	end if;
    return msg;
end //
delimiter ;

select kshuss.classify(4588);

/*
lowest
*/

select ename, salary, classify(salary) as classification from employee;
                       ---------------
/*
A	30000	good
B	49999	good
C	478888	heavy salaried emp
D	30400	good
E	40000	good
*/                       

select salary, count(classify(salary)), classify(salary) as classification from employee
group by classify(salary);

/*
A	30000	4	good
C	478888	1	heavy salaried emp
*/

select salary, count(classify(salary)), classify(salary) as classification from employee
group by classify(salary);

/*
30000	4	good
478888	1	heavy salaried emp
*/
												

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cursor
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

create database cursor_byghatesir;
use cursor_byghatesir;

=========================================
create table cricket(pid int ,
pname varchar(40));
		
insert into cricket values (1,"A"),(2,"B"),(3,"C");

delimiter //
create procedure display_cricket()
begin
declare done boolean default 0;
declare pid int;
declare pname varchar(50);
declare cur cursor for select * from cricket;
declare continue handler for not found set done = 1;

open cur;
loop_label : loop
   fetch cur into pid,pname;
   if done = 1 then
        leave loop_label;
   end if;
   select pid,pname;
end loop;
close cur;
end//
delimiter ;

call display_cricket();

/*
result 1
1	A

result 2
2   B

result 3
3    cache index
*/

==========================================

delimiter //
create procedure display_cricket1()
begin
declare done boolean default 0;
declare pid int;
declare pname varchar(50);
declare cur cursor for select * from cricket;
declare continue handler for not found set done = 1;

open cur;
loop_label : loop
   fetch cur into pid,pname;
   if done = 1 then
        leave loop_label;
   end if;
end loop;
select pid,pname;
close cur;
end//
delimiter ;

call display_cricket1();

/*
result 1
3    C 

*/

=================================================

create table emp(eid int, ename varchar(40), sal int);

insert into emp values (01,"ram",2000),(02,"raj",3000),(03,"yash",4000);

# write a cursor using stored procedure which will update salary of emp

delimiter //
create procedure updatesalary()
begin 
declare done boolean default 0;
declare empid int;
declare cur cursor for select eid from emp;
declare continue handler for not found set done = 1;
open cur;
loop_label : loop
    fetch cur into empid;
    if done = 1 then 
         leave loop_label;
	end if;
    update emp set sal = sal * 1.1  where eid = empid;
end loop;
close cur;
end//
delimiter ;

call updatesalary();

SET SQL_SAFE_UPDATES=0;

select  * from emp;

/*
1	ram	2200
2	raj	3300
3	yash	4400
*/

call updatesalary();

select  * from emp;

/*
1	ram	2420
2	raj	3630
3	yash	4840
*/


+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
trigger
+++++++++++++++++++++++++++++++++++++++++++++++++++

# DROP TRIGGER tNAME;

BEFORE INSERT
==============

CREATE TABLE EMP1(
ID INT PRIMARY KEY,
NAME VARCHAR(30),
SALARY DECIMAL(10,2)
);

# Before execution:
INSERT INTO Emp1 (Id, Name, Salary) VALUES (1, 'John Doe', 500);

SELECT * FROM EMP1;
/*
1	John Doe	500.00
*/

DELIMITER //
CREATE TRIGGER t_BEFORE_INSERT
BEFORE 
INSERT ON EMP1
FOR EACH ROW
BEGIN
    IF NEW.SALARY < 1000 THEN 
	   SIGNAL SQLSTATE '45000'  SET MESSAGE_TEXT = 'SALARY CANNOT BE LESS THAN 1000' ;
	END IF ;
END //
DELIMITER ;

# After execution:

INSERT INTO EMP1 (Id, Name, Salary) VALUES (2, 'KRUTIKA', 500);
# 0	28	15:56:59	INSERT INTO EMP1 (Id, Name, Salary) VALUES (2, 'KRUTIKA', 500)	
#Error Code: 1644. SALARY CANNOT BE LESS THAN 1000	0.000 sec

INSERT INTO EMP1 (Id, Name, Salary) VALUES (2, 'KRUTIKA', 1500);
SELECT * FROM EMP1;
/*
1	John Doe	500.00
2	KRUTIKA	1500.00
*/

# Before Delete Trigger
=======================

CREATE TABLE Orders (
  Id INT PRIMARY KEY,
  CustomerId INT,
  OrderDate DATE
);

INSERT INTO ORDERS VALUES (1, 01, 21/09/2024);
INSERT INTO ORDERS VALUES (2, 101, '2025-02-17');

CREATE TABLE DELETEDORDERS LIKE ORDERS

DELIMITER //
CREATE TRIGGER trg_BeforeDelete
BEFORE DELETE ON Orders
FOR EACH ROW
BEGIN
  INSERT INTO DeletedOrders (Id, CustomerId, OrderDate)
  VALUES (OLD.Id, OLD.CustomerId, OLD.OrderDate);
END//
DELIMITER ;

SELECT * FROM ORDERS;
/*
1	1	0000-00-00
2	101	2025-02-17
*/

DELETE FROM ORDERS WHERE Id = 1;

SELECT * FROM ORDERS;

/*
2	101	2025-02-17
*/

SELECT * FROM DELETEDORDERS;
/*
1	1	0000-00-00
*/

# Before Update Trigger
========================

CREATE TABLE Product (
  Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Price DECIMAL(10, 2)
);

DELIMITER //
CREATE TRIGGER trgger_BeforeUpdate
BEFORE UPDATE ON Product
FOR EACH ROW
BEGIN
  IF NEW.Price < OLD.Price THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price cannot be decreased';
  END IF;
END //
DELIMITER ;

INSERT INTO PRODUCT VALUES (1, "abc", 50);
INSERT INTO PRODUCT VALUES (2, "DEF", 30000);


SELECT * FROM PRODUCT;

/*
1	abc	50.00
2	DEF	30000.00
*/

UPDATE Product SET Price = 49 WHERE Id = 1;
#0	77	17:06:54	UPDATE Product SET Price = 49 WHERE Id = 1	     Error Code: 1644. Price cannot be decreased	0.000 sec

# After Insert Trigger
=====================

CREATE TABLE Customer (
  Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Email VARCHAR(100)
);

INSERT INTO CUSTOMER VALUES(1,"abc","JJRVGBGJBGFJGIJBIGBJIHJI@GMAIL.COM");
INSERT INTO CUSTOMER VALUES(2,"ksh", "HARGUDE@GMAIL.COM"); 

SELECT * FROM CUSTOMER;

/*
1	abc	JJRVGBGJBGFJGIJBIGBJIHJI@GMAIL.COM
2	ksh	HARGUDE@GMAIL.COM
*/

CREATE TABLE CustomerLogs (CustomerId INT PRIMARY KEY, LogMessage VARCHAR(40));

DELIMITER //
CREATE TRIGGER trg_AfterInsert
AFTER INSERT ON Customer
FOR EACH ROW
BEGIN
  INSERT INTO CustomerLogs (CustomerId, LogMessage)
  VALUES (NEW.Id, 'Customer created');
END//
DELIMITER ;

INSERT INTO CUSTOMER (Id, Name, Email) VALUES (3, 'KSH', 'KSH@GMAIL.com');

SELECT * FROM CUSTOMER;
/*
1	abc	JJRVGBGJBGFJGIJBIGBJIHJI@GMAIL.COM
2	ksh	HARGUDE@GMAIL.COM
3	KSH	KSH@GMAIL.com
*/

SELECT * FROM CustomerLogs;
/*
3	Customer created
*/

INSERT INTO CUSTOMER (Id, Name, Email) VALUES (4, 'KSH', 'KSH@GMAIL.com');

SELECT * FROM CustomerLogs;
/*
3	Customer created
4	Customer created
*/

# After Delete Trigger
======================

CREATE TABLE Employees (
  Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Department VARCHAR(50)
);

INSERT INTO Employees VALUES (1, "KSH", "XYZ");

SELECT * FROM Employees;
/*
1	KSH	XYZ
*/

CREATE TABLE EmployeeLogs (EmployeeId INT PRIMARY KEY , LogMessage VARCHAR(30));

DELIMITER //
CREATE TRIGGER trg_AfterDelete
AFTER DELETE ON Employees
FOR EACH ROW
BEGIN
  INSERT INTO EmployeeLogs (EmployeeId, LogMessage)
  VALUES (OLD.Id, 'Employee deleted');
END //
DELIMITER ;

DELETE FROM Employees WHERE Id = 1;

SELECT * FROM Employees;
/*
		
*/

SELECT * FROM EmployeeLogs;
/*
1	Employee deleted
*/

# After Update Trigger
======================

CREATE TABLE Product1 (
  Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Price DECIMAL(10, 2)
);

INSERT INTO PRODUCT1 VALUES (1,"KSH", 150);
INSERT INTO PRODUCT1 VALUES (2,"K", 300);

SELECT * FROM Product1;
/*
1	KSH	150.00
2	K	300.00
*/

CREATE TABLE ProductLogs (ProductId INT PRIMARY KEY, LogMessage VARCHAR(30))

DELIMITER //
CREATE TRIGGER trg_AfterUpdate
AFTER UPDATE ON Product1
FOR EACH ROW
BEGIN
  INSERT INTO ProductLogs (ProductId, LogMessage)
  VALUES (NEW.Id, 'Product updated');
END //
DELIMITER ;


UPDATE Product1 SET Price = 10000000 WHERE Id = 1;

SELECT * FROM Product1;
/*
1	KSH	10000000.00
2	K	300.00
*/

SELECT * FROM ProductLogs;
/*
1	Product updated
*/













