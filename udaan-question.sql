-- count new cities in which udaan arranges a function additionaly in comparison to previous years

create table business_city (
business_date date,
city_id int
);
delete from business_city;
insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);

--solution
with cte as (select DATE_FORMAT(business_date,'%Y') as 
business_year,city_id from business_city)
select c1.business_year,count(distinct case when c2.city_id is null then c1.city_id end) as cnt_new_cities from cte c1
left join cte c2 on c1.business_year > c2.business_year and c1.city_id = c2.city_id
group by c1.business_year
;
