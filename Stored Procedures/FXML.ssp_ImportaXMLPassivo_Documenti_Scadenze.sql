SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [FXML].[ssp_ImportaXMLPassivo_Documenti_Scadenze] (
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

SELECT
    FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('ModalitaPagamento').value('.', 'CHAR(4)') AS ModalitaPagamento,
    FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('DataScadenzaPagamento').value('.', 'DATE') AS DataScadenzaPagamento,
    FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('ImportoPagamento').value('.', 'DECIMAL(15, 2)') AS ImportoPagamento,
    FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('IstitutoFinanziario').value('.', 'NVARCHAR(80)') AS IstitutoFinanziario,
    FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('IBAN').value('.', N'NVARCHAR(34)') AS IBAN,
    FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('ABI').value('.', N'INT') AS ABI,
    FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('CAB').value('.', N'INT') AS CAB,
    FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('BIC').value('.', N'NVARCHAR(11)') AS BIC

FROM FXML.ImportXML IXML
CROSS APPLY @XML.nodes('//FatturaElettronicaBody/DatiPagamento/DettaglioPagamento') AS FatturaElettronicaBody_DatiPagamento_DettaglioPagamento (XML)
WHERE IXML.PKImportXML = @PKImportXML;

/*** Check preventivi: Inizio ***/

/*** Check preventivi: Fine ***/

PRINT 'Pre insert Documenti_Scadenze';

WITH TrascodificaModalitaPagamento
AS (
    SELECT
        MPT.SDI_ModalitaPagamento,
        MPT.ID AS IDTipoPagamento,
        ROW_NUMBER() OVER (PARTITION BY MPT.SDI_ModalitaPagamento ORDER BY CASE WHEN MPT.ID = COALESCE(MPT.SDI_ModalitaPagamento, '') THEN 0 ELSE 1 END, MPT.ID) AS rn

    FROM dbo.ModalitaPagamento_Tipi MPT
    WHERE COALESCE(MPT.SDI_ModalitaPagamento, '') <> ''
)
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
SELECT
    NEWID(),      -- ID - uniqueidentifier
    @IDDocumento,      -- IDDocumento - uniqueidentifier
    NULL,       -- BancaCassa - nvarchar(5)
    NULL,      -- Insoluto - bit
    NULL,      -- RbEsportata - bit
    NULL, -- RbEsportataData - datetime
    FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('IstitutoFinanziario').value('.', 'NVARCHAR(80)'),       -- RbBanca - nvarchar(50)
    FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('IstitutoFinanziario').value('.', 'NVARCHAR(80)'),       -- Descrizione - nvarchar(100)
    NULL,       -- Note - nvarchar(100)
    CASE WHEN FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('DataScadenzaPagamento').value('.', 'DATE') = CAST('19000101' AS DATE) THEN CAST(D.Data AS DATE) ELSE FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('DataScadenzaPagamento').value('.', 'DATE') END AS Data, -- Data - datetime
    ROW_NUMBER() OVER (ORDER BY FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('DataScadenzaPagamento').value('.', 'DATE')),         -- Numero - int
    1 AS Tipo,         -- Tipo - int
    FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('ImportoPagamento').value('.', 'DECIMAL(15, 2)'),      -- Importo - numeric(19, 6)
    COALESCE(TMP.IDTipoPagamento, N'')        -- IDTipoPagamento - nvarchar(4)

FROM FXML.ImportXML IXML
CROSS APPLY @XML.nodes('//FatturaElettronicaBody/DatiPagamento/DettaglioPagamento') AS FatturaElettronicaBody_DatiPagamento_DettaglioPagamento (XML)
INNER JOIN dbo.Documenti D ON D.ID = @IDDocumento
LEFT JOIN TrascodificaModalitaPagamento TMP ON TMP.SDI_ModalitaPagamento = FatturaElettronicaBody_DatiPagamento_DettaglioPagamento.XML.query('ModalitaPagamento').value('.', 'CHAR(4)')
    AND TMP.rn = 1
WHERE IXML.PKImportXML = @PKImportXML;

IF (@@ROWCOUNT = 0)
BEGIN

    DECLARE @SDI_Passivo_ModalitaPagamentoTipoDefault CHAR(4) = NULL;

    SELECT TOP 1 @SDI_Passivo_ModalitaPagamentoTipoDefault = CP.Valore
    FROM dbo.Conf_Parametri CP
    WHERE CP.ID = N'SDI_Passivo_ModalitaPagamentoTipoDefault';

    IF (@SDI_Passivo_ModalitaPagamentoTipoDefault IS NULL) SET @SDI_Passivo_ModalitaPagamentoTipoDefault = N'MP01'; -- MP01: Contanti

    WITH TrascodificaModalitaPagamento
    AS (
        SELECT
            MPT.SDI_ModalitaPagamento,
            MPT.ID AS IDTipoPagamento,
            ROW_NUMBER() OVER (PARTITION BY MPT.SDI_ModalitaPagamento ORDER BY CASE WHEN MPT.ID = COALESCE(MPT.SDI_ModalitaPagamento, '') THEN 0 ELSE 1 END, MPT.ID) AS rn

        FROM dbo.ModalitaPagamento_Tipi MPT
        WHERE COALESCE(MPT.SDI_ModalitaPagamento, '') <> ''
    )
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
    SELECT
        NEWID(),      -- ID - uniqueidentifier
        @IDDocumento,      -- IDDocumento - uniqueidentifier
        NULL,       -- BancaCassa - nvarchar(5)
        NULL,      -- Insoluto - bit
        NULL,      -- RbEsportata - bit
        NULL, -- RbEsportataData - datetime
        NULL,       -- RbBanca - nvarchar(50)
        NULL,       -- Descrizione - nvarchar(100)
        NULL,       -- Note - nvarchar(100)
        CAST(D.Data AS DATE) AS Data, -- Data - datetime
        1 AS Numero,         -- Numero - int
        1 AS Tipo,         -- Tipo - int
        D.TotDoc,      -- Importo - numeric(19, 6)
        N''        -- IDTipoPagamento - nvarchar(4)

    FROM FXML.ImportXML IXML
    INNER JOIN dbo.Documenti D ON D.ID = @IDDocumento
    LEFT JOIN TrascodificaModalitaPagamento TMP ON TMP.SDI_ModalitaPagamento = @SDI_Passivo_ModalitaPagamentoTipoDefault
        AND TMP.rn = 1
    WHERE IXML.PKImportXML = @PKImportXML;

END;

PRINT 'Post insert Documenti_Scadenze';

END;
GO
