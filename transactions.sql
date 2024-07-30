use meanlifestudies



SELECT * FROM transactions;
with cte as(
select user_id, count(*) total_transactions, count(case when type = 'credit' then user_id else null end) as credits, 
count(case when type = 'debit' then user_id else null end) as debits from transactions
group by user_id)
select c.*, credits*100/ (credits+debits) as credit_percent, debits*100/(debits+credits) as debit_percent from cte c


WITH cte AS (
    SELECT
        t.*,
        SUM(CASE WHEN type = 'credit' THEN amount ELSE -amount END) 
            OVER (PARTITION BY user_id ORDER BY transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_balance
    FROM
        transactions t
), cte2 as(
SELECT c.*,
    CASE 
        WHEN type = 'debit' AND running_balance <0 THEN 'Not Eligible'
        ELSE 'Eligible'
    END AS eligibility
FROM
     cte c)
select * from cte2 order by transaction_date

