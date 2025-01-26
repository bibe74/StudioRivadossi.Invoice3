SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[Documenti_Evasione] AS 
	WITH 
	EVASO (ID, RN, RN_Desc, Numero, Data, Txt) AS 
	(
		SELECT 
			ID, 
			DE.Evaso_RN, 
			DE.Evaso_RN_Desc,
			DE.Evaso_Numero, 
			DE.Evaso_Data, 
			CONVERT(NVARCHAR(100), DE.Evaso_IDTipo_Descrizione + ' ' + DE.Evaso_Numero + '/' + SUBSTRING(CONVERT(NCHAR(4), YEAR(DE.Evaso_Data)),3,2))
		FROM dbo.Documenti_Evaso DE WHERE DE.Evaso_RN=1
		UNION ALL SELECT 
			DE2.ID,
			DE2.Evaso_RN,
			DE2.Evaso_RN_Desc,
			DE2.Numero,
			DE2.Data,
			CONVERT(NVARCHAR(100), EVASO.Txt + ' - ' + DE2.Evaso_IDTipo_Descrizione + ' ' + DE2.Evaso_Numero + '/' + SUBSTRING(CONVERT(NCHAR(4), YEAR(DE2.Evaso_Data)),3,2))
		FROM dbo.Documenti_Evaso DE2 INNER JOIN EVASO ON EVASO.ID = DE2.ID AND DE2.Evaso_RN = EVASO.RN + 1
	),
	EVADE (ID, RN, RN_Desc, Numero, Data, Txt) AS 
	(
		SELECT 
			ID, 
			DE.Evade_RN, 
			DE.Evade_RN_Desc,
			DE.Evade_Numero, 
			DE.Evade_Data, 
			CONVERT(NVARCHAR(100), DE.Evade_IDTipo_Descrizione + ' ' + DE.Evade_Numero + '/' + SUBSTRING(CONVERT(NCHAR(4), YEAR(DE.Evade_Data)),3,2))
		FROM dbo.Documenti_Evade DE WHERE DE.Evade_RN=1
		UNION ALL SELECT 
			DE2.ID,
			DE2.Evade_RN,
			DE2.Evade_RN_Desc,
			DE2.Numero,
			DE2.Data,
			CONVERT(NVARCHAR(100), EVADE.Txt + ' - ' + DE2.Evade_IDTipo_Descrizione + ' ' + DE2.Evade_Numero + '/' + SUBSTRING(CONVERT(NCHAR(4), YEAR(DE2.Evade_Data)),3,2))
		FROM dbo.Documenti_Evade DE2 INNER JOIN EVADE ON EVADE.ID = DE2.ID AND DE2.Evade_RN = EVADE.RN + 1
	)
	SELECT 
		doc.ID, 
		doc.IDStato,
		EVASO.Txt AS Evaso,
		EVADE.Txt AS Evade 
	FROM 
		Documenti DOC 
		LEFT JOIN EVASO ON EVASO.ID = DOC.ID AND EVASO.RN_Desc = 1
		LEFT JOIN EVADE ON EVADE.ID = DOC.ID AND EVADE.RN_Desc = 1

GO
