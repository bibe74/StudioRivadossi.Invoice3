CREATE TABLE [previo].[Preventivi_LavorazioniInterne]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[IDPreventivo] [uniqueidentifier] NULL,
[Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Articolo_IDMacchina] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Lotto] [numeric] (19, 6) NULL,
[Articolo_UmTempo] [nchar] (3) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Lotti] [numeric] (19, 6) NULL,
[Articolo_Lotti_Sec] [numeric] (19, 6) NULL,
[Articolo_Pezzi] [numeric] (19, 6) NULL,
[Articolo_Pezzi_Sec] [numeric] (19, 6) NULL,
[Articolo_TempoLotto] [numeric] (19, 6) NULL,
[Articolo_TempoLotto_Sec] [numeric] (19, 6) NULL,
[Fornitura_CostoUnitario] [numeric] (19, 6) NULL,
[Fornitura_CostoCalcolato] [numeric] (19, 6) NULL,
[Fornitura_PercRicarico] [numeric] (19, 6) NULL,
[Fornitura_CostoTotale] [numeric] (19, 6) NULL,
[Fornitura_CostoConsuntivo] [numeric] (19, 6) NULL,
[Articolo_TipoCalcolo] [int] NULL,
[Articolo_LottiConsuntivo] [numeric] (19, 6) NULL,
[Articolo_PezziConsuntivo] [numeric] (19, 6) NULL,
[Articolo_TempoLottoConsuntivo] [numeric] (19, 6) NULL,
[Posizione] [int] NULL,
[Articolo_Qta] [numeric] (19, 6) NULL,
[IDLavorazioneInterna] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_LavorazioniInterne] ADD CONSTRAINT [PK_Preventivi_LavorazioniInterne] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_LavorazioniInterne] ADD CONSTRAINT [FK_Preventivi_LavorazioniInterne_LavorazioneInterna] FOREIGN KEY ([IDLavorazioneInterna]) REFERENCES [previo].[LavorazioniInterne] ([ID])
GO
ALTER TABLE [previo].[Preventivi_LavorazioniInterne] ADD CONSTRAINT [FK_Preventivi_LavorazioniInterne_Macchine] FOREIGN KEY ([Articolo_IDMacchina]) REFERENCES [previo].[Macchine] ([ID]) ON UPDATE CASCADE
GO
ALTER TABLE [previo].[Preventivi_LavorazioniInterne] ADD CONSTRAINT [FK_Preventivi_LavorazioniInterne_Preventivi] FOREIGN KEY ([IDPreventivo]) REFERENCES [previo].[Preventivi] ([ID]) ON DELETE CASCADE
GO
