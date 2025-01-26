CREATE TABLE [dbo].[Magazzini]
(
[ID] [nvarchar] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Attivo] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Magazzini] ADD CONSTRAINT [PK_Magazzini] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Magazzini_Descrizione] ON [dbo].[Magazzini] ([Descrizione]) ON [PRIMARY]
GO
