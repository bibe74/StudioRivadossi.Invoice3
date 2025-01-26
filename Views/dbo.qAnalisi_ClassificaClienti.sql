SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qAnalisi_ClassificaClienti] AS SELECT  TOP (10) Intestazione, ImpCliente, IvaCliente, TotCliente, ImpPeriodo, IvaPeriodo, TotPeriodo, PercIncidenza FROM (SELECT  c.Intestazione, c.ImpCliente, c.IvaCliente, c.TotCliente, t.ImpPeriodo, t.IvaPeriodo, t.TotPeriodo, c.ImpCliente / t.ImpPeriodo * 100 AS PercIncidenza      FROM (SELECT Intestazione, SUM(TotImp) AS ImpCliente, SUM(TotIva) AS IvaCliente, SUM(TotDoc) AS TotCliente      FROM dbo.Documenti      WHERE (IDTipo = N'Cli_Fattura') AND (Data BETWEEN CONVERT(DATETIME, '2008-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2008-12-31 23:59:59', 102))      GROUP BY Intestazione) AS c CROSS JOIN      (SELECT SUM(TotImp) AS ImpPeriodo, SUM(TotIva) AS IvaPeriodo, SUM(TotDoc) AS TotPeriodo      FROM dbo.Documenti AS Documenti_1      WHERE (IDTipo = N'Cli_Fattura') AND (Data BETWEEN CONVERT(DATETIME, '2008-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2008-12-31 23:59:59', 102))) AS t) AS class ORDER BY ImpCliente DESC
GO
