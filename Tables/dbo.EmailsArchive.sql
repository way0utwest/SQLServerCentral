CREATE TABLE [dbo].[EmailsArchive]
(
[EmailID] [int] NOT NULL,
[RecordType] [char] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[EmailTypeName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[IsTest] [bit] NULL,
[UseClickTracking] [bit] NOT NULL,
[SubjectText] [varchar] (500) COLLATE Latin1_General_CI_AS NOT NULL,
[BodyHTML] [text] COLLATE Latin1_General_CI_AS NOT NULL,
[BodyPlainText] [text] COLLATE Latin1_General_CI_AS NOT NULL,
[SenderName] [varchar] (500) COLLATE Latin1_General_CI_AS NULL,
[SenderEmailAddress] [varchar] (500) COLLATE Latin1_General_CI_AS NOT NULL,
[Status] [int] NULL,
[ScheduleForDate] [datetime] NULL,
[ApprovedForSending] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailsArchive] ADD CONSTRAINT [PK_EmailsArchive] PRIMARY KEY CLUSTERED  ([EmailID]) WITH (FILLFACTOR=99) ON [PRIMARY]
GO
