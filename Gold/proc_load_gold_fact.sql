IF OBJECT_ID('gold.fact_race_results','V') is not null
	drop view gold.fact_race_results;
go

create view gold.fact_race_results as
select 
	
	re.resultId as Result_Id,
	re.raceId as Race_Id,
	re.driverId as Driver_Id,
	re.constructorId as Constructor_Id,
	re.grid as Starting_position,
	re.position as Final_position,
	re.positionOrder as Final_rank,
	re.points as Final_points,
	re.laps as Final_laps,
	re.time as Final_time,
	dr.Driver_name,
	dr.Driver_Ref,
	dr.Driver_code,
	re.number as Driver_number,
	co.Constructor_Ref,
	ra.Race_name,
	ra.Race_Circuit_name,
	ra.Race_date,
	ra.Race_country
	
from silver.results as re
join gold.dim_drivers as dr on re.driverId = dr.Driver_Id
join gold.dim_constructors as co on re.constructorId = co.Constructor_Id
join gold.dim_races as ra on re.raceId = ra.Race_Id;

go
select * from gold.fact_race_results

IF OBJECT_ID('gold.fact_sprint_results','V') is not null
	drop view gold.fact_sprint_results;
go

create view gold.fact_sprint_results as
select 
	
	re.resultId as Sprint_Result_Id,
	re.raceId as Sprint_Race_Id,
	re.driverId as Driver_Id,
	re.constructorId as Constructor_Id,
	re.grid as Starting_position,
	re.position as Final_position,
	re.positionOrder as Final_rank,
	re.points as Final_points,
	re.laps as Final_laps,
	re.time as Total_time,
	dr.Driver_name,
	dr.Driver_Ref,
	dr.Driver_code,
	re.number as Driver_number,
	co.Constructor_Ref,
	ra.Race_name,
	ra.Race_Circuit_name,
	ra.Race_date,
	ra.Race_country
	
from silver.sprint_results as re
join gold.dim_drivers as dr on re.driverId = dr.Driver_Id
join gold.dim_constructors as co on re.constructorId = co.Constructor_Id
join gold.dim_races as ra on re.raceId = ra.Race_Id;

go

select * from gold.fact_sprint_results
order by Driver_Id





