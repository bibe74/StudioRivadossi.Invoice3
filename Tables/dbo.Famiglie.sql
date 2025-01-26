CREATE TABLE [dbo].[Famiglie]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[IDPadre] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Nome] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[PercProvvDiretta] [numeric] (4, 2) NULL,
[PercProvvIndiretta] [numeric] (4, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Famiglie] ADD CONSTRAINT [PK_Articoli_Famiglie] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Famiglie] ADD CONSTRAINT [FK_Articoli_Famiglie_Articoli_Famiglie] FOREIGN KEY ([IDPadre]) REFERENCES [dbo].[Famiglie] ([ID])
GO
