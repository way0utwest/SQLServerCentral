CREATE TABLE [dbo].[UserSearches]
(
[UserID] [int] NULL,
[Search] [nvarchar] (1000) COLLATE Latin1_General_CI_AS NOT NULL,
[SearchDate] [datetime] NOT NULL CONSTRAINT [DF_UserSearches_SearchDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [UserID_ClusteredIndex] ON [dbo].[UserSearches] ([UserID]) WITH (FILLFACTOR=99) ON [PRIMARY]
GO
