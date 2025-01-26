CREATE TABLE [previo].[Materiali_Fornitori]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDMateriale] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDCliFor] [uniqueidentifier] NULL,
[Um] [nchar] (2) COLLATE Latin1_General_CI_AS NULL,
[Lotto] [numeric] (19, 6) NULL,
[CostoUnitario] [numeric] (19, 6) NULL,
[Data] [date] NULL,
[ImpNetto] [numeric] (19, 6) NULL,
[Sconto] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Materiali_Fornitori] ADD CONSTRAINT [PK_Materiali_Fornitori] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Materiali_Fornitori] ADD CONSTRAINT [FK_Materiali_Fornitori_Materiali] FOREIGN KEY ([IDMateriale]) REFERENCES [previo].[Materiali] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
