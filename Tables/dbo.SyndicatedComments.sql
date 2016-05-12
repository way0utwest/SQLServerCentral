CREATE TABLE [dbo].[SyndicatedComments]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[SyndicatedId] [nvarchar] (255) COLLATE Latin1_General_CI_AS NOT NULL,
[PublicationDateTime] [datetime] NOT NULL,
[Author] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Body] [nvarchar] (max) COLLATE Latin1_General_CI_AS NOT NULL,
[SyndicatedCommentCacheId] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SyndicatedComments] ADD CONSTRAINT [PK__Syndicat__3214EC0715DA3E5D] PRIMARY KEY CLUSTERED  ([Id]) WITH (FILLFACTOR=90) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SyndicatedComments] ADD CONSTRAINT [FK74AB2C6E759E7848] FOREIGN KEY ([SyndicatedCommentCacheId]) REFERENCES [dbo].[SyndicatedCommentCaches] ([Id])
GO
GRANT SELECT ON  [dbo].[SyndicatedComments] TO [ssc_webapplication]
GO
GRANT INSERT ON  [dbo].[SyndicatedComments] TO [ssc_webapplication]
GO
GRANT DELETE ON  [dbo].[SyndicatedComments] TO [ssc_webapplication]
GO
GRANT UPDATE ON  [dbo].[SyndicatedComments] TO [ssc_webapplication]
GO
