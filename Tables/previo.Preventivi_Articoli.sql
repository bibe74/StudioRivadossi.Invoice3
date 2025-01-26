CREATE TABLE [previo].[Preventivi_Articoli]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Preventivi_Articoli_ID] DEFAULT (newid()),
[IDPreventivo] [uniqueidentifier] NULL,
[IDUnitaMisura] [nvarchar] (5) COLLATE Latin1_General_CI_AS NULL,
[Codice] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Descrizione1] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Qta] [numeric] (19, 6) NULL,
[Cliente] [bit] NULL,
[Fornitore] [bit] NULL,
[Fornitura_IDCliFor] [uniqueidentifier] NULL,
[Fornitura_Um] [char] (2) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_Lotto] [numeric] (19, 6) NULL,
[Fornitura_CostoUnitario] [numeric] (19, 6) NULL,
[Fornitura_CostoCalcolato] [numeric] (19, 6) NULL,
[Fornitura_PercRicarico] [numeric] (19, 6) NULL,
[Fornitura_CostoTotale] [numeric] (19, 6) NULL,
[Fornitura_PezziRicavati] [numeric] (19, 6) NULL,
[IDArticolo] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_Articoli] ADD CONSTRAINT [PK_Preventivi_Articoli] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_Articoli] ADD CONSTRAINT [FK_Preventivi_Articoli_Articoli] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID])
GO
ALTER TABLE [previo].[Preventivi_Articoli] ADD CONSTRAINT [FK_Preventivi_Articoli_Preventivi] FOREIGN KEY ([IDPreventivo]) REFERENCES [previo].[Preventivi] ([ID]) ON DELETE CASCADE
GO
