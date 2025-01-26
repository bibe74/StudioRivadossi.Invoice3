SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Setup].[usp_CreateCodiciIva] AS
BEGIN
	DELETE FROM dbo.CodiciIva_Sostituzione;
	DELETE FROM dbo.CodiciIva;
	INSERT INTO dbo.CodiciIva (
	    ID,
	    Descrizione,
	    Perc,
	    ImpEsigibile,
	    IvaEsigibile,
	    EsenzionePlafond,
	    SDI_Natura,
	    SDI_RiferimentoNormativo,
	    SDI_EsigibilitaIVA,
	    IsSoggettoBollo
	)
	VALUES ('00','Non imponibile',0.0,1,1,0,NULL,NULL,NULL,0);
	INSERT INTO dbo.CodiciIva (
	    ID,
	    Descrizione,
	    Perc,
	    ImpEsigibile,
	    IvaEsigibile,
	    EsenzionePlafond,
	    SDI_Natura,
	    SDI_RiferimentoNormativo,
	    SDI_EsigibilitaIVA,
	    IsSoggettoBollo
	)
	VALUES ('22','Imponibile',22.0,1,1,0,NULL,NULL,'I',0);

END
GO
