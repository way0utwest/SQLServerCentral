CREATE TABLE [dbo].[UtilitiesLog]
(
[UtilitiesLogEntryID] [int] NOT NULL IDENTITY(1, 1),
[Date] [datetime] NOT NULL,
[Thread] [varchar] (255) COLLATE Latin1_General_CI_AS NOT NULL,
[Level] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Logger] [varchar] (255) COLLATE Latin1_General_CI_AS NOT NULL,
[Message] [varchar] (4000) COLLATE Latin1_General_CI_AS NOT NULL,
[Exception] [varchar] (2000) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [PK_UtilitiesLog] ON [dbo].[UtilitiesLog] ([UtilitiesLogEntryID]) WITH (FILLFACTOR=90) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[UtilitiesLog] TO [ssc_webapplication]
GO
