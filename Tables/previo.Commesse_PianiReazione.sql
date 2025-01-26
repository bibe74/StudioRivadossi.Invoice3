CREATE TABLE [previo].[Commesse_PianiReazione]
(
[ID] [uniqueidentifier] NOT NULL,
[IDCommessa] [uniqueidentifier] NULL,
[Posizione] [int] NULL,
[Evento] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Azione1] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Azione2] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Commesse_PianiReazione] ADD CONSTRAINT [PK_Commesse_PianiReazione] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Commesse_PianiReazione] ADD CONSTRAINT [FK_Commesse_PianiReazione_Commesse] FOREIGN KEY ([IDCommessa]) REFERENCES [previo].[Commesse] ([ID]) ON DELETE CASCADE
GO
