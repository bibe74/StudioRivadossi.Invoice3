SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[xlsClientiUltimiAnni] AS
WITH CFF
AS ( SELECT   D.IDCliFor ,
              CAST(MAX(D.Data) AS DATE) AS DataUltimaFattura ,
              COUNT(D.ID) AS NumeroFatture ,
              CONVERT(BIGINT, SUM(D.TotImp)) AS TotaleImponibile ,
              CONVERT(BIGINT, SUM(D.TotIva)) AS TotaleIva ,
              CONVERT(BIGINT, SUM(D.TotDoc)) AS TotaleDocumenti
     FROM     dbo.Documenti D
     WHERE    D.Data >= '2016-01-01'
              AND D.TotDoc > 0
     GROUP BY D.IDCliFor )
SELECT   CF.Codice ,
         CF.PI ,
         CF.Intestazione ,
         COALESCE(CF.Intestazione2, '') AS Intestazione2,
         CFF.DataUltimaFattura ,
         CFF.NumeroFatture ,
         CFF.TotaleImponibile ,
         CFF.TotaleIva ,
         CFF.TotaleDocumenti
FROM     dbo.CliFor CF
         INNER JOIN CFF ON CFF.IDCliFor = CF.ID
WHERE    CF.Cliente = 1



GO
