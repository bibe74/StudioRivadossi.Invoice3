CREATE TABLE [dbo].[Articoli_Tag]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDArticolo] [uniqueidentifier] NOT NULL,
[IDTag_Tipo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[IDTag_Valore] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Descrizione] [nvarchar] (80) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articoli_Tag] ADD CONSTRAINT [PK_Articoli_Tag] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articoli_Tag] ADD CONSTRAINT [FK_Articoli_Tag_Articoli] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID])
GO
ALTER TABLE [dbo].[Articoli_Tag] ADD CONSTRAINT [FK_Articoli_Tag_Tag_Tipi] FOREIGN KEY ([IDTag_Tipo]) REFERENCES [dbo].[Tag_Tipi] ([ID])
GO
ALTER TABLE [dbo].[Articoli_Tag] ADD CONSTRAINT [FK_Articoli_Tag_Tag_Valori] FOREIGN KEY ([IDTag_Tipo], [IDTag_Valore]) REFERENCES [dbo].[Tag_Valori] ([IDTag_Tipo], [ID])
GO
