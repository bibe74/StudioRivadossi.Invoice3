SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Setup].[usp_CreateModalitaPagamento] AS
BEGIN
	DELETE FROM dbo.ModalitaPagamento;
	DELETE FROM dbo.ModalitaPagamento_Tipi;
	
	WITH SRC AS (
		SELECT 'MP01' AS ID,
			   'Contanti' AS Descrizione,
			   0 AS EmissioneRiBa,
			   0 AS PagamentoAutomatico,
			   0 AS SDI_HasDataScadenza,
			   0 AS SDI_HasDatiIstitutoFinanziario
		UNION ALL SELECT 'MP02', 'Assegno'									    ,0,0,0,0
		UNION ALL SELECT 'MP03', 'Assegno circolare'							,0,0,0,0
		UNION ALL SELECT 'MP04', 'Contanti presso Tesoreria'					,0,0,0,0
		UNION ALL SELECT 'MP05', 'Bonifico'										,0,0,1,1
		UNION ALL SELECT 'MP06', 'Vaglia cambiario'								,0,0,0,0
		UNION ALL SELECT 'MP07', 'Bollettino bancario'							,0,0,0,0
		UNION ALL SELECT 'MP08', 'Carta di pagamento'							,0,0,0,0
		UNION ALL SELECT 'MP09', 'RID'											,0,0,0,0
		UNION ALL SELECT 'MP10', 'RID utenze'									,0,0,0,0
		UNION ALL SELECT 'MP11', 'RID veloce'									,0,0,0,0
		UNION ALL SELECT 'MP12', 'RIBA'											,1,1,1,1
		UNION ALL SELECT 'MP13', 'MAV'											,0,0,0,0
		UNION ALL SELECT 'MP14', 'Quietanza erario'								,0,0,0,0
		UNION ALL SELECT 'MP15', 'Giroconto su conti di contabilità speciale'	,0,0,0,0
		UNION ALL SELECT 'MP16', 'Domiciliazione bancaria'						,0,0,0,0
		UNION ALL SELECT 'MP17', 'Domiciliazione postale'						,0,0,0,0
		UNION ALL SELECT 'MP18', 'Bollettino di c/c postale'					,0,0,0,0
		UNION ALL SELECT 'MP19', 'SEPA Direct Debit'							,0,0,0,0
		UNION ALL SELECT 'MP20', 'SEPA Direct Debit CORE'						,0,0,0,0
		UNION ALL SELECT 'MP21', 'SEPA Direct Debit B2B' 						,0,0,0,0
		UNION ALL SELECT 'MP22', 'Trattenuta su somme già riscosse'  			,0,0,0,0)					
	INSERT INTO dbo.ModalitaPagamento_Tipi
	     (
	         ID,
	         Descrizione,
	         EmissioneRiba,
	         PagamentoAutomatico,
	         SDI_ModalitaPagamento,
	         SDI_HasDataScadenza,
	         SDI_HasDatiIstitutoFinanziario
	     )
		SELECT 
			 SRC.ID,
             SRC.Descrizione,
             SRC.EmissioneRiBa,
             SRC.PagamentoAutomatico,
			 SRC.ID,
             SRC.SDI_HasDataScadenza,
             SRC.SDI_HasDatiIstitutoFinanziario
		FROM SRC;


	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'B.B. 30 gg D.F. F.M.', N'MP05', 1, 1, 1, 0, 30, 0, 0,  0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'B.B. 30-60 gg D.F.F.M.', N'MP05', 1, 2, 1, 0, 30, 0, 60, 0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'B.B. 60 gg D.F. F.M.', N'MP05', 1, 1, 1, 0, 60, 0, 0,  0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'B.B. 90 gg D.F.F.M.',	N'MP05', 1, 1, 1, 0, 90, 0, 0,  0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'B.B. RICEV. FATTURA',	N'MP05', 0, 1, 1, 0, 0,  0, 0,  0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'CONTRASSEGNO ', N'MP01', 0, 1, 1, 0, 0,  0, 0,  0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'R.B. 30 gg D.F. F.M.', N'MP12', 1, 1, 1, 0, 30, 0, 0,  0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'R.B. 30 gg scad.15 ',	N'MP12', 1, 1, 1, 0, 45, 0, 0,  0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'R.B. 30-60 gg D.F.F.M.', N'MP12', 1, 2, 1, 0, 30, 0, 60, 0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'R.B. 30-60-90-120-150 gg D.F.F.M.', N'MP12', 1, 5, 1, 0, 30, 0, 60, 0, 90, 0, 120, 0, 150, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'R.B. 60 gg D.F. F.M.', N'MP12', 1, 1, 1, 0, 60, 0, 0,  0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'R.B. 60-90 gg D.F. F.M.',	N'MP12', 1, 2, 1, 0, 60, 0, 90, 0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'R.B. 90 gg D.F.F.M.',	N'MP12', 1, 1, 1, 0, 90, 0, 0,  0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'RID',	N'MP09', 1, 1, 1, 0, 0,  0, 0,  0, 0,  0, 0,   0, 0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)

	INSERT INTO dbo.ModalitaPagamento (ID, Tipo, CalcoloScadenza, NumeroRate, RateUguali, IvaSullaPrimaRata, Rata1_Giorni, Rata1_Perc, Rata2_Giorni, Rata2_Perc, Rata3_Giorni, Rata3_Perc, Rata4_Giorni, Rata4_Perc, Rata5_Giorni, Rata5_Perc, Rata6_Giorni, Rata6_Perc, PagamentoImmediato, RateIvaUguali, Rata1_PercIva, Rata2_PercIva, Rata3_PercIva, Rata4_PercIva, Rata5_PercIva, Rata6_PercIva) 
		VALUES (N'RIMESSA DIRETTA ', N'MP01', 0, 1, 1, 0, 0,  0, 0,  0, 0,  0, 0,   0, 0,   0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0)

END

GO
