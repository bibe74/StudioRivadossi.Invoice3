SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [FXML].[usp_ImportaXMLPassivo] (
    @PKImportXML BIGINT,
    @IDDocumento UNIQUEIDENTIFIER OUTPUT
)
AS
BEGIN

SET NOCOUNT ON;

EXEC FXML.ssp_ImportaXMLPassivo_Documenti @PKImportXML = @PKImportXML,
                                          @IDDocumento = @IDDocumento OUTPUT;

EXEC FXML.ssp_ImportaXMLPassivo_SetModalitaPagamento @IDDocumento = @IDDocumento;

END;
GO
