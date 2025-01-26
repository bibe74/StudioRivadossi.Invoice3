SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [FXML].[usp_VerificaCoerenzaDatiBollo] (
	@DataInizio DATETIME = NULL,
	@DataFine DATETIME = NULL
) AS
BEGIN

	SET NOCOUNT ON;

    DECLARE @ImportoSoglia DECIMAL(19, 6) = 77.47;

    IF (@DataInizio IS NULL) SET @DataInizio = CAST('20190101' AS DATETIME);
    IF (@DataFine IS NULL) SET @DataFine = DATEADD(YEAR, 1, DATEADD(DAY, -DATEPART(DAYOFYEAR, CAST(CURRENT_TIMESTAMP AS DATE)), CURRENT_TIMESTAMP));

    SELECT @DataInizio AS DataInizio, @DataFine AS DataFine;

    WITH FattureOltreSoglia
    AS (
        SELECT
            D.Data AS DataDocumento,
            DI.IDDocumento,
            D.NumeroInt,
            D.Numero,
            SUM(DI.ImpNetto) AS ImponibileIVAEsente

        FROM dbo.Documenti_Iva DI
        INNER JOIN dbo.Documenti D ON D.ID = DI.IDDocumento
        INNER JOIN dbo.Documenti_Tipi DT ON DT.ID = D.IDTipo
            AND DT.SDI_IsValido = CAST(1 AS BIT)
        INNER JOIN dbo.CodiciIva CIVA ON CIVA.ID = DI.CodIva
            AND CIVA.Perc = 0.0
        WHERE D.Data BETWEEN @DataInizio AND @DataFine
        GROUP BY D.Data,
            DI.IDDocumento,
            D.NumeroInt,
            D.Numero
        HAVING SUM(DI.ImpNetto) > 77.47
    ), SpeseBollo
    AS (
        SELECT
            D.Data AS DataDocumento,
            DS.IDDocumento,
            D.NumeroInt,
            D.Numero,
            SUM(DS.ImpNetto) AS ImponibileNettoBollo,
            SUM(DS.ImpLordo) AS ImponibileLordoBollo

        FROM dbo.Documenti_Spese DS
        INNER JOIN dbo.Documenti D ON D.ID = DS.IDDocumento
            AND D.Data BETWEEN @DataInizio AND @DataFine
        INNER JOIN dbo.Documenti_Tipi DT ON DT.ID = D.IDTipo
            AND DT.SDI_IsValido = CAST(1 AS BIT)
        WHERE DS.IsBollo = CAST(1 AS BIT)
        GROUP BY D.Data,
            DS.IDDocumento,
            D.NumeroInt,
            D.Numero
    )
    SELECT
        COALESCE(FOS.DataDocumento, SB.DataDocumento) AS DataDocumento,
        COALESCE(FOS.IDDocumento, SB.IDDocumento) AS IDDocumento,
        COALESCE(FOS.NumeroInt, SB.NumeroInt) AS NumeroInt,
        COALESCE(FOS.Numero, SB.Numero) AS Numero,
        FOS.ImponibileIVAEsente,
        SB.ImponibileNettoBollo,
        SB.ImponibileLordoBollo

    FROM FattureOltreSoglia FOS
    FULL JOIN SpeseBollo SB ON SB.IDDocumento = FOS.IDDocumento
    ORDER BY COALESCE(FOS.DataDocumento, SB.DataDocumento),
        COALESCE(FOS.NumeroInt, SB.NumeroInt);

END;
GO
