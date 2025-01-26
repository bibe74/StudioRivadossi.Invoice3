CREATE TABLE [previo].[ArticoliProduzione_LavorazioniEsterne]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[IDArticoloProduzione] [uniqueidentifier] NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Qta] [float] NULL,
[Articolo_QtaRicavata] [nchar] (10) COLLATE Latin1_General_CI_AS NULL,
[IDLavorazioneEsterna] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Posizione] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArticoliProduzione_LavorazioniEsterne] ADD CONSTRAINT [PK_ArticoliLavorazioniEsterne] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArticoliProduzione_LavorazioniEsterne] ADD CONSTRAINT [FK_ArticoliProduzione_LavorazioniEsterne_ArticoliProduzione] FOREIGN KEY ([IDArticoloProduzione]) REFERENCES [previo].[ArticoliProduzione] ([ID]) ON DELETE CASCADE
GO
