SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [Setup].[usp_CleanAllData]
AS
BEGIN

    /*

	PULITURA DATABASE - Versione 3.0 del 06/11/2018

	*/

    DELETE FROM dbo.Versioni
    WHERE Tipo = 'Exe';
    DELETE FROM previo.Versioni
    WHERE Tipo = 'Exe';

    DELETE FROM previo.Preventivi_Articoli;
    DELETE FROM previo.Preventivi_Componenti;
    DELETE FROM previo.Preventivi_CostiVari;
    DELETE FROM previo.Preventivi_Distinta;
    DELETE FROM previo.Preventivi_Grezzi;
    DELETE FROM previo.Preventivi_LavorazioniEsterne;
    DELETE FROM previo.Preventivi_LavorazioniInterne;
    DELETE FROM previo.Preventivi;
    DELETE FROM previo.Macchine;
    DELETE FROM previo.Materiali_Fornitori;
    DELETE FROM previo.Materiali;
    DELETE FROM previo.LavorazioniEsterne_Fornitori;
    DELETE FROM previo.LavorazioniEsterne;
    DELETE FROM previo.Conf_Colonne;
    DELETE FROM previo.Conf_DataGridView;
    DELETE FROM previo.Grezzi;

    DELETE FROM prod.FogliLavoro_Righe;
    DELETE FROM prod.FogliLavoro;
    DELETE FROM prod.FogliLavoro_Componenti;
    DELETE FROM prod.FogliLavoro_Fasi;
    DELETE FROM prod.FogliLavoro_Reparti;

	DELETE FROM dbo.Allegati_RighePredefinite;
	DELETE FROM dbo.Allegati;

    DELETE FROM dbo.Documenti_Iva;
    DELETE FROM dbo.Documenti_Righe;
    DELETE FROM dbo.Documenti_Scadenze;
    DELETE FROM dbo.Documenti_Spese;
    DELETE FROM dbo.Documenti;
    DELETE FROM dbo.Documenti_Forniture;
    DELETE FROM dbo.Documenti_Tipi_ValoriPredefiniti;
    DELETE FROM dbo.Documenti_Tipi_Evasione;
    DELETE FROM dbo.Documenti_Tipi;
    DELETE FROM dbo.Causali;
    DELETE FROM dbo.Lock;

    DELETE FROM dbo.Agenti;
    DELETE FROM dbo.Articoli_Fornitori;
    DELETE FROM dbo.Articoli_Movimenti;
    DELETE FROM dbo.Articoli_Fasi;
    DELETE FROM dbo.Articoli;
    DELETE FROM dbo.Famiglie;
    DELETE FROM dbo.Banche;
    DELETE FROM dbo.CliFor_Indirizzi;
    DELETE FROM dbo.CliFor_Riferimenti;
    DELETE FROM dbo.CliFor_ScontiArticolo;
    DELETE FROM dbo.CliFor_ScontiFamiglia;
    DELETE FROM dbo.CliFor_Spese;
	DELETE FROM dbo.CliFor_PlafondEsenzione;
    DELETE FROM dbo.CliFor;
    DELETE FROM dbo.CodiciIva_Sostituzione;
    DELETE FROM dbo.CondizioniFornitura;
    DELETE FROM dbo.Conf_Colonne;
    DELETE FROM dbo.Conf_DataGridView;

    DELETE FROM dbo.Utenti_AbilitazioniMagazzini;
	DELETE FROM dbo.Magazzini;
    DELETE FROM dbo.Nazioni;
    DELETE FROM dbo.Trasporto;
    DELETE FROM dbo.ModalitaPagamento;
	DELETE FROM dbo.CodiciIva_Sostituzione;
	DELETE FROM dbo.CodiciIva;	

    EXEC Setup.usp_CreateMagazzini;
    EXEC Setup.usp_CreateDocumentiForniture;
    EXEC Setup.usp_CreateDocumentiTipi;
	EXEC Setup.usp_CreateCodiciIva;
    EXEC Setup.usp_CreateModalitaPagamento;
    EXEC Setup.usp_CreateMenu;
	
	EXEC Setup.usp_InitParametri;
	EXEC Setup.usp_InitUtenti;
	EXEC Setup.usp_InitModelliDocumenti
	EXEC Setup.usp_InitModuli;
END;


GO
