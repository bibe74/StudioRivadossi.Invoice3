SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [FXML].[sfn_GeneraScontoMaggiorazione] (
    @Sconto NVARCHAR(10),
    @ImportoBase DECIMAL(14, 2) = NULL
)
RETURNS @sm TABLE (
    Tipo CHAR(2),
    Percentuale DECIMAL(5, 2),
    Importo DECIMAL(14, 2)
)
AS
BEGIN

INSERT INTO @sm
(
    Tipo,
    Percentuale,
    Importo
)
SELECT
    'SC' AS Tipo,
    TRY_CAST(SSS.Data AS DECIMAL(28, 12)) AS Percentuale,
    NULL AS Importo

FROM FXML.sfn_SplitString(@Sconto, '+') SSS
WHERE TRY_CAST(SSS.Data AS DECIMAL(28, 12)) IS NOT NULL
    AND TRY_CAST(SSS.Data AS DECIMAL(28, 12)) > 0.0;

RETURN;

END;
GO
