CREATE TABLE [dbo].[Menu]
(
[ID] [int] NOT NULL,
[IDPadre] [int] NULL,
[IDModulo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Testo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Comando] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Attivo] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Menu] ADD CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Menu] ADD CONSTRAINT [FK_Menu_Menu] FOREIGN KEY ([IDPadre]) REFERENCES [dbo].[Menu] ([ID])
GO
ALTER TABLE [dbo].[Menu] ADD CONSTRAINT [FK_Menu_Moduli] FOREIGN KEY ([IDModulo]) REFERENCES [dbo].[Moduli] ([ID])
GO
