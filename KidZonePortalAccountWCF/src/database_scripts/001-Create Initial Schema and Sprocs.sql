USE [KidZonePortal]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[BlogID] [uniqueidentifier] NOT NULL,
	[ProfileIDOwner] [uniqueidentifier] NOT NULL,
	[BlogName] [nvarchar](500) NOT NULL,
	[BlogDescription] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Blog_1] PRIMARY KEY CLUSTERED 
(
	[BlogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Unique_BlogName] UNIQUE NONCLUSTERED 
(
	[BlogName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AddressType]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddressType](
	[AddressTypeID] [uniqueidentifier] NOT NULL,
	[AddressTypeDescription] [nvarchar](50) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_AddressType_1] PRIMARY KEY CLUSTERED 
(
	[AddressTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContentType]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentType](
	[ContentTypeID] [uniqueidentifier] NOT NULL,
	[ContentTypeDescription] [nvarchar](500) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_ContentType] PRIMARY KEY CLUSTERED 
(
	[ContentTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountID] [uniqueidentifier] NOT NULL,
	[AccountCode] [nvarchar](255) NOT NULL,
	[AccountUsername] [nvarchar](255) NOT NULL,
	[AccountPassword] [nvarchar](1024) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Account_1] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Account] UNIQUE NONCLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailAddress]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailAddress](
	[EmailAddressID] [uniqueidentifier] NOT NULL,
	[EmailAddress] [nvarchar](500) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_EmailAddress] PRIMARY KEY CLUSTERED 
(
	[EmailAddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_EmailAddress] UNIQUE NONCLUSTERED 
(
	[EmailAddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GetInformationSchemaTables]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetInformationSchemaTables]
	@TableName [nvarchar](255) = null
AS


  SELECT t.*
	from Information_Schema.Tables t
where (t.Table_Name = @TableName or @TableName is null)
and t.Table_Name <> 'dtproperties'
and t.Table_Name <> 'sysdiagrams'
GO
/****** Object:  StoredProcedure [dbo].[GetInformationSchemaTableConstraints]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetInformationSchemaTableConstraints]
	@TableName [nvarchar](255) = null
AS



   select tc.*
	from Information_Schema.Tables t
	inner join Information_Schema.Table_Constraints tc
	on t.Table_Name = tc.Table_Name
	where (t.Table_Name = @TableName or @TableName is null)
	and t.Table_Type IN ('BASE TABLE') 
	and t.Table_Name <> 'dtproperties'
    and t.Table_Name <> 'sysdiagrams'

	Order by t.Table_Name
GO
/****** Object:  StoredProcedure [dbo].[GetInformationSchemaColumnUsage]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetInformationSchemaColumnUsage]
	@TableName [nvarchar](255) = null
AS
select ccu.*
from Information_Schema.Tables t
inner join Information_Schema.Constraint_Column_Usage ccu
on ccu.Table_Name = t.Table_Name
where (t.Table_Name = @TableName or @TableName is null)
	and t.Table_Type IN ('BASE TABLE') 
	and t.Table_Name <> 'dtproperties'
    and t.Table_Name <> 'sysdiagrams'
GO
/****** Object:  StoredProcedure [dbo].[GetInformationSchemaColumns]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetInformationSchemaColumns]
	@TableName [nvarchar](255) = null
AS


  
	SELECT c.*
	FROM Information_Schema.Tables t
	inner join Information_Schema.Columns c
	on c.Table_Name = t.Table_Name
	--WHERE t.TABLE_TYPE IN ('BASE TABLE', 'VIEW') 
	WHERE (t.Table_Name = @TableName or @TableName is null)
	and t.TABLE_TYPE IN ('BASE TABLE') 
	and t.Table_Name <> 'dtproperties'
    and t.Table_Name <> 'sysdiagrams'

	ORDER BY t.TABLE_NAME
GO
/****** Object:  Table [dbo].[Person]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[PersonID] [uniqueidentifier] NOT NULL,
	[PersonFirstName] [nvarchar](255) NOT NULL,
	[PersonLastName] [nvarchar](255) NOT NULL,
	[PersonMiddleInitials] [nvarchar](50) NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PasswordResetRequest]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PasswordResetRequest](
	[PasswordResetRequestID] [uniqueidentifier] NOT NULL,
	[AccountID] [uniqueidentifier] NOT NULL,
	[PasswordResetCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PasswordResetRequest] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchTerm]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchTerm](
	[SearchTermID] [uniqueidentifier] NOT NULL,
	[SearchTerm] [nvarchar](255) NOT NULL,
	[Count] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SearchTerm] PRIMARY KEY CLUSTERED 
(
	[SearchTerm] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProfileType]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfileType](
	[ProfileTypeID] [uniqueidentifier] NOT NULL,
	[ProfileName] [nvarchar](255) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_ProfileType_1] PRIMARY KEY CLUSTERED 
(
	[ProfileTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhoneNumberType]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneNumberType](
	[PhoneNumberTypeID] [uniqueidentifier] NOT NULL,
	[PhoneNumberTypeDescription] [nvarchar](50) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_PhoneNumberType_1] PRIMARY KEY CLUSTERED 
(
	[PhoneNumberTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[IsIdentity]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[IsIdentity]
	@TableName [nvarchar](255) = null,
	@ColumnName [nvarchar](255) = null,
	@IsIdentity [bit] = 0 OUTPUT
AS
if exists(select *
		from information_schema.columns 
		where 
		table_schema = 'dbo' 
		and columnproperty(object_id(@TableName), @ColumnName,'IsIdentity') = 1 
		)
			set @IsIdentity = 1
else
			set @IsIdentity = 0
GO
/****** Object:  Table [dbo].[WebsiteLink]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebsiteLink](
	[WebsiteLinkID] [uniqueidentifier] NOT NULL,
	[WebsiteLinkURL] [nvarchar](500) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_WebsiteLink] PRIMARY KEY CLUSTERED 
(
	[WebsiteLinkID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_WebsiteLink] UNIQUE NONCLUSTERED 
(
	[WebsiteLinkID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[UpdateAccountByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateAccountByPrimaryKey]
	@AccountID [uniqueidentifier],
	@AccountCode [nvarchar](255),
	@AccountUsername [nvarchar](255),
	@AccountPassword [nvarchar](1024),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Account 
Set AccountCode = @AccountCode, 
AccountUsername = @AccountUsername, 
AccountPassword = @AccountPassword, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  AccountID = @AccountID
GO
/****** Object:  StoredProcedure [dbo].[UpdateWebsiteLinkByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateWebsiteLinkByPrimaryKey]
	@WebsiteLinkID [uniqueidentifier],
	@WebsiteLinkURL [nvarchar](500),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update WebsiteLink 
Set WebsiteLinkURL = @WebsiteLinkURL, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  WebsiteLinkID = @WebsiteLinkID
GO
/****** Object:  StoredProcedure [dbo].[UpdateSearchTermByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateSearchTermByPrimaryKey]
	@SearchTermID [uniqueidentifier],
	@SearchTerm [nvarchar](255),
	@Count [int],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update SearchTerm 
Set SearchTermID = @SearchTermID, 
Count = @Count, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  SearchTerm = @SearchTerm
GO
/****** Object:  StoredProcedure [dbo].[UpdateProfileTypeByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateProfileTypeByPrimaryKey]
	@ProfileTypeID [uniqueidentifier],
	@ProfileName [nvarchar](255),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update ProfileType 
Set ProfileName = @ProfileName, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  ProfileTypeID = @ProfileTypeID
GO
/****** Object:  StoredProcedure [dbo].[UpdatePasswordResetRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdatePasswordResetRequestByPrimaryKey]
	@PasswordResetRequestID [uniqueidentifier],
	@AccountID [uniqueidentifier],
	@PasswordResetCode [nvarchar](50)
AS
Update PasswordResetRequest 
Set PasswordResetRequestID = @PasswordResetRequestID, 
PasswordResetCode = @PasswordResetCode 
Where  AccountID = @AccountID
GO
/****** Object:  StoredProcedure [dbo].[UpdatePersonByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdatePersonByPrimaryKey]
	@PersonID [uniqueidentifier],
	@PersonFirstName [nvarchar](255),
	@PersonLastName [nvarchar](255),
	@PersonMiddleInitials [nvarchar](50),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Person 
Set PersonFirstName = @PersonFirstName, 
PersonLastName = @PersonLastName, 
PersonMiddleInitials = @PersonMiddleInitials, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  PersonID = @PersonID
GO
/****** Object:  StoredProcedure [dbo].[UpdatePhoneNumberTypeByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdatePhoneNumberTypeByPrimaryKey]
	@PhoneNumberTypeID [uniqueidentifier],
	@PhoneNumberTypeDescription [nvarchar](50),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update PhoneNumberType 
Set PhoneNumberTypeDescription = @PhoneNumberTypeDescription, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  PhoneNumberTypeID = @PhoneNumberTypeID
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmailAddressByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateEmailAddressByPrimaryKey]
	@EmailAddressID [uniqueidentifier],
	@EmailAddress [nvarchar](500),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update EmailAddress 
Set EmailAddress = @EmailAddress, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  EmailAddressID = @EmailAddressID
GO
/****** Object:  StoredProcedure [dbo].[UpdateContentTypeByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateContentTypeByPrimaryKey]
	@ContentTypeID [uniqueidentifier],
	@ContentTypeDescription [nvarchar](500),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update ContentType 
Set ContentTypeDescription = @ContentTypeDescription, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  ContentTypeID = @ContentTypeID
GO
/****** Object:  StoredProcedure [dbo].[UpdateBlogByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateBlogByPrimaryKey]
	@BlogID [uniqueidentifier],
	@ProfileIDOwner [uniqueidentifier],
	@BlogName [nvarchar](500),
	@BlogDescription [nvarchar](max),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Blog 
Set ProfileIDOwner = @ProfileIDOwner, 
BlogName = @BlogName, 
BlogDescription = @BlogDescription, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  BlogID = @BlogID
GO
/****** Object:  StoredProcedure [dbo].[UpdateAddressTypeByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateAddressTypeByPrimaryKey]
	@AddressTypeID [uniqueidentifier],
	@AddressTypeDescription [nvarchar](50),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update AddressType 
Set AddressTypeDescription = @AddressTypeDescription, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  AddressTypeID = @AddressTypeID
GO
/****** Object:  Table [dbo].[Profile]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profile](
	[ProfileID] [uniqueidentifier] NOT NULL,
	[ProfileTypeID] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Profile_1] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Library]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Library](
	[LibraryID] [uniqueidentifier] NOT NULL,
	[LibraryName] [nvarchar](255) NOT NULL,
	[LibraryDescription] [nvarchar](500) NOT NULL,
	[ContentTypeID] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Library] PRIMARY KEY CLUSTERED 
(
	[LibraryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[InsertWebsiteLink]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertWebsiteLink]
	@WebsiteLinkID [uniqueidentifier] OUTPUT,
	@WebsiteLinkURL [nvarchar](500),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into WebsiteLink 
( WebsiteLinkID, WebsiteLinkURL, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @WebsiteLinkID, @WebsiteLinkURL, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertSearchTerm]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertSearchTerm]
	@SearchTermID [uniqueidentifier],
	@SearchTerm [nvarchar](255) OUTPUT,
	@Count [int],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into SearchTerm 
( SearchTermID, SearchTerm, Count, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @SearchTermID, @SearchTerm, @Count, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertProfileType]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertProfileType]
	@ProfileTypeID [uniqueidentifier] OUTPUT,
	@ProfileName [nvarchar](255),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into ProfileType 
( ProfileTypeID, ProfileName, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @ProfileTypeID, @ProfileName, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  Table [dbo].[PhoneNumber]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneNumber](
	[PhoneNumberID] [uniqueidentifier] NOT NULL,
	[PhoneNumberTypeID] [uniqueidentifier] NOT NULL,
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_PhoneNumber_1] PRIMARY KEY CLUSTERED 
(
	[PhoneNumberID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[InsertPerson]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertPerson]
	@PersonID [uniqueidentifier] OUTPUT,
	@PersonFirstName [nvarchar](255),
	@PersonLastName [nvarchar](255),
	@PersonMiddleInitials [nvarchar](50),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Person 
( PersonID, PersonFirstName, PersonLastName, PersonMiddleInitials, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @PersonID, @PersonFirstName, @PersonLastName, @PersonMiddleInitials, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertPasswordResetRequest]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertPasswordResetRequest]
	@PasswordResetRequestID [uniqueidentifier],
	@AccountID [uniqueidentifier] OUTPUT,
	@PasswordResetCode [nvarchar](50)
AS
Insert Into PasswordResetRequest 
( PasswordResetRequestID, AccountID, PasswordResetCode)
Values ( @PasswordResetRequestID, @AccountID, @PasswordResetCode)
GO
/****** Object:  StoredProcedure [dbo].[InsertPhoneNumberType]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertPhoneNumberType]
	@PhoneNumberTypeID [uniqueidentifier] OUTPUT,
	@PhoneNumberTypeDescription [nvarchar](50),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into PhoneNumberType 
( PhoneNumberTypeID, PhoneNumberTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @PhoneNumberTypeID, @PhoneNumberTypeDescription, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertEmailAddress]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertEmailAddress]
	@EmailAddressID [uniqueidentifier] OUTPUT,
	@EmailAddress [nvarchar](500),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into EmailAddress 
( EmailAddressID, EmailAddress, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @EmailAddressID, @EmailAddress, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertContentType]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertContentType]
	@ContentTypeID [uniqueidentifier] OUTPUT,
	@ContentTypeDescription [nvarchar](500),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into ContentType 
( ContentTypeID, ContentTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @ContentTypeID, @ContentTypeDescription, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertBlog]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertBlog]
	@BlogID [uniqueidentifier] OUTPUT,
	@ProfileIDOwner [uniqueidentifier],
	@BlogName [nvarchar](500),
	@BlogDescription [nvarchar](max),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Blog 
( BlogID, ProfileIDOwner, BlogName, BlogDescription, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @BlogID, @ProfileIDOwner, @BlogName, @BlogDescription, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertAddressType]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertAddressType]
	@AddressTypeID [uniqueidentifier] OUTPUT,
	@AddressTypeDescription [nvarchar](50),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into AddressType 
( AddressTypeID, AddressTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @AddressTypeID, @AddressTypeDescription, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertAccount]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertAccount]
	@AccountID [uniqueidentifier] OUTPUT,
	@AccountCode [nvarchar](255),
	@AccountUsername [nvarchar](255),
	@AccountPassword [nvarchar](1024),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Account 
( AccountID, AccountCode, AccountUsername, AccountPassword, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @AccountID, @AccountCode, @AccountUsername, @AccountPassword, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[GetWebsiteLinkByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetWebsiteLinkByPrimaryKey]
	@WebsiteLinkID [uniqueidentifier]
AS
Select WebsiteLinkID, WebsiteLinkURL, Deleted, InsertedDateTime, ModifiedDateTime
From WebsiteLink 
Where  WebsiteLinkID = @WebsiteLinkID
GO
/****** Object:  StoredProcedure [dbo].[GetWebsiteLinkByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetWebsiteLinkByCriteriaFuzzy]
	@WebsiteLinkID [uniqueidentifier] = null,
	@WebsiteLinkURL [nvarchar](500) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select WebsiteLinkID, WebsiteLinkURL, Deleted, InsertedDateTime, ModifiedDateTime
From WebsiteLink 
Where ( WebsiteLinkID = @WebsiteLinkID Or @WebsiteLinkID = null ) 
And ( WebsiteLinkURL Like @WebsiteLinkURL + '%' Or @WebsiteLinkURL = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetWebsiteLinkByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetWebsiteLinkByCriteriaExact]
	@WebsiteLinkID [uniqueidentifier] = null,
	@WebsiteLinkURL [nvarchar](500) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select WebsiteLinkID, WebsiteLinkURL, Deleted, InsertedDateTime, ModifiedDateTime
From WebsiteLink 
Where ( WebsiteLinkID = @WebsiteLinkID Or @WebsiteLinkID = null ) 
And ( WebsiteLinkURL = @WebsiteLinkURL Or @WebsiteLinkURL = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetPhoneNumberTypeByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPhoneNumberTypeByPrimaryKey]
	@PhoneNumberTypeID [uniqueidentifier]
AS
Select PhoneNumberTypeID, PhoneNumberTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime
From PhoneNumberType 
Where  PhoneNumberTypeID = @PhoneNumberTypeID
GO
/****** Object:  StoredProcedure [dbo].[GetPhoneNumberTypeByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPhoneNumberTypeByCriteriaFuzzy]
	@PhoneNumberTypeID [uniqueidentifier] = null,
	@PhoneNumberTypeDescription [nvarchar](50) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select PhoneNumberTypeID, PhoneNumberTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime
From PhoneNumberType 
Where ( PhoneNumberTypeID = @PhoneNumberTypeID Or @PhoneNumberTypeID = null ) 
And ( PhoneNumberTypeDescription Like @PhoneNumberTypeDescription + '%' Or @PhoneNumberTypeDescription = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetPhoneNumberTypeByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPhoneNumberTypeByCriteriaExact]
	@PhoneNumberTypeID [uniqueidentifier] = null,
	@PhoneNumberTypeDescription [nvarchar](50) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select PhoneNumberTypeID, PhoneNumberTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime
From PhoneNumberType 
Where ( PhoneNumberTypeID = @PhoneNumberTypeID Or @PhoneNumberTypeID = null ) 
And ( PhoneNumberTypeDescription = @PhoneNumberTypeDescription Or @PhoneNumberTypeDescription = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetPhoneNumberType]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPhoneNumberType]
AS
Select PhoneNumberTypeID, PhoneNumberTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime
From PhoneNumberType
GO
/****** Object:  StoredProcedure [dbo].[GetWebsiteLink]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetWebsiteLink]
AS
Select WebsiteLinkID, WebsiteLinkURL, Deleted, InsertedDateTime, ModifiedDateTime
From WebsiteLink
GO
/****** Object:  StoredProcedure [dbo].[GetSearchTermByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetSearchTermByPrimaryKey]
	@SearchTerm [nvarchar](255)
AS
Select SearchTermID, SearchTerm, Count, Deleted, InsertedDateTime, ModifiedDateTime
From SearchTerm 
Where  SearchTerm = @SearchTerm
GO
/****** Object:  StoredProcedure [dbo].[GetSearchTermByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetSearchTermByCriteriaFuzzy]
	@SearchTermID [uniqueidentifier] = null,
	@SearchTerm [nvarchar](255) = null,
	@Count [int] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select SearchTermID, SearchTerm, Count, Deleted, InsertedDateTime, ModifiedDateTime
From SearchTerm 
Where ( SearchTermID = @SearchTermID Or @SearchTermID = null ) 
And ( SearchTerm Like @SearchTerm + '%' Or @SearchTerm = null ) 
And ( Count = @Count Or @Count = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetSearchTermByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetSearchTermByCriteriaExact]
	@SearchTermID [uniqueidentifier] = null,
	@SearchTerm [nvarchar](255) = null,
	@Count [int] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select SearchTermID, SearchTerm, Count, Deleted, InsertedDateTime, ModifiedDateTime
From SearchTerm 
Where ( SearchTermID = @SearchTermID Or @SearchTermID = null ) 
And ( SearchTerm = @SearchTerm Or @SearchTerm = null ) 
And ( Count = @Count Or @Count = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetSearchTerm]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetSearchTerm]
AS
Select SearchTermID, SearchTerm, Count, Deleted, InsertedDateTime, ModifiedDateTime
From SearchTerm
GO
/****** Object:  StoredProcedure [dbo].[GetProfileTypeByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfileTypeByPrimaryKey]
	@ProfileTypeID [uniqueidentifier]
AS
Select ProfileTypeID, ProfileName, Deleted, InsertedDateTime, ModifiedDateTime
From ProfileType 
Where  ProfileTypeID = @ProfileTypeID
GO
/****** Object:  StoredProcedure [dbo].[GetProfileTypeByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfileTypeByCriteriaFuzzy]
	@ProfileTypeID [uniqueidentifier] = null,
	@ProfileName [nvarchar](255) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select ProfileTypeID, ProfileName, Deleted, InsertedDateTime, ModifiedDateTime
From ProfileType 
Where ( ProfileTypeID = @ProfileTypeID Or @ProfileTypeID = null ) 
And ( ProfileName Like @ProfileName + '%' Or @ProfileName = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfileTypeByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfileTypeByCriteriaExact]
	@ProfileTypeID [uniqueidentifier] = null,
	@ProfileName [nvarchar](255) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select ProfileTypeID, ProfileName, Deleted, InsertedDateTime, ModifiedDateTime
From ProfileType 
Where ( ProfileTypeID = @ProfileTypeID Or @ProfileTypeID = null ) 
And ( ProfileName = @ProfileName Or @ProfileName = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfileType]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfileType]
AS
Select ProfileTypeID, ProfileName, Deleted, InsertedDateTime, ModifiedDateTime
From ProfileType
GO
/****** Object:  StoredProcedure [dbo].[GetPerson]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPerson]
AS
Select PersonID, PersonFirstName, PersonLastName, PersonMiddleInitials, Deleted, InsertedDateTime, ModifiedDateTime
From Person
GO
/****** Object:  StoredProcedure [dbo].[GetPasswordResetRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPasswordResetRequestByPrimaryKey]
	@AccountID [uniqueidentifier]
AS
Select PasswordResetRequestID, AccountID, PasswordResetCode
From PasswordResetRequest 
Where  AccountID = @AccountID
GO
/****** Object:  StoredProcedure [dbo].[GetPasswordResetRequestByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPasswordResetRequestByCriteriaFuzzy]
	@PasswordResetRequestID [uniqueidentifier] = null,
	@AccountID [uniqueidentifier] = null,
	@PasswordResetCode [nvarchar](50) = null
AS
Select PasswordResetRequestID, AccountID, PasswordResetCode
From PasswordResetRequest 
Where ( PasswordResetRequestID = @PasswordResetRequestID Or @PasswordResetRequestID = null ) 
And ( AccountID = @AccountID Or @AccountID = null ) 
And ( PasswordResetCode Like @PasswordResetCode + '%' Or @PasswordResetCode = null )
GO
/****** Object:  StoredProcedure [dbo].[GetPasswordResetRequestByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPasswordResetRequestByCriteriaExact]
	@PasswordResetRequestID [uniqueidentifier] = null,
	@AccountID [uniqueidentifier] = null,
	@PasswordResetCode [nvarchar](50) = null
AS
Select PasswordResetRequestID, AccountID, PasswordResetCode
From PasswordResetRequest 
Where ( PasswordResetRequestID = @PasswordResetRequestID Or @PasswordResetRequestID = null ) 
And ( AccountID = @AccountID Or @AccountID = null ) 
And ( PasswordResetCode = @PasswordResetCode Or @PasswordResetCode = null )
GO
/****** Object:  StoredProcedure [dbo].[GetPasswordResetRequest]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPasswordResetRequest]
AS
Select PasswordResetRequestID, AccountID, PasswordResetCode
From PasswordResetRequest
GO
/****** Object:  StoredProcedure [dbo].[GetPersonByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPersonByPrimaryKey]
	@PersonID [uniqueidentifier]
AS
Select PersonID, PersonFirstName, PersonLastName, PersonMiddleInitials, Deleted, InsertedDateTime, ModifiedDateTime
From Person 
Where  PersonID = @PersonID
GO
/****** Object:  StoredProcedure [dbo].[GetPersonByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPersonByCriteriaFuzzy]
	@PersonID [uniqueidentifier] = null,
	@PersonFirstName [nvarchar](255) = null,
	@PersonLastName [nvarchar](255) = null,
	@PersonMiddleInitials [nvarchar](50) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select PersonID, PersonFirstName, PersonLastName, PersonMiddleInitials, Deleted, InsertedDateTime, ModifiedDateTime
From Person 
Where ( PersonID = @PersonID Or @PersonID = null ) 
And ( PersonFirstName Like @PersonFirstName + '%' Or @PersonFirstName = null ) 
And ( PersonLastName Like @PersonLastName + '%' Or @PersonLastName = null ) 
And ( PersonMiddleInitials Like @PersonMiddleInitials + '%' Or @PersonMiddleInitials = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetPersonByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPersonByCriteriaExact]
	@PersonID [uniqueidentifier] = null,
	@PersonFirstName [nvarchar](255) = null,
	@PersonLastName [nvarchar](255) = null,
	@PersonMiddleInitials [nvarchar](50) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select PersonID, PersonFirstName, PersonLastName, PersonMiddleInitials, Deleted, InsertedDateTime, ModifiedDateTime
From Person 
Where ( PersonID = @PersonID Or @PersonID = null ) 
And ( PersonFirstName = @PersonFirstName Or @PersonFirstName = null ) 
And ( PersonLastName = @PersonLastName Or @PersonLastName = null ) 
And ( PersonMiddleInitials = @PersonMiddleInitials Or @PersonMiddleInitials = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetInformationSchema]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetInformationSchema]
	@TableName [nvarchar](255) = null
AS


if (@TableName is null)
	begin
		Exec GetInformationSchemaTables
		Exec GetInformationSchemaTableConstraints
		Exec GetInformationSchemaColumns
		Exec GetInformationSchemaColumnUsage
   end

if(@TableName is not null)
	begin
		Exec GetInformationSchemaTables @TableName
		Exec GetInformationSchemaTableConstraints @TableName
		Exec GetInformationSchemaColumns @TableName
		Exec GetInformationSchemaColumnUsage @TableName
    end
GO
/****** Object:  StoredProcedure [dbo].[GetEmailAddressByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetEmailAddressByPrimaryKey]
	@EmailAddressID [uniqueidentifier]
AS
Select EmailAddressID, EmailAddress, Deleted, InsertedDateTime, ModifiedDateTime
From EmailAddress 
Where  EmailAddressID = @EmailAddressID
GO
/****** Object:  StoredProcedure [dbo].[GetEmailAddressByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetEmailAddressByCriteriaFuzzy]
	@EmailAddressID [uniqueidentifier] = null,
	@EmailAddress [nvarchar](500) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select EmailAddressID, EmailAddress, Deleted, InsertedDateTime, ModifiedDateTime
From EmailAddress 
Where ( EmailAddressID = @EmailAddressID Or @EmailAddressID = null ) 
And ( EmailAddress Like @EmailAddress + '%' Or @EmailAddress = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetEmailAddressByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetEmailAddressByCriteriaExact]
	@EmailAddressID [uniqueidentifier] = null,
	@EmailAddress [nvarchar](500) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select EmailAddressID, EmailAddress, Deleted, InsertedDateTime, ModifiedDateTime
From EmailAddress 
Where ( EmailAddressID = @EmailAddressID Or @EmailAddressID = null ) 
And ( EmailAddress = @EmailAddress Or @EmailAddress = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetEmailAddress]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetEmailAddress]
AS
Select EmailAddressID, EmailAddress, Deleted, InsertedDateTime, ModifiedDateTime
From EmailAddress
GO
/****** Object:  StoredProcedure [dbo].[GetContentTypeByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentTypeByPrimaryKey]
	@ContentTypeID [uniqueidentifier]
AS
Select ContentTypeID, ContentTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime
From ContentType 
Where  ContentTypeID = @ContentTypeID
GO
/****** Object:  StoredProcedure [dbo].[GetContentTypeByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentTypeByCriteriaFuzzy]
	@ContentTypeID [uniqueidentifier] = null,
	@ContentTypeDescription [nvarchar](500) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select ContentTypeID, ContentTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime
From ContentType 
Where ( ContentTypeID = @ContentTypeID Or @ContentTypeID = null ) 
And ( ContentTypeDescription Like @ContentTypeDescription + '%' Or @ContentTypeDescription = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetContentTypeByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentTypeByCriteriaExact]
	@ContentTypeID [uniqueidentifier] = null,
	@ContentTypeDescription [nvarchar](500) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select ContentTypeID, ContentTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime
From ContentType 
Where ( ContentTypeID = @ContentTypeID Or @ContentTypeID = null ) 
And ( ContentTypeDescription = @ContentTypeDescription Or @ContentTypeDescription = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetContentType]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentType]
AS
Select ContentTypeID, ContentTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime
From ContentType
GO
/****** Object:  StoredProcedure [dbo].[GetAccountByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAccountByPrimaryKey]
	@AccountID [uniqueidentifier]
AS
Select AccountID, AccountCode, AccountUsername, AccountPassword, Deleted, InsertedDateTime, ModifiedDateTime
From Account 
Where  AccountID = @AccountID
GO
/****** Object:  StoredProcedure [dbo].[GetAccountByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAccountByCriteriaFuzzy]
	@AccountID [uniqueidentifier] = null,
	@AccountCode [nvarchar](255) = null,
	@AccountUsername [nvarchar](255) = null,
	@AccountPassword [nvarchar](1024) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select AccountID, AccountCode, AccountUsername, AccountPassword, Deleted, InsertedDateTime, ModifiedDateTime
From Account 
Where ( AccountID = @AccountID Or @AccountID = null ) 
And ( AccountCode Like @AccountCode + '%' Or @AccountCode = null ) 
And ( AccountUsername Like @AccountUsername + '%' Or @AccountUsername = null ) 
And ( AccountPassword Like @AccountPassword + '%' Or @AccountPassword = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetAccountByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAccountByCriteriaExact]
	@AccountID [uniqueidentifier] = null,
	@AccountCode [nvarchar](255) = null,
	@AccountUsername [nvarchar](255) = null,
	@AccountPassword [nvarchar](1024) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select AccountID, AccountCode, AccountUsername, AccountPassword, Deleted, InsertedDateTime, ModifiedDateTime
From Account 
Where ( AccountID = @AccountID Or @AccountID = null ) 
And ( AccountCode = @AccountCode Or @AccountCode = null ) 
And ( AccountUsername = @AccountUsername Or @AccountUsername = null ) 
And ( AccountPassword = @AccountPassword Or @AccountPassword = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetAccount]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAccount]
AS
Select AccountID, AccountCode, AccountUsername, AccountPassword, Deleted, InsertedDateTime, ModifiedDateTime
From Account
GO
/****** Object:  StoredProcedure [dbo].[GetBlogByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetBlogByPrimaryKey]
	@BlogID [uniqueidentifier]
AS
Select BlogID, ProfileIDOwner, BlogName, BlogDescription, Deleted, InsertedDateTime, ModifiedDateTime
From Blog 
Where  BlogID = @BlogID
GO
/****** Object:  StoredProcedure [dbo].[GetBlogByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetBlogByCriteriaFuzzy]
	@BlogID [uniqueidentifier] = null,
	@ProfileIDOwner [uniqueidentifier] = null,
	@BlogName [nvarchar](500) = null,
	@BlogDescription [nvarchar](max) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select BlogID, ProfileIDOwner, BlogName, BlogDescription, Deleted, InsertedDateTime, ModifiedDateTime
From Blog 
Where ( BlogID = @BlogID Or @BlogID = null ) 
And ( ProfileIDOwner = @ProfileIDOwner Or @ProfileIDOwner = null ) 
And ( BlogName Like @BlogName + '%' Or @BlogName = null ) 
And ( BlogDescription Like @BlogDescription + '%' Or @BlogDescription = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetBlogByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetBlogByCriteriaExact]
	@BlogID [uniqueidentifier] = null,
	@ProfileIDOwner [uniqueidentifier] = null,
	@BlogName [nvarchar](500) = null,
	@BlogDescription [nvarchar](max) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select BlogID, ProfileIDOwner, BlogName, BlogDescription, Deleted, InsertedDateTime, ModifiedDateTime
From Blog 
Where ( BlogID = @BlogID Or @BlogID = null ) 
And ( ProfileIDOwner = @ProfileIDOwner Or @ProfileIDOwner = null ) 
And ( BlogName = @BlogName Or @BlogName = null ) 
And ( BlogDescription = @BlogDescription Or @BlogDescription = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[DeletePhoneNumberTypeByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeletePhoneNumberTypeByPrimaryKey]
	@PhoneNumberTypeID [uniqueidentifier]
AS
Delete From PhoneNumberType 
Where  PhoneNumberTypeID = @PhoneNumberTypeID
GO
/****** Object:  StoredProcedure [dbo].[DeleteAccountByPrimaryKey]    Script Date: 12/30/2011 08:48:38 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteAccountByPrimaryKey]
	@AccountID [uniqueidentifier]
AS
Delete From Account 
Where  AccountID = @AccountID
GO
/****** Object:  StoredProcedure [dbo].[DeleteWebsiteLinkByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteWebsiteLinkByPrimaryKey]
	@WebsiteLinkID [uniqueidentifier]
AS
Delete From WebsiteLink 
Where  WebsiteLinkID = @WebsiteLinkID
GO
/****** Object:  StoredProcedure [dbo].[GetBlog]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetBlog]
AS
Select BlogID, ProfileIDOwner, BlogName, BlogDescription, Deleted, InsertedDateTime, ModifiedDateTime
From Blog
GO
/****** Object:  StoredProcedure [dbo].[GetAddressTypeByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAddressTypeByPrimaryKey]
	@AddressTypeID [uniqueidentifier]
AS
Select AddressTypeID, AddressTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime
From AddressType 
Where  AddressTypeID = @AddressTypeID
GO
/****** Object:  StoredProcedure [dbo].[GetAddressTypeByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAddressTypeByCriteriaFuzzy]
	@AddressTypeID [uniqueidentifier] = null,
	@AddressTypeDescription [nvarchar](50) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select AddressTypeID, AddressTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime
From AddressType 
Where ( AddressTypeID = @AddressTypeID Or @AddressTypeID = null ) 
And ( AddressTypeDescription Like @AddressTypeDescription + '%' Or @AddressTypeDescription = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetAddressTypeByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAddressTypeByCriteriaExact]
	@AddressTypeID [uniqueidentifier] = null,
	@AddressTypeDescription [nvarchar](50) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select AddressTypeID, AddressTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime
From AddressType 
Where ( AddressTypeID = @AddressTypeID Or @AddressTypeID = null ) 
And ( AddressTypeDescription = @AddressTypeDescription Or @AddressTypeDescription = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetAddressType]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAddressType]
AS
Select AddressTypeID, AddressTypeDescription, Deleted, InsertedDateTime, ModifiedDateTime
From AddressType
GO
/****** Object:  StoredProcedure [dbo].[DeleteSearchTermByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteSearchTermByPrimaryKey]
	@SearchTerm [nvarchar](255)
AS
Delete From SearchTerm 
Where  SearchTerm = @SearchTerm
GO
/****** Object:  StoredProcedure [dbo].[DeleteProfileTypeByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteProfileTypeByPrimaryKey]
	@ProfileTypeID [uniqueidentifier]
AS
Delete From ProfileType 
Where  ProfileTypeID = @ProfileTypeID
GO
/****** Object:  StoredProcedure [dbo].[DeletePasswordResetRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeletePasswordResetRequestByPrimaryKey]
	@AccountID [uniqueidentifier]
AS
Delete From PasswordResetRequest 
Where  AccountID = @AccountID
GO
/****** Object:  StoredProcedure [dbo].[DeletePersonByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeletePersonByPrimaryKey]
	@PersonID [uniqueidentifier]
AS
Delete From Person 
Where  PersonID = @PersonID
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmailAddressByPrimaryKey]    Script Date: 12/30/2011 08:48:38 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteEmailAddressByPrimaryKey]
	@EmailAddressID [uniqueidentifier]
AS
Delete From EmailAddress 
Where  EmailAddressID = @EmailAddressID
GO
/****** Object:  StoredProcedure [dbo].[DeleteContentTypeByPrimaryKey]    Script Date: 12/30/2011 08:48:38 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteContentTypeByPrimaryKey]
	@ContentTypeID [uniqueidentifier]
AS
Delete From ContentType 
Where  ContentTypeID = @ContentTypeID
GO
/****** Object:  StoredProcedure [dbo].[DeleteBlogByPrimaryKey]    Script Date: 12/30/2011 08:48:38 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteBlogByPrimaryKey]
	@BlogID [uniqueidentifier]
AS
Delete From Blog 
Where  BlogID = @BlogID
GO
/****** Object:  StoredProcedure [dbo].[DeleteAddressTypeByPrimaryKey]    Script Date: 12/30/2011 08:48:38 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteAddressTypeByPrimaryKey]
	@AddressTypeID [uniqueidentifier]
AS
Delete From AddressType 
Where  AddressTypeID = @AddressTypeID
GO
/****** Object:  Table [dbo].[Address]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[AddressID] [uniqueidentifier] NOT NULL,
	[AddressTypeID] [uniqueidentifier] NOT NULL,
	[AddressStreet] [nvarchar](500) NOT NULL,
	[AddressCity] [nvarchar](500) NOT NULL,
	[AddressZipCode] [nvarchar](50) NOT NULL,
	[AddressCountry] [nvarchar](50) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Address_1] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Content]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Content](
	[ContentID] [uniqueidentifier] NOT NULL,
	[ContentTypeID] [uniqueidentifier] NOT NULL,
	[ContentPayload] [varbinary](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Content] PRIMARY KEY CLUSTERED 
(
	[ContentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BlogAccessRequest]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogAccessRequest](
	[BlogAccessRequestID] [uniqueidentifier] NOT NULL,
	[ProfileIDChild] [uniqueidentifier] NOT NULL,
	[ProfileIDParent] [uniqueidentifier] NOT NULL,
	[ProfileIDOtherProfile] [uniqueidentifier] NOT NULL,
	[BlogID] [uniqueidentifier] NOT NULL,
	[Approved] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_BlogAccessRequest_1] PRIMARY KEY CLUSTERED 
(
	[ProfileIDChild] ASC,
	[ProfileIDParent] ASC,
	[ProfileIDOtherProfile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContentTag]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentTag](
	[ContentTagID] [uniqueidentifier] NOT NULL,
	[ContentID] [uniqueidentifier] NOT NULL,
	[Tag] [nvarchar](255) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_ContentTag] PRIMARY KEY CLUSTERED 
(
	[ContentID] ASC,
	[Tag] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContentAccessRequest]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentAccessRequest](
	[ContentAccessRequestID] [uniqueidentifier] NOT NULL,
	[ProfileIDOtherProfile] [uniqueidentifier] NOT NULL,
	[ProfileIDParent] [uniqueidentifier] NOT NULL,
	[ProfileIDChild] [uniqueidentifier] NOT NULL,
	[ContentID] [uniqueidentifier] NOT NULL,
	[Approved] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_ContentAccessRequest_1] PRIMARY KEY CLUSTERED 
(
	[ProfileIDOtherProfile] ASC,
	[ProfileIDParent] ASC,
	[ProfileIDChild] ASC,
	[ContentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[DeleteAddressByPrimaryKey]    Script Date: 12/30/2011 08:48:38 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteAddressByPrimaryKey]
	@AddressID [uniqueidentifier]
AS
Delete From Address 
Where  AddressID = @AddressID
GO
/****** Object:  StoredProcedure [dbo].[DeleteContentByPrimaryKey]    Script Date: 12/30/2011 08:48:38 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteContentByPrimaryKey]
	@ContentID [uniqueidentifier]
AS
Delete From Content 
Where  ContentID = @ContentID
GO
/****** Object:  StoredProcedure [dbo].[DeleteLibraryByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteLibraryByPrimaryKey]
	@LibraryID [uniqueidentifier]
AS
Delete From Library 
Where  LibraryID = @LibraryID
GO
/****** Object:  StoredProcedure [dbo].[DeleteProfileByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteProfileByPrimaryKey]
	@ProfileID [uniqueidentifier]
AS
Delete From Profile 
Where  ProfileID = @ProfileID
GO
/****** Object:  StoredProcedure [dbo].[GetAddressByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAddressByPrimaryKey]
	@AddressID [uniqueidentifier]
AS
Select AddressID, AddressTypeID, AddressStreet, AddressCity, AddressZipCode, AddressCountry, Deleted, InsertedDateTime, ModifiedDateTime
From Address 
Where  AddressID = @AddressID
GO
/****** Object:  StoredProcedure [dbo].[GetAddressByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAddressByCriteriaFuzzy]
	@AddressID [uniqueidentifier] = null,
	@AddressTypeID [uniqueidentifier] = null,
	@AddressStreet [nvarchar](500) = null,
	@AddressCity [nvarchar](500) = null,
	@AddressZipCode [nvarchar](50) = null,
	@AddressCountry [nvarchar](50) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select AddressID, AddressTypeID, AddressStreet, AddressCity, AddressZipCode, AddressCountry, Deleted, InsertedDateTime, ModifiedDateTime
From Address 
Where ( AddressID = @AddressID Or @AddressID = null ) 
And ( AddressTypeID = @AddressTypeID Or @AddressTypeID = null ) 
And ( AddressStreet Like @AddressStreet + '%' Or @AddressStreet = null ) 
And ( AddressCity Like @AddressCity + '%' Or @AddressCity = null ) 
And ( AddressZipCode Like @AddressZipCode + '%' Or @AddressZipCode = null ) 
And ( AddressCountry Like @AddressCountry + '%' Or @AddressCountry = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetAddressByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAddressByCriteriaExact]
	@AddressID [uniqueidentifier] = null,
	@AddressTypeID [uniqueidentifier] = null,
	@AddressStreet [nvarchar](500) = null,
	@AddressCity [nvarchar](500) = null,
	@AddressZipCode [nvarchar](50) = null,
	@AddressCountry [nvarchar](50) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select AddressID, AddressTypeID, AddressStreet, AddressCity, AddressZipCode, AddressCountry, Deleted, InsertedDateTime, ModifiedDateTime
From Address 
Where ( AddressID = @AddressID Or @AddressID = null ) 
And ( AddressTypeID = @AddressTypeID Or @AddressTypeID = null ) 
And ( AddressStreet = @AddressStreet Or @AddressStreet = null ) 
And ( AddressCity = @AddressCity Or @AddressCity = null ) 
And ( AddressZipCode = @AddressZipCode Or @AddressZipCode = null ) 
And ( AddressCountry = @AddressCountry Or @AddressCountry = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetAddress]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAddress]
AS
Select AddressID, AddressTypeID, AddressStreet, AddressCity, AddressZipCode, AddressCountry, Deleted, InsertedDateTime, ModifiedDateTime
From Address
GO
/****** Object:  StoredProcedure [dbo].[GetContent]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContent]
AS
Select ContentID, ContentTypeID, ContentPayload, Deleted, InsertedDateTime, ModifiedDateTime
From Content
GO
/****** Object:  StoredProcedure [dbo].[DeletePhoneNumberByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeletePhoneNumberByPrimaryKey]
	@PhoneNumberID [uniqueidentifier]
AS
Delete From PhoneNumber 
Where  PhoneNumberID = @PhoneNumberID
GO
/****** Object:  StoredProcedure [dbo].[GetContentByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentByPrimaryKey]
	@ContentID [uniqueidentifier]
AS
Select ContentID, ContentTypeID, ContentPayload, Deleted, InsertedDateTime, ModifiedDateTime
From Content 
Where  ContentID = @ContentID
GO
/****** Object:  StoredProcedure [dbo].[GetContentByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentByCriteriaFuzzy]
	@ContentID [uniqueidentifier] = null,
	@ContentTypeID [uniqueidentifier] = null,
	@ContentPayload [varbinary](max) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select ContentID, ContentTypeID, ContentPayload, Deleted, InsertedDateTime, ModifiedDateTime
From Content 
Where ( ContentID = @ContentID Or @ContentID = null ) 
And ( ContentTypeID = @ContentTypeID Or @ContentTypeID = null ) 
And ( ContentPayload = @ContentPayload Or @ContentPayload = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetContentByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentByCriteriaExact]
	@ContentID [uniqueidentifier] = null,
	@ContentTypeID [uniqueidentifier] = null,
	@ContentPayload [varbinary](max) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select ContentID, ContentTypeID, ContentPayload, Deleted, InsertedDateTime, ModifiedDateTime
From Content 
Where ( ContentID = @ContentID Or @ContentID = null ) 
And ( ContentTypeID = @ContentTypeID Or @ContentTypeID = null ) 
And ( ContentPayload = @ContentPayload Or @ContentPayload = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetLibraryByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLibraryByPrimaryKey]
	@LibraryID [uniqueidentifier]
AS
Select LibraryID, LibraryName, LibraryDescription, ContentTypeID, Deleted, InsertedDateTime, ModifiedDateTime
From Library 
Where  LibraryID = @LibraryID
GO
/****** Object:  StoredProcedure [dbo].[GetLibraryByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLibraryByCriteriaFuzzy]
	@LibraryID [uniqueidentifier] = null,
	@LibraryName [nvarchar](255) = null,
	@LibraryDescription [nvarchar](500) = null,
	@ContentTypeID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select LibraryID, LibraryName, LibraryDescription, ContentTypeID, Deleted, InsertedDateTime, ModifiedDateTime
From Library 
Where ( LibraryID = @LibraryID Or @LibraryID = null ) 
And ( LibraryName Like @LibraryName + '%' Or @LibraryName = null ) 
And ( LibraryDescription Like @LibraryDescription + '%' Or @LibraryDescription = null ) 
And ( ContentTypeID = @ContentTypeID Or @ContentTypeID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetLibraryByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLibraryByCriteriaExact]
	@LibraryID [uniqueidentifier] = null,
	@LibraryName [nvarchar](255) = null,
	@LibraryDescription [nvarchar](500) = null,
	@ContentTypeID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select LibraryID, LibraryName, LibraryDescription, ContentTypeID, Deleted, InsertedDateTime, ModifiedDateTime
From Library 
Where ( LibraryID = @LibraryID Or @LibraryID = null ) 
And ( LibraryName = @LibraryName Or @LibraryName = null ) 
And ( LibraryDescription = @LibraryDescription Or @LibraryDescription = null ) 
And ( ContentTypeID = @ContentTypeID Or @ContentTypeID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfileByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfileByPrimaryKey]
	@ProfileID [uniqueidentifier]
AS
Select ProfileID, ProfileTypeID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile 
Where  ProfileID = @ProfileID
GO
/****** Object:  StoredProcedure [dbo].[GetProfileByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfileByCriteriaFuzzy]
	@ProfileID [uniqueidentifier] = null,
	@ProfileTypeID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select ProfileID, ProfileTypeID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile 
Where ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( ProfileTypeID = @ProfileTypeID Or @ProfileTypeID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfileByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfileByCriteriaExact]
	@ProfileID [uniqueidentifier] = null,
	@ProfileTypeID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select ProfileID, ProfileTypeID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile 
Where ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( ProfileTypeID = @ProfileTypeID Or @ProfileTypeID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  Table [dbo].[Parent_Child]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parent_Child](
	[Parent_ChildID] [uniqueidentifier] NOT NULL,
	[Parent_ProfileID] [uniqueidentifier] NOT NULL,
	[Child_ProfileID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Parent_Child] PRIMARY KEY CLUSTERED 
(
	[Parent_ProfileID] ASC,
	[Child_ProfileID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificationAccessRequest]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationAccessRequest](
	[NotificationAccessRequestID] [uniqueidentifier] NOT NULL,
	[ProfileIDChild] [uniqueidentifier] NOT NULL,
	[ProfileIDParent] [uniqueidentifier] NOT NULL,
	[ProfileIDOtherProfile] [uniqueidentifier] NOT NULL,
	[Approved] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_NotificationAccessRequest_1] PRIMARY KEY CLUSTERED 
(
	[ProfileIDChild] ASC,
	[ProfileIDParent] ASC,
	[ProfileIDOtherProfile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[NotificationID] [uniqueidentifier] NOT NULL,
	[ProfileIDFrom] [uniqueidentifier] NOT NULL,
	[ProfileIDTo] [uniqueidentifier] NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDatetime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LibraryAccessRequest]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibraryAccessRequest](
	[LibraryAccessRequestID] [uniqueidentifier] NOT NULL,
	[ProfileIDChild] [uniqueidentifier] NOT NULL,
	[ProfileIDParent] [uniqueidentifier] NOT NULL,
	[ProfileIDOtherProfile] [uniqueidentifier] NOT NULL,
	[LibraryID] [uniqueidentifier] NOT NULL,
	[Approved] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_LibraryAccessRequest] PRIMARY KEY CLUSTERED 
(
	[ProfileIDChild] ASC,
	[ProfileIDParent] ASC,
	[ProfileIDOtherProfile] ASC,
	[LibraryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Library_Content]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Library_Content](
	[Library_ContentID] [uniqueidentifier] NOT NULL,
	[LibraryID] [uniqueidentifier] NOT NULL,
	[ContentID] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Library_Content] PRIMARY KEY CLUSTERED 
(
	[LibraryID] ASC,
	[ContentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GetPhoneNumberByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPhoneNumberByPrimaryKey]
	@PhoneNumberID [uniqueidentifier]
AS
Select PhoneNumberID, PhoneNumberTypeID, PhoneNumber, Deleted, InsertedDateTime, ModifiedDateTime
From PhoneNumber 
Where  PhoneNumberID = @PhoneNumberID
GO
/****** Object:  StoredProcedure [dbo].[GetPhoneNumberByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPhoneNumberByCriteriaFuzzy]
	@PhoneNumberID [uniqueidentifier] = null,
	@PhoneNumberTypeID [uniqueidentifier] = null,
	@PhoneNumber [nvarchar](50) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select PhoneNumberID, PhoneNumberTypeID, PhoneNumber, Deleted, InsertedDateTime, ModifiedDateTime
From PhoneNumber 
Where ( PhoneNumberID = @PhoneNumberID Or @PhoneNumberID = null ) 
And ( PhoneNumberTypeID = @PhoneNumberTypeID Or @PhoneNumberTypeID = null ) 
And ( PhoneNumber Like @PhoneNumber + '%' Or @PhoneNumber = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetPhoneNumberByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPhoneNumberByCriteriaExact]
	@PhoneNumberID [uniqueidentifier] = null,
	@PhoneNumberTypeID [uniqueidentifier] = null,
	@PhoneNumber [nvarchar](50) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select PhoneNumberID, PhoneNumberTypeID, PhoneNumber, Deleted, InsertedDateTime, ModifiedDateTime
From PhoneNumber 
Where ( PhoneNumberID = @PhoneNumberID Or @PhoneNumberID = null ) 
And ( PhoneNumberTypeID = @PhoneNumberTypeID Or @PhoneNumberTypeID = null ) 
And ( PhoneNumber = @PhoneNumber Or @PhoneNumber = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetPhoneNumber]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPhoneNumber]
AS
Select PhoneNumberID, PhoneNumberTypeID, PhoneNumber, Deleted, InsertedDateTime, ModifiedDateTime
From PhoneNumber
GO
/****** Object:  StoredProcedure [dbo].[InsertAddress]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertAddress]
	@AddressID [uniqueidentifier] OUTPUT,
	@AddressTypeID [uniqueidentifier],
	@AddressStreet [nvarchar](500),
	@AddressCity [nvarchar](500),
	@AddressZipCode [nvarchar](50),
	@AddressCountry [nvarchar](50),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Address 
( AddressID, AddressTypeID, AddressStreet, AddressCity, AddressZipCode, AddressCountry, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @AddressID, @AddressTypeID, @AddressStreet, @AddressCity, @AddressZipCode, @AddressCountry, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[GetProfile]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile]
AS
Select ProfileID, ProfileTypeID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile
GO
/****** Object:  StoredProcedure [dbo].[GetLibrary]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLibrary]
AS
Select LibraryID, LibraryName, LibraryDescription, ContentTypeID, Deleted, InsertedDateTime, ModifiedDateTime
From Library
GO
/****** Object:  StoredProcedure [dbo].[InsertPhoneNumber]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertPhoneNumber]
	@PhoneNumberID [uniqueidentifier] OUTPUT,
	@PhoneNumberTypeID [uniqueidentifier],
	@PhoneNumber [nvarchar](50),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into PhoneNumber 
( PhoneNumberID, PhoneNumberTypeID, PhoneNumber, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @PhoneNumberID, @PhoneNumberTypeID, @PhoneNumber, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  Table [dbo].[Profile_WebsiteLink]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profile_WebsiteLink](
	[Profile_WebsiteLinkID] [uniqueidentifier] NOT NULL,
	[ProfileID] [uniqueidentifier] NOT NULL,
	[WebsiteLinkID] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Profile_WebsiteLink] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC,
	[WebsiteLinkID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profile_Person]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profile_Person](
	[Profile_PersonID] [uniqueidentifier] NOT NULL,
	[ProfileID] [uniqueidentifier] NOT NULL,
	[PersonID] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Profile_Person] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC,
	[PersonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profile_Library]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profile_Library](
	[Profile_LibraryID] [uniqueidentifier] NOT NULL,
	[ProfileID] [uniqueidentifier] NOT NULL,
	[LibraryID] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Profile_Library] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC,
	[LibraryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profile_EmailAddress]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profile_EmailAddress](
	[Profile_EmailAddressID] [uniqueidentifier] NOT NULL,
	[ProfileID] [uniqueidentifier] NOT NULL,
	[EmailAddressID] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Profile_EmailAddress] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC,
	[EmailAddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profile_Content]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profile_Content](
	[Profile_ContentID] [uniqueidentifier] NOT NULL,
	[ProfileID] [uniqueidentifier] NOT NULL,
	[ContentID] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Profile_Content] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC,
	[ContentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profile_Blog]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profile_Blog](
	[Profile_BlogID] [uniqueidentifier] NOT NULL,
	[ProfileID] [uniqueidentifier] NOT NULL,
	[BlogID] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Profile_Blog] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC,
	[BlogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profile_Account]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profile_Account](
	[Profile_AccountID] [uniqueidentifier] NOT NULL,
	[ProfileID] [uniqueidentifier] NOT NULL,
	[AccountID] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Profile_Account] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC,
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person_PhoneNumber]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person_PhoneNumber](
	[Person_PhoneNumberID] [uniqueidentifier] NOT NULL,
	[PersonID] [uniqueidentifier] NOT NULL,
	[PhoneNumberID] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Person_PhoneNumber] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC,
	[PhoneNumberID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person_Address]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person_Address](
	[Person_AddressID] [uniqueidentifier] NOT NULL,
	[PersonID] [uniqueidentifier] NOT NULL,
	[AddressID] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Person_Address] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC,
	[AddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[InsertProfile]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertProfile]
	@ProfileID [uniqueidentifier] OUTPUT,
	@ProfileTypeID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Profile 
( ProfileID, ProfileTypeID, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @ProfileID, @ProfileTypeID, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertLibrary]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertLibrary]
	@LibraryID [uniqueidentifier] OUTPUT,
	@LibraryName [nvarchar](255),
	@LibraryDescription [nvarchar](500),
	@ContentTypeID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Library 
( LibraryID, LibraryName, LibraryDescription, ContentTypeID, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @LibraryID, @LibraryName, @LibraryDescription, @ContentTypeID, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertContent]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertContent]
	@ContentID [uniqueidentifier] OUTPUT,
	@ContentTypeID [uniqueidentifier],
	@ContentPayload [varbinary](max),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Content 
( ContentID, ContentTypeID, ContentPayload, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @ContentID, @ContentTypeID, @ContentPayload, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[UpdateAddressByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateAddressByPrimaryKey]
	@AddressID [uniqueidentifier],
	@AddressTypeID [uniqueidentifier],
	@AddressStreet [nvarchar](500),
	@AddressCity [nvarchar](500),
	@AddressZipCode [nvarchar](50),
	@AddressCountry [nvarchar](50),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Address 
Set AddressTypeID = @AddressTypeID, 
AddressStreet = @AddressStreet, 
AddressCity = @AddressCity, 
AddressZipCode = @AddressZipCode, 
AddressCountry = @AddressCountry, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  AddressID = @AddressID
GO
/****** Object:  StoredProcedure [dbo].[UpdateContentByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateContentByPrimaryKey]
	@ContentID [uniqueidentifier],
	@ContentTypeID [uniqueidentifier],
	@ContentPayload [varbinary](max),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Content 
Set ContentTypeID = @ContentTypeID, 
ContentPayload = @ContentPayload, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  ContentID = @ContentID
GO
/****** Object:  StoredProcedure [dbo].[UpdateLibraryByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateLibraryByPrimaryKey]
	@LibraryID [uniqueidentifier],
	@LibraryName [nvarchar](255),
	@LibraryDescription [nvarchar](500),
	@ContentTypeID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Library 
Set LibraryName = @LibraryName, 
LibraryDescription = @LibraryDescription, 
ContentTypeID = @ContentTypeID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  LibraryID = @LibraryID
GO
/****** Object:  StoredProcedure [dbo].[UpdatePhoneNumberByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdatePhoneNumberByPrimaryKey]
	@PhoneNumberID [uniqueidentifier],
	@PhoneNumberTypeID [uniqueidentifier],
	@PhoneNumber [nvarchar](50),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update PhoneNumber 
Set PhoneNumberTypeID = @PhoneNumberTypeID, 
PhoneNumber = @PhoneNumber, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  PhoneNumberID = @PhoneNumberID
GO
/****** Object:  StoredProcedure [dbo].[UpdateProfileByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateProfileByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@ProfileTypeID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Profile 
Set ProfileTypeID = @ProfileTypeID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where  ProfileID = @ProfileID
GO
/****** Object:  Table [dbo].[WebsiteLinkAccessRequest]    Script Date: 12/30/2011 08:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebsiteLinkAccessRequest](
	[WebsiteLinkAccessRequestID] [uniqueidentifier] NOT NULL,
	[ProfileIDChild] [uniqueidentifier] NOT NULL,
	[ProfileIDParent] [uniqueidentifier] NOT NULL,
	[ProfileIDOtherProfileID] [uniqueidentifier] NOT NULL,
	[WebsiteLinkID] [uniqueidentifier] NOT NULL,
	[Approved] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_WebsiteLinkAccessRequest_1] PRIMARY KEY CLUSTERED 
(
	[ProfileIDChild] ASC,
	[ProfileIDParent] ASC,
	[ProfileIDOtherProfileID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[UpdateWebsiteLinkAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateWebsiteLinkAccessRequestByPrimaryKey]
	@WebsiteLinkAccessRequestID [uniqueidentifier],
	@ProfileIDChild [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDOtherProfileID [uniqueidentifier],
	@WebsiteLinkID [uniqueidentifier],
	@Approved [bit],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update WebsiteLinkAccessRequest 
Set WebsiteLinkAccessRequestID = @WebsiteLinkAccessRequestID, 
WebsiteLinkID = @WebsiteLinkID, 
Approved = @Approved, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ProfileIDChild = @ProfileIDChild ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDOtherProfileID = @ProfileIDOtherProfileID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateProfile_WebsiteLinkByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateProfile_WebsiteLinkByPrimaryKey]
	@Profile_WebsiteLinkID [uniqueidentifier],
	@ProfileID [uniqueidentifier],
	@WebsiteLinkID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Profile_WebsiteLink 
Set Profile_WebsiteLinkID = @Profile_WebsiteLinkID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ProfileID = @ProfileID ) 
And ( WebsiteLinkID = @WebsiteLinkID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateProfile_PersonByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateProfile_PersonByPrimaryKey]
	@Profile_PersonID [uniqueidentifier],
	@ProfileID [uniqueidentifier],
	@PersonID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Profile_Person 
Set Profile_PersonID = @Profile_PersonID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ProfileID = @ProfileID ) 
And ( PersonID = @PersonID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateProfile_LibraryByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateProfile_LibraryByPrimaryKey]
	@Profile_LibraryID [uniqueidentifier],
	@ProfileID [uniqueidentifier],
	@LibraryID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Profile_Library 
Set Profile_LibraryID = @Profile_LibraryID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ProfileID = @ProfileID ) 
And ( LibraryID = @LibraryID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateProfile_EmailAddressByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateProfile_EmailAddressByPrimaryKey]
	@Profile_EmailAddressID [uniqueidentifier],
	@ProfileID [uniqueidentifier],
	@EmailAddressID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Profile_EmailAddress 
Set Profile_EmailAddressID = @Profile_EmailAddressID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ProfileID = @ProfileID ) 
And ( EmailAddressID = @EmailAddressID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateProfile_ContentByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateProfile_ContentByPrimaryKey]
	@Profile_ContentID [uniqueidentifier],
	@ProfileID [uniqueidentifier],
	@ContentID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Profile_Content 
Set Profile_ContentID = @Profile_ContentID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ProfileID = @ProfileID ) 
And ( ContentID = @ContentID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateProfile_BlogByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateProfile_BlogByPrimaryKey]
	@Profile_BlogID [uniqueidentifier],
	@ProfileID [uniqueidentifier],
	@BlogID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Profile_Blog 
Set Profile_BlogID = @Profile_BlogID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ProfileID = @ProfileID ) 
And ( BlogID = @BlogID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateProfile_AccountByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateProfile_AccountByPrimaryKey]
	@Profile_AccountID [uniqueidentifier],
	@ProfileID [uniqueidentifier],
	@AccountID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Profile_Account 
Set Profile_AccountID = @Profile_AccountID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ProfileID = @ProfileID ) 
And ( AccountID = @AccountID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdatePerson_PhoneNumberByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdatePerson_PhoneNumberByPrimaryKey]
	@Person_PhoneNumberID [uniqueidentifier],
	@PersonID [uniqueidentifier],
	@PhoneNumberID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Person_PhoneNumber 
Set Person_PhoneNumberID = @Person_PhoneNumberID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( PersonID = @PersonID ) 
And ( PhoneNumberID = @PhoneNumberID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdatePerson_AddressByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdatePerson_AddressByPrimaryKey]
	@Person_AddressID [uniqueidentifier],
	@PersonID [uniqueidentifier],
	@AddressID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Person_Address 
Set Person_AddressID = @Person_AddressID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( PersonID = @PersonID ) 
And ( AddressID = @AddressID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateParent_ChildByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateParent_ChildByPrimaryKey]
	@Parent_ChildID [uniqueidentifier],
	@Parent_ProfileID [uniqueidentifier],
	@Child_ProfileID [uniqueidentifier]
AS
Update Parent_Child 
Set Parent_ChildID = @Parent_ChildID 
Where (( Parent_ProfileID = @Parent_ProfileID ) 
And ( Child_ProfileID = @Child_ProfileID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateNotificationByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateNotificationByPrimaryKey]
	@NotificationID [uniqueidentifier],
	@ProfileIDFrom [uniqueidentifier],
	@ProfileIDTo [uniqueidentifier],
	@Message [nvarchar](max),
	@Deleted [bit],
	@InsertedDatetime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Notification 
Set ProfileIDFrom = @ProfileIDFrom, 
ProfileIDTo = @ProfileIDTo, 
Message = @Message, 
Deleted = @Deleted, 
InsertedDatetime = @InsertedDatetime, 
ModifiedDateTime = @ModifiedDateTime 
Where  NotificationID = @NotificationID
GO
/****** Object:  StoredProcedure [dbo].[UpdateNotificationAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateNotificationAccessRequestByPrimaryKey]
	@NotificationAccessRequestID [uniqueidentifier],
	@ProfileIDChild [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDOtherProfile [uniqueidentifier],
	@Approved [bit],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update NotificationAccessRequest 
Set NotificationAccessRequestID = @NotificationAccessRequestID, 
Approved = @Approved, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ProfileIDChild = @ProfileIDChild ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateLibraryAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateLibraryAccessRequestByPrimaryKey]
	@LibraryAccessRequestID [uniqueidentifier],
	@ProfileIDChild [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDOtherProfile [uniqueidentifier],
	@LibraryID [uniqueidentifier],
	@Approved [bit],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update LibraryAccessRequest 
Set LibraryAccessRequestID = @LibraryAccessRequestID, 
Approved = @Approved, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ProfileIDChild = @ProfileIDChild ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile ) 
And ( LibraryID = @LibraryID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateLibrary_ContentByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateLibrary_ContentByPrimaryKey]
	@Library_ContentID [uniqueidentifier],
	@LibraryID [uniqueidentifier],
	@ContentID [uniqueidentifier],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update Library_Content 
Set Library_ContentID = @Library_ContentID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( LibraryID = @LibraryID ) 
And ( ContentID = @ContentID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateContentTagByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateContentTagByPrimaryKey]
	@ContentTagID [uniqueidentifier],
	@ContentID [uniqueidentifier],
	@Tag [nvarchar](255),
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update ContentTag 
Set ContentTagID = @ContentTagID, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ContentID = @ContentID ) 
And ( Tag = @Tag ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateContentAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateContentAccessRequestByPrimaryKey]
	@ContentAccessRequestID [uniqueidentifier],
	@ProfileIDOtherProfile [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDChild [uniqueidentifier],
	@ContentID [uniqueidentifier],
	@Approved [bit],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update ContentAccessRequest 
Set ContentAccessRequestID = @ContentAccessRequestID, 
Approved = @Approved, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ProfileIDOtherProfile = @ProfileIDOtherProfile ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDChild = @ProfileIDChild ) 
And ( ContentID = @ContentID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateBlogAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UpdateBlogAccessRequestByPrimaryKey]
	@BlogAccessRequestID [uniqueidentifier],
	@ProfileIDChild [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDOtherProfile [uniqueidentifier],
	@BlogID [uniqueidentifier],
	@Approved [bit],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Update BlogAccessRequest 
Set BlogAccessRequestID = @BlogAccessRequestID, 
BlogID = @BlogID, 
Approved = @Approved, 
Deleted = @Deleted, 
InsertedDateTime = @InsertedDateTime, 
ModifiedDateTime = @ModifiedDateTime 
Where (( ProfileIDChild = @ProfileIDChild ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile ) 
)
GO
/****** Object:  StoredProcedure [dbo].[InsertWebsiteLinkAccessRequest]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertWebsiteLinkAccessRequest]
	@WebsiteLinkAccessRequestID [uniqueidentifier],
	@ProfileIDChild [uniqueidentifier] OUTPUT,
	@ProfileIDParent [uniqueidentifier] OUTPUT,
	@ProfileIDOtherProfileID [uniqueidentifier] OUTPUT,
	@WebsiteLinkID [uniqueidentifier],
	@Approved [bit],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into WebsiteLinkAccessRequest 
( WebsiteLinkAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfileID, WebsiteLinkID, Approved, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @WebsiteLinkAccessRequestID, @ProfileIDChild, @ProfileIDParent, @ProfileIDOtherProfileID, @WebsiteLinkID, @Approved, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertBlogAccessRequest]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertBlogAccessRequest]
	@BlogAccessRequestID [uniqueidentifier],
	@ProfileIDChild [uniqueidentifier] OUTPUT,
	@ProfileIDParent [uniqueidentifier] OUTPUT,
	@ProfileIDOtherProfile [uniqueidentifier] OUTPUT,
	@BlogID [uniqueidentifier],
	@Approved [bit],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into BlogAccessRequest 
( BlogAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, BlogID, Approved, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @BlogAccessRequestID, @ProfileIDChild, @ProfileIDParent, @ProfileIDOtherProfile, @BlogID, @Approved, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertProfile_WebsiteLink]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertProfile_WebsiteLink]
	@Profile_WebsiteLinkID [uniqueidentifier],
	@ProfileID [uniqueidentifier] OUTPUT,
	@WebsiteLinkID [uniqueidentifier] OUTPUT,
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Profile_WebsiteLink 
( Profile_WebsiteLinkID, ProfileID, WebsiteLinkID, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @Profile_WebsiteLinkID, @ProfileID, @WebsiteLinkID, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertProfile_Person]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertProfile_Person]
	@Profile_PersonID [uniqueidentifier],
	@ProfileID [uniqueidentifier] OUTPUT,
	@PersonID [uniqueidentifier] OUTPUT,
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Profile_Person 
( Profile_PersonID, ProfileID, PersonID, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @Profile_PersonID, @ProfileID, @PersonID, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertProfile_Library]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertProfile_Library]
	@Profile_LibraryID [uniqueidentifier],
	@ProfileID [uniqueidentifier] OUTPUT,
	@LibraryID [uniqueidentifier] OUTPUT,
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Profile_Library 
( Profile_LibraryID, ProfileID, LibraryID, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @Profile_LibraryID, @ProfileID, @LibraryID, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertProfile_EmailAddress]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertProfile_EmailAddress]
	@Profile_EmailAddressID [uniqueidentifier],
	@ProfileID [uniqueidentifier] OUTPUT,
	@EmailAddressID [uniqueidentifier] OUTPUT,
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Profile_EmailAddress 
( Profile_EmailAddressID, ProfileID, EmailAddressID, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @Profile_EmailAddressID, @ProfileID, @EmailAddressID, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertProfile_Content]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertProfile_Content]
	@Profile_ContentID [uniqueidentifier],
	@ProfileID [uniqueidentifier] OUTPUT,
	@ContentID [uniqueidentifier] OUTPUT,
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Profile_Content 
( Profile_ContentID, ProfileID, ContentID, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @Profile_ContentID, @ProfileID, @ContentID, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertProfile_Blog]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertProfile_Blog]
	@Profile_BlogID [uniqueidentifier],
	@ProfileID [uniqueidentifier] OUTPUT,
	@BlogID [uniqueidentifier] OUTPUT,
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Profile_Blog 
( Profile_BlogID, ProfileID, BlogID, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @Profile_BlogID, @ProfileID, @BlogID, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertProfile_Account]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertProfile_Account]
	@Profile_AccountID [uniqueidentifier],
	@ProfileID [uniqueidentifier] OUTPUT,
	@AccountID [uniqueidentifier] OUTPUT,
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Profile_Account 
( Profile_AccountID, ProfileID, AccountID, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @Profile_AccountID, @ProfileID, @AccountID, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertPerson_PhoneNumber]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertPerson_PhoneNumber]
	@Person_PhoneNumberID [uniqueidentifier],
	@PersonID [uniqueidentifier] OUTPUT,
	@PhoneNumberID [uniqueidentifier] OUTPUT,
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Person_PhoneNumber 
( Person_PhoneNumberID, PersonID, PhoneNumberID, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @Person_PhoneNumberID, @PersonID, @PhoneNumberID, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertPerson_Address]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertPerson_Address]
	@Person_AddressID [uniqueidentifier],
	@PersonID [uniqueidentifier] OUTPUT,
	@AddressID [uniqueidentifier] OUTPUT,
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Person_Address 
( Person_AddressID, PersonID, AddressID, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @Person_AddressID, @PersonID, @AddressID, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertParent_Child]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertParent_Child]
	@Parent_ChildID [uniqueidentifier],
	@Parent_ProfileID [uniqueidentifier] OUTPUT,
	@Child_ProfileID [uniqueidentifier] OUTPUT
AS
Insert Into Parent_Child 
( Parent_ChildID, Parent_ProfileID, Child_ProfileID)
Values ( @Parent_ChildID, @Parent_ProfileID, @Child_ProfileID)
GO
/****** Object:  StoredProcedure [dbo].[InsertNotificationAccessRequest]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertNotificationAccessRequest]
	@NotificationAccessRequestID [uniqueidentifier],
	@ProfileIDChild [uniqueidentifier] OUTPUT,
	@ProfileIDParent [uniqueidentifier] OUTPUT,
	@ProfileIDOtherProfile [uniqueidentifier] OUTPUT,
	@Approved [bit],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into NotificationAccessRequest 
( NotificationAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, Approved, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @NotificationAccessRequestID, @ProfileIDChild, @ProfileIDParent, @ProfileIDOtherProfile, @Approved, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertNotification]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertNotification]
	@NotificationID [uniqueidentifier] OUTPUT,
	@ProfileIDFrom [uniqueidentifier],
	@ProfileIDTo [uniqueidentifier],
	@Message [nvarchar](max),
	@Deleted [bit],
	@InsertedDatetime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Notification 
( NotificationID, ProfileIDFrom, ProfileIDTo, Message, Deleted, InsertedDatetime, ModifiedDateTime)
Values ( @NotificationID, @ProfileIDFrom, @ProfileIDTo, @Message, @Deleted, @InsertedDatetime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertLibraryAccessRequest]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertLibraryAccessRequest]
	@LibraryAccessRequestID [uniqueidentifier],
	@ProfileIDChild [uniqueidentifier] OUTPUT,
	@ProfileIDParent [uniqueidentifier] OUTPUT,
	@ProfileIDOtherProfile [uniqueidentifier] OUTPUT,
	@LibraryID [uniqueidentifier] OUTPUT,
	@Approved [bit],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into LibraryAccessRequest 
( LibraryAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, LibraryID, Approved, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @LibraryAccessRequestID, @ProfileIDChild, @ProfileIDParent, @ProfileIDOtherProfile, @LibraryID, @Approved, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertLibrary_Content]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertLibrary_Content]
	@Library_ContentID [uniqueidentifier],
	@LibraryID [uniqueidentifier] OUTPUT,
	@ContentID [uniqueidentifier] OUTPUT,
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into Library_Content 
( Library_ContentID, LibraryID, ContentID, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @Library_ContentID, @LibraryID, @ContentID, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertContentTag]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertContentTag]
	@ContentTagID [uniqueidentifier],
	@ContentID [uniqueidentifier] OUTPUT,
	@Tag [nvarchar](255) OUTPUT,
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into ContentTag 
( ContentTagID, ContentID, Tag, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @ContentTagID, @ContentID, @Tag, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[InsertContentAccessRequest]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[InsertContentAccessRequest]
	@ContentAccessRequestID [uniqueidentifier],
	@ProfileIDOtherProfile [uniqueidentifier] OUTPUT,
	@ProfileIDParent [uniqueidentifier] OUTPUT,
	@ProfileIDChild [uniqueidentifier] OUTPUT,
	@ContentID [uniqueidentifier] OUTPUT,
	@Approved [bit],
	@Deleted [bit],
	@InsertedDateTime [datetime],
	@ModifiedDateTime [datetime]
AS
Insert Into ContentAccessRequest 
( ContentAccessRequestID, ProfileIDOtherProfile, ProfileIDParent, ProfileIDChild, ContentID, Approved, Deleted, InsertedDateTime, ModifiedDateTime)
Values ( @ContentAccessRequestID, @ProfileIDOtherProfile, @ProfileIDParent, @ProfileIDChild, @ContentID, @Approved, @Deleted, @InsertedDateTime, @ModifiedDateTime)
GO
/****** Object:  StoredProcedure [dbo].[GetWebsiteLinkAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetWebsiteLinkAccessRequestByPrimaryKey]
	@ProfileIDChild [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDOtherProfileID [uniqueidentifier]
AS
Select WebsiteLinkAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfileID, WebsiteLinkID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From WebsiteLinkAccessRequest 
Where (( ProfileIDChild = @ProfileIDChild ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDOtherProfileID = @ProfileIDOtherProfileID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetWebsiteLinkAccessRequestByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetWebsiteLinkAccessRequestByCriteriaFuzzy]
	@WebsiteLinkAccessRequestID [uniqueidentifier] = null,
	@ProfileIDChild [uniqueidentifier] = null,
	@ProfileIDParent [uniqueidentifier] = null,
	@ProfileIDOtherProfileID [uniqueidentifier] = null,
	@WebsiteLinkID [uniqueidentifier] = null,
	@Approved [bit] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select WebsiteLinkAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfileID, WebsiteLinkID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From WebsiteLinkAccessRequest 
Where ( WebsiteLinkAccessRequestID = @WebsiteLinkAccessRequestID Or @WebsiteLinkAccessRequestID = null ) 
And ( ProfileIDChild = @ProfileIDChild Or @ProfileIDChild = null ) 
And ( ProfileIDParent = @ProfileIDParent Or @ProfileIDParent = null ) 
And ( ProfileIDOtherProfileID = @ProfileIDOtherProfileID Or @ProfileIDOtherProfileID = null ) 
And ( WebsiteLinkID = @WebsiteLinkID Or @WebsiteLinkID = null ) 
And ( Approved = @Approved Or @Approved = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetWebsiteLinkAccessRequestByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetWebsiteLinkAccessRequestByCriteriaExact]
	@WebsiteLinkAccessRequestID [uniqueidentifier] = null,
	@ProfileIDChild [uniqueidentifier] = null,
	@ProfileIDParent [uniqueidentifier] = null,
	@ProfileIDOtherProfileID [uniqueidentifier] = null,
	@WebsiteLinkID [uniqueidentifier] = null,
	@Approved [bit] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select WebsiteLinkAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfileID, WebsiteLinkID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From WebsiteLinkAccessRequest 
Where ( WebsiteLinkAccessRequestID = @WebsiteLinkAccessRequestID Or @WebsiteLinkAccessRequestID = null ) 
And ( ProfileIDChild = @ProfileIDChild Or @ProfileIDChild = null ) 
And ( ProfileIDParent = @ProfileIDParent Or @ProfileIDParent = null ) 
And ( ProfileIDOtherProfileID = @ProfileIDOtherProfileID Or @ProfileIDOtherProfileID = null ) 
And ( WebsiteLinkID = @WebsiteLinkID Or @WebsiteLinkID = null ) 
And ( Approved = @Approved Or @Approved = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetWebsiteLinkAccessRequest]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetWebsiteLinkAccessRequest]
AS
Select WebsiteLinkAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfileID, WebsiteLinkID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From WebsiteLinkAccessRequest
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_WebsiteLinkByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_WebsiteLinkByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@WebsiteLinkID [uniqueidentifier]
AS
Select Profile_WebsiteLinkID, ProfileID, WebsiteLinkID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_WebsiteLink 
Where (( ProfileID = @ProfileID ) 
And ( WebsiteLinkID = @WebsiteLinkID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_WebsiteLinkByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_WebsiteLinkByCriteriaFuzzy]
	@Profile_WebsiteLinkID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@WebsiteLinkID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_WebsiteLinkID, ProfileID, WebsiteLinkID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_WebsiteLink 
Where ( Profile_WebsiteLinkID = @Profile_WebsiteLinkID Or @Profile_WebsiteLinkID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( WebsiteLinkID = @WebsiteLinkID Or @WebsiteLinkID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_WebsiteLinkByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_WebsiteLinkByCriteriaExact]
	@Profile_WebsiteLinkID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@WebsiteLinkID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_WebsiteLinkID, ProfileID, WebsiteLinkID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_WebsiteLink 
Where ( Profile_WebsiteLinkID = @Profile_WebsiteLinkID Or @Profile_WebsiteLinkID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( WebsiteLinkID = @WebsiteLinkID Or @WebsiteLinkID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_WebsiteLink]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_WebsiteLink]
AS
Select Profile_WebsiteLinkID, ProfileID, WebsiteLinkID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_WebsiteLink
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_PersonByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_PersonByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@PersonID [uniqueidentifier]
AS
Select Profile_PersonID, ProfileID, PersonID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Person 
Where (( ProfileID = @ProfileID ) 
And ( PersonID = @PersonID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_PersonByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_PersonByCriteriaFuzzy]
	@Profile_PersonID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@PersonID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_PersonID, ProfileID, PersonID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Person 
Where ( Profile_PersonID = @Profile_PersonID Or @Profile_PersonID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( PersonID = @PersonID Or @PersonID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_PersonByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_PersonByCriteriaExact]
	@Profile_PersonID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@PersonID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_PersonID, ProfileID, PersonID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Person 
Where ( Profile_PersonID = @Profile_PersonID Or @Profile_PersonID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( PersonID = @PersonID Or @PersonID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_Person]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_Person]
AS
Select Profile_PersonID, ProfileID, PersonID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Person
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_LibraryByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_LibraryByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@LibraryID [uniqueidentifier]
AS
Select Profile_LibraryID, ProfileID, LibraryID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Library 
Where (( ProfileID = @ProfileID ) 
And ( LibraryID = @LibraryID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_LibraryByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_LibraryByCriteriaFuzzy]
	@Profile_LibraryID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@LibraryID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_LibraryID, ProfileID, LibraryID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Library 
Where ( Profile_LibraryID = @Profile_LibraryID Or @Profile_LibraryID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( LibraryID = @LibraryID Or @LibraryID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_LibraryByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_LibraryByCriteriaExact]
	@Profile_LibraryID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@LibraryID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_LibraryID, ProfileID, LibraryID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Library 
Where ( Profile_LibraryID = @Profile_LibraryID Or @Profile_LibraryID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( LibraryID = @LibraryID Or @LibraryID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_Library]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_Library]
AS
Select Profile_LibraryID, ProfileID, LibraryID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Library
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_EmailAddressByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_EmailAddressByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@EmailAddressID [uniqueidentifier]
AS
Select Profile_EmailAddressID, ProfileID, EmailAddressID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_EmailAddress 
Where (( ProfileID = @ProfileID ) 
And ( EmailAddressID = @EmailAddressID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_EmailAddressByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_EmailAddressByCriteriaFuzzy]
	@Profile_EmailAddressID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@EmailAddressID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_EmailAddressID, ProfileID, EmailAddressID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_EmailAddress 
Where ( Profile_EmailAddressID = @Profile_EmailAddressID Or @Profile_EmailAddressID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( EmailAddressID = @EmailAddressID Or @EmailAddressID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_EmailAddressByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_EmailAddressByCriteriaExact]
	@Profile_EmailAddressID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@EmailAddressID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_EmailAddressID, ProfileID, EmailAddressID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_EmailAddress 
Where ( Profile_EmailAddressID = @Profile_EmailAddressID Or @Profile_EmailAddressID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( EmailAddressID = @EmailAddressID Or @EmailAddressID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_EmailAddress]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_EmailAddress]
AS
Select Profile_EmailAddressID, ProfileID, EmailAddressID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_EmailAddress
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_ContentByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_ContentByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@ContentID [uniqueidentifier]
AS
Select Profile_ContentID, ProfileID, ContentID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Content 
Where (( ProfileID = @ProfileID ) 
And ( ContentID = @ContentID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_ContentByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_ContentByCriteriaFuzzy]
	@Profile_ContentID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@ContentID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_ContentID, ProfileID, ContentID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Content 
Where ( Profile_ContentID = @Profile_ContentID Or @Profile_ContentID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( ContentID = @ContentID Or @ContentID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_ContentByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_ContentByCriteriaExact]
	@Profile_ContentID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@ContentID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_ContentID, ProfileID, ContentID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Content 
Where ( Profile_ContentID = @Profile_ContentID Or @Profile_ContentID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( ContentID = @ContentID Or @ContentID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_Content]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_Content]
AS
Select Profile_ContentID, ProfileID, ContentID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Content
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_BlogByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_BlogByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@BlogID [uniqueidentifier]
AS
Select Profile_BlogID, ProfileID, BlogID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Blog 
Where (( ProfileID = @ProfileID ) 
And ( BlogID = @BlogID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_BlogByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_BlogByCriteriaFuzzy]
	@Profile_BlogID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@BlogID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_BlogID, ProfileID, BlogID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Blog 
Where ( Profile_BlogID = @Profile_BlogID Or @Profile_BlogID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( BlogID = @BlogID Or @BlogID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_BlogByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_BlogByCriteriaExact]
	@Profile_BlogID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@BlogID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_BlogID, ProfileID, BlogID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Blog 
Where ( Profile_BlogID = @Profile_BlogID Or @Profile_BlogID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( BlogID = @BlogID Or @BlogID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_Blog]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_Blog]
AS
Select Profile_BlogID, ProfileID, BlogID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Blog
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_AccountByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_AccountByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@AccountID [uniqueidentifier]
AS
Select Profile_AccountID, ProfileID, AccountID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Account 
Where (( ProfileID = @ProfileID ) 
And ( AccountID = @AccountID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_AccountByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_AccountByCriteriaFuzzy]
	@Profile_AccountID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@AccountID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_AccountID, ProfileID, AccountID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Account 
Where ( Profile_AccountID = @Profile_AccountID Or @Profile_AccountID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( AccountID = @AccountID Or @AccountID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_AccountByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_AccountByCriteriaExact]
	@Profile_AccountID [uniqueidentifier] = null,
	@ProfileID [uniqueidentifier] = null,
	@AccountID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Profile_AccountID, ProfileID, AccountID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Account 
Where ( Profile_AccountID = @Profile_AccountID Or @Profile_AccountID = null ) 
And ( ProfileID = @ProfileID Or @ProfileID = null ) 
And ( AccountID = @AccountID Or @AccountID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetProfile_Account]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProfile_Account]
AS
Select Profile_AccountID, ProfileID, AccountID, Deleted, InsertedDateTime, ModifiedDateTime
From Profile_Account
GO
/****** Object:  StoredProcedure [dbo].[GetPerson_PhoneNumberByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPerson_PhoneNumberByPrimaryKey]
	@PersonID [uniqueidentifier],
	@PhoneNumberID [uniqueidentifier]
AS
Select Person_PhoneNumberID, PersonID, PhoneNumberID, Deleted, InsertedDateTime, ModifiedDateTime
From Person_PhoneNumber 
Where (( PersonID = @PersonID ) 
And ( PhoneNumberID = @PhoneNumberID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetPerson_PhoneNumberByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPerson_PhoneNumberByCriteriaFuzzy]
	@Person_PhoneNumberID [uniqueidentifier] = null,
	@PersonID [uniqueidentifier] = null,
	@PhoneNumberID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Person_PhoneNumberID, PersonID, PhoneNumberID, Deleted, InsertedDateTime, ModifiedDateTime
From Person_PhoneNumber 
Where ( Person_PhoneNumberID = @Person_PhoneNumberID Or @Person_PhoneNumberID = null ) 
And ( PersonID = @PersonID Or @PersonID = null ) 
And ( PhoneNumberID = @PhoneNumberID Or @PhoneNumberID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetPerson_PhoneNumberByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPerson_PhoneNumberByCriteriaExact]
	@Person_PhoneNumberID [uniqueidentifier] = null,
	@PersonID [uniqueidentifier] = null,
	@PhoneNumberID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Person_PhoneNumberID, PersonID, PhoneNumberID, Deleted, InsertedDateTime, ModifiedDateTime
From Person_PhoneNumber 
Where ( Person_PhoneNumberID = @Person_PhoneNumberID Or @Person_PhoneNumberID = null ) 
And ( PersonID = @PersonID Or @PersonID = null ) 
And ( PhoneNumberID = @PhoneNumberID Or @PhoneNumberID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetPerson_PhoneNumber]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPerson_PhoneNumber]
AS
Select Person_PhoneNumberID, PersonID, PhoneNumberID, Deleted, InsertedDateTime, ModifiedDateTime
From Person_PhoneNumber
GO
/****** Object:  StoredProcedure [dbo].[GetPerson_AddressByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPerson_AddressByPrimaryKey]
	@PersonID [uniqueidentifier],
	@AddressID [uniqueidentifier]
AS
Select Person_AddressID, PersonID, AddressID, Deleted, InsertedDateTime, ModifiedDateTime
From Person_Address 
Where (( PersonID = @PersonID ) 
And ( AddressID = @AddressID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetPerson_AddressByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPerson_AddressByCriteriaFuzzy]
	@Person_AddressID [uniqueidentifier] = null,
	@PersonID [uniqueidentifier] = null,
	@AddressID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Person_AddressID, PersonID, AddressID, Deleted, InsertedDateTime, ModifiedDateTime
From Person_Address 
Where ( Person_AddressID = @Person_AddressID Or @Person_AddressID = null ) 
And ( PersonID = @PersonID Or @PersonID = null ) 
And ( AddressID = @AddressID Or @AddressID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetPerson_AddressByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPerson_AddressByCriteriaExact]
	@Person_AddressID [uniqueidentifier] = null,
	@PersonID [uniqueidentifier] = null,
	@AddressID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Person_AddressID, PersonID, AddressID, Deleted, InsertedDateTime, ModifiedDateTime
From Person_Address 
Where ( Person_AddressID = @Person_AddressID Or @Person_AddressID = null ) 
And ( PersonID = @PersonID Or @PersonID = null ) 
And ( AddressID = @AddressID Or @AddressID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetPerson_Address]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetPerson_Address]
AS
Select Person_AddressID, PersonID, AddressID, Deleted, InsertedDateTime, ModifiedDateTime
From Person_Address
GO
/****** Object:  StoredProcedure [dbo].[GetLibraryAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLibraryAccessRequestByPrimaryKey]
	@ProfileIDChild [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDOtherProfile [uniqueidentifier],
	@LibraryID [uniqueidentifier]
AS
Select LibraryAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, LibraryID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From LibraryAccessRequest 
Where (( ProfileIDChild = @ProfileIDChild ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile ) 
And ( LibraryID = @LibraryID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetLibraryAccessRequestByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLibraryAccessRequestByCriteriaFuzzy]
	@LibraryAccessRequestID [uniqueidentifier] = null,
	@ProfileIDChild [uniqueidentifier] = null,
	@ProfileIDParent [uniqueidentifier] = null,
	@ProfileIDOtherProfile [uniqueidentifier] = null,
	@LibraryID [uniqueidentifier] = null,
	@Approved [bit] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select LibraryAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, LibraryID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From LibraryAccessRequest 
Where ( LibraryAccessRequestID = @LibraryAccessRequestID Or @LibraryAccessRequestID = null ) 
And ( ProfileIDChild = @ProfileIDChild Or @ProfileIDChild = null ) 
And ( ProfileIDParent = @ProfileIDParent Or @ProfileIDParent = null ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile Or @ProfileIDOtherProfile = null ) 
And ( LibraryID = @LibraryID Or @LibraryID = null ) 
And ( Approved = @Approved Or @Approved = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetLibraryAccessRequestByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLibraryAccessRequestByCriteriaExact]
	@LibraryAccessRequestID [uniqueidentifier] = null,
	@ProfileIDChild [uniqueidentifier] = null,
	@ProfileIDParent [uniqueidentifier] = null,
	@ProfileIDOtherProfile [uniqueidentifier] = null,
	@LibraryID [uniqueidentifier] = null,
	@Approved [bit] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select LibraryAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, LibraryID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From LibraryAccessRequest 
Where ( LibraryAccessRequestID = @LibraryAccessRequestID Or @LibraryAccessRequestID = null ) 
And ( ProfileIDChild = @ProfileIDChild Or @ProfileIDChild = null ) 
And ( ProfileIDParent = @ProfileIDParent Or @ProfileIDParent = null ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile Or @ProfileIDOtherProfile = null ) 
And ( LibraryID = @LibraryID Or @LibraryID = null ) 
And ( Approved = @Approved Or @Approved = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetLibraryAccessRequest]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLibraryAccessRequest]
AS
Select LibraryAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, LibraryID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From LibraryAccessRequest
GO
/****** Object:  StoredProcedure [dbo].[GetLibrary_ContentByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLibrary_ContentByPrimaryKey]
	@LibraryID [uniqueidentifier],
	@ContentID [uniqueidentifier]
AS
Select Library_ContentID, LibraryID, ContentID, Deleted, InsertedDateTime, ModifiedDateTime
From Library_Content 
Where (( LibraryID = @LibraryID ) 
And ( ContentID = @ContentID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetLibrary_ContentByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLibrary_ContentByCriteriaFuzzy]
	@Library_ContentID [uniqueidentifier] = null,
	@LibraryID [uniqueidentifier] = null,
	@ContentID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Library_ContentID, LibraryID, ContentID, Deleted, InsertedDateTime, ModifiedDateTime
From Library_Content 
Where ( Library_ContentID = @Library_ContentID Or @Library_ContentID = null ) 
And ( LibraryID = @LibraryID Or @LibraryID = null ) 
And ( ContentID = @ContentID Or @ContentID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetLibrary_ContentByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLibrary_ContentByCriteriaExact]
	@Library_ContentID [uniqueidentifier] = null,
	@LibraryID [uniqueidentifier] = null,
	@ContentID [uniqueidentifier] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select Library_ContentID, LibraryID, ContentID, Deleted, InsertedDateTime, ModifiedDateTime
From Library_Content 
Where ( Library_ContentID = @Library_ContentID Or @Library_ContentID = null ) 
And ( LibraryID = @LibraryID Or @LibraryID = null ) 
And ( ContentID = @ContentID Or @ContentID = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetLibrary_Content]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetLibrary_Content]
AS
Select Library_ContentID, LibraryID, ContentID, Deleted, InsertedDateTime, ModifiedDateTime
From Library_Content
GO
/****** Object:  StoredProcedure [dbo].[GetParent_ChildByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetParent_ChildByPrimaryKey]
	@Parent_ProfileID [uniqueidentifier],
	@Child_ProfileID [uniqueidentifier]
AS
Select Parent_ChildID, Parent_ProfileID, Child_ProfileID
From Parent_Child 
Where (( Parent_ProfileID = @Parent_ProfileID ) 
And ( Child_ProfileID = @Child_ProfileID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetParent_ChildByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetParent_ChildByCriteriaFuzzy]
	@Parent_ChildID [uniqueidentifier] = null,
	@Parent_ProfileID [uniqueidentifier] = null,
	@Child_ProfileID [uniqueidentifier] = null
AS
Select Parent_ChildID, Parent_ProfileID, Child_ProfileID
From Parent_Child 
Where ( Parent_ChildID = @Parent_ChildID Or @Parent_ChildID = null ) 
And ( Parent_ProfileID = @Parent_ProfileID Or @Parent_ProfileID = null ) 
And ( Child_ProfileID = @Child_ProfileID Or @Child_ProfileID = null )
GO
/****** Object:  StoredProcedure [dbo].[GetParent_ChildByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetParent_ChildByCriteriaExact]
	@Parent_ChildID [uniqueidentifier] = null,
	@Parent_ProfileID [uniqueidentifier] = null,
	@Child_ProfileID [uniqueidentifier] = null
AS
Select Parent_ChildID, Parent_ProfileID, Child_ProfileID
From Parent_Child 
Where ( Parent_ChildID = @Parent_ChildID Or @Parent_ChildID = null ) 
And ( Parent_ProfileID = @Parent_ProfileID Or @Parent_ProfileID = null ) 
And ( Child_ProfileID = @Child_ProfileID Or @Child_ProfileID = null )
GO
/****** Object:  StoredProcedure [dbo].[GetParent_Child]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetParent_Child]
AS
Select Parent_ChildID, Parent_ProfileID, Child_ProfileID
From Parent_Child
GO
/****** Object:  StoredProcedure [dbo].[GetNotificationByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetNotificationByPrimaryKey]
	@NotificationID [uniqueidentifier]
AS
Select NotificationID, ProfileIDFrom, ProfileIDTo, Message, Deleted, InsertedDatetime, ModifiedDateTime
From Notification 
Where  NotificationID = @NotificationID
GO
/****** Object:  StoredProcedure [dbo].[GetNotificationByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetNotificationByCriteriaFuzzy]
	@NotificationID [uniqueidentifier] = null,
	@ProfileIDFrom [uniqueidentifier] = null,
	@ProfileIDTo [uniqueidentifier] = null,
	@Message [nvarchar](max) = null,
	@Deleted [bit] = null,
	@InsertedDatetime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select NotificationID, ProfileIDFrom, ProfileIDTo, Message, Deleted, InsertedDatetime, ModifiedDateTime
From Notification 
Where ( NotificationID = @NotificationID Or @NotificationID = null ) 
And ( ProfileIDFrom = @ProfileIDFrom Or @ProfileIDFrom = null ) 
And ( ProfileIDTo = @ProfileIDTo Or @ProfileIDTo = null ) 
And ( Message Like @Message + '%' Or @Message = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDatetime = @InsertedDatetime Or @InsertedDatetime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetNotificationByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetNotificationByCriteriaExact]
	@NotificationID [uniqueidentifier] = null,
	@ProfileIDFrom [uniqueidentifier] = null,
	@ProfileIDTo [uniqueidentifier] = null,
	@Message [nvarchar](max) = null,
	@Deleted [bit] = null,
	@InsertedDatetime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select NotificationID, ProfileIDFrom, ProfileIDTo, Message, Deleted, InsertedDatetime, ModifiedDateTime
From Notification 
Where ( NotificationID = @NotificationID Or @NotificationID = null ) 
And ( ProfileIDFrom = @ProfileIDFrom Or @ProfileIDFrom = null ) 
And ( ProfileIDTo = @ProfileIDTo Or @ProfileIDTo = null ) 
And ( Message = @Message Or @Message = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDatetime = @InsertedDatetime Or @InsertedDatetime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetNotificationAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetNotificationAccessRequestByPrimaryKey]
	@ProfileIDChild [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDOtherProfile [uniqueidentifier]
AS
Select NotificationAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From NotificationAccessRequest 
Where (( ProfileIDChild = @ProfileIDChild ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetNotificationAccessRequestByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetNotificationAccessRequestByCriteriaFuzzy]
	@NotificationAccessRequestID [uniqueidentifier] = null,
	@ProfileIDChild [uniqueidentifier] = null,
	@ProfileIDParent [uniqueidentifier] = null,
	@ProfileIDOtherProfile [uniqueidentifier] = null,
	@Approved [bit] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select NotificationAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From NotificationAccessRequest 
Where ( NotificationAccessRequestID = @NotificationAccessRequestID Or @NotificationAccessRequestID = null ) 
And ( ProfileIDChild = @ProfileIDChild Or @ProfileIDChild = null ) 
And ( ProfileIDParent = @ProfileIDParent Or @ProfileIDParent = null ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile Or @ProfileIDOtherProfile = null ) 
And ( Approved = @Approved Or @Approved = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetNotificationAccessRequestByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetNotificationAccessRequestByCriteriaExact]
	@NotificationAccessRequestID [uniqueidentifier] = null,
	@ProfileIDChild [uniqueidentifier] = null,
	@ProfileIDParent [uniqueidentifier] = null,
	@ProfileIDOtherProfile [uniqueidentifier] = null,
	@Approved [bit] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select NotificationAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From NotificationAccessRequest 
Where ( NotificationAccessRequestID = @NotificationAccessRequestID Or @NotificationAccessRequestID = null ) 
And ( ProfileIDChild = @ProfileIDChild Or @ProfileIDChild = null ) 
And ( ProfileIDParent = @ProfileIDParent Or @ProfileIDParent = null ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile Or @ProfileIDOtherProfile = null ) 
And ( Approved = @Approved Or @Approved = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetNotificationAccessRequest]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetNotificationAccessRequest]
AS
Select NotificationAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From NotificationAccessRequest
GO
/****** Object:  StoredProcedure [dbo].[GetNotification]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetNotification]
AS
Select NotificationID, ProfileIDFrom, ProfileIDTo, Message, Deleted, InsertedDatetime, ModifiedDateTime
From Notification
GO
/****** Object:  StoredProcedure [dbo].[GetContentTagByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentTagByPrimaryKey]
	@ContentID [uniqueidentifier],
	@Tag [nvarchar](255)
AS
Select ContentTagID, ContentID, Tag, Deleted, InsertedDateTime, ModifiedDateTime
From ContentTag 
Where (( ContentID = @ContentID ) 
And ( Tag = @Tag ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetContentTagByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentTagByCriteriaFuzzy]
	@ContentTagID [uniqueidentifier] = null,
	@ContentID [uniqueidentifier] = null,
	@Tag [nvarchar](255) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select ContentTagID, ContentID, Tag, Deleted, InsertedDateTime, ModifiedDateTime
From ContentTag 
Where ( ContentTagID = @ContentTagID Or @ContentTagID = null ) 
And ( ContentID = @ContentID Or @ContentID = null ) 
And ( Tag Like @Tag + '%' Or @Tag = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetContentTagByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentTagByCriteriaExact]
	@ContentTagID [uniqueidentifier] = null,
	@ContentID [uniqueidentifier] = null,
	@Tag [nvarchar](255) = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select ContentTagID, ContentID, Tag, Deleted, InsertedDateTime, ModifiedDateTime
From ContentTag 
Where ( ContentTagID = @ContentTagID Or @ContentTagID = null ) 
And ( ContentID = @ContentID Or @ContentID = null ) 
And ( Tag = @Tag Or @Tag = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetContentTag]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentTag]
AS
Select ContentTagID, ContentID, Tag, Deleted, InsertedDateTime, ModifiedDateTime
From ContentTag
GO
/****** Object:  StoredProcedure [dbo].[GetContentAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentAccessRequestByPrimaryKey]
	@ProfileIDOtherProfile [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDChild [uniqueidentifier],
	@ContentID [uniqueidentifier]
AS
Select ContentAccessRequestID, ProfileIDOtherProfile, ProfileIDParent, ProfileIDChild, ContentID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From ContentAccessRequest 
Where (( ProfileIDOtherProfile = @ProfileIDOtherProfile ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDChild = @ProfileIDChild ) 
And ( ContentID = @ContentID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetContentAccessRequestByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentAccessRequestByCriteriaFuzzy]
	@ContentAccessRequestID [uniqueidentifier] = null,
	@ProfileIDOtherProfile [uniqueidentifier] = null,
	@ProfileIDParent [uniqueidentifier] = null,
	@ProfileIDChild [uniqueidentifier] = null,
	@ContentID [uniqueidentifier] = null,
	@Approved [bit] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select ContentAccessRequestID, ProfileIDOtherProfile, ProfileIDParent, ProfileIDChild, ContentID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From ContentAccessRequest 
Where ( ContentAccessRequestID = @ContentAccessRequestID Or @ContentAccessRequestID = null ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile Or @ProfileIDOtherProfile = null ) 
And ( ProfileIDParent = @ProfileIDParent Or @ProfileIDParent = null ) 
And ( ProfileIDChild = @ProfileIDChild Or @ProfileIDChild = null ) 
And ( ContentID = @ContentID Or @ContentID = null ) 
And ( Approved = @Approved Or @Approved = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetContentAccessRequestByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentAccessRequestByCriteriaExact]
	@ContentAccessRequestID [uniqueidentifier] = null,
	@ProfileIDOtherProfile [uniqueidentifier] = null,
	@ProfileIDParent [uniqueidentifier] = null,
	@ProfileIDChild [uniqueidentifier] = null,
	@ContentID [uniqueidentifier] = null,
	@Approved [bit] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select ContentAccessRequestID, ProfileIDOtherProfile, ProfileIDParent, ProfileIDChild, ContentID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From ContentAccessRequest 
Where ( ContentAccessRequestID = @ContentAccessRequestID Or @ContentAccessRequestID = null ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile Or @ProfileIDOtherProfile = null ) 
And ( ProfileIDParent = @ProfileIDParent Or @ProfileIDParent = null ) 
And ( ProfileIDChild = @ProfileIDChild Or @ProfileIDChild = null ) 
And ( ContentID = @ContentID Or @ContentID = null ) 
And ( Approved = @Approved Or @Approved = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetContentAccessRequest]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetContentAccessRequest]
AS
Select ContentAccessRequestID, ProfileIDOtherProfile, ProfileIDParent, ProfileIDChild, ContentID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From ContentAccessRequest
GO
/****** Object:  StoredProcedure [dbo].[GetBlogAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetBlogAccessRequestByPrimaryKey]
	@ProfileIDChild [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDOtherProfile [uniqueidentifier]
AS
Select BlogAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, BlogID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From BlogAccessRequest 
Where (( ProfileIDChild = @ProfileIDChild ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile ) 
)
GO
/****** Object:  StoredProcedure [dbo].[GetBlogAccessRequestByCriteriaFuzzy]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetBlogAccessRequestByCriteriaFuzzy]
	@BlogAccessRequestID [uniqueidentifier] = null,
	@ProfileIDChild [uniqueidentifier] = null,
	@ProfileIDParent [uniqueidentifier] = null,
	@ProfileIDOtherProfile [uniqueidentifier] = null,
	@BlogID [uniqueidentifier] = null,
	@Approved [bit] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select BlogAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, BlogID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From BlogAccessRequest 
Where ( BlogAccessRequestID = @BlogAccessRequestID Or @BlogAccessRequestID = null ) 
And ( ProfileIDChild = @ProfileIDChild Or @ProfileIDChild = null ) 
And ( ProfileIDParent = @ProfileIDParent Or @ProfileIDParent = null ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile Or @ProfileIDOtherProfile = null ) 
And ( BlogID = @BlogID Or @BlogID = null ) 
And ( Approved = @Approved Or @Approved = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetBlogAccessRequestByCriteriaExact]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetBlogAccessRequestByCriteriaExact]
	@BlogAccessRequestID [uniqueidentifier] = null,
	@ProfileIDChild [uniqueidentifier] = null,
	@ProfileIDParent [uniqueidentifier] = null,
	@ProfileIDOtherProfile [uniqueidentifier] = null,
	@BlogID [uniqueidentifier] = null,
	@Approved [bit] = null,
	@Deleted [bit] = null,
	@InsertedDateTime [datetime] = null,
	@ModifiedDateTime [datetime] = null
AS
Select BlogAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, BlogID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From BlogAccessRequest 
Where ( BlogAccessRequestID = @BlogAccessRequestID Or @BlogAccessRequestID = null ) 
And ( ProfileIDChild = @ProfileIDChild Or @ProfileIDChild = null ) 
And ( ProfileIDParent = @ProfileIDParent Or @ProfileIDParent = null ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile Or @ProfileIDOtherProfile = null ) 
And ( BlogID = @BlogID Or @BlogID = null ) 
And ( Approved = @Approved Or @Approved = null ) 
And ( Deleted = @Deleted Or @Deleted = null ) 
And ( InsertedDateTime = @InsertedDateTime Or @InsertedDateTime = null ) 
And ( ModifiedDateTime = @ModifiedDateTime Or @ModifiedDateTime = null )
GO
/****** Object:  StoredProcedure [dbo].[GetBlogAccessRequest]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetBlogAccessRequest]
AS
Select BlogAccessRequestID, ProfileIDChild, ProfileIDParent, ProfileIDOtherProfile, BlogID, Approved, Deleted, InsertedDateTime, ModifiedDateTime
From BlogAccessRequest
GO
/****** Object:  StoredProcedure [dbo].[DeleteWebsiteLinkAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteWebsiteLinkAccessRequestByPrimaryKey]
	@ProfileIDChild [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDOtherProfileID [uniqueidentifier]
AS
Delete From WebsiteLinkAccessRequest 
Where (( ProfileIDChild = @ProfileIDChild ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDOtherProfileID = @ProfileIDOtherProfileID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteProfile_WebsiteLinkByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteProfile_WebsiteLinkByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@WebsiteLinkID [uniqueidentifier]
AS
Delete From Profile_WebsiteLink 
Where (( ProfileID = @ProfileID ) 
And ( WebsiteLinkID = @WebsiteLinkID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteProfile_PersonByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteProfile_PersonByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@PersonID [uniqueidentifier]
AS
Delete From Profile_Person 
Where (( ProfileID = @ProfileID ) 
And ( PersonID = @PersonID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteProfile_LibraryByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteProfile_LibraryByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@LibraryID [uniqueidentifier]
AS
Delete From Profile_Library 
Where (( ProfileID = @ProfileID ) 
And ( LibraryID = @LibraryID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteProfile_EmailAddressByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteProfile_EmailAddressByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@EmailAddressID [uniqueidentifier]
AS
Delete From Profile_EmailAddress 
Where (( ProfileID = @ProfileID ) 
And ( EmailAddressID = @EmailAddressID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteProfile_ContentByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteProfile_ContentByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@ContentID [uniqueidentifier]
AS
Delete From Profile_Content 
Where (( ProfileID = @ProfileID ) 
And ( ContentID = @ContentID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteProfile_BlogByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteProfile_BlogByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@BlogID [uniqueidentifier]
AS
Delete From Profile_Blog 
Where (( ProfileID = @ProfileID ) 
And ( BlogID = @BlogID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteProfile_AccountByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteProfile_AccountByPrimaryKey]
	@ProfileID [uniqueidentifier],
	@AccountID [uniqueidentifier]
AS
Delete From Profile_Account 
Where (( ProfileID = @ProfileID ) 
And ( AccountID = @AccountID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeletePerson_PhoneNumberByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeletePerson_PhoneNumberByPrimaryKey]
	@PersonID [uniqueidentifier],
	@PhoneNumberID [uniqueidentifier]
AS
Delete From Person_PhoneNumber 
Where (( PersonID = @PersonID ) 
And ( PhoneNumberID = @PhoneNumberID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeletePerson_AddressByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeletePerson_AddressByPrimaryKey]
	@PersonID [uniqueidentifier],
	@AddressID [uniqueidentifier]
AS
Delete From Person_Address 
Where (( PersonID = @PersonID ) 
And ( AddressID = @AddressID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteLibraryAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:38 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteLibraryAccessRequestByPrimaryKey]
	@ProfileIDChild [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDOtherProfile [uniqueidentifier],
	@LibraryID [uniqueidentifier]
AS
Delete From LibraryAccessRequest 
Where (( ProfileIDChild = @ProfileIDChild ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile ) 
And ( LibraryID = @LibraryID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteLibrary_ContentByPrimaryKey]    Script Date: 12/30/2011 08:48:38 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteLibrary_ContentByPrimaryKey]
	@LibraryID [uniqueidentifier],
	@ContentID [uniqueidentifier]
AS
Delete From Library_Content 
Where (( LibraryID = @LibraryID ) 
And ( ContentID = @ContentID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteParent_ChildByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteParent_ChildByPrimaryKey]
	@Parent_ProfileID [uniqueidentifier],
	@Child_ProfileID [uniqueidentifier]
AS
Delete From Parent_Child 
Where (( Parent_ProfileID = @Parent_ProfileID ) 
And ( Child_ProfileID = @Child_ProfileID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteNotificationByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteNotificationByPrimaryKey]
	@NotificationID [uniqueidentifier]
AS
Delete From Notification 
Where  NotificationID = @NotificationID
GO
/****** Object:  StoredProcedure [dbo].[DeleteNotificationAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteNotificationAccessRequestByPrimaryKey]
	@ProfileIDChild [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDOtherProfile [uniqueidentifier]
AS
Delete From NotificationAccessRequest 
Where (( ProfileIDChild = @ProfileIDChild ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteContentTagByPrimaryKey]    Script Date: 12/30/2011 08:48:38 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteContentTagByPrimaryKey]
	@ContentID [uniqueidentifier],
	@Tag [nvarchar](255)
AS
Delete From ContentTag 
Where (( ContentID = @ContentID ) 
And ( Tag = @Tag ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteContentAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:38 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteContentAccessRequestByPrimaryKey]
	@ProfileIDOtherProfile [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDChild [uniqueidentifier],
	@ContentID [uniqueidentifier]
AS
Delete From ContentAccessRequest 
Where (( ProfileIDOtherProfile = @ProfileIDOtherProfile ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDChild = @ProfileIDChild ) 
And ( ContentID = @ContentID ) 
)
GO
/****** Object:  StoredProcedure [dbo].[DeleteBlogAccessRequestByPrimaryKey]    Script Date: 12/30/2011 08:48:38 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteBlogAccessRequestByPrimaryKey]
	@ProfileIDChild [uniqueidentifier],
	@ProfileIDParent [uniqueidentifier],
	@ProfileIDOtherProfile [uniqueidentifier]
AS
Delete From BlogAccessRequest 
Where (( ProfileIDChild = @ProfileIDChild ) 
And ( ProfileIDParent = @ProfileIDParent ) 
And ( ProfileIDOtherProfile = @ProfileIDOtherProfile ) 
)
GO
/****** Object:  Default [DF_Account_AccountID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_AccountID]  DEFAULT (newid()) FOR [AccountID]
GO
/****** Object:  Default [DF_Account_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Account_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Account_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Address_AddressID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_AddressID]  DEFAULT (newid()) FOR [AddressID]
GO
/****** Object:  Default [DF_Address_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Address_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Address_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_AddressType_AddressTypeID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[AddressType] ADD  CONSTRAINT [DF_AddressType_AddressTypeID]  DEFAULT (newid()) FOR [AddressTypeID]
GO
/****** Object:  Default [DF_AddressType_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[AddressType] ADD  CONSTRAINT [DF_AddressType_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_AddressType_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[AddressType] ADD  CONSTRAINT [DF_AddressType_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_AddressType_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[AddressType] ADD  CONSTRAINT [DF_AddressType_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Blog_BlogID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Blog] ADD  CONSTRAINT [DF_Blog_BlogID]  DEFAULT (newid()) FOR [BlogID]
GO
/****** Object:  Default [DF_Blog_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Blog] ADD  CONSTRAINT [DF_Blog_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Blog_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Blog] ADD  CONSTRAINT [DF_Blog_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Blog_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Blog] ADD  CONSTRAINT [DF_Blog_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_BlogAccessRequest_BlogAccessRequestID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[BlogAccessRequest] ADD  CONSTRAINT [DF_BlogAccessRequest_BlogAccessRequestID]  DEFAULT (newid()) FOR [BlogAccessRequestID]
GO
/****** Object:  Default [DF_BlogAccessRequest_Approved]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[BlogAccessRequest] ADD  CONSTRAINT [DF_BlogAccessRequest_Approved]  DEFAULT ((0)) FOR [Approved]
GO
/****** Object:  Default [DF_BlogAccessRequest_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[BlogAccessRequest] ADD  CONSTRAINT [DF_BlogAccessRequest_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_BlogAccessRequest_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[BlogAccessRequest] ADD  CONSTRAINT [DF_BlogAccessRequest_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_BlogAccessRequest_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[BlogAccessRequest] ADD  CONSTRAINT [DF_BlogAccessRequest_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Content_ContentID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_ContentID]  DEFAULT (newid()) FOR [ContentID]
GO
/****** Object:  Default [DF_Content_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Content_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Content_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_ContentAccessRequest_ContentAccessRequestID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentAccessRequest] ADD  CONSTRAINT [DF_ContentAccessRequest_ContentAccessRequestID]  DEFAULT (newid()) FOR [ContentAccessRequestID]
GO
/****** Object:  Default [DF_ContentAccessRequest_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentAccessRequest] ADD  CONSTRAINT [DF_ContentAccessRequest_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_ContentAccessRequest_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentAccessRequest] ADD  CONSTRAINT [DF_ContentAccessRequest_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_ContentAccessRequest_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentAccessRequest] ADD  CONSTRAINT [DF_ContentAccessRequest_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_ContentTag_ContentTagID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentTag] ADD  CONSTRAINT [DF_ContentTag_ContentTagID]  DEFAULT (newid()) FOR [ContentTagID]
GO
/****** Object:  Default [DF_ContentTag_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentTag] ADD  CONSTRAINT [DF_ContentTag_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_ContentTag_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentTag] ADD  CONSTRAINT [DF_ContentTag_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_ContentTag_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentTag] ADD  CONSTRAINT [DF_ContentTag_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_ContentType_ContentTypeID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentType] ADD  CONSTRAINT [DF_ContentType_ContentTypeID]  DEFAULT (newid()) FOR [ContentTypeID]
GO
/****** Object:  Default [DF_ContentType_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentType] ADD  CONSTRAINT [DF_ContentType_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_ContentType_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentType] ADD  CONSTRAINT [DF_ContentType_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_ContentType_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentType] ADD  CONSTRAINT [DF_ContentType_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_EmailAddress_EmailAddressID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[EmailAddress] ADD  CONSTRAINT [DF_EmailAddress_EmailAddressID]  DEFAULT (newid()) FOR [EmailAddressID]
GO
/****** Object:  Default [DF_EmailAddress_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[EmailAddress] ADD  CONSTRAINT [DF_EmailAddress_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_EmailAddress_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[EmailAddress] ADD  CONSTRAINT [DF_EmailAddress_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_EmailAddress_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[EmailAddress] ADD  CONSTRAINT [DF_EmailAddress_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Library_LibraryID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Library] ADD  CONSTRAINT [DF_Library_LibraryID]  DEFAULT (newid()) FOR [LibraryID]
GO
/****** Object:  Default [DF_Library_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Library] ADD  CONSTRAINT [DF_Library_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Library_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Library] ADD  CONSTRAINT [DF_Library_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Library_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Library] ADD  CONSTRAINT [DF_Library_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Library_Content_Library_ContentID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Library_Content] ADD  CONSTRAINT [DF_Library_Content_Library_ContentID]  DEFAULT (newid()) FOR [Library_ContentID]
GO
/****** Object:  Default [DF_Library_Content_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Library_Content] ADD  CONSTRAINT [DF_Library_Content_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Library_Content_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Library_Content] ADD  CONSTRAINT [DF_Library_Content_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Library_Content_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Library_Content] ADD  CONSTRAINT [DF_Library_Content_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_LibraryAccessRequest_LibraryAccessRequestID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[LibraryAccessRequest] ADD  CONSTRAINT [DF_LibraryAccessRequest_LibraryAccessRequestID]  DEFAULT (newid()) FOR [LibraryAccessRequestID]
GO
/****** Object:  Default [DF_LibraryAccessRequest_Approved]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[LibraryAccessRequest] ADD  CONSTRAINT [DF_LibraryAccessRequest_Approved]  DEFAULT ((0)) FOR [Approved]
GO
/****** Object:  Default [DF_LibraryAccessRequest_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[LibraryAccessRequest] ADD  CONSTRAINT [DF_LibraryAccessRequest_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_LibraryAccessRequest_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[LibraryAccessRequest] ADD  CONSTRAINT [DF_LibraryAccessRequest_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_LibraryAccessRequest_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[LibraryAccessRequest] ADD  CONSTRAINT [DF_LibraryAccessRequest_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Notification_NotificationID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Notification] ADD  CONSTRAINT [DF_Notification_NotificationID]  DEFAULT (newid()) FOR [NotificationID]
GO
/****** Object:  Default [DF_Notification_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Notification] ADD  CONSTRAINT [DF_Notification_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Notification_InsertedDatetime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Notification] ADD  CONSTRAINT [DF_Notification_InsertedDatetime]  DEFAULT (getdate()) FOR [InsertedDatetime]
GO
/****** Object:  Default [DF_Notification_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Notification] ADD  CONSTRAINT [DF_Notification_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_NotificationAccessRequest_NotificationAccessRequestID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[NotificationAccessRequest] ADD  CONSTRAINT [DF_NotificationAccessRequest_NotificationAccessRequestID]  DEFAULT (newid()) FOR [NotificationAccessRequestID]
GO
/****** Object:  Default [DF_NotificationAccessRequest_Approved]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[NotificationAccessRequest] ADD  CONSTRAINT [DF_NotificationAccessRequest_Approved]  DEFAULT ((0)) FOR [Approved]
GO
/****** Object:  Default [DF_NotificationAccessRequest_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[NotificationAccessRequest] ADD  CONSTRAINT [DF_NotificationAccessRequest_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_NotificationAccessRequest_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[NotificationAccessRequest] ADD  CONSTRAINT [DF_NotificationAccessRequest_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_NotificationAccessRequest_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[NotificationAccessRequest] ADD  CONSTRAINT [DF_NotificationAccessRequest_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Parent_Child_Parent_ChildID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Parent_Child] ADD  CONSTRAINT [DF_Parent_Child_Parent_ChildID]  DEFAULT (newid()) FOR [Parent_ChildID]
GO
/****** Object:  Default [DF_Person_PersonID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_PersonID]  DEFAULT (newid()) FOR [PersonID]
GO
/****** Object:  Default [DF_Person_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Person_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Person_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Person_Address_Person_AddressID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person_Address] ADD  CONSTRAINT [DF_Person_Address_Person_AddressID]  DEFAULT (newid()) FOR [Person_AddressID]
GO
/****** Object:  Default [DF_Person_Address_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person_Address] ADD  CONSTRAINT [DF_Person_Address_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Person_Address_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person_Address] ADD  CONSTRAINT [DF_Person_Address_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Person_Address_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person_Address] ADD  CONSTRAINT [DF_Person_Address_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Person_PhoneNumber_Person_PhoneNumberID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person_PhoneNumber] ADD  CONSTRAINT [DF_Person_PhoneNumber_Person_PhoneNumberID]  DEFAULT (newid()) FOR [Person_PhoneNumberID]
GO
/****** Object:  Default [DF_Person_PhoneNumber_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person_PhoneNumber] ADD  CONSTRAINT [DF_Person_PhoneNumber_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Person_PhoneNumber_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person_PhoneNumber] ADD  CONSTRAINT [DF_Person_PhoneNumber_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Person_PhoneNumber_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person_PhoneNumber] ADD  CONSTRAINT [DF_Person_PhoneNumber_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_PhoneNumber_PhoneNumberID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[PhoneNumber] ADD  CONSTRAINT [DF_PhoneNumber_PhoneNumberID]  DEFAULT (newid()) FOR [PhoneNumberID]
GO
/****** Object:  Default [DF_PhoneNumber_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[PhoneNumber] ADD  CONSTRAINT [DF_PhoneNumber_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_PhoneNumber_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[PhoneNumber] ADD  CONSTRAINT [DF_PhoneNumber_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_PhoneNumber_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[PhoneNumber] ADD  CONSTRAINT [DF_PhoneNumber_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_PhoneNumberType_PhoneNumberTypeID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[PhoneNumberType] ADD  CONSTRAINT [DF_PhoneNumberType_PhoneNumberTypeID]  DEFAULT (newid()) FOR [PhoneNumberTypeID]
GO
/****** Object:  Default [DF_PhoneNumberType_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[PhoneNumberType] ADD  CONSTRAINT [DF_PhoneNumberType_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_PhoneNumberType_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[PhoneNumberType] ADD  CONSTRAINT [DF_PhoneNumberType_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_PhoneNumberType_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[PhoneNumberType] ADD  CONSTRAINT [DF_PhoneNumberType_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Profile_ProfileID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile] ADD  CONSTRAINT [DF_Profile_ProfileID]  DEFAULT (newid()) FOR [ProfileID]
GO
/****** Object:  Default [DF_Profile_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile] ADD  CONSTRAINT [DF_Profile_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Profile_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile] ADD  CONSTRAINT [DF_Profile_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Profile_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile] ADD  CONSTRAINT [DF_Profile_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Profile_Account_Profile_AccountID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Account] ADD  CONSTRAINT [DF_Profile_Account_Profile_AccountID]  DEFAULT (newid()) FOR [Profile_AccountID]
GO
/****** Object:  Default [DF_Profile_Account_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Account] ADD  CONSTRAINT [DF_Profile_Account_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Profile_Account_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Account] ADD  CONSTRAINT [DF_Profile_Account_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Profile_Account_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Account] ADD  CONSTRAINT [DF_Profile_Account_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Profile_Blog_Profile_BlogID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Blog] ADD  CONSTRAINT [DF_Profile_Blog_Profile_BlogID]  DEFAULT (newid()) FOR [Profile_BlogID]
GO
/****** Object:  Default [DF_Profile_Blog_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Blog] ADD  CONSTRAINT [DF_Profile_Blog_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Profile_Blog_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Blog] ADD  CONSTRAINT [DF_Profile_Blog_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Profile_Blog_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Blog] ADD  CONSTRAINT [DF_Profile_Blog_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Profile_Content_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Content] ADD  CONSTRAINT [DF_Profile_Content_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Profile_Content_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Content] ADD  CONSTRAINT [DF_Profile_Content_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Profile_Content_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Content] ADD  CONSTRAINT [DF_Profile_Content_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Profile_EmailAddress_Profile_AccountID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_EmailAddress] ADD  CONSTRAINT [DF_Profile_EmailAddress_Profile_AccountID]  DEFAULT (newid()) FOR [Profile_EmailAddressID]
GO
/****** Object:  Default [DF_Profile_EmailAddress_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_EmailAddress] ADD  CONSTRAINT [DF_Profile_EmailAddress_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Profile_EmailAddress_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_EmailAddress] ADD  CONSTRAINT [DF_Profile_EmailAddress_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Profile_EmailAddress_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_EmailAddress] ADD  CONSTRAINT [DF_Profile_EmailAddress_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Profile_Library_Profile_LibraryID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Library] ADD  CONSTRAINT [DF_Profile_Library_Profile_LibraryID]  DEFAULT (newid()) FOR [Profile_LibraryID]
GO
/****** Object:  Default [DF_Profile_Library_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Library] ADD  CONSTRAINT [DF_Profile_Library_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Profile_Library_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Library] ADD  CONSTRAINT [DF_Profile_Library_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Profile_Library_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Library] ADD  CONSTRAINT [DF_Profile_Library_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Profile_Person_Profile_AccountID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Person] ADD  CONSTRAINT [DF_Profile_Person_Profile_AccountID]  DEFAULT (newid()) FOR [Profile_PersonID]
GO
/****** Object:  Default [DF_Profile_Person_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Person] ADD  CONSTRAINT [DF_Profile_Person_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Profile_Person_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Person] ADD  CONSTRAINT [DF_Profile_Person_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Profile_Person_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Person] ADD  CONSTRAINT [DF_Profile_Person_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_Profile_WebsiteLink_Profile_WebsiteLinkID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_WebsiteLink] ADD  CONSTRAINT [DF_Profile_WebsiteLink_Profile_WebsiteLinkID]  DEFAULT (newid()) FOR [Profile_WebsiteLinkID]
GO
/****** Object:  Default [DF_Profile_WebsiteLink_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_WebsiteLink] ADD  CONSTRAINT [DF_Profile_WebsiteLink_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Profile_WebsiteLink_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_WebsiteLink] ADD  CONSTRAINT [DF_Profile_WebsiteLink_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_Profile_WebsiteLink_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_WebsiteLink] ADD  CONSTRAINT [DF_Profile_WebsiteLink_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_ProfileType_ProfileTypeID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ProfileType] ADD  CONSTRAINT [DF_ProfileType_ProfileTypeID]  DEFAULT (newid()) FOR [ProfileTypeID]
GO
/****** Object:  Default [DF_ProfileType_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ProfileType] ADD  CONSTRAINT [DF_ProfileType_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_ProfileType_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ProfileType] ADD  CONSTRAINT [DF_ProfileType_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_ProfileType_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ProfileType] ADD  CONSTRAINT [DF_ProfileType_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_SearchTerm_SearchTermID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[SearchTerm] ADD  CONSTRAINT [DF_SearchTerm_SearchTermID]  DEFAULT (newid()) FOR [SearchTermID]
GO
/****** Object:  Default [DF_SearchTerm_Count]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[SearchTerm] ADD  CONSTRAINT [DF_SearchTerm_Count]  DEFAULT ((1)) FOR [Count]
GO
/****** Object:  Default [DF_SearchTerm_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[SearchTerm] ADD  CONSTRAINT [DF_SearchTerm_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_SearchTerm_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[SearchTerm] ADD  CONSTRAINT [DF_SearchTerm_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_SearchTerm_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[SearchTerm] ADD  CONSTRAINT [DF_SearchTerm_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_WebsiteLink_WebsiteLinkID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLink] ADD  CONSTRAINT [DF_WebsiteLink_WebsiteLinkID]  DEFAULT (newid()) FOR [WebsiteLinkID]
GO
/****** Object:  Default [DF_WebsiteLink_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLink] ADD  CONSTRAINT [DF_WebsiteLink_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_WebsiteLink_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLink] ADD  CONSTRAINT [DF_WebsiteLink_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_WebsiteLink_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLink] ADD  CONSTRAINT [DF_WebsiteLink_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  Default [DF_WebsiteLinkAccessRequest_WebsiteLinkAccessRequestID]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLinkAccessRequest] ADD  CONSTRAINT [DF_WebsiteLinkAccessRequest_WebsiteLinkAccessRequestID]  DEFAULT (newid()) FOR [WebsiteLinkAccessRequestID]
GO
/****** Object:  Default [DF_WebsiteLinkAccessRequest_Approved]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLinkAccessRequest] ADD  CONSTRAINT [DF_WebsiteLinkAccessRequest_Approved]  DEFAULT ((0)) FOR [Approved]
GO
/****** Object:  Default [DF_WebsiteLinkAccessRequest_Deleted]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLinkAccessRequest] ADD  CONSTRAINT [DF_WebsiteLinkAccessRequest_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_WebsiteLinkAccessRequest_InsertedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLinkAccessRequest] ADD  CONSTRAINT [DF_WebsiteLinkAccessRequest_InsertedDateTime]  DEFAULT (getdate()) FOR [InsertedDateTime]
GO
/****** Object:  Default [DF_WebsiteLinkAccessRequest_ModifiedDateTime]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLinkAccessRequest] ADD  CONSTRAINT [DF_WebsiteLinkAccessRequest_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
GO
/****** Object:  ForeignKey [FK_Address_AddressType]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_AddressType] FOREIGN KEY([AddressTypeID])
REFERENCES [dbo].[AddressType] ([AddressTypeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_AddressType]
GO
/****** Object:  ForeignKey [FK_BlogAccessRequest_Blog]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[BlogAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_BlogAccessRequest_Blog] FOREIGN KEY([BlogID])
REFERENCES [dbo].[Blog] ([BlogID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BlogAccessRequest] CHECK CONSTRAINT [FK_BlogAccessRequest_Blog]
GO
/****** Object:  ForeignKey [FK_BlogAccessRequest_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[BlogAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_BlogAccessRequest_Profile] FOREIGN KEY([ProfileIDChild])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BlogAccessRequest] CHECK CONSTRAINT [FK_BlogAccessRequest_Profile]
GO
/****** Object:  ForeignKey [FK_BlogAccessRequest_Profile1]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[BlogAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_BlogAccessRequest_Profile1] FOREIGN KEY([ProfileIDParent])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[BlogAccessRequest] CHECK CONSTRAINT [FK_BlogAccessRequest_Profile1]
GO
/****** Object:  ForeignKey [FK_BlogAccessRequest_Profile2]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[BlogAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_BlogAccessRequest_Profile2] FOREIGN KEY([ProfileIDOtherProfile])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[BlogAccessRequest] CHECK CONSTRAINT [FK_BlogAccessRequest_Profile2]
GO
/****** Object:  ForeignKey [FK_Content_ContentType]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Content]  WITH CHECK ADD  CONSTRAINT [FK_Content_ContentType] FOREIGN KEY([ContentTypeID])
REFERENCES [dbo].[ContentType] ([ContentTypeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Content] CHECK CONSTRAINT [FK_Content_ContentType]
GO
/****** Object:  ForeignKey [FK_ContentAccessRequest_Content]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_ContentAccessRequest_Content] FOREIGN KEY([ContentID])
REFERENCES [dbo].[Content] ([ContentID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentAccessRequest] CHECK CONSTRAINT [FK_ContentAccessRequest_Content]
GO
/****** Object:  ForeignKey [FK_ContentAccessRequest_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_ContentAccessRequest_Profile] FOREIGN KEY([ProfileIDParent])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentAccessRequest] CHECK CONSTRAINT [FK_ContentAccessRequest_Profile]
GO
/****** Object:  ForeignKey [FK_ContentAccessRequest_Profile1]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_ContentAccessRequest_Profile1] FOREIGN KEY([ProfileIDOtherProfile])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[ContentAccessRequest] CHECK CONSTRAINT [FK_ContentAccessRequest_Profile1]
GO
/****** Object:  ForeignKey [FK_ContentTag_Content]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[ContentTag]  WITH CHECK ADD  CONSTRAINT [FK_ContentTag_Content] FOREIGN KEY([ContentID])
REFERENCES [dbo].[Content] ([ContentID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentTag] CHECK CONSTRAINT [FK_ContentTag_Content]
GO
/****** Object:  ForeignKey [FK_Library_ContentType]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Library]  WITH CHECK ADD  CONSTRAINT [FK_Library_ContentType] FOREIGN KEY([ContentTypeID])
REFERENCES [dbo].[ContentType] ([ContentTypeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Library] CHECK CONSTRAINT [FK_Library_ContentType]
GO
/****** Object:  ForeignKey [FK_Library_Content_Content]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Library_Content]  WITH CHECK ADD  CONSTRAINT [FK_Library_Content_Content] FOREIGN KEY([ContentID])
REFERENCES [dbo].[Content] ([ContentID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Library_Content] CHECK CONSTRAINT [FK_Library_Content_Content]
GO
/****** Object:  ForeignKey [FK_LibraryAccessRequest_Library]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[LibraryAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_LibraryAccessRequest_Library] FOREIGN KEY([LibraryID])
REFERENCES [dbo].[Library] ([LibraryID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LibraryAccessRequest] CHECK CONSTRAINT [FK_LibraryAccessRequest_Library]
GO
/****** Object:  ForeignKey [FK_LibraryAccessRequest_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[LibraryAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_LibraryAccessRequest_Profile] FOREIGN KEY([ProfileIDChild])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LibraryAccessRequest] CHECK CONSTRAINT [FK_LibraryAccessRequest_Profile]
GO
/****** Object:  ForeignKey [FK_LibraryAccessRequest_Profile1]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[LibraryAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_LibraryAccessRequest_Profile1] FOREIGN KEY([ProfileIDOtherProfile])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[LibraryAccessRequest] CHECK CONSTRAINT [FK_LibraryAccessRequest_Profile1]
GO
/****** Object:  ForeignKey [FK_LibraryAccessRequest_Profile2]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[LibraryAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_LibraryAccessRequest_Profile2] FOREIGN KEY([ProfileIDOtherProfile])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[LibraryAccessRequest] CHECK CONSTRAINT [FK_LibraryAccessRequest_Profile2]
GO
/****** Object:  ForeignKey [FK_Notification_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Profile] FOREIGN KEY([ProfileIDFrom])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Profile]
GO
/****** Object:  ForeignKey [FK_Notification_Profile1]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Profile1] FOREIGN KEY([ProfileIDTo])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Profile1]
GO
/****** Object:  ForeignKey [FK_Notification_Profile2]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Profile2] FOREIGN KEY([ProfileIDFrom])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Profile2]
GO
/****** Object:  ForeignKey [FK_NotificationAccessRequest_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[NotificationAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_NotificationAccessRequest_Profile] FOREIGN KEY([ProfileIDChild])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NotificationAccessRequest] CHECK CONSTRAINT [FK_NotificationAccessRequest_Profile]
GO
/****** Object:  ForeignKey [FK_NotificationAccessRequest_Profile1]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[NotificationAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_NotificationAccessRequest_Profile1] FOREIGN KEY([ProfileIDParent])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[NotificationAccessRequest] CHECK CONSTRAINT [FK_NotificationAccessRequest_Profile1]
GO
/****** Object:  ForeignKey [FK_NotificationAccessRequest_Profile2]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[NotificationAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_NotificationAccessRequest_Profile2] FOREIGN KEY([ProfileIDOtherProfile])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[NotificationAccessRequest] CHECK CONSTRAINT [FK_NotificationAccessRequest_Profile2]
GO
/****** Object:  ForeignKey [FK_NotificationAccessRequest_Profile3]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[NotificationAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_NotificationAccessRequest_Profile3] FOREIGN KEY([ProfileIDOtherProfile])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[NotificationAccessRequest] CHECK CONSTRAINT [FK_NotificationAccessRequest_Profile3]
GO
/****** Object:  ForeignKey [FK_Parent_Child_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Parent_Child]  WITH CHECK ADD  CONSTRAINT [FK_Parent_Child_Profile] FOREIGN KEY([Parent_ProfileID])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Parent_Child] CHECK CONSTRAINT [FK_Parent_Child_Profile]
GO
/****** Object:  ForeignKey [FK_Parent_Child_Profile1]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Parent_Child]  WITH CHECK ADD  CONSTRAINT [FK_Parent_Child_Profile1] FOREIGN KEY([Child_ProfileID])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[Parent_Child] CHECK CONSTRAINT [FK_Parent_Child_Profile1]
GO
/****** Object:  ForeignKey [FK_Person_Address_Address]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person_Address]  WITH CHECK ADD  CONSTRAINT [FK_Person_Address_Address] FOREIGN KEY([AddressID])
REFERENCES [dbo].[Address] ([AddressID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Person_Address] CHECK CONSTRAINT [FK_Person_Address_Address]
GO
/****** Object:  ForeignKey [FK_Person_Address_Person]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person_Address]  WITH CHECK ADD  CONSTRAINT [FK_Person_Address_Person] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Person_Address] CHECK CONSTRAINT [FK_Person_Address_Person]
GO
/****** Object:  ForeignKey [FK_Person_PhoneNumber_Person]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person_PhoneNumber]  WITH CHECK ADD  CONSTRAINT [FK_Person_PhoneNumber_Person] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Person_PhoneNumber] CHECK CONSTRAINT [FK_Person_PhoneNumber_Person]
GO
/****** Object:  ForeignKey [FK_Person_PhoneNumber_PhoneNumber]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Person_PhoneNumber]  WITH CHECK ADD  CONSTRAINT [FK_Person_PhoneNumber_PhoneNumber] FOREIGN KEY([PhoneNumberID])
REFERENCES [dbo].[PhoneNumber] ([PhoneNumberID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Person_PhoneNumber] CHECK CONSTRAINT [FK_Person_PhoneNumber_PhoneNumber]
GO
/****** Object:  ForeignKey [FK_PhoneNumber_PhoneNumberType]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[PhoneNumber]  WITH CHECK ADD  CONSTRAINT [FK_PhoneNumber_PhoneNumberType] FOREIGN KEY([PhoneNumberTypeID])
REFERENCES [dbo].[PhoneNumberType] ([PhoneNumberTypeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PhoneNumber] CHECK CONSTRAINT [FK_PhoneNumber_PhoneNumberType]
GO
/****** Object:  ForeignKey [FK_Profile_ProfileType]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [FK_Profile_ProfileType] FOREIGN KEY([ProfileTypeID])
REFERENCES [dbo].[ProfileType] ([ProfileTypeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile] CHECK CONSTRAINT [FK_Profile_ProfileType]
GO
/****** Object:  ForeignKey [FK_Profile_Account_Account]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Account]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Account_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_Account] CHECK CONSTRAINT [FK_Profile_Account_Account]
GO
/****** Object:  ForeignKey [FK_Profile_Account_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Account]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Account_Profile] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_Account] CHECK CONSTRAINT [FK_Profile_Account_Profile]
GO
/****** Object:  ForeignKey [FK_Profile_Blog_Blog]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Blog]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Blog_Blog] FOREIGN KEY([BlogID])
REFERENCES [dbo].[Blog] ([BlogID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_Blog] CHECK CONSTRAINT [FK_Profile_Blog_Blog]
GO
/****** Object:  ForeignKey [FK_Profile_Blog_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Blog]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Blog_Profile] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_Blog] CHECK CONSTRAINT [FK_Profile_Blog_Profile]
GO
/****** Object:  ForeignKey [FK_Profile_Content_Content]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Content]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Content_Content] FOREIGN KEY([ContentID])
REFERENCES [dbo].[Content] ([ContentID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_Content] CHECK CONSTRAINT [FK_Profile_Content_Content]
GO
/****** Object:  ForeignKey [FK_Profile_Content_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Content]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Content_Profile] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_Content] CHECK CONSTRAINT [FK_Profile_Content_Profile]
GO
/****** Object:  ForeignKey [FK_Profile_EmailAddress_EmailAddress]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_EmailAddress]  WITH CHECK ADD  CONSTRAINT [FK_Profile_EmailAddress_EmailAddress] FOREIGN KEY([EmailAddressID])
REFERENCES [dbo].[EmailAddress] ([EmailAddressID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_EmailAddress] CHECK CONSTRAINT [FK_Profile_EmailAddress_EmailAddress]
GO
/****** Object:  ForeignKey [FK_Profile_EmailAddress_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_EmailAddress]  WITH CHECK ADD  CONSTRAINT [FK_Profile_EmailAddress_Profile] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_EmailAddress] CHECK CONSTRAINT [FK_Profile_EmailAddress_Profile]
GO
/****** Object:  ForeignKey [FK_Profile_Library_Library]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Library]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Library_Library] FOREIGN KEY([LibraryID])
REFERENCES [dbo].[Library] ([LibraryID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_Library] CHECK CONSTRAINT [FK_Profile_Library_Library]
GO
/****** Object:  ForeignKey [FK_Profile_Library_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Library]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Library_Profile] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_Library] CHECK CONSTRAINT [FK_Profile_Library_Profile]
GO
/****** Object:  ForeignKey [FK_Profile_Person_Person]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Person]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Person_Person] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_Person] CHECK CONSTRAINT [FK_Profile_Person_Person]
GO
/****** Object:  ForeignKey [FK_Profile_Person_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_Person]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Person_Profile] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_Person] CHECK CONSTRAINT [FK_Profile_Person_Profile]
GO
/****** Object:  ForeignKey [FK_Profile_WebsiteLink_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_WebsiteLink]  WITH CHECK ADD  CONSTRAINT [FK_Profile_WebsiteLink_Profile] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_WebsiteLink] CHECK CONSTRAINT [FK_Profile_WebsiteLink_Profile]
GO
/****** Object:  ForeignKey [FK_Profile_WebsiteLink_WebsiteLink]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[Profile_WebsiteLink]  WITH CHECK ADD  CONSTRAINT [FK_Profile_WebsiteLink_WebsiteLink] FOREIGN KEY([WebsiteLinkID])
REFERENCES [dbo].[WebsiteLink] ([WebsiteLinkID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profile_WebsiteLink] CHECK CONSTRAINT [FK_Profile_WebsiteLink_WebsiteLink]
GO
/****** Object:  ForeignKey [FK_WebsiteLinkAccessRequest_Profile]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLinkAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_WebsiteLinkAccessRequest_Profile] FOREIGN KEY([ProfileIDChild])
REFERENCES [dbo].[Profile] ([ProfileID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebsiteLinkAccessRequest] CHECK CONSTRAINT [FK_WebsiteLinkAccessRequest_Profile]
GO
/****** Object:  ForeignKey [FK_WebsiteLinkAccessRequest_Profile1]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLinkAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_WebsiteLinkAccessRequest_Profile1] FOREIGN KEY([ProfileIDParent])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[WebsiteLinkAccessRequest] CHECK CONSTRAINT [FK_WebsiteLinkAccessRequest_Profile1]
GO
/****** Object:  ForeignKey [FK_WebsiteLinkAccessRequest_Profile2]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLinkAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_WebsiteLinkAccessRequest_Profile2] FOREIGN KEY([ProfileIDOtherProfileID])
REFERENCES [dbo].[Profile] ([ProfileID])
GO
ALTER TABLE [dbo].[WebsiteLinkAccessRequest] CHECK CONSTRAINT [FK_WebsiteLinkAccessRequest_Profile2]
GO
/****** Object:  ForeignKey [FK_WebsiteLinkAccessRequest_WebsiteLink]    Script Date: 12/30/2011 08:48:36 ******/
ALTER TABLE [dbo].[WebsiteLinkAccessRequest]  WITH CHECK ADD  CONSTRAINT [FK_WebsiteLinkAccessRequest_WebsiteLink] FOREIGN KEY([WebsiteLinkID])
REFERENCES [dbo].[WebsiteLink] ([WebsiteLinkID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebsiteLinkAccessRequest] CHECK CONSTRAINT [FK_WebsiteLinkAccessRequest_WebsiteLink]
GO
