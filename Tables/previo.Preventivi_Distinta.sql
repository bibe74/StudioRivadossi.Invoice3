CREATE TABLE [previo].[Preventivi_Distinta]
(
[ID] [uniqueidentifier] NOT NULL,
[IDPreventivo] [uniqueidentifier] NULL,
[IDArticolo] [uniqueidentifier] NULL,
[CodicePadre] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[CodiceFiglio] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Qta] [numeric] (19, 6) NULL,
[Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_Distinta] ADD CONSTRAINT [PKPreventivi_Distinta] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_Distinta] ADD CONSTRAINT [FK_Preventivi_Distinta_Articoli] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID])
GO
ALTER TABLE [previo].[Preventivi_Distinta] ADD CONSTRAINT [FK_Preventivi_Distinta_Preventivo] FOREIGN KEY ([IDPreventivo]) REFERENCES [previo].[Preventivi] ([ID])
GO
