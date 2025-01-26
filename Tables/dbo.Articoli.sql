CREATE TABLE [dbo].[Articoli]
(
[ID] [uniqueidentifier] NOT NULL,
[IDFamiglia] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDUnitaMisura] [nvarchar] (5) COLLATE Latin1_General_CI_AS NULL,
[IDClasseProvvigione] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[Codice] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Descrizione1] [nvarchar] (1000) COLLATE Latin1_General_CI_AS NULL,
[Descrizione2] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Descrizione3] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Descrizione4] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[DEL_ImpNetto] [numeric] (19, 6) NULL,
[DEL_Sconto] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[DEL_ImpSconto] [numeric] (19, 6) NULL,
[DEL_ImpNettoScontato] [numeric] (19, 6) NULL,
[CodIva] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[ImpIva] [numeric] (19, 6) NULL,
[ImpLordo] [numeric] (19, 6) NULL,
[Note] [nvarchar] (2500) COLLATE Latin1_General_CI_AS NULL,
[Cliente] [bit] NULL,
[Fornitore] [bit] NULL,
[ScortaMinima] [float] NULL,
[IDCliFor] [uniqueidentifier] NULL,
[Produzione] [bit] NULL,
[Disegno] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[DisegnoNumero] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[CostoProgetto] [numeric] (19, 6) NULL,
[CostoProduzione] [numeric] (19, 6) NULL,
[PercProvvigione] [numeric] (5, 2) NULL,
[Sospeso] [bit] NOT NULL CONSTRAINT [DF_dbo_Articoli_Sospeso] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articoli] ADD CONSTRAINT [PK_Articoli] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Articoli_Codice] ON [dbo].[Articoli] ([Codice]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articoli] ADD CONSTRAINT [FK_Articoli_Articoli_Famiglie] FOREIGN KEY ([IDFamiglia]) REFERENCES [dbo].[Famiglie] ([ID]) ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Articoli] ADD CONSTRAINT [FK_Articoli_ClassiProvvigione] FOREIGN KEY ([IDClasseProvvigione]) REFERENCES [dbo].[ClassiProvvigione] ([ID])
GO
ALTER TABLE [dbo].[Articoli] ADD CONSTRAINT [FK_Articoli_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID])
GO
ALTER TABLE [dbo].[Articoli] ADD CONSTRAINT [FK_Articoli_CodiciIva] FOREIGN KEY ([CodIva]) REFERENCES [dbo].[CodiciIva] ([ID])
GO
ALTER TABLE [dbo].[Articoli] ADD CONSTRAINT [FK_Articoli_UnitaMisura] FOREIGN KEY ([IDUnitaMisura]) REFERENCES [dbo].[UnitaMisura] ([ID])
GO
