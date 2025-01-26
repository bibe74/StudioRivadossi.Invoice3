CREATE TABLE [previo].[LavorazioniInterne]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[RigaCartellino] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[LavorazioniInterne] ADD CONSTRAINT [PK_Lavorazioni] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
