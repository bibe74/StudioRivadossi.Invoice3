SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [Setup].[usp_InitUtenti] AS

BEGIN

	DELETE FROM dbo.Utenti_AbilitazioniModuli;
	DELETE FROM dbo.Utenti_AbilitazioniMagazzini;
	DELETE FROM dbo.Utenti_AbilitazioniModelliDocumento;
	DELETE FROM dbo.Utenti;

	INSERT INTO dbo.Utenti
	(
	    ID,
	    Password,
	    Note,
	    Livello,
	    Predefinito,
	    Admin,
	    NascondiTotElencoDocumenti,
	    Iniziali,
	    NascondiPrezziDocumenti,
	    AutologonUser
	)
	VALUES
	(   N'SuperAdmin',  -- ID - nvarchar(20)
	    N'Mqa8P/NJaSZ1uJ3eECLAVA==',  -- Password - nvarchar(255)
	    N'',  -- Note - nvarchar(100)
	    0,    -- Livello - int
	    0, -- Predefinito - bit
	    1, -- Admin - bit
	    0, -- NascondiTotElencoDocumenti - bit
	    N'SA',  -- Iniziali - nvarchar(10)
	    0, -- NascondiPrezziDocumenti - bit
	    N'bs_piccioli'   -- AutologonUser - nvarchar(50)
	    )

	INSERT INTO	dbo.Utenti
	(
	    ID,
	    Password,
	    Note,
	    Livello,
	    Predefinito,
	    Admin,
	    NascondiTotElencoDocumenti,
	    Iniziali,
	    NascondiPrezziDocumenti,
	    AutologonUser
	)
	VALUES
	(   N'Admin',  -- ID - nvarchar(20)
	    N'8QsxKXbTcn8=',  -- Password - nvarchar(255)
	    N'',  -- Note - nvarchar(100)
	    0,    -- Livello - int
	    0, -- Predefinito - bit
	    1, -- Admin - bit
	    0, -- NascondiTotElencoDocumenti - bit
	    N'AD',  -- Iniziali - nvarchar(10)
	    0, -- NascondiPrezziDocumenti - bit
	    N''   -- AutologonUser - nvarchar(50)
	    )

	
END
GO
