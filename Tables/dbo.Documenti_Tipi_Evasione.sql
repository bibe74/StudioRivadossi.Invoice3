CREATE TABLE [dbo].[Documenti_Tipi_Evasione]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Documenti_Tipi_Evasione_ID] DEFAULT (newid()),
[IDTipoEvaso] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[IDTipoEvasore] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Precedenza] [int] NULL,
[EvasioneParziale] [bit] NULL,
[CollegaOrigine] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Tipi_Evasione] ADD CONSTRAINT [PK_Documenti_Tipi_Evasione] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Tipi_Evasione] ADD CONSTRAINT [FK_Documenti_Tipi_Evasione_Documenti_Tipi] FOREIGN KEY ([IDTipoEvaso]) REFERENCES [dbo].[Documenti_Tipi] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Tipi_Evasione] ADD CONSTRAINT [FK_Documenti_Tipi_Evasione_Documenti_Tipi1] FOREIGN KEY ([IDTipoEvasore]) REFERENCES [dbo].[Documenti_Tipi] ([ID])
GO
