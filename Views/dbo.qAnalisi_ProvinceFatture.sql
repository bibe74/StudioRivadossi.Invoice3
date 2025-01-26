SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qAnalisi_ProvinceFatture] AS SELECT  dbo.Province.DenominazioneProvincia, dbo.CliFor.ProvvigioneDiretta, dbo.CliFor.ProvvigioneIndiretta, dbo.CliFor.Sospeso, dbo.CliFor.Cliente, dbo.Documenti.Numero, dbo.Documenti.NumeroPre,  dbo.Documenti.NumeroInt, dbo.Documenti.NumeroPos, dbo.Documenti.Data, dbo.Documenti.Intestazione, dbo.Documenti.TotImp * dbo.Documenti_Tipi.ContributoAnalisi AS TotImp,  dbo.Documenti.TotIva * dbo.Documenti_Tipi.ContributoAnalisi AS TotIva, dbo.Documenti.TotDoc * dbo.Documenti_Tipi.ContributoAnalisi AS TotDoc FROM     dbo.Documenti INNER JOIN dbo.CliFor ON dbo.Documenti.IDCliFor = dbo.CliFor.ID INNER JOIN dbo.Documenti_Tipi ON dbo.Documenti.IDTipo = dbo.Documenti_Tipi.ID LEFT OUTER JOIN dbo.Province ON dbo.CliFor.Provincia = dbo.Province.SiglaProvincia WHERE  (dbo.Documenti.Data BETWEEN CONVERT(DATETIME, '2008-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2008-12-31 23:59:59', 102)) AND (dbo.CliFor.Sospeso = 0) AND (dbo.CliFor.Cliente = 1)  AND (dbo.Documenti_Tipi.ContributoAnalisi <> 0) AND (dbo.Documenti.TotImp <> 0)
GO
