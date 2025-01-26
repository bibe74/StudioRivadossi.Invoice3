CREATE TABLE [previo].[Preventivi]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Preventivi_ID] DEFAULT (newid()),
[IDArticolo] [uniqueidentifier] NULL,
[IDCliFor] [uniqueidentifier] NULL,
[Codice] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Data] [datetime] NULL,
[Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Codice] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Disegno] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_Note1] [nvarchar] (500) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_Note2] [nvarchar] (500) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_Note3] [nvarchar] (500) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_TotCosti] [numeric] (19, 6) NULL,
[Fornitura_PercRicarico] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_TotPreventivo] [numeric] (19, 6) NULL,
[Fornitura_TotConsuntivo] [numeric] (19, 6) NULL,
[Fornitura_CheckMateriali] [nchar] (10) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_CheckLavorazioniInterne] [nchar] (10) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_CheckLavorazioniEsterne] [nchar] (10) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_CheckArticoli] [nchar] (10) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_TotMateriali] [numeric] (19, 6) NULL,
[Fornitura_TotLavorazioniInterne] [numeric] (19, 6) NULL,
[Fornitura_TotLavorazioniEsterne] [numeric] (19, 6) NULL,
[Fornitura_TotArticoli] [numeric] (19, 6) NULL,
[Fornitura_TotCostiVari] [numeric] (19, 6) NULL,
[Fornitura_TotComponenti] [numeric] (19, 6) NULL CONSTRAINT [DF_Preventivi_Componenti_TotComponenti] DEFAULT ((0)),
[Articolo_DisegnoNumero] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_IDFornitura] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_CommessaNumero] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_CommessaDataConsegna] [datetime] NULL,
[Invoice_IDDocumento] [uniqueidentifier] NULL,
[Invoice_IDDocumentoRiga] [uniqueidentifier] NULL,
[Riga] [int] NULL,
[Qta] [numeric] (19, 6) NULL,
[PrezzoListino] [numeric] (19, 6) NULL,
[Fornitura_CostoOrario] [numeric] (19, 6) NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi] ADD CONSTRAINT [PK_Preventivi] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi] ADD CONSTRAINT [FK_Preventivi_Articoli] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID])
GO
ALTER TABLE [previo].[Preventivi] ADD CONSTRAINT [FK_Preventivi_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID])
GO
