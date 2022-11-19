--problem
/*Intuit offers several tax filing products, such as TurboTax and QuickBooks, which come in multiple versions.

Write a query to find the user ids of everyone who filed their taxes with any version of TurboTax three or more years in a row. Display the output in the ascending order of user ids.

Assumption:

As reflected in the table, a user can only file taxes once a year using one product.

Reference 👉🏼 https://datalemur.com/questions/consecutive-filing-years*/

--solution
with cte as (SELECT *,EXTRACT(YEAR from filing_date) as filing_year
FROM filed_taxes where upper(product) like '%TURBOTAX%'),
ranked_cte as (select *,rank() over(PARTITION BY user_id
order by filing_year) as rn from cte),
year_grouping_cte as (select *,filing_year - rn as group_year from ranked_cte)
select distinct user_id from year_grouping_cte 
group by user_id,group_year having count(*) >= 3;
