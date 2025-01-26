SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qAnalisi_FatturatoMese] AS SELECT  CONVERT(CHAR(4), YEAR(Data)) AS Anno, MONTH(Data) AS Mese, SUM(TotImp) AS Imp, SUM(TotIva) AS Iva, SUM(TotDoc) AS Tot, UPPER(LEFT(DATENAME(month, Data), 1)) + SUBSTRING(DATENAME(month, Data), 2, 2) AS MeseTxt FROM dbo.Documenti WHERE (IDTipo = N'Cli_Fattura') GROUP BY CONVERT(CHAR(4), YEAR(Data)), MONTH(Data), UPPER(LEFT(DATENAME(month, Data), 1)) + SUBSTRING(DATENAME(month, Data), 2, 2)
GO
