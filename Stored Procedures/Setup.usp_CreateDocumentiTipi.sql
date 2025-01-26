SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [Setup].[usp_CreateDocumentiTipi]
AS
	DELETE FROM dbo.Documenti_Tipi_ValoriPredefiniti
	DELETE FROM dbo.Documenti_Tipi_Evasione
	DELETE FROM dbo.Documenti_Tipi
	
	INSERT INTO dbo.Causali
	(
	    ID,
	    IDOpposta,
	    Descrizione,
	    SoggettoRitAcc,
	    MovimentazioneMagazzino,
	    Fatturare,
	    SDI_TipoRitenuta,
	    SDI_CausalePagamentoRitenuta
	)
	VALUES  
		( N'VE', NULL, N'Vendita', 0, 1, 1, '', ''),
		( N'AC', NULL, N'Acquisto', 0, 1, 1, '', '');


	INSERT INTO dbo.Documenti_Tipi ( ID ,
	                                 IDModulo ,
	                                 IDCausaleDefault ,
	                                 Priorita ,
	                                 ContributoSomma ,
	                                 ContributoAnalisi ,
	                                 DescrizioneSingolare ,
	                                 DescrizionePlurale ,
	                                 DescrizioneRidottaSingolare ,
	                                 DescrizioneRidottaPlurale ,
	                                 Cliente ,
	                                 Fornitore ,
	                                 Intestazione ,
	                                 Destinazione ,
	                                 Pagamento ,
	                                 Spese ,
	                                 Trasporto ,
	                                 CondizioniFornitura ,
	                                 Righe ,
	                                 Note ,
	                                 Stato ,
	                                 NumeroLibero ,
	                                 NumeroPre ,
	                                 NumeroPos ,
	                                 NumeroCifre ,
	                                 MovimentazioneMagazzino ,
	                                 ReportEmbedded ,
	                                 ReportName ,
	                                 ReportMostraIntestazione ,
	                                 ReportMostraDestinazione ,
	                                 ReportMostraImporti ,
	                                 ReportMostraTotali ,
	                                 ReportMostraScadenze ,
	                                 ReportMostraNote ,
	                                 ReportMostraAgente ,
	                                 AmmessoCliForNonAnagrafico ,
	                                 AmmessoNascondiTotali ,
	                                 CampiChiave ,
	                                 DataConsegna ,
	                                 DescrizioneRidottaSingolareAlternativa ,
	                                 Protocollo ,
	                                 Allegato ,
	                                 Contatto ,
	                                 SviluppoProvvigioni )
		
		VALUES
		( N'Cli_Ddt', 'Cli_Ddt', N'VE', 12, 1, 0, N'Documento di Trasporto Cliente', N'Documenti di Trasporto Cliente', N'D.D.T.', N'D.D.T.', 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, NULL, NULL, NULL, 1, 0, N'rptDocumento.Ddt.rpt', N'True', N'True', N'Pag_Modalita=''CONTRASSEGNO''', N'Pag_Modalita=''CONTRASSEGNO''', N'Pag_Modalita=''CONTRASSEGNO''', N'Note<>''''', N'False', 0, 0, N'Numero', 0, '', 0, 0, 0, 0 ), 
		( N'Cli_Fattura', 'Cli_Fattura', N'VE', 13, 1, 1, N'Fattura Cliente', N'Fatture Cliente', N'FATTURA', N'Fatture', 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, NULL, N'/[Anno]', NULL, 1, 0, N'rptDocumento.Fatt.rpt', N'True', N'False', N'True', N'True', N'True', N'true', N'False', 0, 0, N'Numero', 0, '', 0, 0, 0, 0), 
		( N'Cli_NotaCredito', 'Cli_NotaCredito', NULL, 14, -1, -1, N'Nota di Credito Cliente', N'Note di Credito Cliente', N'NOTA CREDITO', N'N.D.A.', 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, 0, 0, N'rptDocumento.Fatt.rpt', N'True', N'False', N'True', N'True', N'True', N'False', N'False', 0, 0, N'Numero', 0, '', 0, 0, 0, 0 ), 
		( N'Cli_Ordine', 'Cli_Ordine', NULL, 11, 1, 0, N'Ordine Cliente', N'Ordini Cliente', N'ORDINE', N'Ordini', 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, NULL, NULL, NULL, 0, 0, N'rptDocumento.OrdineCli?Ordine|rptDocumento.Comunicazione?Comunicazione prezzi', N'True', N'True', N'True', N'True', N'False', N'Note<>''''', N'True', 0, 0, N'Numero', 1, '', 0, 0, 0, 0 ), 
		( N'Cli_Preventivo', 'Cli_Preventivo', NULL, 10, 1, 0, N'Preventivo Cliente', N'Preventivi Cliente', N'PREVENTIVO', N'Preventivi', 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, NULL, NULL, NULL, 0, 0, N'rptDocumento', N'True', N'False', N'True', N'NascondiTotali=False', N'True', N'False', N'False', 1, 1, N'Numero', 0, '', 0, 0, 0, 0 ), 
		( N'Cli_Proforma', 'Cli_Proforma', N'VE', 13, 1, 0, N'Fattura Proforma', N'Fatture Proforma', N'FATTURA PROFORMA', N'Fatture PF', 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, 1, 0, N'rptDocumento.Fatt.rpt', N'True', N'False', N'True', N'True', N'False', N'False', N'False', 0, 0, N'Numero', 0, '', 0, 0, 0, 0 ), 
		( N'For_Ddt', 'For_Ddt', N'AC', 22, -1, 0, N'Documento di Trasporto Fornitore', N'Documenti di Trasporto Fornitore', N'D.D.T.', N'D.D.T.', 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, NULL, NULL, NULL, 1, 0, N'rptDocumento', N'False', N'False', N'False', N'False', N'False', N'False', N'False', 0, 0, N'IDCliFor;Numero', 0, '', 0, 0, 0, 0 ), 
		( N'For_Fattura', 'For_Fattura', N'AC', 23, -1, -1, N'Fattura Fornitore', N'Fatture Fornitore', N'FATTURA', N'Fatture', 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, NULL, NULL, NULL, 1, 0, N'rptDocumento', N'True', N'False', N'False', N'False', N'False', N'False', N'False', 0, 0, N'IDCliFor;Numero', 0, '', 0, 0, 0, 0 ), 
		( N'For_NotaCredito', 'For_NotaCredito', NULL, 24, 1, 1, N'Nota di Credito Fornitore', N'Note di Credito Fornitore', N'NOTA CREDITO', N'N.D.A.', 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, NULL, NULL, NULL, 0, 0, N'rptDocumento', N'False', N'False', N'False', N'False', N'False', N'False', N'False', 0, 0, N'IDCliFor;Numero', 0, '', 0, 0, 0, 0 ), 
		( N'For_Ordine', 'For_Ordine', NULL, 21, -1, 0, N'Ordine Fornitore', N'Ordini Fornitore', N'ORDINE', N'Ordini', 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, NULL, NULL, NULL, 0, 0, N'rptDocumento.OrdineFor.rpt', N'True', N'False', N'True', N'False', N'False', N'False', N'False', 0, 0, N'IDCliFor;Numero', 1, '', 0, 0, 0, 0 ), 
		( N'For_Preventivo', 'For_Preventivo', NULL, 10, -1, 0, N'Preventivo Fornitore', N'Preventivi Fornitore', N'PREVENTIVO', N'Preventivi', 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, NULL, NULL, NULL, 0, 0, N'rptDocumento', N'False', N'False', N'True', N'NascondiTotali=False', N'True', N'False', N'False', 1, 1, N'IDCliFor;Numero', 0, '', 0, 0, 0, 0 )

	INSERT INTO dbo.Documenti_Tipi_Evasione ( ID ,
	                                          IDTipoEvaso ,
	                                          IDTipoEvasore ,
	                                          Precedenza ,
	                                          EvasioneParziale )
		VALUES
		( '{8ebdfd63-e75a-468e-809a-1d811dca5ac8}', N'Cli_Ddt', N'Cli_Fattura', 0, 0 ), 
		( '{894b3a04-b99d-4f40-b452-29a36abcac5c}', N'Cli_Preventivo', N'Cli_DDT', 0, 1 ), 
		( '{595db39d-7b9c-4509-b642-42a3fbf32bb0}', N'Cli_Proforma', N'Cli_Fattura', 0, 0 ), 
		( '{6baf364c-7c7a-44dc-b3a7-7f2f871a4842}', N'Cli_Ordine', N'Cli_DDT', 0, 1 ), 
		( '{36e3b579-546e-43f7-8c01-d94d6ad9eaf0}', N'For_Ddt', N'For_Fattura', 0, 0 ), 
		( '{ff3b7381-db4f-4f68-bb71-f831d7b55714}', N'Cli_Preventivo', N'Cli_Ordine', 0, 1 )

	INSERT INTO dbo.Documenti_Tipi_ValoriPredefiniti ( ID, IDTipo, NomeCampo, Valore ) 
		VALUES  
		( NEWID(), N'Cli_Preventivo', N'IDFornitura', N'Fornitura completa'), 
		( NEWID(), N'Cli_Ordine', N'IDFornitura', N'Fornitura completa')
	    



GO
