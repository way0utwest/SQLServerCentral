CREATE TABLE [dbo].[EmailerConfiguration]
(
[ComputerName] [nvarchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[Active] [bit] NOT NULL,
[BatchSize] [int] NOT NULL,
[Priority] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailerConfiguration] ADD CONSTRAINT [PK_EmailerConfiguration] PRIMARY KEY CLUSTERED  ([ComputerName]) WITH (FILLFACTOR=99) ON [PRIMARY]
GO
