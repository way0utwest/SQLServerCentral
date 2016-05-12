CREATE TABLE [dbo].[StaticTextFragments]
(
[StaticTextFragmentID] [int] NOT NULL IDENTITY(1, 1),
[KeyText] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[StaticText] [varchar] (8000) COLLATE Latin1_General_CI_AS NULL,
[ContainsTokens] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StaticTextFragments] ADD CONSTRAINT [PK_StaticTextFragments] PRIMARY KEY CLUSTERED  ([StaticTextFragmentID]) WITH (FILLFACTOR=99) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[StaticTextFragments] TO [ssc_webapplication]
GO
GRANT INSERT ON  [dbo].[StaticTextFragments] TO [ssc_webapplication]
GO
GRANT UPDATE ON  [dbo].[StaticTextFragments] TO [ssc_webapplication]
GO
