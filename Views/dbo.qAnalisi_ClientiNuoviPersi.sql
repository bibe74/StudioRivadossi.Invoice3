SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qAnalisi_ClientiNuoviPersi]
                AS
                    SELECT Anno ,
                           ID ,
		                   IDCliFor_Categoria,
                           Intestazione ,
                           Intestazione2 ,
                           AnnoPrimaFattura ,
                           AnnoUltimaFattura ,
                           FatturatoImp ,
                           FatturatoIva ,
                           FAtturatoTot ,
                           ( CASE WHEN ( Anno = AnnoPrimaFattura ) THEN 'Nuovo'
                                  WHEN ( AnnoUltimaFattura = Anno - 1 ) THEN 'Perso'
                                  ELSE ''
                             END ) AS Stato ,
                           Indirizzo ,
                           Cap ,
                           Comune ,
                           Provincia ,
                           (   SELECT TOP ( 1 ) Dato
                               FROM   dbo.CliFor_Riferimenti
                               WHERE  ( IDCliFor = RiepPerAnno.ID )
                                      AND ( Tipo = 'Telefono' )) AS Telefono ,
                           (   SELECT TOP ( 1 ) Dato
                               FROM   dbo.CliFor_Riferimenti AS CliFor_Riferimenti_3
                               WHERE  ( IDCliFor = RiepPerAnno.ID )
                                      AND ( Tipo = 'Fax' )) AS Fax ,
                           (   SELECT TOP ( 1 ) Dato
                               FROM   dbo.CliFor_Riferimenti AS CliFor_Riferimenti_2
                               WHERE  ( IDCliFor = RiepPerAnno.ID )
                                      AND ( Tipo = 'E-mail' )) AS Email ,
                           (   SELECT TOP ( 1 ) Dato
                               FROM   dbo.CliFor_Riferimenti AS CliFor_Riferimenti_1
                               WHERE  ( IDCliFor = RiepPerAnno.ID )
                                      AND ( Tipo = 'Cellulare' )) AS Cellulare
                    FROM   (   SELECT   Anni.Anno ,
                                        dbo.CliFor.ID ,
                                        dbo.CliFor.IDCliFor_Categoria ,
                                        dbo.CliFor.Intestazione ,
                                        dbo.CliFor.Intestazione2 ,
                                        dbo.CliFor.Indirizzo ,
                                        dbo.CliFor.Cap ,
                                        dbo.CliFor.Comune ,
                                        dbo.CliFor.Provincia ,
                                        (   SELECT MIN(YEAR(Data)) AS Expr1
                                            FROM   dbo.Documenti
                                            WHERE  ( IDCliFor = dbo.CliFor.ID )) AS AnnoPrimaFattura ,
                                        (   SELECT MAX(YEAR(Data)) AS Expr1
                                            FROM   dbo.Documenti AS Documenti_3
                                            WHERE  ( IDCliFor = dbo.CliFor.ID )) AS AnnoUltimaFattura ,
                                        SUM(Documenti_1.TotImp) AS FatturatoImp ,
                                        SUM(Documenti_1.TotIva) AS FatturatoIva ,
                                        SUM(Documenti_1.TotDoc) AS FAtturatoTot
                               FROM     (   SELECT DISTINCT YEAR(Data) AS Anno
                                            FROM   dbo.Documenti AS Documenti_2 ) AS Anni
                                        CROSS JOIN dbo.CliFor
                                        INNER JOIN dbo.Documenti AS Documenti_1 ON dbo.CliFor.ID = Documenti_1.IDCliFor
                               WHERE    ( dbo.CliFor.Cliente = 1 )
                                        AND ( dbo.CliFor.Sospeso = 0 )
                               GROUP BY Anni.Anno ,
                                        dbo.CliFor.ID ,
                                        dbo.CliFor.IDCliFor_Categoria ,
                                        dbo.CliFor.Intestazione ,
                                        dbo.CliFor.Intestazione2 ,
                                        dbo.CliFor.Indirizzo ,
                                        dbo.CliFor.Cap ,
                                        dbo.CliFor.Comune ,
                                        dbo.CliFor.Provincia ) AS RiepPerAnno;
GO
