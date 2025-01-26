SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 

CREATE PROCEDURE [Setup].[usp_SaldoAutomaticoScadenze]
AS 
BEGIN

	--previene avvio accidentale
	SET NOEXEC ON;
	--SET NOEXET OFF;

	DECLARE @idTipo NVARCHAR(20) = N'For_Fattura';
	DECLARE @data1 DATETIME = '20100101';
	DECLARE @data2 DATETIME = '20101231';
	DECLARE @descrizione NVARCHAR(100) = N'SALDO AUTOMATICO DD-MM-YYYY';

	--DELETE FROM dbo.Documenti_Scadenze WHERE Descrizione = @descrizione;

	INSERT INTO dbo.Documenti_Scadenze
	(
		ID,
		IDDocumento,
		BancaCassa,
		Insoluto,
		RbEsportata,
		RbEsportataData,
		RbBanca,
		Descrizione,
		Note,
		Data,
		Numero,
		Tipo,
		Importo,
		IDTipoPagamento
	)
	SELECT NEWID(),
			D.ID,
			'B',
			0,
			0,
			NULL,
			'',
			@descrizione,
			NULL,
			DS.Data,
			DS.Numero,
			-1,
			DS.Importo,
			NULL
	FROM dbo.Documenti D
		INNER JOIN dbo.Documenti_Scadenze DS
			ON DS.IDDocumento = D.ID
		LEFT JOIN dbo.Documenti_Scadenze DS2
			ON DS2.IDDocumento = D.ID
				AND DS2.Numero = DS.Numero
				AND DS2.Tipo = -DS.Tipo
	WHERE D.IDTipo = @idTipo
			--AND YEAR(DS.Data) <= 2017
			AND DS.Data BETWEEN @data1 AND @data2
			AND DS2.ID IS NULL
			AND DS.Importo < 0
			AND COALESCE(DS.Insoluto, 0) = 0;
END;
GO
