create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;
-- Write a query to output team, num_match_played, wins, losses
with cte as(
select Team_1 as team, 
case when Team_1 = Winner then 1 else 0 end as wins,
case when Team_2 = Winner then 1 else 0 end as loss
from icc_world_cup
UNION ALL
select Team_2 as team, 
case when Team_2 = Winner then 1 else 0 end as wins,
case when Team_1 = Winner then 1 else 0 end as loss
from icc_world_cup
)
select team, count(*) as num_match_played, sum(wins) as wins, sum(loss) as loss from cte
group by team;