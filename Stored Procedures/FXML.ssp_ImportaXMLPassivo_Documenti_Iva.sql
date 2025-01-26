SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [FXML].[ssp_ImportaXMLPassivo_Documenti_Iva] (
    @PKImportXML BIGINT,
    @IDDocumento UNIQUEIDENTIFIER
)
AS
BEGIN

SET NOCOUNT ON;

DECLARE @XML XML;

SELECT TOP 1 @XML = XMLContent
FROM FXML.ImportXML
WHERE PKImportXML = @PKImportXML;

PRINT 'Pre insert Documenti_Iva';

INSERT INTO dbo.Documenti_Iva
(
    ID,
    IDDocumento,
    IDPlafondEsenzione,
    ImpNetto,
    CodIva,
    ImpIva,
    ImpLordo
)
SELECT
   NEWID(),			-- ID - uniqueidentifier
    @IDDocumento,	-- IDDocumento - uniqueidentifier
    0,				-- IDPlafondEsenzione - int
    FatturaElettronicaBody_DatiBeniServizi_DatiRiepilogo.XML.query('ImponibileImporto').value('.', 'DECIMAL(15, 2)'),	-- ImpNetto - numeric(19, 6)
    FatturaElettronicaBody_DatiBeniServizi_DatiRiepilogo.XML.query('AliquotaIVA').value('.', 'NVARCHAR(10)'),			-- CodIva - nvarchar(10)
    FatturaElettronicaBody_DatiBeniServizi_DatiRiepilogo.XML.query('Imposta').value('.', 'DECIMAL(15, 2)'),				-- ImpIva - numeric(19, 6)
    FatturaElettronicaBody_DatiBeniServizi_DatiRiepilogo.XML.query('ImponibileImporto').value('.', 'DECIMAL(15, 2)')
    + FatturaElettronicaBody_DatiBeniServizi_DatiRiepilogo.XML.query('Imposta').value('.', 'DECIMAL(15, 2)')			-- ImpLordo - numeric(19, 6)
FROM FXML.ImportXML IXML
CROSS APPLY @XML.nodes('//FatturaElettronicaBody/DatiBeniServizi/DatiRiepilogo') AS FatturaElettronicaBody_DatiBeniServizi_DatiRiepilogo (XML)
INNER JOIN dbo.Documenti D ON D.ID = @IDDocumento
WHERE IXML.PKImportXML = @PKImportXML;

WITH DI AS (
	SELECT	
		DI.IDDocumento,
		SUM(DI.ImpNetto) AS TotImpNetto,
		SUM(DI.ImpIva) AS TotImpIva,
		SUM(DI.ImpLordo) AS TotImpLordo
	FROM dbo.Documenti_Iva DI 
	WHERE DI.IDDocumento=@IDDocumento
	GROUP BY DI.IDDocumento
)
UPDATE D
SET
	D.TotRighe = ROUND(DI.TotImpNetto / (1.0 + COALESCE(D.Inps, 0.0) / 100.0), 2),
	D.TotImp = DI.TotImpNetto,
	D.TotIva = DI.TotImpIva,
	D.TotLordo = DI.TotImpLordo,
	D.TotDoc = DI.TotImpLordo - DI.TotImpNetto * COALESCE(D.RitAcc, 0.0) / 100.0
FROM 
	dbo.Documenti D INNER JOIN	
	DI ON DI.IDDocumento = D.ID
WHERE 
	D.ID=@IDDocumento;

END;
GO
