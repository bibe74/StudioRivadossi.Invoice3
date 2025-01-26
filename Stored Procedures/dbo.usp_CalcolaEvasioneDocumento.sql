SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_CalcolaEvasioneDocumento] @ID UNIQUEIDENTIFIER = NULL
AS
BEGIN;

    -------------
    --Evade/evaso
    -------------

	--testata documento
    UPDATE D
    SET D.Evaso = LEFT(FDE.Evaso, 255),
        D.Evade = LEFT(FDE.Evade, 255)
    FROM dbo.ufn_Documenti_Evasione(@ID) FDE
        INNER JOIN dbo.Documenti D
            ON D.ID = @ID;

	--documenti collegati 
    WITH FDE
    AS (SELECT DISTINCT
               DR.IDDocumento_Origine AS IDDocumento,
               FDE.Evade,
               FDE.Evaso
        FROM dbo.Documenti_Righe DR
            CROSS APPLY dbo.ufn_Documenti_Evasione(DR.IDDocumento_Origine) FDE
        WHERE DR.IDDocumento_Origine IS NOT NULL
              AND DR.IDDocumento = @ID)
    UPDATE D
    SET D.Evade = FDE.Evade,
        D.Evaso = FDE.Evaso
    FROM dbo.Documenti D
        INNER JOIN FDE
            ON FDE.IDDocumento = D.ID;

END;
GO
