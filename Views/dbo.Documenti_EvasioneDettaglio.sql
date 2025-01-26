SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[Documenti_EvasioneDettaglio] AS
                                        WITH EVR
                                        AS ( SELECT DR1.IDDocumento AS IDDocumento1 ,
                                                    DR1.ID AS IDRiga1 ,
                                                    DR1.Qta AS Qta1 ,
                                                    DR2.IDDocumento AS IDDocumento2 ,
                                                    DR2.ID AS IDRiga2 ,
                                                    DR2.Qta AS Qta2
                                             FROM   dbo.Documenti_Righe DR1
                                                    INNER JOIN dbo.Documenti_Righe DR2 ON DR1.ID = DR2.IDDocumento_RigaOrigine
                                           ) ,
                                             EVD
                                        AS ( SELECT   EVR.IDDocumento1 ,
                                                      SUM(EVR.Qta1) AS Qta1 ,
                                                      EVR.IDDocumento2 ,
                                                      SUM(EVR.Qta2) AS Qta2
                                             FROM     EVR
                                             GROUP BY EVR.IDDocumento1 ,
                                                      EVR.IDDocumento2
                                           )
                                        SELECT D.ID ,
                                               D.IDTipo ,
                                               D.Numero ,
                                               D.Data ,
	                                           EVD_Evaso.IDDocumento2 AS Evaso_ID,
	                                           D_Evaso.IDTipo AS Evaso_IDTipo ,
	                                           DT_Evaso.DescrizioneRidottaSingolare AS Evaso_IDTipo_Descrizione,
	                                           D_Evaso.Numero AS Evaso_Numero,
	                                           D_Evaso.Data AS Evaso_Data,
                                               EVD_Evaso.Qta2 AS Evaso_Qta ,
	                                           EVD_Evade.IDDocumento1 AS Evade_ID,
	                                           D_Evade.IDTipo AS Evade_IDTipo ,
	                                           DT_Evade.DescrizioneRidottaSingolare AS Evade_IDTipo_Descrizione,
	                                           D_Evade.Numero AS Evade_Numero,
	                                           D_Evade.Data AS Evade_Data,
                                               EVD_Evade.Qta2 AS Evade_Qta
                                        FROM   dbo.Documenti D
                                               LEFT JOIN EVD EVD_Evaso ON EVD_Evaso.IDDocumento1 = D.ID
	                                           LEFT JOIN dbo.Documenti D_Evaso ON D_Evaso.ID = EVD_Evaso.IDDocumento2
	                                           LEFT JOIN dbo.Documenti_Tipi DT_Evaso ON DT_Evaso.ID = D_Evaso.IDTipo
                                               LEFT JOIN EVD EVD_Evade ON EVD_Evade.IDDocumento2 = D.ID
	                                           LEFT JOIN dbo.Documenti D_Evade ON D_Evade.ID = EVD_Evade.IDDocumento1
	                                           LEFT JOIN dbo.Documenti_Tipi DT_Evade ON DT_Evade.ID = D_Evade.IDTipo
GO
