CREATE TABLE [previo].[LavorazioniEsterne]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Default_lavorazione] [nvarchar] (1) COLLATE Latin1_General_CI_AS NULL,
[RigaCartellino] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[LavorazioniEsterne] ADD CONSTRAINT [PK_LavorazioniEsterne] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
