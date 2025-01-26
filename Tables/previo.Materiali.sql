CREATE TABLE [previo].[Materiali]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[PesoSpecifico] [numeric] (19, 6) NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Materiali] ADD CONSTRAINT [PK_Materiali] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
