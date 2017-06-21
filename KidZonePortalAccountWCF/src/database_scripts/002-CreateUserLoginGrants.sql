

USE [KidZonePortal]
GO

CREATE LOGIN [KidZonePortalUser] 
    WITH PASSWORD = 'my$h0wcas3';
    
    GO
    
USE [KidZonePortal];
GO

CREATE USER [KidZonePortalUser] FOR LOGIN [KidZonePortalUser] 
    WITH DEFAULT_SCHEMA = dbo;
GO

EXEC sp_addrolemember 'db_owner','KidZonePortalUser'
GO

use [KidZonePortal]
go

GRANT SELECT ON SCHEMA :: dbo TO [KidZonePortalUser] WITH GRANT OPTION;
go

use [KidZonePortal]
go

GRANT EXECUTE ON SCHEMA :: dbo TO [KidZonePortalUser] WITH GRANT OPTION;
go









