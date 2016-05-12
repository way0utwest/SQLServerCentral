CREATE TABLE [dbo].[Adverts]
(
[ContentItemID] [int] NOT NULL,
[PlainTextRepresentation] [text] COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Adverts] ADD CONSTRAINT [PK_Adverts] PRIMARY KEY CLUSTERED  ([ContentItemID]) WITH (FILLFACTOR=90) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[Adverts] TO [ssc_webapplication]
GO
GRANT INSERT ON  [dbo].[Adverts] TO [ssc_webapplication]
GO
GRANT UPDATE ON  [dbo].[Adverts] TO [ssc_webapplication]
GO
