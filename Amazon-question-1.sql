-- find employee with 3 highest salary or if no of employees < 3 then lowest salary person in each department
create DATABASE practise;
use practise;
CREATE TABLE emp(
 emp_id int ,
 emp_name text(50) ,
 salary int ,
 manager_id int ,
 emp_age int ,
 dep_id int ,
 dep_name text ,
 gender text 
) ;
insert into emp values(1,'Ankit',14300,4,39,100,'Analytics','Female');
insert into emp values(2,'Mohit',14000,5,48,200,'IT','Male');
insert into emp values(3,'Vikas',12100,4,37,100,'Analytics','Female');
insert into emp values(4,'Rohit',7260,2,16,100,'Analytics','Female');
insert into emp values(5,'Mudit',15000,6,55,200,'IT','Male');
insert into emp values(6,'Agam',15600,2,14,200,'IT','Male');
insert into emp values(7,'Sanjay',12000,2,13,200,'IT','Male');
insert into emp values(8,'Ashish',7200,2,12,200,'IT','Male');
insert into emp values(9,'Mukesh',7000,6,51,300,'HR','Male');
insert into emp values(10,'Rakesh',8000,6,50,300,'HR','Male');
insert into emp values(11,'Akhil',4000,1,31,500,'Ops','Male');

select * from emp;
with cte as (select *,rank() over (partition by dep_id order by salary desc) as rn,count(1) over (partition by dep_id ) as cnt from emp)
select * from cte where rn = 3 or (cnt < 3 and rn = cnt);
