CREATE TABLE [FXML].[TrascodificaFornitoreArticolo]
(
[IDFornitore] [uniqueidentifier] NOT NULL,
[CodiceValore] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[IDArticolo] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [FXML].[TrascodificaFornitoreArticolo] ADD CONSTRAINT [PK_FXML_TrascodificaFornitoreArticolo] PRIMARY KEY CLUSTERED  ([IDFornitore], [CodiceValore]) ON [PRIMARY]
GO
ALTER TABLE [FXML].[TrascodificaFornitoreArticolo] ADD CONSTRAINT [FK_FML_TrascodificaFornitoreArticolo_IDFornitore] FOREIGN KEY ([IDFornitore]) REFERENCES [dbo].[CliFor] ([ID])
GO
ALTER TABLE [FXML].[TrascodificaFornitoreArticolo] ADD CONSTRAINT [FK_FXML_TrascodificaFornitoreArticolo_IDArticolo] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID])
GO
