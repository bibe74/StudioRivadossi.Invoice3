CREATE TABLE [FXML].[TipiDocumentoUscita]
(
[IDTipoDocumento_InVoice] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[IDTipoDocumento_SDI] [char] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[SwitchCedenteCessionario] [bit] NOT NULL CONSTRAINT [DFT_FXML_TipiDocumentoUscita_SwitchCedenteCessionario] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [FXML].[TipiDocumentoUscita] ADD CONSTRAINT [PK_FXML_TipiDocumentoUscita] PRIMARY KEY CLUSTERED ([IDTipoDocumento_InVoice], [IDTipoDocumento_SDI]) ON [PRIMARY]
GO
