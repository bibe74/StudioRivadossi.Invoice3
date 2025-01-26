CREATE TABLE [dbo].[CliFor_PlafondEsenzione]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDCliFor] [uniqueidentifier] NOT NULL,
[CodiceEsenzione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[DataInizio] [date] NULL,
[DataFine] [date] NULL,
[DescrizioneEsenzione] [nvarchar] (200) COLLATE Latin1_General_CI_AS NULL,
[ImpTotale] [numeric] (19, 6) NOT NULL,
[ImpConsumato] [numeric] (19, 6) NULL CONSTRAINT [DF_CliFor_PlafondEsenzione_ImpConsumato] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_PlafondEsenzione] ADD CONSTRAINT [PK_CliFor_PlafondEsenzione] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CliFor_PlafondEsenzione] ON [dbo].[CliFor_PlafondEsenzione] ([IDCliFor], [CodiceEsenzione]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_PlafondEsenzione] ADD CONSTRAINT [FK_CliFor_PlafondEsenzione_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID])
GO
