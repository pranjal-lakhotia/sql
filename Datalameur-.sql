--problem
/*As a data analyst at Uber, it's your job to report the latest metrics for specific groups of Uber users. Some riders create their Uber account the same day they book their first ride; the rider engagement team calls them "in-the-moment" users.

Uber wants to know the average delay between the day of user sign-up and the day of their 2nd ride. Write a query to pull the average 2nd ride delay for "in-the-moment" Uber users. Round the answer to 2-decimal places.

Tip:

You don't need to use date operations to get the answer! You're welcome to, but it's not necessary.

Reference 👉🏻 https://datalemur.com/questions/2nd-ride-delay*/

--solution
with cte as (SELECT u.user_id,u.registration_date,r.ride_date,ride_date-registration_date as difference_in_dates FROM rides r 
join users u on r.user_id = u.user_id where u.user_id in (SELECT distinct u.user_id FROM rides r join users u on r.user_id = u.user_id
where ride_date = registration_date)),
ranked_cte as (select *,row_number() over(partition by user_id order by ride_date) as rn from cte)
select round(avg(difference_in_dates),2) from ranked_cte where rn = 2;
