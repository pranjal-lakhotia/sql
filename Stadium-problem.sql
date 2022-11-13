-- find out rows from stadium where count of people on consecutive days > 100 and rows are continous
create table stadium (
id int,
visit_date date,
no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);
with cte as (select *,rank() over (order by visit_date)
 as rn from stadium where no_of_people > 100),
group_cte as (select *,(id - rn) as grp from cte)
select * from group_cte where grp in (
select grp from group_cte group by grp having count(grp) > 3);
