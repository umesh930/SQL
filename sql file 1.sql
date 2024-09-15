F1 race analysis

1. Identify the country which has produced the most F1 drivers.
select nationality,count(1) as tot_drivers  
from drivers
group by nationality
order by tot_drivers desc
limit 1;

2. Which country has produced the most no of F1 circuits
select country,count(1)as tot_f1_circuits
from circuits
group by country
order by tot_f1_circuits desc
limit 1;

3. Which countries have produced exactly 5 constructors?

select cir.country,count(1) as tot_constructors
from constructor_results c
join races r on r.raceid = c.raceid
join circuits cir on cir.circuitid = r.circuitid
group by cir.country
having count(1)=5;

4. List down the no of races that have taken place each year
select year,count(1) as tot_races 
from races 
group by year
order by year 

5. Who is the youngest and oldest F1 driver?

method--1
----------------

with cte as (
select forename||' '||surname as driver_name,dob
from drivers),
oldest as (
select driver_name,dob 
from cte
order by dob
limit 1
),
youngest as (
select driver_name,dob 
from cte
order by dob desc
limit 1
)

select * ,'oldest'as young_old
from oldest
union 
select * ,'youngest' young_old
from youngest


method---2
----------
with cte as (
select forename||''||surname as driver_name,case when dob= (select min(dob) from drivers ) then 'oldest'
            when dob= (select max(dob) from drivers ) then 'youngest'
			end as young_old
from drivers)
select driver_name,young_old
from cte 
where young_old is not null;

6. List down the no of races that have taken place each year and mentioned which
was the first and the last race of each season.

select year,count(1) as tot_races,min(date) as first_race,max(date) as last_race
from races
group  by year
order  by year









select * from seasons;
select * from status; 	
select * from circuits;
select * from races;
select * from drivers;
select * from constructors; 
select * from constructor_results; 
select * from constructor_standings;
select * from driver_standings;
select * from lap_times;
select * from pit_stops; 
select * from qualifying;
select * from results;
select * from sprint_results;

