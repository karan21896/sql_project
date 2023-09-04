--- window function
--- to create different partition of table
--- drop table employes

create database project3;
use project3;

create table employee
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh', 'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);
COMMIT;
use project3;

select * from employee;

select dept_name,max(salary) from employee
group by dept_name;



--- by using window function

select e.*, max(salary) over(partition by dept_name) as max_salary
from employee e;

-- number(),rank(),rank_dense(),lag(),lead

select e.*, row_number() over(partition by dept_name) as rn
from employee e;

select e.*, row_number() over(partition by dept_name order by salary desc) as rn
from employee e ;

select * from
(select e.*, row_number() over(partition by dept_name order by salary desc)
 as rn
from employee e) x where x.rn<3;


-- 2 old employees from each dept

select * from 
(select e.*, row_number() over(partition by dept_name order by emp_id asc) as rn
from employee e) as x where x.rn<3; 



# rank 

select e.*, rank() over(partition by dept_name order by salary desc) as rnk
from employee e;

select * from
(select e.*, rank() over(partition by dept_name order by salary desc) as rnk
from employee e) x where x.rnk=1;


# dense_rank

select e.*, dense_rank() over(partition by dept_name order by salary desc)
 as rnk
from employee e;


--- lead and lag 

select e.*, lag(salary) over(partition by dept_name order by salary desc)
 as lg
from employee e;











