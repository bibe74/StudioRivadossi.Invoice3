SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_CalcolaStatoDocumento] @ID UNIQUEIDENTIFIER = NULL
AS
BEGIN;

	SET NOCOUNT ON;

	-----------------
    --Stato righe 	
    -----------------
		
	WITH DSUM 
	AS (SELECT DR.IDDocumento_RigaOrigine, SUM(DR.Qta) AS QtaEvasa
		FROM dbo.Documenti_Righe DR WHERE DR.IDDocumento_Origine = @ID
		GROUP BY DR.IDDocumento_RigaOrigine)
	UPDATE DR SET
		DR.QtaEvasa=DSUM.QtaEvasa,
		DR.IDStato = CASE 
			WHEN COALESCE(DSUM.QtaEvasa,0) = 0 THEN NULL 
			WHEN COALESCE(DSUM.QtaEvasa,0) >= DR.Qta THEN 'Evaso' ELSE 
			'Evaso Parz' END
	FROM 
		dbo.Documenti_Righe DR
		LEFT JOIN dsum ON DSUM.IDDocumento_RigaOrigine = DR.ID
	WHERE 
		DR.IDDocumento = @ID;

    -----------------
    --Stato documento 	
    -----------------

    WITH DSUM
    AS (SELECT D.ID,				
               COALESCE(SUM(DR.Qta),0) AS NEW_Qta,
               COALESCE(SUM(DR.QtaEvasa),0) AS NEW_QtaEvasa,
               COALESCE(SUM(CASE WHEN COALESCE(DR.Qta, 0)>0 THEN 1 ELSE 0
							END
                  ),0) AS NEW_Righe,
               COALESCE(SUM(CASE 
								WHEN DR.IDStato = 'Evaso' THEN 1
								ELSE 0
							END
                  ),0) AS NEW_RigheEvase,
               COALESCE(SUM(CASE 
								WHEN DR.IDStato = 'Evaso Parz' THEN 1
								ELSE 0
                           END
                  ),0) AS NEW_RigheEvaseParz
        FROM dbo.Documenti D
            INNER JOIN dbo.Documenti_Righe DR
                ON DR.IDDocumento = D.ID
        WHERE DR.IDDocumento = @ID
        GROUP BY D.ID)
    UPDATE D
    SET 
		D.Qta = DSUM.NEW_Qta,
		D.QtaEvasa = DSUM.NEW_QtaEvasa,
		D.Righe = DSUM.NEW_Righe,
        D.RigheEvase = DSUM.NEW_RigheEvase,
        D.RigheEvaseParz = DSUM.NEW_RigheEvaseParz,
        D.IDStato = CASE 
						WHEN COALESCE(DSUM.NEW_Qta,0) = 0 THEN NULL
						WHEN COALESCE(DSUM.NEW_QtaEvasa,0) = 0 THEN NULL
						WHEN COALESCE(DSUM.NEW_QtaEvasa,0) >= D.Qta AND COALESCE(DSUM.NEW_RigheEvaseParz,0) = 0 THEN N'Evaso'
						ELSE N'Evaso Parz'
                    END
    FROM dbo.Documenti D
        INNER JOIN DSUM
            ON DSUM.ID = D.ID;

    ------------------------
    --Documenti evasi, righe
    ------------------------

	WITH D_EVASI 
	AS (SELECT DISTINCT DR.IDDocumento_Origine AS IDDocumento FROM dbo.Documenti_Righe DR WHERE DR.IDDocumento = @ID),
	DSUM 
	AS (SELECT DR.IDDocumento_RigaOrigine, SUM(DR.Qta) AS QtaEvasa
		FROM dbo.Documenti_Righe DR 
		INNER JOIN D_EVASI ON DR.IDDocumento_Origine=D_EVASI.IDDocumento
		GROUP BY DR.IDDocumento_RigaOrigine)
	UPDATE DR SET
		DR.QtaEvasa=DSUM.QtaEvasa,
		DR.IDStato = CASE 
			WHEN COALESCE(DSUM.QtaEvasa,0) = 0 THEN NULL 
			WHEN COALESCE(DSUM.QtaEvasa,0) >= DR.Qta THEN 'Evaso' ELSE 
			'Evaso Parz' END
	FROM 
		dbo.Documenti_Righe DR
		INNER JOIN D_EVASI ON D_EVASI.IDDocumento = DR.IDDocumento
		LEFT JOIN dsum ON DSUM.IDDocumento_RigaOrigine = DR.ID;

    --------------------------
    --Documenti evasi, testate
    --------------------------

    WITH D_Evasi
	AS (SELECT DISTINCT DR.IDDocumento_Origine AS IDDocumento FROM dbo.Documenti_Righe DR WHERE DR.IDDocumento = @ID),
    D_Evasi_QtaEvasa
    AS (SELECT D.ID,
               SUM(DR.QtaEvasa) AS NEW_QtaEvasa,
               SUM(CASE 
						WHEN DR.IDStato = 'Evaso' THEN 1
						ELSE 0 
					END
                  ) AS NEW_RigheEvase,
               SUM(CASE 
						WHEN DR.IDStato = 'Evaso Parz' THEN 1
						ELSE 0
                   END
                  ) AS NEW_RigheEvaseParz
        FROM dbo.Documenti D
            INNER JOIN dbo.Documenti_Righe DR
                ON DR.IDDocumento = D.ID				
        GROUP BY D.ID)
    UPDATE D
    SET D.QtaEvasa = D_Evasi_QtaEvasa.NEW_QtaEvasa,
        D.RigheEvase = D_Evasi_QtaEvasa.NEW_RigheEvase,
        D.RigheEvaseParz = D_Evasi_QtaEvasa.NEW_RigheEvaseParz,
        D.IDStato = CASE 
						WHEN COALESCE(D_Evasi_QtaEvasa.NEW_QtaEvasa,0) = 0 THEN NULL
						WHEN COALESCE(D_Evasi_QtaEvasa.NEW_QtaEvasa,0) >= D.Qta AND COALESCE(D_Evasi_QtaEvasa.NEW_RigheEvaseParz,0) = 0 THEN N'Evaso'
						ELSE N'Evaso Parz'
					END
    FROM dbo.Documenti D
        INNER JOIN D_Evasi
            ON D_Evasi.IDDocumento = D.ID
        INNER JOIN D_Evasi_QtaEvasa
            ON D_Evasi_QtaEvasa.ID = D_Evasi.IDDocumento;
END;
GO
