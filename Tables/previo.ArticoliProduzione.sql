CREATE TABLE [previo].[ArticoliProduzione]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Articoli_ID] DEFAULT (newid()),
[IDCliFor] [uniqueidentifier] NULL,
[Data] [datetime] NULL,
[Codice] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Disegno] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_TotMateriali] [float] NULL,
[Fornitura_TotLavorazioniInterne] [float] NULL,
[Fornitura_TotLavorazioniEsterne] [float] NULL,
[Fornitura_TotArticoli] [float] NULL,
[Fornitura_TotCostiVari] [float] NULL,
[Note] [nvarchar] (500) COLLATE Latin1_General_CI_AS NULL,
[DisegnoNumero] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArticoliProduzione] ADD CONSTRAINT [PK_Articoli_2] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ArticoliProduzione] ON [previo].[ArticoliProduzione] ([Codice]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Codice] ON [previo].[ArticoliProduzione] ([IDCliFor], [Codice]) ON [PRIMARY]
GO
