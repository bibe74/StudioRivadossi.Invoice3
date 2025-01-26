CREATE TABLE [previo].[Commesse_Grezzi]
(
[ID] [uniqueidentifier] NOT NULL,
[IDCommessa] [uniqueidentifier] NULL,
[IDGrezzo] [uniqueidentifier] NULL,
[Solido] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Misure] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_NumeroLotto] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Commesse_Grezzi] ADD CONSTRAINT [PK_Commesse_Grezzi] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Commesse_Grezzi] ADD CONSTRAINT [FK_Commesse_Grezzi_Commesse] FOREIGN KEY ([IDCommessa]) REFERENCES [previo].[Commesse] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [previo].[Commesse_Grezzi] ADD CONSTRAINT [FK_Commesse_Grezzi_Grezzi] FOREIGN KEY ([IDGrezzo]) REFERENCES [previo].[Grezzi] ([ID]) ON DELETE CASCADE
GO
