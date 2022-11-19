--problem
/*Apple has a trade-in program where their customers can return the old iPhone device to Apple and Apple gives the customers the trade-in value (known as payout) of the device in cash.

For each store, write a query of the total revenue from the trade-in. Order the result by the descending order.
Reference 👉 https://datalemur.com/questions/trade-in-payouts*/

--solution
with cte as (SELECT t.*,c.payout_amount FROM trade_in_transactions t join trade_in_payouts c
on t.model_id = c.model_id)
select store_id,sum(payout_amount) as payout_total from cte group by store_id
order by payout_total DESC;
