SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Setup].[usp_CreateMagazzini]
AS
    INSERT INTO dbo.Magazzini ( ID, Descrizione, Attivo ) VALUES  ( N'01', N'Magazzino principale', 1)

	INSERT INTO dbo.Utenti_AbilitazioniMagazzini
	(
	    ID,
	    IDUtente,
	    IDMagazzino,
	    Attivo
	)
	SELECT
		NEWID(),
		U.ID,
		M.ID,
		1
	FROM dbo.Utenti U
	CROSS JOIN dbo.Magazzini M
GO
