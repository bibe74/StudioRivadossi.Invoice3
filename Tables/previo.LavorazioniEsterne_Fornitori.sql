CREATE TABLE [previo].[LavorazioniEsterne_Fornitori]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDLavorazioneEsterna] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDCliFor] [uniqueidentifier] NULL,
[Um] [nchar] (2) COLLATE Latin1_General_CI_AS NULL,
[Lotto] [numeric] (19, 6) NULL,
[CostoUnitario] [numeric] (19, 6) NULL,
[Data] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[LavorazioniEsterne_Fornitori] ADD CONSTRAINT [PK_LavorazioniEsterne_Fornitori] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[LavorazioniEsterne_Fornitori] ADD CONSTRAINT [FK_LavorazioniEsterne_Fornitori_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID])
GO
ALTER TABLE [previo].[LavorazioniEsterne_Fornitori] ADD CONSTRAINT [FK_LavorazioniEsterne_Fornitori_LavorazioniEsterne] FOREIGN KEY ([IDLavorazioneEsterna]) REFERENCES [previo].[LavorazioniEsterne] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
