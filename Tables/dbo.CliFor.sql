CREATE TABLE [dbo].[CliFor]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CliFor_ID] DEFAULT (newid()),
[IDAgente] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[IDCliFor_Categoria] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDClasseProvvigione] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[ProvvigioneDiretta] [bit] NULL,
[ProvvigioneIndiretta] [bit] NULL,
[Sospeso] [bit] NULL,
[Cliente] [bit] NULL,
[Fornitore] [bit] NULL,
[Codice] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Intestazione] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Intestazione2] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Promemoria] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[CF] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[PI] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Nazione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Indirizzo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Cap] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Comune] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Provincia] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[DistanzaKm] [int] NULL,
[Note] [nvarchar] (max) COLLATE Latin1_General_CI_AS NULL,
[Sconto] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Sconto_Cumulo] [bit] NULL,
[Pag_Modalita] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Pag_Banca] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Pag_Cin] [nvarchar] (1) COLLATE Latin1_General_CI_AS NULL,
[Pag_Abi] [nvarchar] (5) COLLATE Latin1_General_CI_AS NULL,
[Pag_Cab] [nvarchar] (5) COLLATE Latin1_General_CI_AS NULL,
[Pag_Cc] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Pag_Iban] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Pag_Bic] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Avviso] [nvarchar] (max) COLLATE Latin1_General_CI_AS NULL,
[CodIva] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[NoteInFattura] [bit] NULL,
[IDBancaRB] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[ChkNoteInDDT] [bit] NULL,
[NoteInDDT] [bit] NULL,
[ModelloReport] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[PercProvvigione] [numeric] (5, 2) NULL,
[CodiceFornitore] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[SDI_CodiceDestinatarioCliente] [nvarchar] (7) COLLATE Latin1_General_CI_AS NULL,
[SDI_PECDestinatarioCliente] [nvarchar] (256) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor] ADD CONSTRAINT [PK_CliFor] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_CliFor_Codice] ON [dbo].[CliFor] ([Codice]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CliFor_Intestazione] ON [dbo].[CliFor] ([Intestazione], [Intestazione2], [Cliente], [Fornitore]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor] ADD CONSTRAINT [FK_CliFor_Agenti] FOREIGN KEY ([IDAgente]) REFERENCES [dbo].[Agenti] ([ID])
GO
ALTER TABLE [dbo].[CliFor] ADD CONSTRAINT [FK_CliFor_ClassiProvvigione] FOREIGN KEY ([IDClasseProvvigione]) REFERENCES [dbo].[ClassiProvvigione] ([ID])
GO
ALTER TABLE [dbo].[CliFor] ADD CONSTRAINT [FK_CliFor_CliFor_Categorie] FOREIGN KEY ([IDCliFor_Categoria]) REFERENCES [dbo].[CliFor_Categorie] ([ID])
GO
ALTER TABLE [dbo].[CliFor] ADD CONSTRAINT [FK_CliFor_CodiciIva] FOREIGN KEY ([CodIva]) REFERENCES [dbo].[CodiciIva] ([ID])
GO
ALTER TABLE [dbo].[CliFor] ADD CONSTRAINT [FK_CliFor_Documenti_ModelliReport] FOREIGN KEY ([ModelloReport]) REFERENCES [dbo].[Documenti_ModelliReport] ([ID])
GO
ALTER TABLE [dbo].[CliFor] ADD CONSTRAINT [FK_CliFor_ModalitaPagamento] FOREIGN KEY ([Pag_Modalita]) REFERENCES [dbo].[ModalitaPagamento] ([ID]) ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CliFor] ADD CONSTRAINT [FK_CliFor_Nazioni] FOREIGN KEY ([Nazione]) REFERENCES [dbo].[Nazioni] ([ID])
GO
