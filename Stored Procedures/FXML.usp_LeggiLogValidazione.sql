SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [FXML].[usp_LeggiLogValidazione] (
	@IDDocumento UNIQUEIDENTIFIER,
	@PKValidazione BIGINT,
	@LivelloLog TINYINT = NULL
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

	EXEC InVoiceXML.XMLAudit.usp_LeggiLogValidazione @chiaveGestionale_CodiceNumerico = @codiceNumerico,       -- bigint
	                                            @chiaveGestionale_CodiceAlfanumerico = @codiceAlfanumerico, -- nvarchar(40)
	                                            @PKValidazione = @PKValidazione,                              -- bigint
	                                            @LivelloLog = @LivelloLog                             -- tinyint

END;
GO
