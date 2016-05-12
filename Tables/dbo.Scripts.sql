CREATE TABLE [dbo].[Scripts]
(
[ContentItemID] [int] NOT NULL,
[SqlCode] [ntext] COLLATE Latin1_General_CI_AS NULL,
[Rgtool] [ntext] COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Scripts] ADD CONSTRAINT [PK_Scripts] PRIMARY KEY CLUSTERED  ([ContentItemID]) WITH (FILLFACTOR=99) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[Scripts] TO [ssc_webapplication]
GO
GRANT INSERT ON  [dbo].[Scripts] TO [ssc_webapplication]
GO
GRANT DELETE ON  [dbo].[Scripts] TO [ssc_webapplication]
GO
GRANT UPDATE ON  [dbo].[Scripts] TO [ssc_webapplication]
GO
