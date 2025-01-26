CREATE TABLE [previo].[Preventivi_Grezzi]
(
[ID] [uniqueidentifier] NOT NULL,
[IDPreventivo] [uniqueidentifier] NULL,
[Solido] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Mis1] [numeric] (19, 6) NULL,
[Mis2] [numeric] (19, 6) NULL,
[Mis3] [numeric] (19, 6) NULL,
[Mis4] [numeric] (19, 6) NULL,
[Mis5] [numeric] (19, 6) NULL,
[Mis6] [numeric] (19, 6) NULL,
[Mis7] [numeric] (19, 6) NULL,
[Mis8] [numeric] (19, 6) NULL,
[Mis9] [numeric] (19, 6) NULL,
[Mis10] [numeric] (19, 6) NULL,
[Superficie] [numeric] (19, 6) NULL,
[Volume] [numeric] (19, 6) NULL,
[Articolo_IDMateriale] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Peso] [numeric] (19, 6) NULL,
[Articolo_Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_QtaRicavata] [numeric] (19, 6) NULL,
[Articolo_PercScarto] [numeric] (19, 6) NULL,
[Articolo_Qta] [numeric] (19, 6) NULL,
[Fornitura_IDCliFor] [uniqueidentifier] NULL,
[Fornitura_Um] [nchar] (2) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_Lotto] [numeric] (19, 6) NULL,
[Fornitura_CostoUnitario] [numeric] (19, 6) NULL,
[Fornitura_CostoCalcolato] [numeric] (19, 6) NULL,
[Fornitura_PercRicarico] [numeric] (19, 6) NULL,
[Fornitura_CostoTotale] [numeric] (19, 6) NULL,
[Articolo_PesoReale] [bit] NULL,
[Articolo_PesoRealeKg] [numeric] (19, 6) NULL,
[Fornitura_Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDGrezzo] [uniqueidentifier] NULL,
[Articolo_NettoKg] [numeric] (19, 6) NULL,
[Articolo_NettoReale] [bit] NULL,
[Articolo_NettoRealeKg] [numeric] (19, 6) NULL,
[Fornitura_NumeroLotto] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_Grezzi] ADD CONSTRAINT [PK_Preventivi_Grezzi] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_Grezzi] ADD CONSTRAINT [FK_Preventivi_Grezzi_Grezzo] FOREIGN KEY ([IDGrezzo]) REFERENCES [previo].[Grezzi] ([ID])
GO
ALTER TABLE [previo].[Preventivi_Grezzi] ADD CONSTRAINT [FK_Preventivi_Grezzi_Preventivi] FOREIGN KEY ([IDPreventivo]) REFERENCES [previo].[Preventivi] ([ID]) ON DELETE CASCADE
GO
