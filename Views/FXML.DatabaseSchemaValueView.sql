SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE   VIEW [FXML].[DatabaseSchemaValueView]
AS
SELECT
	N'dbo' AS schema_name,
	N'Documenti_Tipi' AS table_name,
	N'SDI_TipoDocumento' AS column_name,
	DT.SDI_TipoDocumento AS value,
	N'' AS Note

FROM dbo.Documenti_Tipi DT
LEFT JOIN InVoiceXML.XMLCodifiche.TipoDocumento XMLTD ON XMLTD.IDTipoDocumento = DT.SDI_TipoDocumento COLLATE DATABASE_DEFAULT
WHERE COALESCE(DT.SDI_TipoDocumento, '') <> ''
	AND XMLTD.IDTipoDocumento IS NULL
	
UNION ALL

SELECT N'dbo', N'CodiciIva', N'SDI_Natura', CI.SDI_Natura, N''
FROM dbo.CodiciIva CI
LEFT JOIN InVoiceXML.XMLCodifiche.Natura XMLN ON XMLN.IDNatura = CI.SDI_Natura COLLATE DATABASE_DEFAULT
WHERE COALESCE(CI.SDI_Natura, '') <> ''
	AND XMLN.IDNatura IS NULL
	
UNION ALL

SELECT N'dbo', N'CodiciIva', N'SDI_EsigibilitaIVA', CI.SDI_EsigibilitaIVA, N''
FROM dbo.CodiciIva CI
LEFT JOIN InVoiceXML.XMLCodifiche.EsigibilitaIVA XMLEI ON XMLEI.IDEsigibilitaIVA = CI.SDI_EsigibilitaIVA COLLATE DATABASE_DEFAULT
WHERE COALESCE(CI.SDI_EsigibilitaIVA, '') <> ''
	AND XMLEI.IDEsigibilitaIVA IS NULL
	
UNION ALL

SELECT N'dbo', N'CodiciIva', N'SDI_Natura', CI.ID, N'Natura non compilata a fronte di IVA a zero'
FROM dbo.CodiciIva CI
WHERE COALESCE(CI.Perc, 0.0) = 0.0
	AND COALESCE(CI.SDI_Natura, '') = ''

UNION ALL

SELECT N'dbo', N'CodiciIva', N'SDI_Natura', CI.ID, N'Riferimento normativo non compilato a fronte di IVA a zero'
FROM dbo.CodiciIva CI
WHERE COALESCE(CI.Perc, 0.0) = 0.0
	AND COALESCE(CI.SDI_RiferimentoNormativo, N'') = N''

UNION ALL

SELECT N'dbo', N'CodiciIva', N'SDI_ModalitaPagamento', MPT.SDI_ModalitaPagamento, N''
FROM dbo.ModalitaPagamento_Tipi MPT
LEFT JOIN InVoiceXML.XMLCodifiche.ModalitaPagamento XMLMP ON XMLMP.IDModalitaPagamento = MPT.SDI_ModalitaPagamento COLLATE DATABASE_DEFAULT
WHERE COALESCE(MPT.SDI_ModalitaPagamento, '') <> ''
	AND XMLMP.IDModalitaPagamento IS NULL

UNION ALL

SELECT N'dbo', N'Conf_Parametri', N'Valore', CP.Valore, N''
FROM dbo.Conf_Parametri CP
LEFT JOIN dbo.Nazioni N ON N.ID = CP.Valore
LEFT JOIN InVoiceXML.XMLCodifiche.Nazione XMLCN ON XMLCN.IDNazione = N.SDI_IDNazione COLLATE DATABASE_DEFAULT
WHERE CP.ID = N'Company.Nazione'
	AND XMLCN.IDNazione IS NULL

UNION ALL

SELECT N'dbo', N'Conf_Parametri', N'Valore', CP.Valore, N''
FROM dbo.Conf_Parametri CP
LEFT JOIN InVoiceXML.XMLCodifiche.RegimeFiscale XMLRF ON XMLRF.IDRegimeFiscale = CP.Valore COLLATE DATABASE_DEFAULT
WHERE CP.ID = N'Company.SDI_RegimeFiscale'
	AND XMLRF.IDRegimeFiscale IS NULL

UNION ALL

SELECT N'dbo', N'Conf_Parametri', N'Valore', CP.Valore, N''
FROM dbo.Conf_Parametri CP
LEFT JOIN InVoiceXML.XMLCodifiche.TipoRitenuta XMLTR ON XMLTR.IDTipoRitenuta = CP.Valore COLLATE DATABASE_DEFAULT
WHERE CP.ID = N'Company.SDI_TipoRitenuta'
	AND XMLTR.IDTipoRitenuta IS NULL

UNION ALL

SELECT N'dbo', N'Conf_Parametri', N'Valore', CP.Valore, N''
FROM dbo.Conf_Parametri CP
LEFT JOIN InVoiceXML.XMLCodifiche.CausalePagamento XMLCP ON XMLCP.IDCausalePagamento = CP.Valore COLLATE DATABASE_DEFAULT
WHERE CP.ID = N'Company.SDI_CausalePagamentoRitenuta'
	AND XMLCP.IDCausalePagamento IS NULL

UNION ALL

SELECT N'dbo', N'Conf_Parametri', N'Valore', CP.Valore, N''
FROM dbo.Conf_Parametri CP
LEFT JOIN InVoiceXML.XMLCodifiche.TipoCassa XMLTC ON XMLTC.IDTipoCassa = CP.Valore COLLATE DATABASE_DEFAULT
WHERE CP.ID = N'Company.SDI_TipoCassa'
	AND XMLTC.IDTipoCassa IS NULL

UNION ALL

SELECT N'dbo', N'Conf_Parametri', N'Valore', CP.Valore, N'Valore non numerico'
FROM dbo.Conf_Parametri CP
WHERE CP.ID = N'Company.SDI_CodiceIvaCassa'
	AND ISNUMERIC(COALESCE(CP.Valore, N'AAA')) = 0

UNION ALL

SELECT N'dbo', N'Conf_Parametri', N'', N'', N'Codice Fiscale e Partita IVA mancanti'
WHERE NOT EXISTS (
	SELECT CP.Valore
	FROM dbo.Conf_Parametri CP
	WHERE CP.ID IN (N'Company.PI', N'Company.CF')
		AND COALESCE(CP.Valore, N'') <> N''
);
GO
