CREATE TABLE [FXML].[ImportXML]
(
[PKImportXML] [bigint] NOT NULL CONSTRAINT [DFT_FXML_ImportXML_PKImportXML] DEFAULT (NEXT VALUE FOR [FXML].[seq_ImportXML]),
[DataOraInserimento] [datetime2] NOT NULL CONSTRAINT [DFT_FXML_ImportXML_DataOraInserimento] DEFAULT (getdate()),
[IDStatoImportazione] [tinyint] NOT NULL CONSTRAINT [DFT_FXML_ImportXML_IDStatoImportazione] DEFAULT ((0)),
[PKStaging_FatturaElettronicaHeader] [bigint] NOT NULL CONSTRAINT [DFT_FXML_ImportXML_PKStaging_FatturaElettronicaHeader] DEFAULT ((-1)),
[XMLContent] [xml] NULL,
[CedentePrestatore_DatiAnagrafici_IDFiscaleIVA_IdCodice] [nvarchar] (28) COLLATE Latin1_General_CI_AS NULL,
[DatiGenerali_DatiGeneraliDocumento_TipoDocumento] [char] (4) COLLATE Latin1_General_CI_AS NULL,
[DatiGenerali_DatiGeneraliDocumento_Data] [date] NULL,
[DatiGenerali_DatiGeneraliDocumento_Numero] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[IDDocumento] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
ALTER TABLE [FXML].[ImportXML] ADD CONSTRAINT [PK_FXML_ImportXML] PRIMARY KEY CLUSTERED  ([PKImportXML]) ON [PRIMARY]
GO
