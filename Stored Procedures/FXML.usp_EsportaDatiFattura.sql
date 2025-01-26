SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [FXML].[usp_EsportaDatiFattura] (
	@IDDocumento UNIQUEIDENTIFIER,
	@PKLanding_Fattura BIGINT,
	@PKEvento BIGINT OUTPUT,
	@PKEsitoEvento SMALLINT OUTPUT,
	@PKStaging_FatturaElettronicaHeader BIGINT OUTPUT
) AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @codiceNumerico INT;
	DECLARE @codiceAlfanumerico NVARCHAR(40);

	SELECT
		@codiceNumerico = D.NumeroInt,
		@codiceAlfanumerico = CONVERT(NVARCHAR(40), @IDDocumento)

	FROM dbo.Documenti D
	INNER JOIN dbo.Documenti_Tipi DT ON DT.ID = D.IDTipo
		AND DT.SDI_IsValido = CAST(1 AS BIT)
	WHERE D.ID = @IDDocumento;

	EXEC InVoiceXML.XMLFatture.usp_ImportaDatiFattura @codiceNumerico = @codiceNumerico,
	                                                  @codiceAlfanumerico = @codiceAlfanumerico,
	                                                  @PKLanding_Fattura = @PKLanding_Fattura,
	                                                  @PKEvento = @PKEvento OUTPUT,
	                                                  @PKEsitoEvento = @PKEsitoEvento OUTPUT,
	                                                  @PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader OUTPUT;

	EXEC FXML.ssp_EsportaDatiFattura_Header @IDDocumento = @IDDocumento,
	                                        @PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

	PRINT REPLACE('Testata fattura esportata, assegnato PKStaging_FatturaElettronicaHeader #%PKStaging_FatturaElettronicaHeader%', '%PKStaging_FatturaElettronicaHeader%', CONVERT(VARCHAR(20), @PKStaging_FatturaElettronicaHeader));

	EXEC FXML.ssp_EsportaDatiFattura_Body @IDDocumento = @IDDocumento,
	                                      @PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;
	
	PRINT REPLACE('Righe fattura esportate per PKStaging_FatturaElettronicaHeader #%PKStaging_FatturaElettronicaHeader%', '%PKStaging_FatturaElettronicaHeader%', CONVERT(VARCHAR(20), @PKStaging_FatturaElettronicaHeader));

END;
GO
