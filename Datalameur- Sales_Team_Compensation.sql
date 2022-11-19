--problem 
/*As Oracle’s Sales Operations analyst, you are helping the VP of Sales determine the final compensation each salesperson earned for the year.

Each salesperson earns a fixed base salary and a percentage of commission on their total deals. Also, if they beat their quota, any sales after that receive an accelerator, which is just a higher commission rate applied to their commissions after they hit the quota.

Write a query to calculate the total compensation earned by each salesperson. Output the employee id and total compensation in descending order. Where there are ties, sort the employee id in ascending order.

Assumptions:

Hitting a target (quota) means the amount of total deals is equivalent to or higher than the target.
When a salesperson did not hit the target (quota), the employee receives a fixed base salary and a commission on the total deals.
When a salesperson hits the target (quota), the compensation package includes:
a fixed base salary,
a commission on target (quota), and
a commission and accelerated commission on the balance of the total deals (total deals - quota) (see example output & explanation below).

Reference 👉 https://datalemur.com/questions/sales-team-compensation*/

--solution
with cte as (SELECT employee_id,sum(deal_size) as total_size FROM deals group by employee_id),
cte1 as (select e.*,c.total_size,case when total_size > quota then 'yes' else 'no' end as flag from cte c inner join employee_contract e on 
c.employee_id = e.employee_id)
select employee_id,case when flag = 'yes' then (base +(quota*commission) + ((total_size - quota)*accelerator*commission))
else (base +(total_size*commission)) end as total_earning 
from cte1 order by total_earning desc;
