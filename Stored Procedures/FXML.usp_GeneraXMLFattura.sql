SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [FXML].[usp_GeneraXMLFattura] (
	@IDDocumento UNIQUEIDENTIFIER,
	@PKFatturaElettronicaHeader BIGINT,
	@PKEvento BIGINT OUTPUT,
	@PKEsitoEvento SMALLINT OUTPUT,
	@XMLOutput XML OUTPUT
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

	EXEC InVoiceXML.XMLFatture.usp_GeneraXMLFattura @codiceNumerico = @codiceNumerico,                    -- bigint
	                                                @codiceAlfanumerico = @codiceAlfanumerico,              -- nvarchar(40)
	                                                @PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader,        -- bigint
	                                                @PKEvento = @PKEvento OUTPUT,           -- bigint
	                                                @PKEsitoEvento = @PKEsitoEvento OUTPUT, -- smallint
	                                                @XMLOutput = @XMLOutput OUTPUT                      -- text

END;
GO
