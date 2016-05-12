CREATE TABLE [dbo].[EmailRecipients]
(
[EmailRecipientID] [int] NOT NULL IDENTITY(1, 1),
[EmailID] [int] NOT NULL,
[UserID] [int] NULL,
[SentDate] [datetime] NULL,
[SendingComputerName] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[ArbitraryRecipientName] [nvarchar] (500) COLLATE Latin1_General_CI_AS NULL,
[ArbitraryRecipientEmailAddress] [nvarchar] (500) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailRecipients] ADD CONSTRAINT [PK_EmailRecipients] PRIMARY KEY CLUSTERED  ([EmailRecipientID]) WITH (FILLFACTOR=80) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EmailAndRecipients] ON [dbo].[EmailRecipients] ([EmailID], [EmailRecipientID]) INCLUDE ([SendingComputerName], [SentDate]) WITH (FILLFACTOR=80) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [SSC_SentDate] ON [dbo].[EmailRecipients] ([SentDate], [SendingComputerName]) INCLUDE ([EmailID], [EmailRecipientID]) WITH (FILLFACTOR=90) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EmailRecipients_UserID_SentDate] ON [dbo].[EmailRecipients] ([UserID], [SentDate]) INCLUDE ([EmailID], [EmailRecipientID], [SendingComputerName]) WITH (FILLFACTOR=90) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmailRecipients] ADD CONSTRAINT [FK_EmailRecipients_EmailRecipients] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmailRecipients] ADD CONSTRAINT [FK_EmailRecipients_Emails] FOREIGN KEY ([EmailID]) REFERENCES [dbo].[Emails] ([EmailID]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[EmailRecipients] TO [ssc_webapplication]
GO
GRANT INSERT ON  [dbo].[EmailRecipients] TO [ssc_webapplication]
GO
GRANT DELETE ON  [dbo].[EmailRecipients] TO [ssc_webapplication]
GO
GRANT UPDATE ON  [dbo].[EmailRecipients] TO [ssc_webapplication]
GO
