create database mysqlsyllabus;

use mysqlsyllabus;

create database student

create database book

use student

create table gen_info(rno int,name varchar(21),age int)

insert into gen_info VALUES(1,'xyz',20)
insert into gen_info values(2,'abc',25)

select * from gen_info;

1	xyz	20
2	abc	25

--#5
drop database student

drop database book

create database employee

use employee

create table emp_info(name varchar(15),mobile int,adress varchar(50),
salary int,desg varchar(20))

insert into emp_info values('abc',1234,'pratap nagar',20000,'software trainee');
insert into emp_info values('abc1',1235,'malvia nagar',40000,'software developer')
insert into emp_info values('abc2',1236,'jagatpura',65000,'s software developer')
insert into emp_info values('abc3',1237,'sanganer',12000,'clerk')
insert into emp_info values('abc4',1238,'mansarover',80000,'team leader')

select * from emp_info

--abc	1234	pratap nagar	20000	software trainee
abc1	1235	malvia nagar	40000	software developer
abc2	1236	jagatpura	65000	s software developer
abc3	1237	sanganer	12000	clerk
abc4	1238	mansarover	80000	team leader--

=====================
--operator
=====================
--1.relational(>,<,=,!=,>=,<=)
-------------------------------

select * from emp_info where salary<25000

--1234	abc	pratap nagar	20000	software trainee
1237	abc3	sanganer	12000	clerk--

select * from emp_info where salary>25000

--abc1	1235	malvia nagar	40000	software developer
abc2	1236	jagatpura	65000	s software developer
abc4	1238	mansarover	80000	team leader--

select * from emp_info where salary=25000

--empty set--

select * from emp_info where salary!=25000

--abc	1234	pratap nagar	20000	software trainee
abc1	1235	malvia nagar	40000	software developer
abc2	1236	jagatpura	65000	s software developer
abc3	1237	sanganer	12000	clerk
abc4	1238	mansarover	80000	team leader--

select * from emp_info where salary>=25000

--abc1	1235	malvia nagar	40000	software developer
abc2	1236	jagatpura	65000	s software developer
abc4	1238	mansarover	80000	team leader--

select * from emp_info where salary<=25000

--abc	1234	pratap nagar	20000	software trainee
abc3	1237	sanganer	12000	clerk--

========================
--2.logical(and,or,not)
========================

select * from emp_info where desg='software developer' and salary>35000

--abc1	1235	malvia nagar	40000	software developer--

select * from emp_info where desg='software developer' or salary>35000

--abc1	1235	malvia nagar	40000	software developer
abc2	1236	jagatpura	65000	s software developer
abc4	1238	mansarover	80000	team leader--

=========================
--3.arithmetic(+,-,*,/)
=========================

select name,salary*12 as anual_salary from emp_info
--abc	240000
abc1	480000
abc2	780000
abc3	144000
abc4	960000--

=======================================================
--4.special category operator(in,between,like,is null)
========================================================

--@1.in
----------
select * from emp_info where desg in('software developer','s software developer','clerk')

--abc1	1235	malvia nagar	40000	software developer
abc2	1236	jagatpura	65000	s software developer
abc3	1237	sanganer	12000	clerk--

--@2.between
----------------

select * from emp_info where salary between 40000 and 70000

--abc1	1235	malvia nagar	40000	software developer
abc2	1236	jagatpura	65000	s software developer--

--@3.like(%,____)
--------------------

select * from emp_info where desg like '%t%'

--abc	1234	pratap nagar	20000	software trainee
abc1	1235	malvia nagar	40000	software developer
abc2	1236	jagatpura	65000	s software developer
abc4	1238	mansarover	80000	team leader--

select * from emp_info where desg not like '_t%'

--abc	1234	pratap nagar	20000	software trainee
abc1	1235	malvia nagar	40000	software developer
abc2	1236	jagatpura	65000	s software developer
abc3	1237	sanganer	12000	clerk
abc4	1238	mansarover	80000	team leader--

--@4.is NULL 
----------------  

insert into emp_info (name,salary) values('pqr',68000) 

select * from emp_info where adress is null

--pqr			68000	--

=========================================================================================================================
--**updating column values of TABLE
=========================================================================================================================
--update column VALUES
update emp_info set salary=25000, desg="software developer" where name="pqr";
--it will give error as safe update mode --
--set sql-safe-update=1;--

SET SQL_SAFE_UPDATES=0;

--order GROUP BY
select * from emp_info order by salary desc

===============================================
--**adding or dropping columns from a TABLE
===============================================

--@existing TABLE
----------------------------------------------
--@1.to add particular column 
alter table emp_info add adrno int
desc emp_info;
--name	varchar(15)	YES		
mobile	int	YES		
adress	varchar(50)	YES		
salary	int	YES		
desg	varchar(20)	YES		
adrno	int	YES		--

--@2.to add multiple column at a time 
alter table emp_info add column (adrno1 int,adrno2 int)
desc emp_info
--name	varchar(15)	YES		
mobile	int	YES		
adress	varchar(50)	YES		
salary	int	YES		
desg	varchar(20)	YES		
adrno	int	YES		
adrno1	int	YES		
adrno2	int	YES		--

--@3.to delete any particular COLUMN
alter table emp_info drop adrno1
desc emp_info
--name	varchar(15)	YES		
mobile	int	YES		
adress	varchar(50)	YES		
salary	int	YES		
desg	varchar(20)	YES		
adrno	int	YES		
adrno2	int	YES		--

--@4.to delete multiple COLUMN
alter table emp_info drop adrno ,drop adrno2
 desc emp_info
 --name	varchar(15)	YES		
mobile	int	YES		
adress	varchar(50)	YES		
salary	int	YES		
desg	varchar(20)	YES		--

 --**to get description of TABLE
 desc emp_info

 --**to modify COLUMN
 alter table emp_info modify desg varchar(50) 
 desc emp_info
 --name	varchar(15)	YES		
mobile	int	YES		
adress	varchar(50)	YES		
salary	int	YES		
desg	varchar(50)	YES		--

 --**to change name of column
alter table emp_info change column adress current_adress varchar (50)
 desc emp_info
 --name	varchar(15)	YES			
mobile	int	YES			
current_adress	varchar(50)	YES			
salary	int	YES			
desg	varchar(50)	YES			--

--**to delete table from DATABASE
create table ksh(rno int,name varchar (1000))
show tables
--emp_info
gen_info
ksh--
insert into ksh values(1,'don')
drop table ksh
show tables
--emp_info
gen_info--emp3

--**to delete record from TABLE
delete from emp_info where name='abc1'

--**delete command
delete from emp_info where name='abc1' 
--if want delete all then
delete from emp_info

--**truncate command
truncate table emp_info

--L10
==============================================================================================================================
--**FUNCTONS
===============================================================================================================================
--
select * from emp_info
select max(salary)from emp_info
--min,sum,avg,count(*)
select sum(salary) as sum from emp_info

--L11

===============================
clauses
===============================

--**group GROUP BY

select desg ,count(*) from emp_info group by desg

select name,desg,count(*) from emp_info group by desg

--select *,count(*) from emp_info group by desg

select name,desg,count(*) from emp_info group by name,desg

select desg,count(*) from emp_info group by desg,name

 ============
 
--**having 
select desg,adress,count(*)from emp_info
group by desg,adress having desg='software trainee'

--Q.query to get desg name in which more then 1 emp isworking

select desg from emp_info group by desg having count(*)=1-->1

--Q.query to get desg and number of emp working under that desg ADD
--in the decreasing order of number of emp working

select desg,count(*) as no_of_emp from emp_info
group by desg order by count(*) desc

--same as
select desg,count(*) as no_of_emp from emp_info
group by desg order by no_of_emp desc

--L12
===============================

--**distinct
select distinct desg from emp_info
--for more than one COLUMN
select distinct desg,adress from emp_info
select * from emp_info

=====================================
--**limit
====================================
--select * from emp_info order by salary limit 3

==================================================================================================================================
--**CONSTRAINT
==================================================================================================================================
--NOT NULL
------------------------
--AT TABLE CREATION 
create table ksh(name varchar(30) not null,mobile int)

--after 
--alter table ksh modify name varchar (25) not null

--removing
--alter table ksh modify name varchar(39) null

----------------------------------
--UNIQUE
---------------------------------

---AT TABLE CREATION 
create table ksh1(name varchar(30) not null,mobile int
unique(name))
--2
create table ksh2(name varchar(30) not null,mobile int
constraint csd unique(name))
--after 
alter table ksh2 add unique (mobile)
alter table ksh2 drop index mobile
--show index from emp_info

---------------------------------------
--PRIMARY
--------------------------------------

--at the time of table creation

create table emp1_info(
eid int,
name varchar (20),
primary key (eid))

create table emp2_info(
eid int, 
name varchar(40),
constraint pri primary key(eid))

create table emp3_info(
eid int primary key,
name varchar(59))

--after table creation

--create table emp(id int)
alter table emp add constraint pri  primary key(id)
--create table emp2(id int)
alter table emp2 add primary key(id)

---------------------------------------
--foreign key
---------------------------------------

-- at the time of table creation

create table job(jid int primary key)

create table job_history(
hid int primary key,
jid int,
foreign key (jid)
references job (jid)
on update cascade on delete cascade)

-- after table creation

create table job1(jid int primary key)

create table job_history1(
hid int primary key,
jid int
)

alter table job_history1 
add foreign key(jid)
references job1 (jid)

droping foreign key

alter table job_history1 drop foreign key


-------------------------------------------
check
------------------------------------------

-------------------------------------------
default
-------------------------------------------

---at the time of table creation
create table person(
pid int,
age int default 20)

-- after table creation

create table person2(
id int,
age int)

alter table person2 alter age set default 49

---------------------------------------------
auto increament
---------------------------------------------

--at the time of table creation 

create table person3(
pid int auto_increment,
age int,
primary key(pid))

--after table creation

alter table person3 auto_increment =100


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--#assignment 1 1/09
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
create database cpt_assignment;
use cpt_assignment;
create table customer_1(customer_id int, cust_name varchar(15),city varchar(50),
grade int, salesman_id varchar(15));
insert into customer_1 values(3002,'csd','Jaipur',100,5001);
insert into customer_1 values(3007,'csd1','Jaipur',200,5001);
insert into customer_1 values(3005,'csd2','Hyderabad',200,5002);
insert into customer_1 values(3008,'csd3','Banglore',300,5002);
insert into customer_1 values(3004,'csd4','Pune',300,5006);
insert into customer_1 values(3009,'csd5','Surat',100,5003);
insert into customer_1 values(3003,'csd6','Jodhpur',200,5007);

select *from customer_1
-- Q1)
select * from customer_1 where grade>100;
-- Q2)
select * from customer_1 where city='Jaipur' and grade>100;
-- Q3)
select * from customer_1 where city='Jaipur' or grade>100;
-- Q4)
select * from customer_1 where city='Jaipur' or grade<100;
-- Q5)
select * from customer_1 where customer_id in(3007,3008,3009);
-- Q6)
select * from customer_1 where city like 'J%';
-- Q7)
select * from customer_1 where city like '%e';
-- Q8)
select city, max(grade) as max_grade from customer_1 group by city;
-- Q9)
select salesman_id,max(grade) as max_grade from customer_1 group by salesman_id

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
--#assignment 2 09/01
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

use cpt_assignment;
create table order_details(ord_no int, purch_amt int,customer_id int,salesman_id int);
insert into order_details values(70001,150.5,3005,5002);
insert into order_details values(70009,270.65,3001,5005);
insert into order_details values(70002,65.26,3002,5001);
insert into order_details values(70004,110.5,3009,5003);
insert into order_details values(70007,948.5,3005,5002);
insert into order_details values(70005,2400.6,3007,5001);
insert into order_details values(70008,5760,3002,5001);

select * from order_details
-- Q1)
select ord_no,purch_amt,
(purch_amt/6000)*100 as achieved_percent,
((6000-purch_amt)/6000)*100 as unachieved_percent
from order_details where (purch_amt/6000)*100 > 40;
-- Q2)
select * from order_details where purch_amt between 500 and 6000;
-- Q3)
select sum(purch_amt) as total_purchase_amount from order_details;
-- Q4)
select avg(purch_amt) as average_purchase_amount from order_details;
-- Q5)
select count(distinct salesman_id) as num_ofsalesman from order_details;
-- Q6)
select count(customer_id) as num_customers from order_details;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--#assignment 3 1/09
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

use cpt_assignment;
create table salesman(salesman_id int, name varchar(15),city varchar(15), commission int);
insert into salesman values(5001,'csd','Jaipur',0.15);
insert into salesman values(5002,'csd1','Hyderabad',0.13);
insert into salesman values(5005,'csd2','Banglore',0.11);
insert into salesman values(5006,'csd3','Hyderabad',0.14);
insert into salesman values(5007,'csd4','Pune',0.13);
insert into salesman values(5003,'csd5','Jodhpur',0.12);
select * from salesman
-- Q1)
select * from salesman where (commission>=0.12 and commission<=0.14);
-- Q2)
select * from salesman where city like 'J___p%';



--L19
create database ecom
use ecom

create table customer(cid int not null ,cname varchar (20),age int)
insert into customer values(3,'csd2',22)
insert into customer values(4,'pqr',16)
insert into customer values(5,'pqr1',16)
insert into customer values(6,'pqr2',16)
insert into customer values(8,'pqr3',17)
insert into customer values(9,'pqr3',34)

select * from customer

alter table customer add constraint pri primary key (cid)

create TABLE corder(oid int,item_name varchar(20),person_id int)

alter table corder add CONSTRAINT fk FOREIGN KEY(person_id)
REFERENCES customer (cid)

insert into corder values(126,'shirt',3)

select * from corder
==================================================================================================================
-------------------------------------------------------------
--INNER JOIN
--------------------------------------------------------------

--write down a query to fetch customer 
-- (cid,cname,age,oid,item_name)
--who have raised any order.
select cid,cname,age,oid,item_name 
from customer inner join corder
on cid=person_id 

--write down a query to fetch customer details
--(cid,cname,age,oid,item_name)
--who have raised any order and the oid should be 126
select cid,cname,age,oid,item_name 
from customer inner join corder
on cid=person_id
where oid=126

----------------------------------------------------------------
--LEFT JOIN
---------------------------------------------------------------

--write down a query to fetch all the customer detals
--(cid,cname,age,oid,item_name)?
select cid,cname,age,oid,item_name
from customer left join corder 
on cid=person_id

---------------------------------------------------------------
--RIGHT JOIN
---------------------------------------------------------------

--write down a query to fetch all the customer detals
--(cid,cname,age,oid,item_name)?
select cid,cname,age,oid,item_name
from corder right join  customer 
on cid=person_id

alter table corder add cid int
--DUPLICATE OR SAME COLUMN NAME AND ALISING

select c.cid,cname,age,oid,item_name,co.cid
from customer c inner join corder co
on c.cid=co.cid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
--L20 assignment 4,5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

use cpt_assignment
-- Q1)
select cust_name,salesman.city,salesman.name,commission
from customer_1 inner join salesman on
customer_1.salesman_id=salesman.salesman_id;

-- Q2)
select c.cust_name,c.city,s.name,s.commission
from customer_1 c right join salesman s on
c.salesman_id=s.salesman_id
where commission>0.12;

-- Q3)
select cust_name,customer_1.city as cust_city, salesman.name,salesman.city as salesman_city, commission
from customer_1 inner join salesman on
customer_1.salesman_id=salesman.salesman_id
where customer_1.city != salesman.city and commission>0.12;

-- Q4)
select c.customer_id,c.cust_name,c.city as customer_city,c.grade,
s.name,s.city as salesman_city
from customer_1 c left join
salesman s on
c.salesman_id=s.salesman_id
order by customer_id;

-- Q5)
select c.customer_id,c.cust_name,c.city as customer_city,c.grade,
s.name,s.city as salesman_city
from customer_1 c left join
salesman s on
c.salesman_id=s.salesman_id
where c.grade<300 order by customer_id;

-- Q6)
select c.customer_id,c.cust_name,c.city as customer_city,c.grade,
s.name,s.city as salesman_city
from customer_1 c right join
salesman s on
c.salesman_id=s.salesman_id
order by s.salesman_id;

--L21
----------------------------------------------------------------------------
--SELF JOIN
-----------------------------------------------------------------------------

--Q.Write a query to find customer that are from the same city 
--return customer 1 name,customer 2 name,city 
select c1.cust_name,c2.cust_name,c1.city
from customer_1 c1 inner join customer_1 c2
on c1.city=c2.city 
--Q.
select c1.cust_name,c2.cust_name,c1.city
from customer_1 c1 inner join customer_1 c2
on c1.city=c2.city 
where c1.customer_id !=c2.customer_id

--------------------------------------------------------------------------------
--CROSS JOIN
-------------------------------------------------------------------------------

select * from customer_1 cross join salesman 

select c.cust_name,s.name from customer_1 c 
cross join salesman s 
             --same--
select c.cust_name, s.name FROM
customer_1 c,salesman s

--Q.write a sql query to combine each row of the salesman
--table that with each row of the customer
select * from salesman, customer_1 
--Q.write sql query statement to create a cartesian product
--between salesperson and customer i.e each salesperson will appear for 
--all customer and vice versa for that salesperson who belongs to the city
select * from salesman cross join customer_1 where salesman.city is not null
--Q.each saleman will appear for every customer and vice versa for those
--salesperson who belongs to a city and customer who require a grade
select * from salesman cross join customer_1 where 
salesman.city is not null and customer_1.grade is not null
--Q.from the following write sql query to find details of an order
--return ord_no,purch_amt,customer name, grade,salesman,commission
select o.ord_no,o.purch_amt,c.cust_name,c.grade,s.name,s.commission
from order_details o inner join customer_1 c
on o.customer_id=c.customer_id
inner join salesman s
on s.salesman_id=s.salesman_id

--L22
=======================================
--**SUBQUERY
=======================================











%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
use cpt_assignment
select * from salesman
select * from customer_1
select * from order_details

--Q query to find all the orders issued by the salesman csd .
--return ord no , purch amt, cust id and saleman ID
select * from order_details where salesman_id=
(select salesman_id from salesman where name='csd')

--Q
select * from order_details where salesman_id in
(select salesman_id from salesman where city='Hyderabad')

--Q
select * from order_details where salesman_id=
(select distinct salesman_id from order_details where customer_id=3002 ) 

--Q
select * from order_details where salesman_id in
(select salesman_id from salesman where city='Hyderabad')

--Q
--select * from customer_1
select grade,count(*) from customer_1
group by grade
having grade>(select avg(grade) from customer_1 where city='jaipur')

============================================================================
============================================================================
UNION
-----------------------------

















































use ecom
drop database sample

create database orderemp
use orderemp

create table salesman(
    sid int, sname varchar (24),city varchar (30),commision float,
    primary key(sid))

insert into salesman values(5001,'csd','jaipur',0.15)
insert into salesman values(5002,'csd1','hyderabad',0.13)
insert into salesman values(5005,'csd2','banglore',0.11)
insert into salesman values(5006,'csd3','hyderabad',0.14)
insert into salesman values(5007,'csd4','pune',0.13)
insert into salesman values(5003,'csd5','jodhapur',0.12)

select * from salesman

create table orders(
    ono int primary key,purch_amt int,cust_id int,
    constraint fk foreign key (sid)
    references salesman(sid)
)

create data
























































































































