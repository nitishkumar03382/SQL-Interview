with platform_spending as(
select user_id, spend_date, max(platform) platform, sum(amount) total_amount from spending
group by 1, 2 having count(distinct platform) = 1
UNION
select user_id, spend_date, 'both' as platform, sum(amount) total_amount from spending
group by 1, 2 having count(distinct platform) = 2
UNION
select distinct NULL as user_id, spend_date, 'both' as platform, 0 as total_amount
from spending
)
select spend_date, platform, sum(total_amount) as total_amt,
count(distinct user_id) as total_users
 from platform_spending
 group by 1, 2
 order by 1, 2 desc;
