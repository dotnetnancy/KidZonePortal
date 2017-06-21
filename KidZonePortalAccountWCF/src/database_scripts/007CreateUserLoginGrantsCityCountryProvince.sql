

USE [countrystatecitydb]
GO

CREATE USER [KidZonePortalUser] FOR LOGIN [KidZonePortalUser] 
    WITH DEFAULT_SCHEMA = dbo;
GO

EXEC sp_addrolemember 'db_owner','KidZonePortalUser'
GO

USE [countrystatecitydb]
go

GRANT SELECT ON SCHEMA :: dbo TO [KidZonePortalUser] WITH GRANT OPTION;
go

USE [countrystatecitydb]
go

GRANT EXECUTE ON SCHEMA :: dbo TO [KidZonePortalUser] WITH GRANT OPTION;
go









