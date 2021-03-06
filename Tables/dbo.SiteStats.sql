CREATE TABLE [dbo].[SiteStats]
(
[StatID] [int] NOT NULL IDENTITY(1, 1),
[StatEntryDate] [date] NULL CONSTRAINT [DF__SiteStats__State__4589517F] DEFAULT (sysdatetime()),
[StatMonth] [tinyint] NULL,
[StatYear] [smallint] NULL,
[PageVisits] [int] NULL,
[TimeOnSite] [time] NULL,
[Engagement] AS (CONVERT([bigint],[PageVisits],(0))*datediff(second,CONVERT([time],'00:00:00',(0)),[TimeOnSite]))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SiteStats] ADD CONSTRAINT [PK__SiteStat__3A162D1F2D3977E0] PRIMARY KEY NONCLUSTERED  ([StatID]) ON [PRIMARY]
GO
