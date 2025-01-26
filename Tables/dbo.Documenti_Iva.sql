CREATE TABLE [dbo].[Documenti_Iva]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Documenti_Iva_ID] DEFAULT (newid()),
[IDDocumento] [uniqueidentifier] NULL,
[IDPlafondEsenzione] [int] NULL,
[ImpNetto] [numeric] (19, 6) NULL,
[CodIva] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[ImpIva] [numeric] (19, 6) NULL,
[ImpLordo] [numeric] (19, 6) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Iva] ADD CONSTRAINT [PK_Documenti_Iva] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Iva] ADD CONSTRAINT [FK_Documenti_Iva_Documenti] FOREIGN KEY ([IDDocumento]) REFERENCES [dbo].[Documenti] ([ID]) ON DELETE CASCADE
GO
