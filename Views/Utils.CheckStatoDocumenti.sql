SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   VIEW [Utils].[CheckStatoDocumenti] AS 
WITH DSUM
    AS (SELECT D.ID,				
               COALESCE(SUM(DR.Qta),0) AS NEW_Qta,
               COALESCE(SUM(DR.QtaEvasa),0) AS NEW_QtaEvasa,
               COALESCE(SUM(CASE 
								WHEN COALESCE(D.Qta, 0)>0 THEN 1
								ELSE 0
							END
                  ),0) AS NEW_RigheEvase,
               COALESCE(SUM(CASE 
								WHEN DR.IDStato = 'Evaso' THEN 1
								ELSE 0
							END
                  ),0) AS NEW_Righe,
               COALESCE(SUM(CASE 
								WHEN DR.IDStato = 'Evaso Parz' THEN 1
								ELSE 0
                           END
                  ),0) AS NEW_RigheEvaseParz
        FROM dbo.Documenti D
            INNER JOIN dbo.Documenti_Righe DR
                ON DR.IDDocumento = D.ID
        --WHERE DR.IDDocumento = @ID
        GROUP BY D.ID)
SELECT
	D.IDTipo,
	D.Numero,
	D.Data,
	D.IDStato,
	D.Qta,
    CASE 
					WHEN COALESCE(DSUM.NEW_Qta,0) = 0 THEN NULL
					WHEN COALESCE(DSUM.NEW_QtaEvasa,0) = 0 THEN NULL
					WHEN COALESCE(DSUM.NEW_QtaEvasa,0) >= D.Qta AND COALESCE(DSUM.NEW_RigheEvaseParz,0) = 0 THEN N'Evaso'
					ELSE N'Evaso Parz'
                END AS NEW_IDStato,
	DSUM.NEW_Qta,
	DSUM.NEW_QtaEvasa,
	DSUM.NEW_Righe,
    DSUM.NEW_RigheEvase,
    DSUM.NEW_RigheEvaseParz
FROM dbo.Documenti D
    INNER JOIN DSUM
        ON DSUM.ID = D.ID
WHERE D.IDStato<>CASE 
					WHEN COALESCE(DSUM.NEW_Qta,0) = 0 THEN NULL
					WHEN COALESCE(DSUM.NEW_QtaEvasa,0) = 0 THEN NULL
					WHEN COALESCE(DSUM.NEW_QtaEvasa,0) >= COALESCE(D.Qta, DSUM.NEW_Qta) AND COALESCE(DSUM.NEW_RigheEvaseParz,0) = 0 THEN N'Evaso'
					ELSE N'Evaso Parz'
	            END;
GO
