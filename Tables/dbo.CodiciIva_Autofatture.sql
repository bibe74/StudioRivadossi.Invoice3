CREATE TABLE [dbo].[CodiciIva_Autofatture]
(
[CodIva] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[SDI_TipoDocumento] [char] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[SDI_CodIva] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[SDI_IDTipo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodiciIva_Autofatture] ADD CONSTRAINT [PK_CodiciIva_Autofatture] PRIMARY KEY CLUSTERED ([CodIva], [SDI_TipoDocumento], [SDI_CodIva]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodiciIva_Autofatture] ADD CONSTRAINT [FK_CodiciIva_Autofatture_Documenti_Tipi] FOREIGN KEY ([SDI_IDTipo]) REFERENCES [dbo].[Documenti_Tipi] ([ID])
GO
