SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [FXML].[ssp_EsportaDatiFattura_Header] (
	@IDDocumento UNIQUEIDENTIFIER,
	@PKStaging_FatturaElettronicaHeader BIGINT
) AS
BEGIN

	SET NOCOUNT ON;

    DECLARE @IsPubblicaAmministrazione BIT;

    SELECT @IsPubblicaAmministrazione = CASE WHEN LEN(COALESCE(C.SDI_CodiceDestinatarioCliente, N'')) = 6 THEN 1 ELSE 0 END
	FROM dbo.Documenti D
	INNER JOIN dbo.CliFor C ON C.ID = D.IDCliFor
		AND C.Cliente = CAST(1 AS BIT)
	WHERE D.ID = @IDDocumento;

	UPDATE FEH
	SET FEH.DataOraInserimento = CURRENT_TIMESTAMP,
		FEH.IsValida = CAST(0 AS BIT),
		FEH.DatiTrasmissione_IdTrasmittente_IdPaese = N.SDI_IDNazione, -- 1.1.1.1
		FEH.DatiTrasmissione_IdTrasmittente_IdCodice = COALESCE(CPCF.Valore, CPPI.Valore), -- 1.1.1.2
		FEH.DatiTrasmissione_ProgressivoInvio = RIGHT(REPLICATE(N'0', 10) + CONVERT(NVARCHAR(10), FEH.PKStaging_FatturaElettronicaHeader), 10), -- 1.1.2
        --FEH.DatiTrasmissione_FormatoTrasmissione = 'FPR12', -- 1.1.3 -- FPR12: fattura verso privati
        FEH.DatiTrasmissione_FormatoTrasmissione = CASE WHEN @IsPubblicaAmministrazione = CAST(1 AS BIT) THEN 'FPA12' ELSE 'FPR12' END, -- 1.1.3 -- FPR12: fattura verso privati
		FEH.DatiTrasmissione_CodiceDestinatario = CASE
		  WHEN NOT (C.SDI_CodiceDestinatarioCliente IS NULL OR C.SDI_CodiceDestinatarioCliente = N'') THEN C.SDI_CodiceDestinatarioCliente
		  WHEN (C.SDI_CodiceDestinatarioCliente IS NULL OR C.SDI_CodiceDestinatarioCliente = N'') THEN N'0000000'
		  ELSE N'<???>'
		END, -- 1.1.4
		FEH.DatiTrasmissione_PECDestinatario = CASE
		  WHEN NOT (C.SDI_CodiceDestinatarioCliente IS NULL OR C.SDI_CodiceDestinatarioCliente = N'') THEN N''
		  WHEN (C.SDI_CodiceDestinatarioCliente IS NULL OR C.SDI_CodiceDestinatarioCliente = N'') THEN C.SDI_PECDestinatarioCliente
		  ELSE N'<???>'
		END, -- 1.1.6
		FEH.CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese = N.SDI_IDNazione, -- 1.2.1.1.1
		FEH.CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice = CPPI.Valore, -- 1.2.1.1.2
		FEH.CedentePrestatore_DatiAnagrafici_CodiceFiscale = CASE WHEN @IsPubblicaAmministrazione = CAST(1 AS BIT) THEN COALESCE(CPCF.Valore, CPPI.Valore) WHEN COALESCE(CPCF.Valore, CPPI.Valore) = CPPI.Valore THEN NULL ELSE CPCF.Valore END, -- 1.2.1.2
		FEH.CedentePrestatore_Sede_Nazione = N.SDI_IDNazione, -- 1.2.2.6
		FEH.CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese = NC.SDI_IDNazione, -- 1.4.1.1.1
		FEH.CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice = C.PI, -- 1.4.1.1.2
		FEH.CessionarioCommittente_DatiAnagrafici_CodiceFiscale = CASE WHEN COALESCE(C.CF, C.PI) = C.PI THEN NULL ELSE C.CF END, -- 1.4.1.2
		FEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione = LEFT(RTRIM(LTRIM(COALESCE(C.Intestazione, N''))) + N' ' + RTRIM(LTRIM(COALESCE(C.Intestazione2, N''))), 80), -- 1.4.1.3.1
		FEH.CessionarioCommittente_Sede_Indirizzo = C.Indirizzo, -- 1.4.2.1
		FEH.CessionarioCommittente_Sede_CAP = C.Cap, -- 1.4.2.3
		FEH.CessionarioCommittente_Sede_Comune = C.Comune, -- 1.4.2.4
		FEH.CessionarioCommittente_Sede_Provincia = CASE WHEN COALESCE(NC.SDI_IDNazione, N'') = N'IT' THEN C.Provincia ELSE N'' END, -- 1.4.2.5
		FEH.CessionarioCommittente_Sede_Nazione = NC.SDI_IDNazione -- 1.4.2.6

	FROM dbo.Documenti D
	INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaHeader FEH ON FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
	LEFT JOIN dbo.Conf_Parametri CPNazione ON CPNazione.ID = N'Company.Nazione'
	LEFT JOIN dbo.Nazioni N ON N.ID = CPNazione.Valore
	LEFT JOIN dbo.Conf_Parametri CPPI ON CPPI.ID = N'Company.PI'
	LEFT JOIN dbo.Conf_Parametri CPCF ON CPCF.ID = N'Company.CF'
	INNER JOIN dbo.CliFor C ON C.ID = D.IDCliFor
		AND C.Cliente = CAST(1 AS BIT)
	INNER JOIN dbo.Nazioni NC ON NC.ID = C.Nazione
	WHERE D.ID = @IDDocumento;

	UPDATE FEH
	SET FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione = CP.Valore -- 1.2.1.3.1
	FROM dbo.Conf_Parametri CP
	INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaHeader FEH ON FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
	WHERE CP.ID = N'Company.Name';

	--UPDATE FEH
	--SET FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Nome = CP.Valore -- 1.2.1.3.2
	--FROM dbo.Conf_Parametri CP
	--INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaHeader FEH ON FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
	--WHERE CP.ID = N'';

	--UPDATE FEH
	--SET FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome = CP.Valore -- 1.2.1.3.3
	--FROM dbo.Conf_Parametri CP
	--INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaHeader FEH ON FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
	--WHERE CP.ID = N'';

	UPDATE FEH
	SET FEH.CedentePrestatore_DatiAnagrafici_RegimeFiscale = CP.Valore -- 1.2.1.8
	FROM dbo.Conf_Parametri CP
	INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaHeader FEH ON FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
	WHERE CP.ID = N'Company.SDI_RegimeFiscale';

	UPDATE FEH
	SET FEH.CedentePrestatore_Sede_Indirizzo = CP.Valore -- 1.2.2.1
	FROM dbo.Conf_Parametri CP
	INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaHeader FEH ON FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
	WHERE CP.ID = N'Company.Indirizzo';

	UPDATE FEH
	SET FEH.CedentePrestatore_Sede_CAP = CP.Valore -- 1.2.2.3
	FROM dbo.Conf_Parametri CP
	INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaHeader FEH ON FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
	WHERE CP.ID = N'Company.Cap';

	UPDATE FEH
	SET FEH.CedentePrestatore_Sede_Comune = CP.Valore -- 1.2.2.4
	FROM dbo.Conf_Parametri CP
	INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaHeader FEH ON FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
	WHERE CP.ID = N'Company.Comune';

	UPDATE FEH
	SET FEH.CedentePrestatore_Sede_Provincia = CP.Valore -- 1.2.2.5
	FROM dbo.Conf_Parametri CP
	INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaHeader FEH ON FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
	WHERE CP.ID = N'Company.Provincia';

    UPDATE FEH
	SET FEH.CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese = FEH.CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese,
	    FEH.CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice = FEH.CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice,
	    FEH.CessionarioCommittente_DatiAnagrafici_CodiceFiscale = FEH.CedentePrestatore_DatiAnagrafici_CodiceFiscale,
	    FEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione = FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione,
	    FEH.CessionarioCommittente_Sede_Indirizzo = FEH.CedentePrestatore_Sede_Indirizzo,
	    FEH.CessionarioCommittente_Sede_CAP = FEH.CedentePrestatore_Sede_CAP,
	    FEH.CessionarioCommittente_Sede_Comune = FEH.CedentePrestatore_Sede_Comune,
	    FEH.CessionarioCommittente_Sede_Provincia = FEH.CedentePrestatore_Sede_Provincia,
	    FEH.CessionarioCommittente_Sede_Nazione = FEH.CedentePrestatore_Sede_Nazione

	FROM dbo.Documenti D
	INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaHeader FEH ON FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
    INNER JOIN FXML.TipiDocumentoUscita TDU ON TDU.IDTipoDocumento_InVoice = D.IDTipo AND TDU.IDTipoDocumento_SDI = D.SDI_IDTipoDocumento
        AND TDU.SwitchCedenteCessionario = CAST(1 AS BIT)
    INNER JOIN dbo.Documenti DO ON DO.ID = D.IDDocumento_Origine
    INNER JOIN dbo.CliFor F ON F.ID = DO.IDCliFor
        --AND F.Fornitore = CAST(1 AS BIT)
    LEFT JOIN dbo.Nazioni NF ON NF.ID = F.Nazione
	WHERE D.ID = @IDDocumento;

    UPDATE FEH
    SET FEH.CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese = NF.SDI_IDNazione,
        FEH.CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice = F.PI,
        FEH.CedentePrestatore_DatiAnagrafici_CodiceFiscale = F.CF,
        FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione = F.Intestazione,
        --FEH.CedentePrestatore_DatiAnagrafici_RegimeFiscale =  N'TODO', -- TODO: Regime fiscale Fornitori
        FEH.CedentePrestatore_Sede_Indirizzo = F.Indirizzo,
        FEH.CedentePrestatore_Sede_CAP = F.Cap,
        FEH.CedentePrestatore_Sede_Comune = F.Comune,
        FEH.CedentePrestatore_Sede_Provincia = CASE WHEN NF.SDI_IDNazione = N'IT' THEN F.Provincia ELSE N'-1' END,
        FEH.CedentePrestatore_Sede_Nazione = NF.SDI_IDNazione

	FROM dbo.Documenti D
	INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaHeader FEH ON FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
    INNER JOIN FXML.TipiDocumentoUscita TDU ON TDU.IDTipoDocumento_InVoice = D.IDTipo AND TDU.IDTipoDocumento_SDI = D.SDI_IDTipoDocumento
        AND TDU.SwitchCedenteCessionario = CAST(1 AS BIT)
    INNER JOIN dbo.Documenti DO ON DO.ID = D.IDDocumento_Origine
    INNER JOIN dbo.CliFor F ON F.ID = DO.IDCliFor
        --AND F.Fornitore = CAST(1 AS BIT)
    LEFT JOIN dbo.Nazioni NF ON NF.ID = F.Nazione
	WHERE D.ID = @IDDocumento;

END;
GO
