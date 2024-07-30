with cteone as (
    select storeid,
           Salesamount as sales,
           date,
           datepart(week, date) as week,
           dense_rank() over(partition by storeid order by datepart(week, date) asc) as first_week,
           dense_rank() over(partition by storeid order by datepart(week, date) desc) as last_week
    from sales_info
), ctwo as(
    select storeid,
           sum(case when first_week = 1 then sales end) as first_amount,
           sum(case when last_week = 1 then sales end) as last_amount
    from cteone
    group by storeid
)
select storeid,
       round(((last_amount - first_amount) / first_amount) * 100, 2) as perc_increase
from ctwo;

select * from sales_info

with cte as(
select storeid, datename(week, date) weeknum, sum(salesamount) total_sales
 from sales_info group by storeid, datename(week, date)
 )
 select storeid, sum(case when weeknum = 3 then total_sales else 0 end) as last_week, 
					sum(case when weeknum = 1 then total_sales else 0 end) as first_week from cte
					group by storeid

select sum(salesamount), datename(week, date), storeid from sales_info group by storeid, datename(week, date)
