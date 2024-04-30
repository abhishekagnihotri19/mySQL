CREATE TABLE EMPLOYEE ( NAME VARCHAR (20), CITY VARCHAR(20), DEPARTMENT_ID INT NULL, 
SALARY INT NOT NULL, FOREIGN KEY (department_id) REFERENCES department(id));
CREATE table DEPARTMENT (ID int primary key auto_increment, NAME VARCHAR(20)); 
CREATE table COMPANY (ID INT PRIMARY KEY auto_increment, NAME VARCHAR (20) NOT NULL, REVENUE INT);

INSERT INTO DEPARTMENT (NAME)
VALUES ('IT'), ('MANAGEMENT'),('IT'), ('SUPPORT');

INSERT INTO COMPANY(NAME, REVENUE)
VALUES ('IBM', 2000000),
('GOOGLE', 9000000),
('Apple', 10000000);

INSERT INTO EMPLOYEE (NAME,CITY,DEPARTMENT_ID,SALARY)
VALUES 
('ROBIN', 'London', 3, 80000),
('MANJU', 'London', 3, 70000),
('MEENALI', 'Paris', 3, 60000),
('ANKITA', 'Paris', 3, 50000),
('AVNI', 'London', 2, 110000),
('AKANSHA', 'London', 2, 90000),
('SHUBHANSHU', 'Rome', 4, 30000),
('IVAN', 'London', 3, 100000);

/*1 query all rows from Employee table*/
SELECT * FROM EMPLOYEE;

/* 2 all rows from Department table*/
SELECT * FROM DEPARTMENT;

/* 3 query to change name of Department having ID 1*/
UPDATE department 
SET NAME ='MANAGEMENT'
WHERE ID=1;

/* 4 query name of all company*/
select * from company;

/*5 query to change name of Employee having salary 80000*/
update employee
set name="Abhishek"
where salary =80000;

/* 6 Delete employee salary>100000 */
delete from employee
where salary > 100000;

/* 7 query name and city of all employee*/
select name, city from employee;

/* 8 all companies with revenue greater than 5 000 000*/
SELECT * FROM company
WHERE REVENUE>5000000;

 /*9 Query all companies with revenue smaller than 5 000 000*/
 SELECT	* FROM company
 WHERE REVENUE < 5000000;
 
 /*10 Query all companies with revenue smaller than 5 000 000 , but you cannot use the '<' operator*/

SELECT * FROM COMPANY
WHERE NOT REVENUE >= 5000000;

-- alternate method of above query--
SELECT * FROM COMPANY
ORDER BY REVENUE
LIMIT 1;

/* 11 Query all employees with salary greater than 50 000 and smaller than 70 000 */
select* FROM employee
WHERE SALARY BETWEEN 50000 AND 70000;
-- aLETRENATE METHOD OR IF cannot use BETWEEN--
SELECT * FROM employee
WHERE NOT SALARY < 50000 AND NOT SALARY > 70000;
-- ALTERNATE VERSION---
SELECT * FROM employee
WHERE salary >= 50000 AND salary <= 70000;
/* 12 Query all employees with salary not equal to 80 000*/
select* FROM EMPLOYEE
WHERE SALARY < 80000;

/*IMPORTANCE OF 'OR'
13 Query all names of employees with salary greater than 70 000 
together with employees who work on the 'IT' department*/

SELECT NAME FROM EMPLOYEE
WHERE SALARY>70000 
or department_id IN (SELECT ID FROM department WHERE NAME='IT' );

/*IMPORTANCE OF 'AND'
14 Query all names of employees with salary greater than 70 000 
AND ONLY work on the 'IT' department*/

SELECT NAME FROM EMPLOYEE
WHERE SALARY>70000 
AND department_id IN (SELECT ID FROM department WHERE NAME='IT' );

 /*-CHECKING EMPOYEE TABLE CONTENT--*/
SELECT NAME, SALARY, DEPARTMENT_ID FROM employee;
/* PRACTICING OR-AND QUERIES*/
SELECT name FROM employee
where salary >70000
OR department_id in(select id from department where name='MANAGEMENT');

SELECT name FROM employee
where salary >70000
AND department_id in(select id from department where name='MANAGEMENT');

/* 15. Query all employees that work in city that starts with 'L'*/
SELECT * FROM EMPLOYEE
WHERE CITY LIKE 'L%';

/* 16. Query all employees that work in city that starts with 'L', OR  END WITH 'S' */
SELECT * FROM EMPLOYEE
WHERE CITY LIKE 'L%' OR CITY LIKE '%S';

/* 17. Query all employees that  work in city with 'o' somewhere in the middle */
SELECT * FROM EMPLOYEE
WHERE CITY LIKE '%O%';

/* 18 Query all departments (each name only once)*/
SELECT distinct NAME FROM department;

/*19 Query names of all employees together with id of department, DEPARTMENT NAME they work in, but you cannot use JOIN */
SELECT emp.name, emp.DEPARTMENT_ID, dep.NAME 
FROM employee emp, department dep
order by emp.name, dep.name;

/* Check this also */
SELECT emp.name, emp.DEPARTMENT_ID, dep.NAME 
FROM employee emp, department dep
where emp.DEPARTMENT_ID= dep.id
order by emp.name, dep.name;

/*19 Query names of all employees together with id of department, DEPARTMENT NAME they work in, by using join */

select emp.name, emp.DEPARTMENT_ID, dep.name
from employee emp
join department dep
on emp.DEPARTMENT_ID= dep.id
order by emp.name, dep.id;
 

SELECT emp.name,dep.id,dep.name
FROM employee emp
JOIN department dep
ON emp.department_id = dep.id
ORDER BY emp.name, dep.id;


select* from company;
select * from department;

/*25. Query name of every company together with departments */

SELECT comp.id,COMP.NAME, DEP.NAME
FROM COMPANY comp
join department dep on comp.id = dep.id
order by comp.id;

/* 26. Query employee name together with the department name that they are not working in*/

select emp.name, dep.name
from employee emp, department dep
where emp.department_id<> dep.id;

/*
27. Query company name together with other companies names
LIKE:
GOOGLE Apple
GOOGLE IBM
Apple IBM
...
*/
select com1.name, com2.name
from company com1, company com2
where com1.name<>com2.name
order by com1.name, com2.name;

/* 28. Query employee names with salary smaller than 80 000 without using NOT and <
NOTE: for POSTGRESQL only. Mysql doesn't support except
*/

select e1.name from employee e1
except
select e2.name from employee e2 where e2.salary >80000;

/*
29.Query names of every company and change the name of column to 'Company'
*/
select name as company
from company;

/*
30. Query all employees that work in same department as Ankita
*/


/*
30. Query all employees that work in same department as Ankita
*/
select * from employee where department_id IN (select DEPARTMENT_ID from employee where name = 'Ankita');