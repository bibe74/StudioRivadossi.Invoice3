SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE   VIEW [FXML].[Conf_ParametriView]
AS
WITH SDIParameters
AS (
	SELECT
		N'Company.SDI_DataInizioFatturazioneElettronica' AS parameter,
		CAST(0 AS BIT) AS is_mandatory

	UNION ALL SELECT N'Company.Cap', 1
	UNION ALL SELECT N'Company.CF', 0
	UNION ALL SELECT N'Company.CodiceIvaCassa', 0
	UNION ALL SELECT N'Company.Comune', 1
	UNION ALL SELECT N'Company.Indirizzo', 1
	UNION ALL SELECT N'Company.Name', 1
	UNION ALL SELECT N'Company.Nazione', 1
	UNION ALL SELECT N'Company.PI', 0
	UNION ALL SELECT N'Company.Provincia', 1
	UNION ALL SELECT N'Company.RitenutaCassa', 0
	UNION ALL SELECT N'Company.SDI_CausalePagamentoRitenuta', 0
	UNION ALL SELECT N'Company.SDI_RegimeFiscale', 1
	UNION ALL SELECT N'Company.SDI_TipoCassa', 0
	UNION ALL SELECT N'Company.SDI_TipoRitenuta', 0
	UNION ALL SELECT N'Documents.Inps', 0
	UNION ALL SELECT N'Documents.RitAcc', 0
)
SELECT
	SDIP.parameter AS Parametro,
    CASE WHEN SDIP.is_mandatory = CAST(1 AS BIT) THEN N'Sì' ELSE N'No' END AS Obbligatorio

FROM SDIParameters SDIP
LEFT JOIN dbo.Conf_Parametri CP ON CP.ID = SDIP.parameter
WHERE CP.ID IS NULL;
GO
