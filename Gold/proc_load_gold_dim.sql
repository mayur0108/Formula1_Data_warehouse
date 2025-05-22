IF OBJECT_ID('gold.dim_drivers','V') is not null
	drop view gold.dim_drivers;
go

CREATE VIEW gold.dim_drivers AS
SELECT
    driverId as Driver_Id,
    driverRef as Driver_Ref,
    number as Driver_number,
    code as Driver_code,
    forename + ' ' + surname as Driver_name,
    nationality as Driver_nationality,
    dob as Driver_date_of_birth
FROM silver.drivers;

go

IF OBJECT_ID('gold.dim_constructors','V') is not null
	drop view gold.dim_drivers;
go
create view gold.dim_constructors as 
select 
	constructorId as Constructor_Id,
	constructorRef as Constructor_Ref,
	name as Constructor_name,
	nationality as Constructor_nationality
from silver.constructors

go

IF OBJECT_ID('gold.dim_circuits','V') is not null
	drop view gold.dim_drivers;
go
CREATE VIEW gold.dim_circuits AS 
SELECT 
	circuit_id as Circuit_Id,
	circuit_ref as Circuit_Ref,
	name as Circuit_name,
	location as Circuit_Location,
	country as Circuit_country
FROM silver.circuits
go 


IF OBJECT_ID('gold.dim_races','V') is not null
	drop view gold.dim_drivers;
go
CREATE VIEW gold.dim_races AS
SELECT 
	ra.raceId as Race_Id,
	ra.name as Race_name,
	ra.date as Race_date,
	ra.round as Race_laps,
	ra.circuitId as Race_Circuit_id,
	ci.name as Race_Circuit_name,
	ci.location as Race_location,
	ci.country as Race_country

FROM silver.races as ra join 
silver.circuits as ci 
on ra.circuitId = ci.circuit_id

go 