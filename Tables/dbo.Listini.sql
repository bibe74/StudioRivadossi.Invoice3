CREATE TABLE [dbo].[Listini]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[DataCreazione] [date] NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDCliFor_Categoria] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDCliFor] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Listini] ADD CONSTRAINT [PK_Listini] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
