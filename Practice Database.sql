create database Teks;
use teks;
create table STUDENTS(
student_id int primary key,
student_name varchar(10),
course varchar(10),
marks int);
create table EMPLOYEE(
employee_id int primary key,
employee_name varchar(10),
department varchar(10),
salary int);
create table PRODUCTS(
product_id int primary key,
product_name varchar(10),
category varchar(10),
price int);
create table ORDERS(
order_id int primary key,
customer_name varchar(10),
product_name varchar(10),
order_date date,
amount int);
insert into STUDENTS values(101, 'Aishwarya','DataSci',89);
insert into STUDENTS values(102, 'Bhavana','CyberCer',98);
insert into STUDENTS values(103, 'Chetana','DataSci',90);
insert into STUDENTS values(104, 'Deepti','AWS',78);
insert into STUDENTS values(105, 'Pooja', 'Commerce',90);
select * from STUDENTS;
select student_name, marks from STUDENTS;
select * from STUDENTS where marks>70;
update STUDENTS set marks=99 where student_id=101;
update STUDENTS set course=
CASE student_id
when 101 THEN 'AWS'
when 102 Then 'DATAsci'
when 103 THEN 'AWS'
END;
delete from STUDENTS where student_id=105;
insert into EMPLOYEE values(1001,'Abhinav','Sales',35000);
insert into EMPLOYEE values(1002,'Akash','HR',40000);
insert into EMPLOYEE values(1003,'Supriya','Support',25000);
insert into EMPLOYEE values(1004,'Karthik','Finance',65000);
insert into EMPLOYEE values(1005,'Suhas','HR',45000);
insert into EMPLOYEE values(1006,'Chaitanya','Finance',65000);
select * from EMPLOYEE where department='sales';
select * from EMPLOYEE where salary>30000;
update EMPLOYEE set salary=
CASE employee_id
WHEN 1001 THEN 40000
WHEN 1002 THEN 45000
WHEN 1003 THEN 30000
WHEN 1004 THEN 70000
WHEN 1005 THEN 50000
WHEN 1006 THEN 70000
END;
delete from EMPLOYEE where employee_id=1004;
select * from EMPLOYEE order by salary ASC;
select * from EMPLOYEE;
insert into PRODUCTS values(501,'Phone','Electronic',35000);
insert into PRODUCTS values(502,'Broomstick','Household',350);
insert into PRODUCTS values(503,'Pods','Electronic',3500);
insert into PRODUCTS values(504,'Ottoman','Furniture',5000);
insert into PRODUCTS values(506,'DUVET','Bedding',700);
insert into PRODUCTS values(505,'TV','Electronic',75000);
select * from PRODUCTS;
select * from PRODUCTS where category='Electronic';
update PRODUCTS set price=80000 where product_id=505;
delete from PRODUCTS where product_id=505;
delete from PRODUCTS where price>50000;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM PRODUCTS
WHERE price > 50000;
SET SQL_SAFE_UPDATES = 1;
select * from PRODUCTS
order by price ASC;
alter table EMPLOYEE
add COLUMN age int; 
select * from EMPLOYEE where salary>30000 order by salary desc limit 3;
select * from EMPLOYEE order by department asc, salary desc;

select * from STUDENTS;
alter table STUDENTS 
add column age int, 
add column admission_date date;

select * from STUDENTS order by student_name;
select * from STUDENTS order by marks desc;
select * from students order by age;
select * from students order by admission_date;
select * from students where course='Python' order by marks desc; 
select * from students order by course asc, student_name;
select * from students order by marks desc limit 5;
select * from students order by marks limit 4;
select * from students order by marks limit 4 offset 3;
select * from students order by age desc limit 5;
select * from students order by age desc limit 3;
select * from students order by admission_date limit 5 offset 5;
select * from students where course='Java' order by marks limit 2;
select * from students order by marks desc limit 3 offset 4;
select * from students order by marks desc limit 1 offset 1;
show tables;
select count(*) as total_students from students;
select max(marks) from students;
select min(marks) from students;
select avg(marks) from students;
select sum(marks) from students;
select count(student_name) from students where course='Java';
select avg(age) from students;
select max(marks) from students where course='DataSci';
select min(marks) from students where course='Python';

create table sales_data(
id int primary key,
name varchar(20),
category varchar(15), 
quantity int,
price int,
city varchar(15),
sales_data date);
select * from sales_data;

select count(*) from sales_data;
select sum(quantity) from sales_data;
select avg(price) from sales_data;
select max(price) from sales_data;
select min(price) from sales_data;
select sum(price*quantity) as total_revenue from sales_data;
select count(*) as Total_electronics from sales_data where category='Electronics';
select avg(quantity) from sales_data;
select max(quantity) from sales_data;
select min(quantity) from sales_data;

select count(quantity) as total_quantity, name from sales_data group by name;
select avg(price) as Average, category from sales_data group by category;
select sum(price*quantity) as total_revenue, city from sales_data group by city;
select count(*) as number_of_sales, city from sales_data group by city;
select max(price), city from sales_data group by city;
select min(price), city from sales_data group by city;
select count(*), category from sales_data group by category;
select avg(quantity), city from sales_data group by city;
select sum(price*quantity), name from sales_data group by name;
select count(quantity), category from sales_data group by category;

select city,sum(price*quantity) as total_revenue from sales_data group by city having sum(price*quantity)>100000;
select category,avg(price) from sales_data group by category having avg(price)>10000;
select name,sum(quantity) as total_sold from sales_data group by name having sum(quantity)>5;
select category, price from sales_data where price>40000;
select city, count(*) as number_of_sales from sales_data group by city having count(*)>3;
select name, avg(quantity) from sales_data group by name having avg(quantity)>3;
select category,sum(quantity) from sales_data group by category having sum(quantity)>15;
select city,min(price) from sales_data group by city having min(price)<2000;
select name,sum(price*quantity) from sales_data group by name having sum(price*quantity)>50000;
select category,avg(price) from sales_data group by category having avg(price)<15000;

select city, sum(quantity*price) as revenue from sales_data where category='Electronics' group by city having revenue>50000;
select name, avg(price) as average from sales_data where quantity>3 group by name order by average desc;
select category,count(*) as sales_per_category from sales_data where sales_data > '2023-04-04' group by category having count(*) > 5; 
select city, max(price) as maximum_price_per_city from sales_data group by city order by maximum_price_per_city desc limit 3;
select name, count(quantity) as total_quantity from sales_data group by name order by total_quantity limit 3 offset 2;
select category, avg(quantity) as average_quantity_per_category from sales_data where city='Mumbai' group by category having average_quantity_per_category > 4;

select addtime(current_time(), '10:00:00');
select current_timestamp + interval 10 hour;
select * from employee;

use teks;
show tables;
desc person_info;
create table person_info(
id int primary key,
name varchar(20),
email varchar(50));
create table aadhar_info(
aadhar_id int primary key,
aadhan_no varchar(20),
person_id int unique,
foreign key (person_id) references person_info(id));
desc aadhar_info;
insert into person_info(id, name, email) values(1,'Likith','likith@gmail.com'),(2, 'Gamana','Gamana@gmail.com');

create table account(
id int auto_increment primary key,
name varchar(100),
amount decimal(10,2));
select * from account;
begin;
update account set amount = amount-100 where id=1;
select * from account;
update account set amount = amount + 100 where id =2;
select * from account;
begin;
update account set amount = amount - 500 where id = 1;
update account set amount = amount + 500 where id = 2;
rollback;
update account set amount = amount-500 where id = 1;
commit;
rollback;
select * from account;

show tables;

desc employee;
desc company;
desc sales_data;

create view Sales_Table_view as
select id, name, price, quantity from sales_data;
select * from Sales_Table_view;


