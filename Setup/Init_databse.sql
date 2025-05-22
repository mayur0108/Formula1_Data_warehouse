use master;
go 

IF EXISTS (SELECT 1 FROM SYS.databases Where name= 'Formula1')
BEGIN 
	ALTER DATABASE	Formula1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Formula1;
End;
go 

Create Database Formula1;
go 

use Formula1;
go 

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO