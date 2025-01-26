SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   PROCEDURE [FXML].[ssp_ImportaXMLPassivo_Documenti_Righe] (
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
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('NumeroLinea').value('.', 'INT') AS NumeroLinea,
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('CodiceArticolo/CodiceTipo').value('.', 'NVARCHAR(35)') AS CodiceArticolo_CodiceTipo,
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('CodiceArticolo/CodiceValore').value('.', 'NVARCHAR(35)') AS CodiceArticolo_CodiceValore,
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('Descrizione').value('.', 'NVARCHAR(1000)') AS Descrizione,
    --FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('Quantita').value('.', N'DECIMAL(20, 5)') AS Quantita,
	FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('Quantita').value('.', N'NVARCHAR(21)') AS Quantita,
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('UnitaMisura').value('.', N'NVARCHAR(10)') AS UnitaMisura,
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('PrezzoUnitario').value('.', N'DECIMAL(20, 5)') AS PrezzoUnitario,
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('PrezzoTotale').value('.', N'DECIMAL(20, 5)') AS PrezzoTotale,
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('AliquotaIVA').value('.', N'DECIMAL(5, 2)') AS AliquotaIVA

FROM FXML.ImportXML IXML
CROSS APPLY @XML.nodes('//FatturaElettronicaBody/DatiBeniServizi/DettaglioLinee') AS FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee (XML)
WHERE IXML.PKImportXML = @PKImportXML;

/*** Check preventivi: Inizio ***/

PRINT 'Codici iva';

DECLARE @SDI_MaxProgr INT;

SELECT @SDI_MaxProgr = MAX(TRY_CAST(SUBSTRING(CI.ID, 4, LEN(CI.ID)) AS INT))
FROM dbo.CodiciIva CI
WHERE CI.ID LIKE N'SDI%';

WITH TrascodificaAliquotaIVA
AS (
    SELECT
        Perc AS AliquotaIVA,
        COALESCE(SDI_Natura, '') AS SDI_Natura,
        ID AS CodIva,
        ROW_NUMBER() OVER (PARTITION BY Perc, COALESCE(SDI_Natura, '') ORDER BY ID) AS rn

    FROM dbo.CodiciIva
),
AliquotaNatura
AS (
    SELECT DISTINCT
        FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('AliquotaIVA').value('.', N'DECIMAL(5, 2)') AS AliquotaIVA,
        COALESCE(FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('Natura').value('.', N'CHAR(2)'), '') AS SDI_Natura

    FROM FXML.ImportXML IXML
    CROSS APPLY @XML.nodes('//FatturaElettronicaBody/DatiBeniServizi/DettaglioLinee') AS FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee (XML)
    LEFT JOIN TrascodificaAliquotaIVA TAIVA ON TAIVA.AliquotaIVA = FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('AliquotaIVA').value('.', N'DECIMAL(5, 2)') AND TAIVA.SDI_Natura = COALESCE(FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('Natura').value('.', N'CHAR(2)'), '')
        AND TAIVA.rn = 1
    WHERE IXML.PKImportXML = @PKImportXML
        AND TAIVA.CodIva IS NULL
)
INSERT INTO dbo.CodiciIva
(
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
SELECT
    'SDI' + RIGHT('000' + CONVERT(VARCHAR(3), COALESCE(@SDI_MaxProgr, 0) + ROW_NUMBER() OVER (ORDER BY AN.AliquotaIVA, AN.SDI_Natura)), 3),
    'Importato da SDI',
    AN.AliquotaIVA,
    CAST(1 AS BIT),
    CAST(1 AS BIT),
    CAST(0 AS BIT),
    AN.SDI_Natura,
    NULL,
    'I',
    CAST(0 AS BIT)

FROM AliquotaNatura AN;

/*** Check preventivi: Fine ***/

PRINT 'Pre insert Documenti_Righe';

WITH TrascodificaAliquotaIVA
AS (
    SELECT
        Perc AS AliquotaIVA,
        COALESCE(SDI_Natura, '') AS SDI_Natura,
        ID AS CodIva,
        ROW_NUMBER() OVER (PARTITION BY Perc, COALESCE(SDI_Natura, '') ORDER BY ID) AS rn

    FROM dbo.CodiciIva
)
INSERT INTO dbo.Documenti_Righe
(
    ID,
    IDDocumento,
    IDArticolo,
    IDFamiglia,
    IDUnitaMisura,
    IDDocumento_Origine,
    IDDocumento_RigaOrigine,
    IDStato,
    Posizione,
    Qta,
    QtaEvasa,
    Codice,
    Descrizione1,
    Descrizione2,
    Descrizione3,
    Descrizione4,
    ImpUnitario,
    ImpNetto,
    Sconto,
    ImpSconto,
    ImpUnitarioScontato,
    ImpNettoScontato,
    CodIva,
    ImpIva,
    ImpLordo,
    NoteRiga,
    Lock_Delete,
    Lock_Qta,
    Lock_Codice,
    Lock_Descrizione1,
    Lock_Descrizione2,
    Lock_Descrizione3,
    Lock_Descrizione4,
    Nascondi,
    DisegnoNumero,
    CommessaNumero,
    CommessaDataConsegna,
    IDPreventivoPrevio,
    DdtEntrataNumero,
    DdtEntrataData,
    OrdCliNumero,
    OrdCliData,
    SDI_NumeroLinea,
	CodiceEsterno,
	CodiceEsternoTipo
)
SELECT
    NEWID(),      -- ID - uniqueidentifier
    @IDDocumento,      -- IDDocumento - uniqueidentifier
    COALESCE(TFA.IDArticolo, NULL),      -- IDArticolo - uniqueidentifier
    NULL,       -- IDFamiglia - nvarchar(50)
    NULL,       -- IDUnitaMisura - nvarchar(5)
    NULL,      -- IDDocumento_Origine - uniqueidentifier
    NULL,      -- IDDocumento_RigaOrigine - uniqueidentifier
    NULL,       -- IDStato - nvarchar(10)
    --MP 24/11/2020: Aggiunta posizione
    --ERA: NULL,         -- Posizione - int
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('NumeroLinea').value('.', 'INT'),          -- Posizione - int
    --FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('Quantita').value('.', N'DECIMAL(20, 5)'),      -- Qta - numeric(19, 6)
	CASE 
		WHEN FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('Quantita').value('.', N'NVARCHAR(21)') = '' 
		THEN 0.0
		ELSE FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('Quantita').value('.', N'DECIMAL(20, 5)') 
		END
	AS Quantita,
    NULL,      -- QtaEvasa - numeric(19, 6)

    NULL,       -- Codice - nvarchar(50)
    --CASE WHEN COALESCE(FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('CodiceArticolo/CodiceTipo').value('.', 'NVARCHAR(35)'), N'') = N'' THEN N'' ELSE FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('CodiceArticolo/CodiceTipo').value('.', 'NVARCHAR(35)') + N'.' END
    --+ COALESCE(FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('CodiceArticolo/CodiceValore').value('.', 'NVARCHAR(35)'), N''),-- Codice - nvarchar(50)

    --NULL,       -- Descrizione1 - nvarchar(1000)
    COALESCE(FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('Descrizione').value('.', 'NVARCHAR(1000)'), N''),       -- Descrizione1 - nvarchar(1000)

    NULL,       -- Descrizione2 - nvarchar(255)
    NULL,       -- Descrizione3 - nvarchar(255)
    NULL,       -- Descrizione4 - nvarchar(255)
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('PrezzoUnitario').value('.', N'DECIMAL(20, 5)'),      -- ImpUnitario - numeric(19, 6)
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('PrezzoTotale').value('.', N'DECIMAL(20, 5)'),      -- ImpNetto - numeric(19, 6)
    NULL,       -- Sconto - nvarchar(20)
    NULL,      -- ImpSconto - numeric(19, 6)
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('PrezzoUnitario').value('.', N'DECIMAL(20, 5)'),      -- ImpUnitarioScontato - numeric(19, 6)
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('PrezzoTotale').value('.', N'DECIMAL(20, 5)'),      -- ImpNettoScontato - numeric(19, 6)

    COALESCE(TAIVA.CodIva, N'> TODO <'),       -- CodIva - nvarchar(10)
    --NULL,       -- CodIva - nvarchar(10)

    NULL,      -- ImpIva - numeric(19, 6)
    NULL,      -- ImpLordo - numeric(19, 6)
    NULL,       -- NoteRiga - nvarchar(2500)
    NULL,      -- Lock_Delete - bit
    NULL,      -- Lock_Qta - bit
    NULL,      -- Lock_Codice - bit
    NULL,      -- Lock_Descrizione1 - bit
    NULL,      -- Lock_Descrizione2 - bit
    NULL,      -- Lock_Descrizione3 - bit
    NULL,      -- Lock_Descrizione4 - bit
    NULL,      -- Nascondi - bit
    NULL,       -- DisegnoNumero - nvarchar(20)
    NULL,       -- CommessaNumero - nvarchar(20)
    NULL, -- CommessaDataConsegna - datetime
    NULL,      -- IDPreventivoPrevio - uniqueidentifier
    NULL,       -- DdtEntrataNumero - nvarchar(20)
    NULL, -- DdtEntrataData - datetime
    NULL,       -- OrdCliNumero - nvarchar(20)
    NULL, -- OrdCliData - datetime
    FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('NumeroLinea').value('.', 'INT'),          -- SDI_NumeroLinea - int
    COALESCE(FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('CodiceArticolo/CodiceValore').value('.', 'NVARCHAR(35)'), N''), -- CodiceEsterno - nvarchar(50)
	CASE WHEN COALESCE(FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('CodiceArticolo/CodiceTipo').value('.', 'NVARCHAR(35)'), N'') = N'' THEN N'' ELSE FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('CodiceArticolo/CodiceTipo').value('.', 'NVARCHAR(35)') END -- CodiceEsternoTipo - NVARCHAR(50)

FROM FXML.ImportXML IXML
CROSS APPLY @XML.nodes('//FatturaElettronicaBody/DatiBeniServizi/DettaglioLinee') AS FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee (XML)
INNER JOIN dbo.Documenti D ON D.ID = @IDDocumento
LEFT JOIN FXML.TrascodificaFornitoreArticolo TFA ON TFA.IDFornitore = D.IDCliFor AND TFA.CodiceValore = FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('CodiceArticolo/CodiceValore').value('.', 'NVARCHAR(35)')
LEFT JOIN TrascodificaAliquotaIVA TAIVA ON TAIVA.AliquotaIVA = FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('AliquotaIVA').value('.', N'DECIMAL(5, 2)') AND TAIVA.SDI_Natura = COALESCE(FatturaElettronicaBody_DatiBeniServizi_DettaglioLinee.XML.query('Natura').value('.', N'CHAR(2)'), '')
    AND TAIVA.rn = 1
WHERE IXML.PKImportXML = @PKImportXML;

--Controllo codici

PRINT 'Codici articoli';

UPDATE
	DR
SET	
	DR.IDArticolo = A.ID,
	DR.Codice = A.Codice
FROM	
	dbo.Documenti_Righe DR 
	INNER JOIN dbo.Articoli A 
		ON A.Codice = DR.CodiceEsterno
WHERE DR.IDDocumento=@idDocumento
	AND COALESCE(DR.Codice,'') = '' AND DR.CodiceEsterno <> ''

--Controllo codici esterni

PRINT 'Codici esterni';

UPDATE
	DR
SET	
	DR.IDArticolo = A.ID,
	DR.Codice = A.Codice
FROM	
	dbo.Documenti D
	INNER JOIN dbo.Documenti_Righe DR 
		ON DR.IDDocumento = D.ID
	INNER JOIN dbo.Articoli_CodiciEsterni ACE 
		ON ACE.IDCliFor = D.IDCliFor
		AND ACE.CodiceEsterno = DR.CodiceEsterno
	INNER JOIN dbo.Articoli A 
		ON A.ID = ACE.IDArticolo
WHERE DR.IDDocumento=@idDocumento
	AND COALESCE(DR.Codice,'') = '' AND DR.CodiceEsterno <> ''

PRINT 'Post insert Documenti_Righe';

END;
GO
