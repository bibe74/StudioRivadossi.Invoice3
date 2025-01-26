CREATE TABLE [dbo].[Utenti]
(
[ID] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[Password] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Note] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Livello] [int] NULL,
[Predefinito] [bit] NULL,
[Admin] [bit] NULL,
[NascondiTotElencoDocumenti] [bit] NULL,
[Iniziali] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[NascondiPrezziDocumenti] [bit] NULL,
[AutologonUser] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Utenti] ADD CONSTRAINT [PK_Utenti] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
