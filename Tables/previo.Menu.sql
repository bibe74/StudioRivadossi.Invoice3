CREATE TABLE [previo].[Menu]
(
[ID] [int] NOT NULL,
[IDPadre] [int] NULL,
[IDModulo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Testo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Comando] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Attivo] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Menu] ADD CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
