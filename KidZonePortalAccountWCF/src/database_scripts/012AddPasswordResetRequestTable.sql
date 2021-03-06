/*
   Thursday, December 29, 201111:58:14 AM
   User: 
   Server: WIN-3AHR7ERVN41\NI
   Database: KidZonePortal
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.PasswordResetRequest
	(
	PasswordResetRequestID uniqueidentifier NOT NULL,
	AccountID uniqueidentifier NOT NULL,
	PasswordResetCode nvarchar(50) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.PasswordResetRequest SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.PasswordResetRequest', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.PasswordResetRequest', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.PasswordResetRequest', 'Object', 'CONTROL') as Contr_Per 