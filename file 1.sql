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


7. Which circuit has hosted the most no of races. Display the circuit name, no of races,
city and country.

select c.name as circuiut_name ,c.location as city,c.country,count(1) as tot_races   
from races r
join  circuits c on c.circuitid = r.circuitid
group by  c.name,c.location,c.country 
order by tot_races  desc
limit 1

8. Display the following for 2022 season:
Year, Race_no, circuit name, driver name, driver race position, driver race points,
flag to indicate if winner
, constructor name, constructor position, constructor points, , flag to indicate if
constructor is winner
, race status of each driver, flag to indicate fastest lap for which driver, total no of pit
stops by each driver

select r.year,r.raceid as race_no,c.name as circuit_name,d.forename||''||d.surname as driver_name,
ds.position as driver_race_position,ds.points as driver_race_points,case when ds.position=1 then
'winner' end as driver_winner,co.name as constructor_namne,cs.position as constructor_position,
cs.points as constructor_points,case when cs.position= 1 then 'winner' end as constructor_winner,
s.status,x.tot_pit_stops as tot_pit_stops,case when mm.fastest_lap is not null then 'fastest_lap' end
 as fastest_lap
from races r
join circuits c on c.circuitid =r.circuitid
join driver_standings ds on ds.raceid=r.raceid
join drivers d on d.driverid = ds.driverid
join constructor_standings cs on cs.raceid = r.raceid
join constructors  co on co.constructorid = cs.constructorid
join results res on res.raceid = r.raceid and res.driverid = d.driverid and res.constructorid= 
co.constructorid
join status s on s.statusid = res.statusid
left join(
          select driverid,raceid,count(1) as tot_pit_stops
          from pit_stops
           group by raceid,driverid,raceid
          )x on x.driverid = d.driverid and x.raceid = r.raceid
left join (
            select lt.driverid,lt.raceid,fastest_lap
            from lap_times lt
            join(
            select raceid,min(time) as fastest_lap
            from lap_times
            group by  raceid
                )t on t.raceid = lt.raceid  and t.fastest_lap=lt.time
           )mm on mm.driverid=d.driverid and mm.raceid= r.raceid 
where r.year=2022 







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

