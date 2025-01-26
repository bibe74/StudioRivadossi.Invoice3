CREATE TABLE [previo].[ArticoliProduzione_LavorazioniInterne]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[IDArticoloProduzione] [uniqueidentifier] NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_IDMacchina] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Lotto] [float] NULL,
[Articolo_UmTempo] [nchar] (3) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Lotti] [float] NULL,
[Articolo_Lotti_Sec] [float] NULL,
[Articolo_Pezzi] [float] NULL,
[Articolo_Pezzi_Sec] [float] NULL,
[Articolo_TempoLotto] [float] NULL,
[Articolo_TempoLotto_Sec] [float] NULL,
[Articolo_TipoCalcolo] [int] NULL,
[Posizione] [int] NULL,
[Articolo_Qta] [float] NULL,
[IDLavorazioneInterna] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArticoliProduzione_LavorazioniInterne] ADD CONSTRAINT [PK_Articoli_LavorazioniInterne] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArticoliProduzione_LavorazioniInterne] ADD CONSTRAINT [FK_ArticoliProduzione_LavorazioniInterne_ArticoliProduzione] FOREIGN KEY ([IDArticoloProduzione]) REFERENCES [previo].[ArticoliProduzione] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [previo].[ArticoliProduzione_LavorazioniInterne] ADD CONSTRAINT [FK_ArticoliProduzione_LavorazioniInterne_Macchine] FOREIGN KEY ([Articolo_IDMacchina]) REFERENCES [previo].[Macchine] ([ID]) ON UPDATE CASCADE
GO
