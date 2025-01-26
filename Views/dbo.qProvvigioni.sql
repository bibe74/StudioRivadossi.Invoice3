SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[qProvvigioni]
AS
    ( SELECT    D.Numero AS DocNumero,
                D.Data AS DocData,
                D.Intestazione AS DocIntestazione ,
				D.Rif_Ordine,
                DR.OrdCliNumero ,
                DR.OrdCliData ,
				DR.IDDocumento_Origine,
				DR.IDDocumento_RigaOrigine,
                DSP.*
      FROM      dbo.Documenti_Scadenze_Provvigioni DSP
                INNER JOIN dbo.Documenti_Righe DR ON DR.ID = DSP.IDDocumento_Riga
                INNER JOIN dbo.Documenti D ON D.ID = DR.IDDocumento
    );
GO
