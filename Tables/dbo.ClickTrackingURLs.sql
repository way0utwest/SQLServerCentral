CREATE TABLE [dbo].[ClickTrackingURLs]
(
[UrlID] [int] NOT NULL IDENTITY(1, 1),
[EmailID] [int] NOT NULL,
[Url] [varchar] (800) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClickTrackingURLs] ADD CONSTRAINT [PK_ClickTrackingURLs] PRIMARY KEY CLUSTERED  ([UrlID]) WITH (FILLFACTOR=99) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ssc_emailid] ON [dbo].[ClickTrackingURLs] ([EmailID]) INCLUDE ([Url]) WITH (FILLFACTOR=99) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClickTrackingURLs] ADD CONSTRAINT [FK_ClickTrackingURLs_Emails] FOREIGN KEY ([EmailID]) REFERENCES [dbo].[Emails] ([EmailID]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[ClickTrackingURLs] TO [ssc_webapplication]
GO
GRANT INSERT ON  [dbo].[ClickTrackingURLs] TO [ssc_webapplication]
GO
GRANT DELETE ON  [dbo].[ClickTrackingURLs] TO [ssc_webapplication]
GO
GRANT UPDATE ON  [dbo].[ClickTrackingURLs] TO [ssc_webapplication]
GO
