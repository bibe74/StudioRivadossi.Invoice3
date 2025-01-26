CREATE TABLE [dbo].[Documenti_Spese]
(
[ID] [uniqueidentifier] NOT NULL,
[IDDocumento] [uniqueidentifier] NULL,
[Posizione] [int] NULL,
[Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[ImpNetto] [numeric] (19, 6) NULL,
[CodIva] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[ImpIva] [numeric] (19, 6) NULL,
[ImpLordo] [numeric] (19, 6) NULL,
[IsBollo] [bit] NOT NULL CONSTRAINT [DFT_dbo_Documenti_Spese_IsBollo] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Spese] ADD CONSTRAINT [PK_Documenti_Spese] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Spese] ADD CONSTRAINT [FK_Documenti_Spese_CodiciIva] FOREIGN KEY ([CodIva]) REFERENCES [dbo].[CodiciIva] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Spese] ADD CONSTRAINT [FK_Documenti_Spese_Documenti] FOREIGN KEY ([IDDocumento]) REFERENCES [dbo].[Documenti] ([ID]) ON DELETE CASCADE
GO
