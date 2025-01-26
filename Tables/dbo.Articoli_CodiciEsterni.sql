CREATE TABLE [dbo].[Articoli_CodiciEsterni]
(
[IDArticolo] [uniqueidentifier] NOT NULL,
[IDCliFor] [uniqueidentifier] NOT NULL,
[CodiceEsterno] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[CodiceEsternoTipo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articoli_CodiciEsterni] ADD CONSTRAINT [PK_Articoli_CodiciEsterni] PRIMARY KEY CLUSTERED  ([IDArticolo], [IDCliFor], [CodiceEsterno]) ON [PRIMARY]
GO
