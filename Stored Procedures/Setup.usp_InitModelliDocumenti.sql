SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [Setup].[usp_InitModelliDocumenti] AS

BEGIN
	DELETE FROM dbo.Utenti_AbilitazioniModelliDocumento;
	DELETE FROM dbo.Documenti_ModelliReport;
	INSERT INTO dbo.Documenti_ModelliReport VALUES ('STD','',1);
	
	INSERT INTO dbo.Utenti_AbilitazioniModelliDocumento
	(
	    IDUtente,
	    ModelloReport,
	    Abilitato
	)
	SELECT 
		U.ID, 
		MR.ID,
		1 
	FROM 
		dbo.Documenti_ModelliReport MR
		CROSS JOIN dbo.Utenti U;

	UPDATE dbo.Documenti_Tipi SET ModelloReport='STD';
	UPDATE dbo.Documenti SET ModelloReport='STD';
	UPDATE dbo.CliFor SET ModelloReport='STD';
END
GO
