CREATE TABLE [dbo].[CliFor_ScontiFamiglia]
(
[ID] [uniqueidentifier] NOT NULL,
[IDCliFor] [uniqueidentifier] NULL,
[IDFamiglia] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Sconto] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_ScontiFamiglia] ADD CONSTRAINT [PK_CliFor_ScontiFamiglia] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_ScontiFamiglia] ADD CONSTRAINT [FK_CliFor_ScontiFamiglia_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CliFor_ScontiFamiglia] ADD CONSTRAINT [FK_CliFor_ScontiFamiglia_Famiglie] FOREIGN KEY ([IDFamiglia]) REFERENCES [dbo].[Famiglie] ([ID]) ON UPDATE CASCADE
GO
