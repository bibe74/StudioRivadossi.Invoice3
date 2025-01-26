SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE   VIEW [FXML].[DatabaseSchemaView]
AS
WITH SchemaTableColumn
AS (
	SELECT
		N'dbo' AS schema_name,
		N'Documenti_Tipi' AS table_name,
		N'SDI_TipoDocumento' AS column_name

	UNION ALL SELECT N'dbo', N'Documenti_Tipi', N'SDI_IsValido'

	UNION ALL SELECT N'dbo', N'CodiciIva', N'SDI_Natura'
	UNION ALL SELECT N'dbo', N'CodiciIva', N'SDI_RiferimentoNormativo'
	UNION ALL SELECT N'dbo', N'CodiciIva', N'SDI_EsigibilitaIVA'
	UNION ALL SELECT N'dbo', N'ModalitaPagamento_Tipi', N'SDI_ModalitaPagamento'
	UNION ALL SELECT N'dbo', N'ModalitaPagamento_Tipi', N'SDI_HasDataScadenza'
	UNION ALL SELECT N'dbo', N'ModalitaPagamento_Tipi', N'SDI_HasDatiIstitutoFinanziario'
	UNION ALL SELECT N'dbo', N'CliFor', N'SDI_CodiceDestinatarioCliente'
	UNION ALL SELECT N'dbo', N'CliFor', N'SDI_PECDestinatarioCliente'
	UNION ALL SELECT N'dbo', N'Nazioni', N'SDI_IDNazione'
	UNION ALL SELECT N'dbo', N'Documenti_Righe', N'SDI_NumeroLinea'
)
SELECT
	STC.schema_name,
    STC.table_name,
    STC.column_name,

	REPLACE(REPLACE(N'Tabella %FULL_TABLE_NAME%: campo %COLUMN_NAME% mancante', N'%FULL_TABLE_NAME%', STC.schema_name + N'.' + STC.table_name), N'%COLUMN_NAME%', STC.column_name) AS Note

FROM SchemaTableColumn STC
LEFT JOIN sys.columns C ON C.name = STC.column_name
LEFT JOIN sys.tables T ON T.object_id = C.object_id AND T.name = STC.table_name
LEFT JOIN sys.schemas S ON S.schema_id = T.schema_id AND C.name = STC.column_name
WHERE C.object_id IS NULL;
GO
