CREATE ROLE [Emailer]
AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'Emailer', N'ssc_emailer'
GO
