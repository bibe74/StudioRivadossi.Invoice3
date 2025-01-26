CREATE TABLE [previo].[ArticoliProduzione_Distinta]
(
[ID] [uniqueidentifier] NOT NULL,
[IDArticoloProduzione] [uniqueidentifier] NULL,
[CodicePadre] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[CodiceFiglio] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Qta] [float] NULL,
[Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArticoliProduzione_Distinta] ADD CONSTRAINT [PKArticoliProduzione_Distinta] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArticoliProduzione_Distinta] ADD CONSTRAINT [FK_ArticoliProduzione_Distinta_ArticoliProduzione] FOREIGN KEY ([IDArticoloProduzione]) REFERENCES [previo].[ArticoliProduzione] ([ID]) ON DELETE CASCADE
GO
