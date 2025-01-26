SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [Setup].[usp_InitModuli] AS

BEGIN

	--moduli mancanti

	INSERT INTO dbo.Moduli
	(
		ID,
		Descrizione
	)
	SELECT DT.ID,
		   DT.DescrizioneRidottaSingolare
	FROM dbo.Documenti_Tipi AS DT
		LEFT JOIN dbo.Moduli AS M
			ON M.ID = DT.ID
	WHERE M.ID IS NULL;

	--autorizzazioni per utenti amministratori

	WITH ADM AS (SELECT U.ID FROM dbo.Utenti U WHERE U.Admin=1 OR U.ID='SuperAdmin')
	,ADM_M AS (SELECT ADM.ID AS IDUtente, M.ID AS IDModulo FROM ADM, dbo.Moduli M)

	
	INSERT INTO dbo.Utenti_AbilitazioniModuli
	(
		IDUtente,
		IDModulo,
		Lettura,
		Scrittura
	)
	SELECT
		ADM_M.IDUtente, ADM_M.IDModulo,1,1
	FROM ADM_M LEFT JOIN dbo.Utenti_AbilitazioniModuli UAM ON UAM.IDModulo = ADM_M.IDModulo AND UAM.IDUtente = ADM_M.IDUtente
	WHERE UAM.IDUtente IS NULL;

END
GO
