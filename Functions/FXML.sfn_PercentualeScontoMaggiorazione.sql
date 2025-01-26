SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [FXML].[sfn_PercentualeScontoMaggiorazione] (
    @Sconto NVARCHAR(10)
)
RETURNS DECIMAL(28, 12)
AS
BEGIN

DECLARE @ret DECIMAL(28, 12);

SELECT @ret = (1.0 - EXP(SUM(LOG(1.0 - GSM.Percentuale / 100.0)))) * 100.0 FROM FXML.sfn_GeneraScontoMaggiorazione(@Sconto, NULL) GSM;

RETURN @ret;

END;
GO
