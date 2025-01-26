SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[Documenti_Evade] AS


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
       ROW_NUMBER() OVER (PARTITION BY D.ID ORDER BY D_Evade.IDTipo, D_Evade.Data, D_Evade.Numero) AS Evade_RN,
       ROW_NUMBER() OVER (PARTITION BY D.ID ORDER BY D_Evade.IDTipo DESC, D_Evade.Data DESC, D_Evade.Numero DESC) AS Evade_RN_Desc,
	   EVD_Evade.IDDocumento1 AS Evade_ID,
	   D_Evade.IDTipo AS Evade_IDTipo	,
	   DT_Evade.DescrizioneRidottaSingolare AS Evade_IDTipo_Descrizione,
	   D_Evade.Numero AS Evade_Numero,
	   D_Evade.Data AS Evade_Data,
       EVD_Evade.Qta2 AS Evade_Qta
FROM   dbo.Documenti D
       INNER JOIN EVD EVD_Evade ON EVD_Evade.IDDocumento2 = D.ID
	   INNER JOIN dbo.Documenti D_Evade ON D_Evade.ID = EVD_Evade.IDDocumento1
	   INNER JOIN dbo.Documenti_Tipi DT_Evade ON DT_Evade.ID = D_Evade.IDTipo
GO
