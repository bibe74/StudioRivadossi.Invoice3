SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--CREATE SCHEMA Setup






CREATE PROC [Setup].[usp_InitParametri_Francesco] AS
BEGIN

	
	--Francesco

	BEGIN TRANSACTION 

	DELETE FROM inVoiceFrancesco.dbo.Menu WHERE ID=503;
	INSERT INTO	inVoiceFrancesco.dbo.Menu VALUES (503, 500, NULL, N'Parametri', N'CTRL=ucParametri', 1);
	UPDATE inVoiceFrancesco.dbo.Menu SET ID=510 WHERE ID=502;

	UPDATE inVoiceFrancesco.dbo.Documenti_Tipi SET NumeroPos=' R.A.' WHERE ID='Cli_Fatt_RA';
	UPDATE inVoiceFrancesco.dbo.Documenti SET NumeroPos=' R.A.' WHERE NumeroPos='R.A.';

	INSERT INTO inVoiceFrancesco.dbo.Moduli VALUES ('Cli_Fatt_RA', 'FATTURE R.A.')
	INSERT INTO	inVoiceFrancesco.dbo.Utenti_AbilitazioniModuli (IDUtente,IDModulo,Lettura,Scrittura)
		VALUES (N'ADMIN',N'Cli_Fatt_RA',1,1)
	INSERT INTO	inVoiceFrancesco.dbo.Utenti_AbilitazioniModuli (IDUtente,IDModulo,Lettura,Scrittura)
		VALUES (N'SuperAdmin',N'Cli_Fatt_RA',1,1)

	ROLLBACK TRANSACTION 

	BEGIN TRANSACTION 
	DELETE FROM dbo.Listini_Righe;
	INSERT INTO dbo.Listini_Righe
	(
		IDListino,
		IDArticolo,
		IDCliFor,
		IDCliFor_Categoria,
		DataInizio,
		DataFine,
		ImpNetto
	)
	SELECT 
		NULL AS IDListino,
		A.ID AS IDArticolo, 
		A.IDCliFor,
		CF.IDCliFor_Categoria,
		NULL AS DataInizio, 
		NULL AS DataFine, 
		A.ImpNetto
	FROM 
		dbo.Articoli A
		LEFT JOIN dbo.CliFor CF ON CF.ID = A.IDCliFor
	WHERE A.ImpNetto>0
	ROLLBACK TRANSACTION 
 
END
GO
