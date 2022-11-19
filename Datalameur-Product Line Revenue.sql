--Question 
/* As a business analyst on the revenue forecasting team at NVIDIA, you are given a table of NVIDIA transactions in 2021.

Write a query to summarize the total sales revenue for each product line. The product line with the highest revenue should be at the top of the results.

Assumption:

There will be at least one sale of each product line. 
For complete question visit here --> https://datalemur.com/questions/revenue-by-product-line*/

--solution

select product_line,sum(amount) as total_sales from(SELECT p.*,t.amount FROM product_info p join transactions t 
on p.product_id = t.product_id) q group by product_line
order by total_sales desc;
