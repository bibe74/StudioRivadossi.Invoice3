CREATE TABLE [previo].[Preventivi_LavorazioniEsterne]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[IDPreventivo] [uniqueidentifier] NULL,
[Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_QtaRicavata] [numeric] (19, 6) NULL,
[Articolo_Qta] [numeric] (19, 6) NULL,
[Fornitura_IDCliFor] [uniqueidentifier] NULL,
[Fornitura_Um] [nchar] (2) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_Lotto] [numeric] (19, 6) NULL,
[Fornitura_CostoUnitario] [numeric] (19, 6) NULL,
[Fornitura_CostoCalcolato] [numeric] (19, 6) NULL,
[Fornitura_PercRicarico] [numeric] (19, 6) NULL,
[Fornitura_CostoTotale] [numeric] (19, 6) NULL,
[IDLavorazioneEsterna] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Posizione] [int] NULL,
[Fornitura_Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_LavorazioniEsterne] ADD CONSTRAINT [PK_Preventivi_LavorazioniEsterne] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_LavorazioniEsterne] ADD CONSTRAINT [FK_Preventivi_LavorazioniEsterne_LavorazioneEsterna] FOREIGN KEY ([IDLavorazioneEsterna]) REFERENCES [previo].[LavorazioniEsterne] ([ID])
GO
ALTER TABLE [previo].[Preventivi_LavorazioniEsterne] ADD CONSTRAINT [FK_Preventivi_LavorazioniEsterne_Preventivi] FOREIGN KEY ([IDPreventivo]) REFERENCES [previo].[Preventivi] ([ID]) ON DELETE CASCADE
GO
