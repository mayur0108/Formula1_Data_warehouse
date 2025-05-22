

	IF OBJECT_ID('bronze.circuits', 'U') IS NOT NULL
		DROP TABLE bronze.circuits;
	GO

	CREATE TABLE bronze.circuits (
		circuit_id			INT,
		circuit_ref			NVARCHAR(255),
		name				NVARCHAR(255),
		location			NVARCHAR(255),
		country				NVARCHAR(255),
		lat					FLOAT,
		lng					FLOAT,
		alt					INT,
   
	);


	IF OBJECT_ID('bronze.constructor_results', 'U') IS NOT NULL
		DROP TABLE bronze.constructor_results;
	GO

	CREATE TABLE bronze.constructor_results (
		constructorResultsId	INT,
		raceId					INT,
		constructorId			INT,
		points					FLOAT,
		status					NVARCHAR(255)
	);


	IF OBJECT_ID('bronze.constructor_standings', 'U') IS NOT NULL 
		DROP TABLE bronze.constructor_standings;

	CREATE TABLE bronze.constructor_standings( 
		constructorstandingsId		INT,
		raceId						INT,
		constructorId				INT,
		points						FLOAT,
		position					INT,
		positionText				NVARCHAR(255),
		wins						INT
	);


	IF OBJECT_ID('bronze.constructors', 'U') IS NOT NULL
		DROP TABLE bronze.constructors;
	GO

	CREATE TABLE bronze.constructors (
		constructorId		INT,
		constructorRef		NVARCHAR(255),
		name				NVARCHAR(255),
		nationality			NVARCHAR(255),
	);


	IF OBJECT_ID('bronze.driver_standings', 'U') IS NOT NULL 
		DROP TABLE bronze.driver_standings;

	CREATE TABLE bronze.driver_standings (
		driverStandingsId		INT,
		raceId					INT,
		driverId				INT,
		points					FLOAT,
		position				INT,
		positionText			NVARCHAR(255),
		wins					INT
	);

	IF OBJECT_ID('bronze.drivers', 'U') IS NOT NULL
		DROP TABLE bronze.drivers;
	GO

	CREATE TABLE bronze.drivers (
		driverId		INT,
		driverRef		NVARCHAR(255),
		number			NVARCHAR(255),
		code			NVARCHAR(255),
		forename		NVARCHAR(255),
		surname			NVARCHAR(255),
		dob				NVARCHAR(255),
		nationality		NVARCHAR(255),
 
	);

	IF OBJECT_ID('bronze.lap_times', 'U') IS NOT NULL
		DROP TABLE bronze.lap_times;
	GO

	CREATE TABLE bronze.lap_times (
		raceId			INT,
		driverId		INT,
		lap				INT,
		position		INT,
		time			NVARCHAR(255),
		milliseconds	INT
	);


	IF OBJECT_ID('bronze.pit_stops', 'U') IS NOT NULL
		DROP TABLE bronze.pit_stops;
	GO

	CREATE TABLE bronze.pit_stops (
		raceId			INT,
		driverId		INT,
		stop			INT,
		lap				INT,
		time			NVARCHAR(255),
		duration		NVARCHAR(255),
		milliseconds	INT
	);


	IF OBJECT_ID('bronze.qualifying', 'U') IS NOT NULL
		DROP TABLE bronze.qualifying;
	GO

	CREATE TABLE bronze.qualifying (
		qualifyId		INT,
		raceId			INT,
		driverId		INT,
		constructorId	INT,
		number			INT,
		position		INT,
		q1				NVARCHAR(255),
		q2				NVARCHAR(255),
		q3				NVARCHAR(255)
	);

	IF OBJECT_ID('bronze.races', 'U') IS NOT NULL
		DROP TABLE bronze.races;
	GO

	CREATE TABLE bronze.races (
		raceId			INT,
		year			INT,
		round			INT,
		circuitId		INT,
		name			NVARCHAR(255),
		date			DATE,
		time			NVARCHAR(255),
		fp1_date		NVARCHAR(255),
		fp1_time		NVARCHAR(255),
		fp2_date		NVARCHAR(255),
		fp2_time		NVARCHAR(255),
		fp3_date		NVARCHAR(255),
		fp3_time		NVARCHAR(255),
		quali_date		NVARCHAR(255),
		quali_time		NVARCHAR(255),
		sprint_date		NVARCHAR(255),
		sprint_time		NVARCHAR(255)
	);


	IF OBJECT_ID('bronze.results', 'U') IS NOT NULL
		DROP TABLE bronze.results;
	GO

	CREATE TABLE bronze.results (
		resultId		INT,
		raceId			INT,
		driverId		INT,
		constructorId	INT,
		number			NVARCHAR(255),
		grid			INT,
		position		NVARCHAR(255),
		positionText	NVARCHAR(255),
		positionOrder	INT,
		points			FLOAT,
		laps			INT,
		time			NVARCHAR(255),
		milliseconds	NVARCHAR(255),
		fastestLap		NVARCHAR(255),
		rank			NVARCHAR(255),
		fastestLapTime	NVARCHAR(255),
		fastestLapSpeed NVARCHAR(255),
		statusId		INT
	);

	IF OBJECT_ID('bronze.seasons', 'U') IS NOT NULL
		DROP TABLE bronze.seasons;
	GO

	CREATE TABLE bronze.seasons (
		year DATE,
	);


	IF OBJECT_ID('bronze.sprint_results', 'U') IS NOT NULL
		DROP TABLE bronze.sprint_results;
	GO

	CREATE TABLE bronze.sprint_results (
		resultId		INT,
		raceId			INT,
		driverId		INT,
		constructorId	INT,
		number			INT,
		grid			INT,
		position		NVARCHAR(255),
		positionText	NVARCHAR(255),
		positionOrder	INT,
		points			INT,
		laps			INT,
		time			NVARCHAR(255),
		milliseconds	NVARCHAR(255),
		fastestLap		NVARCHAR(255),
		fastestLapTime	NVARCHAR(255),
		statusId		INT
	);

	IF OBJECT_ID('bronze.status', 'U') IS NOT NULL
		DROP TABLE bronze.status;
	GO

	CREATE TABLE bronze.status (
		statusId	INT,
		status		NVARCHAR(255)
	);


