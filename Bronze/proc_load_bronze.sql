CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	BEGIN TRY

		------------------------------------------------------------------- [circuits] 
		PRINT '>> Inserting Data Into: bronze.circuits';
		TRUNCATE TABLE bronze.circuits;
		BULK INSERT bronze.circuits
		FROM 'C:\Users\patel\Downloads\circuits_cleaned.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
		------------------------------------------------------------------- [constructor_results]
		PRINT '>> Inserting Data Into: bronze.constructor_results';
		TRUNCATE TABLE bronze.constructor_results;
		BULK INSERT bronze.constructor_results
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\constructor_results.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
		------------------------------------------------------------------- [constructor_standings]

		PRINT '>> Inserting Data Into: bronze.constructor_standings';
		TRUNCATE TABLE [bronze].[constructor_standings]
		BULK INSERT [bronze].[constructor_standings]
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\constructor_standings.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);  

		------------------------------------------------------------------- [constructors]

		PRINT '>> Inserting Data Into: [bronze].[constructors]';
		TRUNCATE TABLE [bronze].[constructors];
		BULK INSERT [bronze].[constructors]
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\constructors.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

		------------------------------------------------------------------- [driver_standings]

		PRINT '>> Inserting Data Into: [bronze].[driver_standings]';
		TRUNCATE TABLE [bronze].[driver_standings];
		BULK INSERT [bronze].[driver_standings]
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\driver_standings.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

		------------------------------------------------------------------- [drivers]

		PRINT '>> Inserting Data Into: [bronze].[drivers]';
		TRUNCATE TABLE [bronze].[drivers];
		BULK INSERT [bronze].[drivers]
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\drivers.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);



		------------------------------------------------------------------- [lap times]


		PRINT '>> Inserting Data Into: bronze.lap_times';
		TRUNCATE TABLE [bronze].[lap_times];

		BULK INSERT [bronze].[lap_times]
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\lap_times.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		------------------------------------------------------------------- [pit_stops]

		PRINT '>> Inserting Data Into: [bronze].[pit_stops]';
		TRUNCATE TABLE [bronze].[pit_stops];
		BULK INSERT [bronze].[pit_stops]
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\pit_stops.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
		------------------------------------------------------------------- [qualifying]

		PRINT '>> Inserting Data Into: [bronze].[qualifying]';
		TRUNCATE TABLE [bronze].[qualifying];
		BULK INSERT [bronze].[qualifying]
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\qualifying.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

		------------------------------------------------------------------- [bronze].[races]

		PRINT '>> Inserting Data Into: [bronze].[races]';
		TRUNCATE TABLE [bronze].[races];
		BULK INSERT [bronze].[races]
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\races.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

		------------------------------------------------------------------- [bronze].[results]

		PRINT '>> Inserting Data Into: [bronze].[results]';
		TRUNCATE TABLE [bronze].[results];
		BULK INSERT [bronze].[results]
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\results.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

		------------------------------------------------------------------- [seasons]

		PRINT '>> Inserting Data Into: [bronze].[seasons]';
		TRUNCATE TABLE [bronze].[seasons];
		BULK INSERT [bronze].[seasons]
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\seasons.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

		------------------------------------------------------------------- [sprint_results]

		PRINT '>> Inserting Data Into: [bronze].[sprint_results]';
		TRUNCATE TABLE [bronze].[sprint_results];
		BULK INSERT[bronze].[sprint_results]
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\sprint_results.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
		------------------------------------------------------------------- [status]

		PRINT '>> Inserting Data Into: [bronze].[status]';
		TRUNCATE TABLE [bronze].[status];
		BULK INSERT[bronze].[status]
		FROM 'C:\Users\patel\Downloads\Formula1_dataset\status.csv'
		with (
				FIRSTROW=2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END


exec bronze.load_bronze;