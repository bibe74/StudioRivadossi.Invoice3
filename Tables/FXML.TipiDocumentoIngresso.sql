CREATE TABLE [FXML].[TipiDocumentoIngresso]
(
[IDTipoDocumento_SDI] [char] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[IDTipoDocumento_InVoice] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [FXML].[TipiDocumentoIngresso] ADD CONSTRAINT [PK_FXML_TipiDocumentoIngresso] PRIMARY KEY CLUSTERED  ([IDTipoDocumento_SDI]) ON [PRIMARY]
GO
