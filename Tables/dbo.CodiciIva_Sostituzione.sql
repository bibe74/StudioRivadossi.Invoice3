CREATE TABLE [dbo].[CodiciIva_Sostituzione]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDCliFor] [uniqueidentifier] NULL,
[IDTipoDocumento] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[IDCodiceIvaOld] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[IDCodiceIvaNew] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[DataDal] [date] NULL,
[DataAl] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodiciIva_Sostituzione] ADD CONSTRAINT [PK_CodiciIva_Sostituzione] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodiciIva_Sostituzione] ADD CONSTRAINT [FK_CodiciIva_Sostituzione_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID])
GO
ALTER TABLE [dbo].[CodiciIva_Sostituzione] ADD CONSTRAINT [FK_CodiciIva_Sostituzione_Documenti_Tipi] FOREIGN KEY ([IDTipoDocumento]) REFERENCES [dbo].[Documenti_Tipi] ([ID])
GO
ALTER TABLE [dbo].[CodiciIva_Sostituzione] ADD CONSTRAINT [FK_CodiciIva_Sostituzione_New_CodiciIva] FOREIGN KEY ([IDCodiceIvaNew]) REFERENCES [dbo].[CodiciIva] ([ID])
GO
ALTER TABLE [dbo].[CodiciIva_Sostituzione] ADD CONSTRAINT [FK_CodiciIva_Sostituzione_Old_CodiciIva] FOREIGN KEY ([IDCodiceIvaOld]) REFERENCES [dbo].[CodiciIva] ([ID])
GO
