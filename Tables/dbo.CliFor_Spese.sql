CREATE TABLE [dbo].[CliFor_Spese]
(
[ID] [uniqueidentifier] NOT NULL,
[IDCliFor] [uniqueidentifier] NULL,
[Posizione] [int] NULL,
[Descrizione] [nvarchar] (30) COLLATE Latin1_General_CI_AS NULL,
[ImpNetto] [numeric] (19, 6) NULL,
[CodIva] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[ImpIva] [numeric] (19, 6) NULL,
[ImpLordo] [numeric] (19, 6) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_Spese] ADD CONSTRAINT [PK_CliFor_Spese] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_Spese] ADD CONSTRAINT [FK_CliFor_Spese_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CliFor_Spese] ADD CONSTRAINT [FK_CliFor_Spese_CodiciIva] FOREIGN KEY ([CodIva]) REFERENCES [dbo].[CodiciIva] ([ID])
GO
