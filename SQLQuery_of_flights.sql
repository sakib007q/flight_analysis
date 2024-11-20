--deleting unnecessary columns
alter table flights
drop column year,month,day;


--adding some necessary columns
alter table flights
add dep_delay int;
--
update flights
set dep_delay=dep_time-sched_dep_time;

--
alter table flights
add arr_delay int;
--
update flights
set arr_delay= arr_time-sched_arr_time;

--queries

--monthly flights
select format(time_hour, 'MMMM') month, count(flight) total_flights
from flights
group by format(time_hour, 'MMMM');


-- times per distance with airlines
select name, sum(distance)/sum(air_time) time_per_distance
from flights
group by name;


--flights with no and their distance covers
select flight flight_no,count(flight) total_flights, sum(distance) total_distance
from flights
group by flight
order by total_flights desc;


--monthly delayed flights percentage
select format(time_hour,'MMMM') month, round(count(flight)*100.0/
(select count(flight) from flights),2) delayed_flights_rate
from flights
group by format(time_hour,'MMMM');


--origin & dest of flight which cover max distance
select top 1 origin,dest,flight ,distance
from flights
where distance=(
select max(distance) from flights);


--origin and dest by avg time avg dest
select origin,dest,avg((hour *60)+minute) avg_time, avg(distance) avg_distance
from flights
group by origin,dest
order by avg_distance desc;


--carriers
select carrier airlines, count(flight) flights
from flights
group by carrier;


--delay flights
select flight,avg(dep_delay) average_dep_delay, avg(arr_delay) average_arr_delay
from flights
group by flight;


-- Most delayed route
select origin,dest,count(flight) no_delayed_flights
from flights
where dep_delay>0
group by origin,dest
order by no_delayed_flights desc;


-- Most busy routes
select origin,dest,count(flight) flights
from flights
group by origin,dest
order by flights desc;






select * from flights