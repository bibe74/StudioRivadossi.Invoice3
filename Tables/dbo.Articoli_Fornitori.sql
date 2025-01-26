CREATE TABLE [dbo].[Articoli_Fornitori]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Articoli_Fornitori_ID] DEFAULT (newid()),
[IDArticolo] [uniqueidentifier] NULL,
[IDCliFor] [uniqueidentifier] NULL,
[CodiceFornitore] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[ImpNetto] [numeric] (19, 6) NULL,
[Sconto] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[ImpSconto] [numeric] (19, 6) NULL,
[ImpNettoScontato] [numeric] (19, 6) NULL,
[CodIva] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[ImpIva] [numeric] (19, 6) NULL,
[ImpLordo] [numeric] (19, 6) NULL,
[Note] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Lotto] [float] NULL,
[Data] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articoli_Fornitori] ADD CONSTRAINT [PK_Articoli_Fornitori] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articoli_Fornitori] ADD CONSTRAINT [FK_Articoli_Fornitori_Articoli] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Articoli_Fornitori] ADD CONSTRAINT [FK_Articoli_Fornitori_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID])
GO
ALTER TABLE [dbo].[Articoli_Fornitori] ADD CONSTRAINT [FK_Articoli_Fornitori_CodiciIva] FOREIGN KEY ([CodIva]) REFERENCES [dbo].[CodiciIva] ([ID])
GO
