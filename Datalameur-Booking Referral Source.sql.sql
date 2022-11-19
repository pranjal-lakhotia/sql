--problem
/*The Airbnb marketing analytics team is trying to understand what are the most common marketing channels that lead users to book their first rental on Airbnb.

Write a query to find the top marketing channel and percentage of first rental bookings from the aforementioned marketing channel. Round the percentage to the closest integer. Assume there are no ties.

Assumptions:

Marketing channel with null values should be incorporated in the percentage of first bookings calculation, but the top channel should not be a null value. Meaning, we cannot have null as the top marketing channel.
To avoid integer division, multiple the percentage with 100.0 and not 100.

Reference 👉 https://datalemur.com/questions/booking-referral-source*/

--solution
with cte as ( select *, rank() over(partition by user_id order by booking_date asc) as rn
from bookings),
cte2 as (select * from cte c join booking_attribution ba on c.booking_id = ba.booking_id where rn = 1),
cte3 as (select channel,count(1) as cnt from cte2 group by channel),
cte4 as (select sum(cnt) as total from cte3)
select channel,cast(cnt/total*100.0 as integer) as pct from cte3,cte4 order by pct desc limit 1;
