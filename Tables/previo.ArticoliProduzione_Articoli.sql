CREATE TABLE [previo].[ArticoliProduzione_Articoli]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Articoli_Componenti_ID] DEFAULT (newid()),
[IDArticoloProduzione] [uniqueidentifier] NULL,
[IDUnitaMisura] [nvarchar] (5) COLLATE Latin1_General_CI_AS NULL,
[Codice] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Descrizione1] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Qta] [float] NULL,
[Cliente] [bit] NULL,
[Fornitore] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArticoliProduzione_Articoli] ADD CONSTRAINT [PK_Articoli_Componenti] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArticoliProduzione_Articoli] ADD CONSTRAINT [FK_Articoli_Componenti_Articoli] FOREIGN KEY ([IDArticoloProduzione]) REFERENCES [previo].[ArticoliProduzione] ([ID]) ON DELETE CASCADE
GO
