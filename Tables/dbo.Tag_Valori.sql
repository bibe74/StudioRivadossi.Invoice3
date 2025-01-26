CREATE TABLE [dbo].[Tag_Valori]
(
[ID] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[IDTag_Tipo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[Descrizione] [nvarchar] (80) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tag_Valori] ADD CONSTRAINT [PK_Tag_Valori] PRIMARY KEY CLUSTERED  ([IDTag_Tipo], [ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tag_Valori] ADD CONSTRAINT [FK_Tag_Valori_Tag_Tipi] FOREIGN KEY ([IDTag_Tipo]) REFERENCES [dbo].[Tag_Tipi] ([ID])
GO
