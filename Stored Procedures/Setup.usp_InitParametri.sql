SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--CREATE SCHEMA Setup



CREATE PROC [Setup].[usp_InitParametri] AS
BEGIN

	--Company
	UPDATE dbo.Conf_Parametri SET Valore='Azienda test'	   	    WHERE ID='Company.Name';
	UPDATE dbo.Conf_Parametri SET Valore='Via Brescia, 11'		WHERE ID='Company.Indirizzo';
	UPDATE dbo.Conf_Parametri SET Valore='AZNTST99A22B157H'		WHERE ID='Company.CF';
	UPDATE dbo.Conf_Parametri SET Valore='12345678901'			WHERE ID='Company.PI';
	UPDATE dbo.Conf_Parametri SET Valore='25100'				WHERE ID='Company.Cap';
	UPDATE dbo.Conf_Parametri SET Valore='Brescia'				WHERE ID='Company.Comune';
	UPDATE dbo.Conf_Parametri SET Valore='BS'					WHERE ID='Company.Provincia';
	UPDATE dbo.Conf_Parametri SET Valore='ITALIA'				WHERE ID='Company.Nazione';

	--Sdi
	UPDATE dbo.Conf_Parametri SET Valore='True'					WHERE ID='Company.SDI_EsportaAllegato';
	UPDATE dbo.Conf_Parametri SET Valore='C:\Temp\inVoice\Xml'	WHERE ID='Company.SDI_CartellaXml';
	UPDATE dbo.Conf_Parametri SET Valore='1234567'				WHERE ID='Company.SDI_Codice';
	UPDATE dbo.Conf_Parametri SET Valore=''						WHERE ID='Company.SDI_Pec';
	UPDATE dbo.Conf_Parametri SET Valore='RF01'					WHERE ID='Company.SDI_RegimeFiscale';

	--Reports/Pdf
	UPDATE dbo.Conf_Parametri SET Valore='C:\Sviluppo.Maurizio\inVoice\Ver 3.1.2\Reports'		WHERE ID='Reports.Folder';
	UPDATE dbo.Conf_Parametri SET Valore='C:\Temp\inVoice\Stampe\[DescrizionePlurale]\[Year]'	WHERE ID='Pdf.Folder';
	UPDATE dbo.Conf_Parametri SET Valore=''														WHERE ID='Pdf.TmpFolder';
	UPDATE dbo.Conf_Parametri SET Valore='[Numero] - [Intestazione].pdf'						WHERE ID='Pdf.Name';

	--Behaviour
	UPDATE dbo.Conf_Parametri SET Valore='False'		WHERE ID='Behaviour.AutopagRiba'						
	UPDATE dbo.Conf_Parametri SET Valore='OnCreate'		WHERE ID='Behaviour.DocNewNumber'						
	UPDATE dbo.Conf_Parametri SET Valore='False'		WHERE ID='Behaviour.DocSortAsc'							
	UPDATE dbo.Conf_Parametri SET Valore='True'			WHERE ID='Behaviour.FiltroAutomaticoDate'		
	UPDATE dbo.Conf_Parametri SET Valore='False'	   	WHERE ID='Behaviour.ListinoEsteso';		
	UPDATE dbo.Conf_Parametri SET Valore='True'			WHERE ID='Behaviour.LockDocumentiEvasi'					
	UPDATE dbo.Conf_Parametri SET Valore='False'		WHERE ID='Behaviour.LockDocumentiEvasiForzaturaRighe'	
	UPDATE dbo.Conf_Parametri SET Valore='False'		WHERE ID='Behaviour.LogCalcoloPrezzi'					
	UPDATE dbo.Conf_Parametri SET Valore='False'		WHERE ID='Behaviour.PrevioEnable'						
	UPDATE dbo.Conf_Parametri SET Valore='False'		WHERE ID='Behaviour.Provvigioni'						
	UPDATE dbo.Conf_Parametri SET Valore='True'			WHERE ID='Behaviour.RecordInfo'							
	UPDATE dbo.Conf_Parametri SET Valore='True'			WHERE ID='Behaviour.RecordLock'							
	UPDATE dbo.Conf_Parametri SET Valore='MaterialBlue'	WHERE ID='Behaviour.Skin'								
	UPDATE dbo.Conf_Parametri SET Valore='False'		WHERE ID='Behaviour.TestEnvironment'					

	--Documents
	UPDATE dbo.Conf_Parametri SET Valore=''		WHERE ID='Documents.Attach.FileFolder'		
	UPDATE dbo.Conf_Parametri SET Valore=''		WHERE ID='Documents.Attach.FileModelFold'	
	UPDATE dbo.Conf_Parametri SET Valore=''		WHERE ID='Documents.Attach.FileModelFolder'	
	UPDATE dbo.Conf_Parametri SET Valore=''		WHERE ID='Documents.Attach.FileName'		
	UPDATE dbo.Conf_Parametri SET Valore='22'	WHERE ID='Documents.CodIva'					
	UPDATE dbo.Conf_Parametri SET Valore='2'	WHERE ID='Documents.DecimaliRighe'			
	UPDATE dbo.Conf_Parametri SET Valore='2'	WHERE ID='Documents.DecimaliTotali'			
	UPDATE dbo.Conf_Parametri SET Valore='4'	WHERE ID='Documents.Inps'					
	UPDATE dbo.Conf_Parametri SET Valore='20'	WHERE ID='Documents.RitAcc'	
	UPDATE dbo.Documenti_Tipi SET Totali=1, SviluppoScadenze=1, SDI_TipoDocumento='TD01', SDI_IsValido=1, SDI_DataInizio='20181101' WHERE ID IN ('Cli_Fattura','Cli_Fatt_RA');
	UPDATE dbo.Documenti_Tipi SET Totali=1, SviluppoScadenze=1, SDI_TipoDocumento='TD01', SDI_IsValido=1, SDI_DataInizio='20181101' WHERE ID IN ('Cli_NotaCredito');

	--nazioni
	DELETE FROM dbo.Nazioni
	INSERT INTO dbo.Nazioni
	(
	    ID,
	    SDI_IDNazione,
	    SDI_Esportazione
	)
	VALUES
	(   N'ITALIA', -- ID - nvarchar(50)
	    'IT',  -- SDI_IDNazione - char(2)
	    1 -- SDI_Esportazione - bit
	    )

	
END
GO
