SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[xlsOrdiniCliente] AS  
    SELECT D.IDTipo ,
           D.Numero AS Numero ,
           D.Data AS Data ,
           D.Intestazione ,
           COALESCE(DR.Codice, '') AS Codice ,
           DR.Descrizione1 ,
           COALESCE(DR.Descrizione2, '') AS Descrizione2 ,
           COALESCE(DR.Qta, 0) AS Qta ,
           DR.ImpNettoScontato ,
           COALESCE(DR.Sconto, '') AS Sconto ,
           DR.ImpNetto ,
           DR.QtaEvasa ,
           COALESCE(DR.IDStato, D.IDStato, '') AS Stato ,
		   COALESCE(D.Evade, '') AS Evade,
		   COALESCE(D.Evaso, '') AS Evaso,
           CASE WHEN DR.QtaEvasa = 0 THEN NULL
                ELSE COALESCE(D2.Data, D.DataConsegna)
           END AS DataConsegna,
		   COALESCE(D.IDCausale, '') AS IDCausale,
		   COALESCE(C.Descrizione, '') AS Causale
    FROM   dbo.Documenti D
           INNER JOIN dbo.Documenti_Righe DR ON DR.IDDocumento = D.ID
           LEFT JOIN dbo.Documenti_Righe DR2 ON DR2.IDDocumento_RigaOrigine = DR.ID
           LEFT JOIN dbo.Documenti D2 ON D2.ID = DR2.IDDocumento
		   LEFT JOIN dbo.Causali C ON C.ID = D.IDCausale
    WHERE  D.IDTipo = 'Cli_Ordine' 
		   AND DR.Qta <> 0
           AND D.Data >= '2016-01-01';
GO
