CREATE TABLE [dbo].[ContentItemsScheduledRelease]
(
[contentItemID] [int] NULL,
[ReleaseDate] [datetime] NULL,
[released] [tinyint] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ContentItemID] ON [dbo].[ContentItemsScheduledRelease] ([contentItemID]) WITH (FILLFACTOR=99) ON [PRIMARY]
GO
