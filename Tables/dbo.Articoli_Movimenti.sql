CREATE TABLE [dbo].[Articoli_Movimenti]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Articoli_Movimenti_ID] DEFAULT (newid()),
[IDArticolo] [uniqueidentifier] NOT NULL,
[IDDocumento] [uniqueidentifier] NULL,
[IDDocumento_Riga] [uniqueidentifier] NULL,
[IDCausale] [nvarchar] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[IDMagazzino] [nvarchar] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[IDMagazzinoOpposto] [nvarchar] (3) COLLATE Latin1_General_CI_AS NULL,
[Data] [datetime] NOT NULL,
[ImpUnitario] [numeric] (19, 6) NULL,
[ImpNetto] [numeric] (19, 6) NULL,
[Sconto] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[ImpSconto] [numeric] (19, 6) NULL,
[ImpNettoScontato] [numeric] (19, 6) NULL,
[CodIva] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[ImpIva] [numeric] (19, 6) NULL,
[ImpLordo] [numeric] (19, 6) NULL,
[Qta] [numeric] (19, 6) NULL,
[Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Note] [nvarchar] (2500) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articoli_Movimenti] ADD CONSTRAINT [PK_Articoli_Movimenti] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articoli_Movimenti] ADD CONSTRAINT [FK_Articoli_Movimenti_Articoli] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID])
GO
ALTER TABLE [dbo].[Articoli_Movimenti] ADD CONSTRAINT [FK_Articoli_Movimenti_Causali] FOREIGN KEY ([IDCausale]) REFERENCES [dbo].[Causali] ([ID])
GO
ALTER TABLE [dbo].[Articoli_Movimenti] ADD CONSTRAINT [FK_Articoli_Movimenti_Documenti_Righe] FOREIGN KEY ([IDDocumento_Riga]) REFERENCES [dbo].[Documenti_Righe] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Articoli_Movimenti] ADD CONSTRAINT [FK_Articoli_Movimenti_Magazzini] FOREIGN KEY ([IDMagazzino]) REFERENCES [dbo].[Magazzini] ([ID])
GO
ALTER TABLE [dbo].[Articoli_Movimenti] ADD CONSTRAINT [FK_Articoli_Movimenti_Magazzini1] FOREIGN KEY ([IDMagazzinoOpposto]) REFERENCES [dbo].[Magazzini] ([ID])
GO
