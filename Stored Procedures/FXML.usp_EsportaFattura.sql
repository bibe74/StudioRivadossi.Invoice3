SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [FXML].[usp_EsportaFattura] (
	@IDDocumento UNIQUEIDENTIFIER,
	@PKEvento BIGINT OUTPUT,
	@PKEsitoEvento SMALLINT OUTPUT,
	@PKLanding_Fattura BIGINT OUTPUT
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

	BEGIN TRY

		EXEC InVoiceXML.XMLFatture.usp_ImportaFattura @codiceNumerico = @codiceNumerico,
													  @codiceAlfanumerico = @codiceAlfanumerico,
													  @PKEvento = @PKEvento OUTPUT,
													  @PKEsitoEvento = @PKEsitoEvento OUTPUT,
													  @PKLanding_Fattura = @PKLanding_Fattura OUTPUT;

		PRINT REPLACE('Fattura esportata, assegnato PKLanding_Fattura #%PKLanding_Fattura%', '%PKLanding_Fattura%', CONVERT(VARCHAR(20), @PKLanding_Fattura));

	END TRY
	BEGIN CATCH

		-- TODO: gestire l'eccezione in importazione
		PRINT 'TODO: gestire l''eccezione in importazione';

	END CATCH

	IF (@PKEsitoEvento = 0)
	BEGIN
		PRINT 'Proseguo nell''esportazione';
	END;

	EXEC InVoiceXML.XMLAudit.usp_LeggiLogEvento @chiaveGestionale_CodiceNumerico = @codiceNumerico,
	                                            @chiaveGestionale_CodiceAlfanumerico = @codiceAlfanumerico,
	                                            @PKEvento = @PKEvento,
	                                            @LivelloLog = 0; -- 0: trace, 1: debug, 2: info, 3: warn, 4: error

END;
GO
