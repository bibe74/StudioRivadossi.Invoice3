CREATE TABLE [previo].[Grezzi]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Grezzi_ID] DEFAULT (newid()),
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
[default_grezzo] [nvarchar] (1) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Grezzi] ADD CONSTRAINT [PK_Grezzi] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
