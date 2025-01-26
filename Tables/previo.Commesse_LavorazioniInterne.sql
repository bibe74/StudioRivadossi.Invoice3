CREATE TABLE [previo].[Commesse_LavorazioniInterne]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDCommessa] [uniqueidentifier] NOT NULL,
[IDLavorazioneInterna] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[IDMacchina] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Posizione] [int] NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Stampo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Parametri] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[OggettoControllo] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Limiti] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[StrumentoControllo] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[FrequenzaControllo] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Commesse_LavorazioniInterne] ADD CONSTRAINT [PK_Commesse_LavorazioniInterne] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Commesse_LavorazioniInterne] ADD CONSTRAINT [FK_Commesse_LavorazioniInterne_Commesse] FOREIGN KEY ([IDCommessa]) REFERENCES [previo].[Commesse] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [previo].[Commesse_LavorazioniInterne] ADD CONSTRAINT [FK_Commesse_LavorazioniInterne_Macchine] FOREIGN KEY ([IDMacchina]) REFERENCES [previo].[Macchine] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [previo].[Commesse_LavorazioniInterne] ADD CONSTRAINT [FK_Commesse_LavorazioniInterne_Preventivi_LavorazioniInterne] FOREIGN KEY ([IDLavorazioneInterna]) REFERENCES [previo].[Preventivi_LavorazioniInterne] ([ID]) ON DELETE CASCADE
GO
