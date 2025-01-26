SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [FXML].[usp_ConvalidaFattura] (
	@IDDocumento UNIQUEIDENTIFIER,
	@PKStaging_FatturaElettronicaHeader BIGINT,
	@PKEvento BIGINT OUTPUT,
	@PKEsitoEvento SMALLINT OUTPUT,
	@IsValida BIT OUTPUT,
	@PKValidazione BIGINT OUTPUT,
	@PKFatturaElettronicaHeader BIGINT OUTPUT
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

	EXEC InVoiceXML.XMLFatture.usp_ConvalidaFattura @codiceNumerico = @codiceNumerico,
	                                                @codiceAlfanumerico = @codiceAlfanumerico,
	                                                @PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader,
	                                                @PKEvento = @PKEvento OUTPUT,
	                                                @PKEsitoEvento = @PKEsitoEvento OUTPUT,
													@IsValida = @IsValida OUTPUT,
	                                                @PKValidazione = @PKValidazione OUTPUT,
	                                                @PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader OUTPUT;

END;
GO
