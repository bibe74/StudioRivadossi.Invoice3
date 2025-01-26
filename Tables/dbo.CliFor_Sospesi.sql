CREATE TABLE [dbo].[CliFor_Sospesi]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDCliFor] [uniqueidentifier] NULL,
[IDDocumento] [uniqueidentifier] NULL,
[IDDocumentoTipo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Data] [datetime] NULL,
[Descrizione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NOT NULL,
[ImpUnitario] [numeric] (19, 6) NULL,
[Qta] [numeric] (19, 6) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_Sospesi] ADD CONSTRAINT [PK_CliFor_Sospesi] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_Sospesi] ADD CONSTRAINT [FK_CliFor_Sospesi_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID]) ON DELETE CASCADE
GO
