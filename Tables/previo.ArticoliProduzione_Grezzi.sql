CREATE TABLE [previo].[ArticoliProduzione_Grezzi]
(
[ID] [uniqueidentifier] NOT NULL,
[IDArticoloProduzione] [uniqueidentifier] NULL,
[Solido] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Mis1] [float] NULL,
[Mis2] [float] NULL,
[Mis3] [float] NULL,
[Mis4] [float] NULL,
[Mis5] [float] NULL,
[Mis6] [float] NULL,
[Mis7] [float] NULL,
[Mis8] [float] NULL,
[Mis9] [float] NULL,
[Mis10] [float] NULL,
[Superficie] [float] NULL,
[Volume] [float] NULL,
[Articolo_IDMateriale] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Peso] [float] NULL,
[Articolo_Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_QtaRicavata] [float] NULL,
[Articolo_PercScarto] [float] NULL,
[Articolo_Qta] [float] NULL,
[Articolo_PesoReale] [bit] NULL,
[Articolo_PesoRealeKg] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArticoliProduzione_Grezzi] ADD CONSTRAINT [PK_Articoli_Grezzi] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArticoliProduzione_Grezzi] ADD CONSTRAINT [FK_ArticoliProduzione_Grezzi_ArticoliProduzione] FOREIGN KEY ([IDArticoloProduzione]) REFERENCES [previo].[ArticoliProduzione] ([ID]) ON DELETE CASCADE
GO
