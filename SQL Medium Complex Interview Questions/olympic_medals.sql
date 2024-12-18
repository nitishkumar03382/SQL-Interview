# DDL
# CREATE TABLE
CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);

delete from events;
# INSERT INTO TABLE
INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');
#########################################################################
-- write a query to find number of gold medals per swimmer for swimmer who only won gold
#select * from events;
#Solution 1
with cte as(
select GOLD as player_name, 'GOLD' as medal_type from events
UNION ALL
select SILVER as player_name, 'SILVER' as medal_type from events
UNION ALL
select BRONZE as player_name, 'BRONZE' as medal_type from events
)
select player_name, length(replace(group_concat(medal_type), 'GOLD','')) + 1 as gold_medal_count from cte
group by player_name
having group_concat(medal_type) not like '%SILVER%' and
group_concat(medal_type) not like '%BRONZE%' 
order by 2 desc;
# Solution 2
select * from events;
select GOLD as player_name, count(*) as gold_medal_count from events
where GOLD NOT IN (select SILVER as pn from events UNION SELECT BRONZE as pn FROM events)
GROUP BY 1
ORDER BY 2 DESC;
# Solution 3
with cte as(
select GOLD as player_name, 'GOLD' as medal_type from events
UNION ALL
select SILVER as player_name, 'SILVER' as medal_type from events
UNION ALL
select BRONZE as player_name, 'BRONZE' as medal_type from events
)
select player_name, count(*) from cte
group by 1
having count(distinct medal_type) = 1 and max(medal_type) = 'GOLD'
order by 2 desc;