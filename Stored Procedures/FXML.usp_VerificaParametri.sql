SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [FXML].[usp_VerificaParametri] (
	@DataInizioFatturazioneElettronica DATETIME = NULL,
	@debug BIT = 0
)
AS
BEGIN

	SET NOCOUNT ON;

	IF (@DataInizioFatturazioneElettronica IS NULL)
	BEGIN
		SELECT @DataInizioFatturazioneElettronica = CONVERT(DATETIME, CP.Valore)
		FROM dbo.Conf_Parametri CP
		WHERE CP.ID = N'Company.SDI_DataInizioFatturazioneElettronica';
	END;

	IF (@DataInizioFatturazioneElettronica IS NULL) SET @DataInizioFatturazioneElettronica = CAST('20190101' AS DATETIME);

	IF OBJECT_ID('tempdb..#FattureDaVerificare') IS NOT NULL
	BEGIN
		DROP TABLE #FattureDaVerificare;
	END;

	SELECT
		D.ID,
		D.IDTipo,
		D.IDCliFor,
		D.Numero,
		D.Data,
		D.TotDoc

	INTO #FattureDaVerificare
	FROM dbo.Documenti D
	INNER JOIN dbo.Documenti_Tipi DT ON DT.ID = D.IDTipo
		AND DT.SDI_IsValido = CAST(1 AS BIT)
	WHERE D.Data >= @DataInizioFatturazioneElettronica
	ORDER BY D.Data,
		D.Numero;

	IF (@debug = CAST(1 AS BIT))
	BEGIN

		SELECT
			D.ID,
            D.IDTipo,
            D.IDCliFor,
            D.Numero,
            D.Data,
            D.TotDoc

		FROM #FattureDaVerificare D
		ORDER BY D.Data,
			D.Numero;

	END;

	SELECT DISTINCT
		N'dbo' AS schema_name,
		N'CliFor' AS table_name,
		CF.Codice AS Codice,
		CF.Intestazione AS Descrizione,
		101 AS IDVerifica,
		N'Cliente senza CodiceDestinatario nè PECDestinatario' AS Note

	FROM #FattureDaVerificare D
	INNER JOIN dbo.CliFor CF ON CF.ID = D.IDCliFor
		AND COALESCE(CF.SDI_CodiceDestinatarioCliente, N'') = N''
		AND COALESCE(CF.SDI_PECDestinatarioCliente, N'') = N''
	LEFT JOIN dbo.Nazioni N ON N.ID = CF.Nazione

	WHERE D.Data >= @DataInizioFatturazioneElettronica
		AND COALESCE(N.SDI_IDNazione, N'IT') = N'IT' -- Escludo i clienti esteri

	UNION ALL

	SELECT DISTINCT
		N'dbo' AS schema_name,
		N'CliFor' AS table_name,
		CF.Codice AS Codice,
		CF.Intestazione AS Descrizione,
		102 AS IDVerifica,
		N'Cliente senza Nazione' AS Note

	FROM #FattureDaVerificare D
	INNER JOIN dbo.CliFor CF ON CF.ID = D.IDCliFor
	LEFT JOIN dbo.Nazioni N ON N.ID = CF.Nazione

	WHERE D.Data >= @DataInizioFatturazioneElettronica
		AND N.SDI_IDNazione IS NULL

	UNION ALL

	SELECT DISTINCT
		N'dbo' AS schema_name,
		N'CliFor' AS table_name,
		CF.Codice AS Codice,
		CF.Intestazione AS Descrizione,
		103 AS IDVerifica,
		N'Cliente senza Partita IVA nè Codice Fiscale' AS Note

	FROM #FattureDaVerificare D
	INNER JOIN dbo.CliFor CF ON CF.ID = D.IDCliFor
		AND COALESCE(CF.SDI_CodiceDestinatarioCliente, N'') = N''
		AND COALESCE(CF.SDI_PECDestinatarioCliente, N'') = N''
	LEFT JOIN dbo.Nazioni N ON N.ID = CF.Nazione

	WHERE D.Data >= @DataInizioFatturazioneElettronica
		AND COALESCE(N.SDI_IDNazione, N'IT') = N'IT' -- Escludo i clienti esteri
		AND COALESCE(CF.PI, N'') = N''
		AND COALESCE(CF.CF, N'') = N''

	ORDER BY schema_name,
		table_name,
		Codice,
		IDVerifica;

END;
GO
