SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qAnalisi_ClientiFattureDettagliato] AS 
                                            SELECT 
	                                            dbo.CliFor.ProvvigioneDiretta, 
	                                            dbo.CliFor.ProvvigioneIndiretta, 
	                                            dbo.CliFor.Sospeso, 
	                                            dbo.CliFor.Cliente, 
	                                            dbo.Documenti.Numero, 
	                                            dbo.Documenti.NumeroPre, 
	                                            dbo.Documenti.NumeroInt, 
	                                            dbo.Documenti.NumeroPos, 
	                                            dbo.Documenti.Data, 
	                                            dbo.Documenti.Intestazione, 
	                                            dbo.Documenti.TotImp * dbo.Documenti_Tipi.ContributoAnalisi AS TotImp, 
	                                            dbo.Documenti.TotIva * dbo.Documenti_Tipi.ContributoAnalisi AS TotIva, 
	                                            dbo.Documenti.TotDoc * dbo.Documenti_Tipi.ContributoAnalisi AS TotDoc, 
	                                            dbo.Documenti.Pag_Modalita,
	                                            dbo.Documenti_Righe.Posizione, 
	                                            dbo.Documenti_Righe.Qta, 
	                                            dbo.Documenti_Righe.QtaEvasa, 
	                                            dbo.Documenti_Righe.Codice, 
	                                            dbo.Documenti_Righe.Descrizione1, 
	                                            dbo.Documenti_Righe.Descrizione2, 
	                                            dbo.Documenti_Righe.Descrizione3, 
	                                            dbo.Documenti_Righe.Descrizione4, 
	                                            dbo.Documenti_Righe.ImpUnitario, 
	                                            dbo.Documenti_Righe.ImpNetto, 
	                                            dbo.Documenti_Righe.Sconto, 
	                                            dbo.Documenti_Righe.ImpSconto, 
	                                            dbo.Documenti_Righe.ImpUnitarioScontato, 
	                                            dbo.Documenti_Righe.ImpNettoScontato, 
	                                            dbo.Documenti_Righe.CodIva, 
	                                            dbo.Documenti_Righe.ImpIva, 
	                                            dbo.Documenti_Righe.ImpLordo, 
	                                            dbo.Documenti_Righe.NoteRiga, 
	                                            dbo.Documenti_Righe.Nascondi 
                                            FROM dbo.Documenti 
	                                            INNER JOIN dbo.CliFor ON dbo.Documenti.IDCliFor = dbo.CliFor.ID 
	                                            INNER JOIN dbo.Documenti_Tipi ON dbo.Documenti.IDTipo = dbo.Documenti_Tipi.ID 
	                                            INNER JOIN dbo.Documenti_Righe ON dbo.Documenti.ID = dbo.Documenti_Righe.IDDocumento
                                            WHERE (dbo.Documenti.Data BETWEEN CONVERT(DATETIME, '2008-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2008-12-31 23:59:59', 102)) AND 
	                                            (dbo.CliFor.Sospeso = 0) AND 
	                                            (dbo.CliFor.Cliente = 1) AND 
	                                            (dbo.Documenti_Tipi.ContributoAnalisi <> 0)
GO
