CREATE TABLE [dbo].[Allegati]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[RefTableID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[RefRecID] [uniqueidentifier] NOT NULL,
[Tipo] [nchar] (8) COLLATE Latin1_General_CI_AS NOT NULL,
[Nome] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[FullPath] [nvarchar] (1024) COLLATE Latin1_General_CI_AS NULL CONSTRAINT [DF_Allegati_FullPath] DEFAULT (''),
[IDMacchina] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDFase] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Allegati] ADD CONSTRAINT [PK_Allegati] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Allegati] ADD CONSTRAINT [FK_Allegati_Fasi] FOREIGN KEY ([IDFase]) REFERENCES [prod].[FogliLavoro_Fasi] ([ID])
GO
ALTER TABLE [dbo].[Allegati] ADD CONSTRAINT [FK_Allegati_Macchine] FOREIGN KEY ([IDMacchina]) REFERENCES [prod].[Macchine] ([IDMacchina])
GO
