CREATE TABLE [dbo].[ClassiProvvigione]
(
[ID] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[PercProvvigione] [numeric] (5, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClassiProvvigione] ADD CONSTRAINT [PK_ClassiProvvigione] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
