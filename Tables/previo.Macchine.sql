CREATE TABLE [previo].[Macchine]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[CostoOra] [numeric] (19, 6) NULL,
[RigaCartellino] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Macchine] ADD CONSTRAINT [PK_Macchine] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
