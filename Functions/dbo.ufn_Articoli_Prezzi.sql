SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[ufn_Articoli_Prezzi]
(	
	@idCliFor UNIQUEIDENTIFIER = NULL
)
RETURNS TABLE 
AS
RETURN 
(
	WITH Listini_Righe_Valide AS (
	SELECT 
		LR.IDArticolo, 
		LR.DataInizio, 
		LR.DataFine, 
		LR.ImpNetto,
		ROW_NUMBER() OVER	(PARTITION BY LR.IDArticolo ORDER BY LR.ID) RNA,
		ROW_NUMBER() OVER	(PARTITION BY LR.IDArticolo ORDER BY LR.ID DESC) RND
	FROM 
		dbo.Listini_Righe LR
	WHERE 
		LR.IDListino IS NULL AND 
		(@idCliFor IS NULL OR LR.IDCliFor IS NULL OR LR.IDCliFor = @idCliFor) AND
		(LR.IDCliFor_Categoria IS NULL OR LR.IDCliFor_Categoria=(SELECT TOP 1 CF.IDCliFor_Categoria FROM dbo.CliFor CF WHERE CF.ID=@idCliFor)) AND
		(CASE 
			WHEN LR.DataInizio IS NULL AND LR.DataFine IS NULL THEN 1 
			WHEN LR.DataInizio IS NOT NULL THEN (CASE WHEN CURRENT_TIMESTAMP>=LR.DataInizio THEN 1 ELSE 0 end)
			WHEN LR.DataFine IS NOT NULL THEN(CASE WHEN CURRENT_TIMESTAMP<DATEADD(DAY,1,LR.DataFine) THEN 1 ELSE 0 END)
			WHEN CURRENT_TIMESTAMP BETWEEN LR.DataInizio AND DATEADD(DAY,1,LR.DataFine) THEN 1
			ELSE 0 END)=1
	)
	SELECT 
		Listini_Righe_Valide.IDArticolo,
		Listini_Righe_Valide.ImpNetto 
	FROM 
		Listini_Righe_Valide 
	WHERE 
		Listini_Righe_Valide.RNA=Listini_Righe_Valide.RND
)
GO
