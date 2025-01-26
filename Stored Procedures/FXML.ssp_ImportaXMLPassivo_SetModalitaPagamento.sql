SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [FXML].[ssp_ImportaXMLPassivo_SetModalitaPagamento]
	@IDDocumento UNIQUEIDENTIFIER = NULL
AS
BEGIN
	--DECLARE @IDDocumento UNIQUEIDENTIFIER = '6B22DBDE-6E35-4755-9AC5-B4407068851F';
	DECLARE @Tmp TABLE (IDDocumento UNIQUEIDENTIFIER NOT NULL, ModalitaPagamento NVARCHAR(100) NOT NULL);

	--Modalità di pagamento per documento
	;WITH DS1 AS (
		SELECT
			DS.IDDocumento,
			DS.IDTipoPagamento,
			COUNT(1) AS NumScadenze
		FROM 
			dbo.Documenti D 
			INNER JOIN dbo.Documenti_Scadenze DS ON DS.IDDocumento = D.ID
		WHERE 
			D.ID = @IDDocumento
			OR
			(@IDDocumento IS NULL
			 AND D.IDTipo LIKE 'For_%'
			 AND D.SDI_Stato = -1
			 AND D.Pag_Modalita IS NULL
			 AND DS.Tipo=1
			 AND COALESCE(DS.IDTipoPagamento, '') <> '')
		GROUP BY DS.IDDocumento, DS.IDTipoPagamento)
	,DS2 AS (
	SELECT 
		t1.IDDocumento,
		SUBSTRING(
			(SELECT  ', ' + st1.IDTipoPagamento + ' (' + CONVERT(VARCHAR(10), st1.NumScadenze) + ')' AS  [text()]
				FROM DS1 st1
				WHERE st1.IDDocumento = t1.IDDocumento
				ORDER BY st1.IDTipoPagamento
				FOR XML PATH ('')
			) 
		, 3, 1000) ModalitaPagamento
	  FROM DS1 t1
	)
	INSERT INTO @Tmp 
		(IDDocumento, ModalitaPagamento)
	SELECT DISTINCT
		DS2.IDDocumento,
		DS2.ModalitaPagamento
	FROM DS2;

	--Aggiungo modalità se non esiste
	MERGE dbo.ModalitaPagamento AS TGT
	USING (SELECT DISTINCT T.ModalitaPagamento FROM @Tmp T) AS SRC
	ON TGT.ID = SRC.ModalitaPagamento
	WHEN NOT MATCHED THEN	
		INSERT (ID, Sospesa) 
		VALUES (SRC.ModalitaPagamento, 1);

	--Aggiorno modalità pagamento su documenti
	UPDATE D
	SET
		Pag_Modalita = T.ModalitaPagamento
	FROM 
		dbo.Documenti D
		INNER JOIN @Tmp T ON T.IDDocumento = D.ID;
END
GO
