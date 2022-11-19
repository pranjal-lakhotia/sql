--problem 
/*You are given a table of Facebook posts from users who posted at least twice in 2021. Write a query to find the average number of days between each user’s posts during 2021.

Output the user id and the average number of the days between posts.

Assumptions:

A user can post several times a day.
When calculating the differences between dates, output the component of the time in the form of days. For example, 10 days or 5.5 days.
Reference 👉🏻 https://datalemur.com/questions/sql-average-post-hiatus-2*/


--solution 
with cte as (
  select 
    *, 
    row_number() over(
      PARTITION BY user_id 
      order by 
        post_date
    ) as rn 
  from 
    posts 
  where 
    extract(
      year 
      from 
        post_date
    ) = 2021
), 
joined_cte as (
  select 
    c1.user_id as user_id, 
    c1.post_date as c1_post_date, 
    c1.rn as c1_rn, 
    c2.post_date as c2_post_date, 
    c2.rn as c2_rn 
  from 
    cte c1 
    left join cte c2 on c1.post_date > c2.post_date 
    and c1.user_id = c2.user_id
), 
filtered_cte as (
  select 
    * 
  from 
    joined_cte 
  where 
    (c1_rn - c2_rn = 1)
) 
select 
  user_id, 
  avg(
    date_part(
      'day', c1_post_date - c2_post_date
    )
  ) as days_between 
from 
  filtered_cte 
group by 
  user_id 
order by 
  user_id;
