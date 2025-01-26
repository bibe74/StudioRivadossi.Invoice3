SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[ufn_Documenti_Evasione] 
(	
	-- Add the parameters for the function here
	@idDoc UNIQUEIDENTIFIER
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT STUFF((
	SELECT N' - ' + T.Evade
	FROM (
	SELECT DISTINCT
		dr.IDDocumento, 
		CONCAT(DOT.DescrizioneRidottaSingolare, ' ', do.Numero,'/', YEAR(do.Data)%100) AS Evade
	FROM 
		dbo.Documenti_Righe DR
		INNER JOIN dbo.Documenti DO ON DO.ID = DR.IDDocumento_Origine
		INNER JOIN dbo.Documenti_Tipi DOT ON DOT.ID = DO.IDTipo
	WHERE DR.IDDocumento=@idDoc
	) T
	FOR XML PATH('')),1, 3, N'') AS Evade,
	STUFF((
		SELECT N' - ' + T2.Evaso
	FROM (
		SELECT DISTINCT
			CONCAT(DDT.DescrizioneRidottaSingolare, ' ', DD.Numero, '/', YEAR(DD.Data)%100) AS Evaso
		FROM dbo.Documenti_Righe DR2
		INNER JOIN dbo.Documenti DD ON DD.ID = DR2.IDDocumento
		INNER JOIN dbo.Documenti_Tipi DDT ON DDT.ID = DD.IDTipo
		WHERE DR2.IDDocumento_Origine = @idDoc
	) T2
	FOR XML PATH ('')), 1, 3, N'') AS Evaso
)





GO
