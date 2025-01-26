SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [Setup].[usp_CreateMenu]
	@Esteso INT =1 
AS
BEGIN
	DELETE FROM dbo.Menu;
	DELETE FROM dbo.Utenti_AbilitazioniModuli;
	DELETE FROM dbo.Moduli;

	INSERT INTO dbo.Moduli VALUES ('Art','ARTICOLI')
	INSERT INTO dbo.Moduli VALUES ('Cli','CLIENTI')
	INSERT INTO dbo.Moduli VALUES ('Cli_Ddt','DDT VENDITA')
	INSERT INTO dbo.Moduli VALUES ('Cli_Fattura','FATTURE VENDITA')
	INSERT INTO dbo.Moduli VALUES ('Cli_FatturaElettr','FATTURA ELETTRONICA')
	INSERT INTO dbo.Moduli VALUES ('Cli_FogliLavoro','FOGLI DI LAVORO')
	INSERT INTO dbo.Moduli VALUES ('Cli_NotaCredito','NOTA CREDITO VENDITA')
	INSERT INTO dbo.Moduli VALUES ('Cli_Ordine','ORDINI  VENDITA')
	INSERT INTO dbo.Moduli VALUES ('Cli_Preventivo','PREVENTIVI VENDITA')
	INSERT INTO dbo.Moduli VALUES ('Cli_Proforma','PROFORMA VENDITA')
	INSERT INTO dbo.Moduli VALUES ('For','FORNITORI')
	INSERT INTO dbo.Moduli VALUES ('For_Ddt','DDT ACQUISTO')
	INSERT INTO dbo.Moduli VALUES ('For_Fattura','FATTURE ACQUISTO')
	INSERT INTO dbo.Moduli VALUES ('For_Ordine','ORDINI ACQUISTO')
	INSERT INTO dbo.Moduli VALUES ('For_Preventivo','PREVENTIVI ACQUISTO')
	INSERT INTO dbo.Moduli VALUES ('Previo','PREVIO')
	INSERT INTO dbo.Moduli VALUES ('Stat','STATISTICHE')

	DELETE FROM dbo.Utenti_AbilitazioniModuli WHERE IDUtente IN ('Admin', 'SuperAdmin');
	INSERT INTO dbo.Utenti_AbilitazioniModuli
	        ( ID ,
	          IDUtente ,
	          IDModulo ,
	          Lettura ,
	          Scrittura
	        )
	SELECT NEWID() , -- ID - uniqueidentifier
	          N'ADMIN' , -- IDUtente - nvarchar(20)
	          ID , -- IDModulo - nvarchar(20)
	          1 , -- Lettura - bit
	          1  -- Scrittura - bit
	FROM dbo.Moduli
	INSERT INTO dbo.Utenti_AbilitazioniModuli
	        ( ID ,
	          IDUtente ,
	          IDModulo ,
	          Lettura ,
	          Scrittura
	        )
	SELECT NEWID() , -- ID - uniqueidentifier
	          N'SuperAdmin' , -- IDUtente - nvarchar(20)
	          ID , -- IDModulo - nvarchar(20)
	          1 , -- Lettura - bit
	          1  -- Scrittura - bit
	FROM dbo.Moduli

	INSERT INTO dbo.Menu VALUES (1000,	NULL,	NULL,				'Archivi',		NULL,1)
	INSERT INTO dbo.Menu VALUES (1010,	1000,	'Art',				'Articoli',		'CTRL=ucArticoli',1)
	INSERT INTO dbo.Menu VALUES (1020,	1000,	'Art',				'Listini',		'FORM=frmListini',1)
	INSERT INTO dbo.Menu VALUES (1030,	1000,	NULL,				'Contatti',		'CTRL=ucCliFor;PARAMS=Pot',1)
	INSERT INTO dbo.Menu VALUES (1040,	1000,	'Cli',				'Clienti',		'CTRL=ucCliFor;PARAMS=Cli',1)
	INSERT INTO dbo.Menu VALUES (1050,	1000,	'For',				'Fornitori',	'CTRL=ucCliFor;PARAMS=For',1)
	INSERT INTO dbo.Menu VALUES (1060,	1000,	NULL,				'Ricerca',		'FORM=frmCercaFullText',1)
	INSERT INTO dbo.Menu VALUES (1070,	1000,	'Stat',				'Statistiche',	'CTRL=ucStat',1)

	INSERT INTO dbo.Menu VALUES (2000,	NULL,	NULL,				'Acquisti',		NULL,1)
	INSERT INTO dbo.Menu VALUES (2010,	2000,	'For_Preventivo',	'Preventivi',	'CTRL=ucDocumenti;PARAMS=For_Preventivo',1)
	INSERT INTO dbo.Menu VALUES (2020,	2000,	'For_Ordine',		'Ordini',		'CTRL=ucDocumenti;PARAMS=For_Ordine',1)
	INSERT INTO dbo.Menu VALUES (2030,	2000,	'For_DDT',			'DDT',			'CTRL=ucDocumenti;PARAMS=For_DDT',1)
	INSERT INTO dbo.Menu VALUES (2040,	2000,	'For_Fattura',		'Fatture',		'CTRL=ucDocumenti;PARAMS=For_Fattura',1)
	INSERT INTO dbo.Menu VALUES (2050,	2000,	'For_Fattura',		'Scadenze',		'CTRL=ucScadenze;PARAMS=For_Fattura',1)

	INSERT INTO dbo.Menu VALUES (3000,	NULL,	NULL,				'Preventivi',	NULL,1)
	INSERT INTO dbo.Menu VALUES (3010,	3000,	'Cli_Preventivo',	'Nuovo',		'FORM=frmDocumento;PARAMS=Cli_Preventivo,NULL',@Esteso)
	INSERT INTO dbo.Menu VALUES (3020,	3000,	'Cli_Preventivo',	'Elenco',		'CTRL=ucDocumenti;PARAMS=Cli_Preventivo',1)

	INSERT INTO dbo.Menu VALUES (4000,	NULL,	NULL,				'Ordini',		NULL,1)
	INSERT INTO dbo.Menu VALUES (4010,	4000,	'Cli_Ordine',		'Nuovo',		'FORM=frmDocumento;PARAMS=Cli_Ordine,NULL',@Esteso)
	INSERT INTO dbo.Menu VALUES (4020,	4000,	'Cli_Ordine',		'Elenco',		'CTRL=ucDocumenti;PARAMS=Cli_Ordine',1)
	INSERT INTO dbo.Menu VALUES (4030,	4000,	'Cli_Ordine',		'Evasione',		'FORM=frmEvasioneOrdini',1)
	INSERT INTO dbo.Menu VALUES (4040,	4000,	'Cli_Ordine',		'Calendario',	'CTRL=ucCalendario',1)

	INSERT INTO dbo.Menu VALUES (5000,	NULL,	NULL,				'Lavorazioni',		NULL,1)
	INSERT INTO dbo.Menu VALUES (5010,	5000,	'Cli_FogliLavoro',	'Fogli lavoro',	'CTRL=ucFogliLavoro',1)
	INSERT INTO dbo.Menu VALUES (5020,	5000,	'Cli_FogliLavoro',	'Avanzamento fasi',	'CTRL=ucFogliLavoro_Righe',1)

	INSERT INTO dbo.Menu VALUES (6000,	NULL,	NULL,				'DDT',			NULL,1)
	INSERT INTO dbo.Menu VALUES (6010,	6000,	'Cli_Ddt',			'Nuovo',		'FORM=frmDocumento;PARAMS=Cli_Ddt,NULL',@Esteso)
	INSERT INTO dbo.Menu VALUES (6020,	6000,	'Cli_Ddt',			'Elenco',		'CTRL=ucDocumenti;PARAMS=Cli_Ddt',1)
	INSERT INTO dbo.Menu VALUES (6030,	6000,	'Cli_Ddt',			'Evasione',		'FORM=frmEvasioneDdt',1)

	INSERT INTO dbo.Menu VALUES (7000,	NULL,	NULL,				'Viaggi',		NULL,1)

	INSERT INTO dbo.Menu VALUES (8000,	NULL,	NULL,				'Fatture',		NULL,1)
	INSERT INTO dbo.Menu VALUES (8010,	8000,	'Cli_Fattura',		'Nuova',		'FORM=frmDocumento;PARAMS=Cli_Fattura,NULL',@Esteso)
	INSERT INTO dbo.Menu VALUES (8020,	8000,	'Cli_Fattura',		'Differita',	'FORM=frmEvasioneDdt',0)
	INSERT INTO dbo.Menu VALUES (8030,	8000,	'Cli_Fattura',		'Elenco',		'CTRL=ucDocumenti;PARAMS=Cli_Fattura',1)
	INSERT INTO dbo.Menu VALUES (8040,	8000,	'Cli_Fattura',		'Fabbisogno',	'FORM=frmUnderConstruction',0)
	INSERT INTO dbo.Menu VALUES (8050,	8000,	'Cli_Fattura',		'Scadenze',		'CTRL=ucScadenze;PARAMS=Cli_Fattura',1)
	INSERT INTO dbo.Menu VALUES (8060,	8000,	'Stat',				'Analisi',		'CTRL=ucStat',1)

	INSERT INTO dbo.Menu VALUES (90000,	NULL,	NULL,				'Comandi',		NULL,1)
	INSERT INTO dbo.Menu VALUES (90010,	90000,	NULL,				'Informazioni',	'FORM=frmAbout',1)
	INSERT INTO dbo.Menu VALUES (90020,	90000,	NULL,				'Parametri',	'CTRL=ucParametri',1)
	INSERT INTO dbo.Menu VALUES (90030,	90000,	NULL,				'Esci',			'ACTION=QUIT',1)

	END
GO
