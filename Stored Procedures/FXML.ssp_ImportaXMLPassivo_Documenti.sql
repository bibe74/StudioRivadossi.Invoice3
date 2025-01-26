SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   PROCEDURE [FXML].[ssp_ImportaXMLPassivo_Documenti] (
    @PKImportXML BIGINT,
    @IDDocumento UNIQUEIDENTIFIER OUTPUT
)
AS
BEGIN

SET NOCOUNT ON;

DECLARE @XML XML;

SELECT TOP 1 @XML = XMLContent
FROM FXML.ImportXML
WHERE PKImportXML = @PKImportXML;

SELECT
    FatturaElettronicaHeader.XML.query('CedentePrestatore/DatiAnagrafici/IdFiscaleIVA/IdPaese').value('.', 'CHAR(2)') AS CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese,
    FatturaElettronicaHeader.XML.query('CedentePrestatore/DatiAnagrafici/IdFiscaleIVA/IdCodice').value('.', 'NVARCHAR(28)') AS CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice,
    FatturaElettronicaHeader.XML.query('CedentePrestatore/DatiAnagrafici/CodiceFiscale').value('.', 'NVARCHAR(16)') AS CedentePrestatore_DatiAnagrafici_CodiceFiscale

FROM FXML.ImportXML IXML
CROSS APPLY @XML.nodes('//FatturaElettronicaHeader') AS FatturaElettronicaHeader (XML)
WHERE IXML.PKImportXML = @PKImportXML;

SELECT
    FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/TipoDocumento').value('.', 'CHAR(4)') AS DatiGenerali_DatiGeneraliDocumento_TipoDocumento,
    FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/Divisa').value('.', 'CHAR(3)') AS DatiGenerali_DatiGeneraliDocumento_Divisa,
    FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/Data').value('.', N'DATE') AS DatiGenerali_DatiGeneraliDocumento_Data,
    FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/Numero').value('.', N'NVARCHAR(20)') AS DatiGenerali_DatiGeneraliDocumento_Numero

FROM FXML.ImportXML IXML
CROSS APPLY @XML.nodes('//FatturaElettronicaBody') AS FatturaElettronicaBody (XML)
WHERE IXML.PKImportXML = @PKImportXML;

/*** Check preventivi: Inizio ***/

DECLARE @XML_CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice NVARCHAR(28);
DECLARE @XML_CedentePrestatore_DatiAnagrafici_CodiceFiscale NVARCHAR(16);
DECLARE @XML_CedentePrestatore_Sede_Nazione CHAR(2);
DECLARE @XML_DatiGenerali_DatiGeneraliDocumento_TipoDocumento CHAR(4);
DECLARE @XML_DatiGenerali_DatiGeneraliDocumento_Data DATE;
DECLARE @XML_DatiGenerali_DatiGeneraliDocumento_Numero NVARCHAR(20);

DECLARE @IDCliFor UNIQUEIDENTIFIER;
DECLARE @Nazione NVARCHAR(50);

SELECT
    @XML_CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice = FatturaElettronicaHeader.XML.query('CedentePrestatore/DatiAnagrafici/IdFiscaleIVA/IdCodice').value('.', 'NVARCHAR(28)'),
    @XML_CedentePrestatore_DatiAnagrafici_CodiceFiscale = FatturaElettronicaHeader.XML.query('CedentePrestatore/DatiAnagrafici/CodiceFiscale').value('.', 'NVARCHAR(16)'),
    @XML_CedentePrestatore_Sede_Nazione = FatturaElettronicaHeader.XML.query('CedentePrestatore/Sede/Nazione').value('.', 'CHAR(2)')

FROM FXML.ImportXML IXML
CROSS APPLY @XML.nodes('//FatturaElettronicaHeader') AS FatturaElettronicaHeader (XML)
WHERE IXML.PKImportXML = @PKImportXML;

SELECT
    @XML_DatiGenerali_DatiGeneraliDocumento_TipoDocumento = FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/TipoDocumento').value('.', 'CHAR(4)'),
    @XML_DatiGenerali_DatiGeneraliDocumento_Data = FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/Data').value('.', N'DATE'),
    @XML_DatiGenerali_DatiGeneraliDocumento_Numero = FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/Numero').value('.', N'NVARCHAR(20)')

FROM FXML.ImportXML IXML
CROSS APPLY @XML.nodes('//FatturaElettronicaBody') AS FatturaElettronicaBody (XML)
WHERE IXML.PKImportXML = @PKImportXML;

SELECT TOP 1
    @IDCliFor = CF.ID
FROM dbo.CliFor CF
WHERE CF.Fornitore = CAST(1 AS BIT)
    AND (
        [PI] = @XML_CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice
        --MP 24/11/2020: ERA: OR CF = @XML_CedentePrestatore_DatiAnagrafici_CodiceFiscale
        OR (COALESCE(CF, '') <> '' AND CF = @XML_CedentePrestatore_DatiAnagrafici_CodiceFiscale)
    );

SELECT
    @Nazione = N.Nazione

FROM InVoiceXML.XMLCodifiche.Nazione N
WHERE N.IDNazione = @XML_CedentePrestatore_Sede_Nazione;

SELECT @Nazione = COALESCE(@Nazione, N'Italia');

--MPI: 17/10/2019: Aggiungo nazione se non esiste : Begin
INSERT INTO dbo.Nazioni
(
    ID,
    SDI_IDNazione,
    SDI_Esportazione,
    BolloVirtuale
)

SELECT 
	N.Nazione,
	N.IDNazione,
	0,
	0
FROM
	inVoiceXml.XMLCodifiche.Nazione N
WHERE NOT EXISTS (SELECT N2.SDI_IDNazione 
				  FROM dbo.Nazioni N2 
				  WHERE N2.SDI_IDNazione COLLATE Latin1_General_CI_AS = N.IDNazione COLLATE Latin1_General_CI_AS
				  AND   N2.ID COLLATE Latin1_General_CI_AS = N.Nazione COLLATE Latin1_General_CI_AS)
	AND N.IDNazione = @XML_CedentePrestatore_Sede_Nazione;
--MPI: 17/10/2019: Aggiungo nazione se non esiste : End

SELECT
    @XML_CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice AS XML_CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice,
    @XML_CedentePrestatore_DatiAnagrafici_CodiceFiscale AS XML_CedentePrestatore_DatiAnagrafici_CodiceFiscale,
    @IDCliFor AS IDCliFor,
    @Nazione AS Nazione;

DECLARE @XML_TipoDocumento CHAR(4);
DECLARE @IDTipoDocumento NVARCHAR(20);
DECLARE @ModelloReport NVARCHAR(50);

SELECT
    @XML_TipoDocumento = FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/TipoDocumento').value('.', 'CHAR(4)')

FROM FXML.ImportXML IXML
CROSS APPLY @XML.nodes('//FatturaElettronicaBody') AS FatturaElettronicaBody (XML)
WHERE IXML.PKImportXML = @PKImportXML;

-- #071 Richieste di modifica/integrazione - 28/11/2020 - BEGIN
/* Era:
SELECT TOP 1
    @IDTipoDocumento = DT.ID,
	@ModelloReport = DT.ModelloReport

FROM dbo.Documenti_Tipi DT
WHERE DT.SDI_TipoDocumentoPassivo = @XML_TipoDocumento;
*/

SELECT TOP 1
    @IDTipoDocumento = IDTipoDocumento_InVoice

FROM FXML.TipiDocumentoIngresso
WHERE IDTipoDocumento_SDI = @XML_TipoDocumento
ORDER BY IDTipoDocumento_InVoice;

IF @IDTipoDocumento IS NOT NULL
BEGIN

SELECT TOP 1
    @ModelloReport = DT.ModelloReport

FROM dbo.Documenti_Tipi DT
WHERE DT.ID = @IDTipoDocumento
ORDER BY DT.ID;

END;

IF @IDTipoDocumento IS NULL
BEGIN

    UPDATE FXML.ImportXML
    SET IDStatoImportazione = 99 -- 99: importazione terminata con errori
    WHERE PKImportXML = @PKImportXML;

    SET @IDDocumento = NULL;

END;
ELSE
BEGIN

-- #071 Richieste di modifica/integrazione - 28/11/2020 - END

SELECT
    @XML_TipoDocumento AS XML_IDTipoDocumento,
    @IDTipoDocumento AS IDTipoDocumento;

/*** Check preventivi: Fine ***/

BEGIN TRANSACTION 

BEGIN TRY

    SET @IDDocumento = NEWID();

    PRINT @IDDocumento;

    UPDATE FXML.ImportXML
    SET IDStatoImportazione = 1, -- 1: importazione in corso
        CedentePrestatore_DatiAnagrafici_IDFiscaleIVA_IdCodice = @XML_CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice,
        DatiGenerali_DatiGeneraliDocumento_TipoDocumento = @XML_DatiGenerali_DatiGeneraliDocumento_TipoDocumento,
        DatiGenerali_DatiGeneraliDocumento_Data = @XML_DatiGenerali_DatiGeneraliDocumento_Data,
        DatiGenerali_DatiGeneraliDocumento_Numero = @XML_DatiGenerali_DatiGeneraliDocumento_Numero,
        IDDocumento = @IDDocumento

    WHERE PKImportXML = @PKImportXML;

    PRINT 'Pre insert dbo.Documenti';

    INSERT INTO dbo.Documenti
    (
        ID,
        IDTipo,
        IDStato,
        IDCliFor,
        IDCliFor_Indirizzo,
        IDCausale,
        IDMagazzino,
        IDMagazzinoOpposto,
        Numero,
        NumeroPre,
        NumeroInt,
        NumeroPos,
        Data,
        DataConsegna,
        CF,
        PI,
        Intestazione,
        Intestazione2,
        Indirizzo,
        Cap,
        Comune,
        Provincia,
        Nazione,
        Pag_Modalita,
        Pag_CalcolaImporti,
        Pag_Banca,
        Pag_Cin,
        Pag_Abi,
        Pag_Cab,
        Pag_Cc,
        Pag_Iban,
        Pag_Bic,
        Pag_Spese,
        Pag_ExtraSconto,
        Pag_ExtraSconto_Perc,
        Dest_Intestazione,
        Dest_Intestazione2,
        Dest_Indirizzo,
        Dest_Cap,
        Dest_Comune,
        Dest_Provincia,
        Dest_Nazione,
        Note,
        TotRighe,
        Inps,
        TotImp,
        TotIva,
        TotLordo,
        RitAcc,
        TotDoc,
        Righe,
        RigheEvase,
        RigheEvaseParz,
        CondFor_Validita,
        CondFor_Tempi,
        CondFor_Trasporto,
        CondFor_Resa,
        CondFor_Note,
        Trasp_TsInizio,
        Trasp_Mezzo,
        Trasp_Aspetto,
        Trasp_Colli,
        Trasp_Peso,
        Trasp_Porto,
        Trasp_Vettore1,
        Trasp_Vettore2,
        Trasp_Vettore3,
        Trasp_IDVeicolo,
        Trasp_DistanzaKm,
        Trasp_MezzoCedente,
        Trasp_MezzoCessionario,
        NascondiTotali,
        SoggettoRitAcc,
        Pag_ModalitaSviluppata,
        Protocollo,
        DescrizioneRidottaSingolare,
        AllegatoModello,
        AllegatoFile,
        IDFornitura,
        IDBancaRB,
        Creazione_Ts,
        Creazione_IDUtente,
        Modifica_Ts,
        Modifica_IDUtente,
        Allegato,
        Rif_CodiceFornitore,
        Rif_Ordine,
        Rif_Magazzino,
        SitPag_TotPagato,
        SitPag_TotProvvigione,
        SitPag_TotProvvigionePagato,
        Pdf,
        Pdf_Ts,
        Riferimenti,
        Evaso,
        Evade,
        IDReferente,
        DataRichiesta,
        ModelloReport,
        Qta,
        QtaEvasa,
        SDI_Stato,
        SDI_StatoTs,
        SDI_LogEvento,
        SDI_LogValidazione,
        CodiceCIG,
        CodiceCUP,
        Sospeso,
        HasDatiBollo,
        ImportoBollo
        -- #071 Richieste di modifica/integrazione - 28/11/2020 - BEGIN
        , SDI_IDTipoDocumento
        -- #071 Richieste di modifica/integrazione - 28/11/2020 - END
    )
    SELECT
        @IDDocumento,      -- ID - uniqueidentifier
        @IDTipoDocumento,       -- IDTipo - nvarchar(20)
        NULL,       -- IDStato - nvarchar(10)
        @IDCliFor,      -- IDCliFor - uniqueidentifier
        NULL,      -- IDCliFor_Indirizzo - uniqueidentifier
        NULL,       -- IDCausale - nvarchar(3)
        NULL,       -- IDMagazzino - nvarchar(3)
        NULL,       -- IDMagazzinoOpposto - nvarchar(3)
        NULL,       -- Numero - nvarchar(20)
        NULL,       -- NumeroPre - nvarchar(10)
        NULL,         -- NumeroInt - int
        NULL,       -- NumeroPos - nvarchar(10)
        NULL, -- Data - datetime
        NULL, -- DataConsegna - datetime
        FatturaElettronicaHeader.XML.query('CedentePrestatore/DatiAnagrafici/CodiceFiscale').value('.', 'NVARCHAR(16)'),       -- CF - nvarchar(50)
        FatturaElettronicaHeader.XML.query('CedentePrestatore/DatiAnagrafici/IdFiscaleIVA/IdCodice').value('.', 'NVARCHAR(28)'),       -- PI - nvarchar(50)
        CASE WHEN COALESCE(FatturaElettronicaHeader.XML.query('CedentePrestatore/DatiAnagrafici/Anagrafica/Denominazione').value('.', 'NVARCHAR(80)'), N'') = N''
            THEN FatturaElettronicaHeader.XML.query('CedentePrestatore/DatiAnagrafici/Anagrafica/Cognome').value('.', 'NVARCHAR(80)')
                + N' ' + FatturaElettronicaHeader.XML.query('CedentePrestatore/DatiAnagrafici/Anagrafica/Nome').value('.', 'NVARCHAR(80)')
            ELSE FatturaElettronicaHeader.XML.query('CedentePrestatore/DatiAnagrafici/Anagrafica/Denominazione').value('.', 'NVARCHAR(80)')
        END,       -- Intestazione - nvarchar(100)
        NULL,       -- Intestazione2 - nvarchar(50)
        FatturaElettronicaHeader.XML.query('CedentePrestatore/Sede/Indirizzo').value('.', 'NVARCHAR(60)'),       -- Indirizzo - nvarchar(50)
        FatturaElettronicaHeader.XML.query('CedentePrestatore/Sede/CAP').value('.', 'NVARCHAR(5)'),       -- Cap - nvarchar(50)
        FatturaElettronicaHeader.XML.query('CedentePrestatore/Sede/Comune').value('.', 'NVARCHAR(60)'),       -- Comune - nvarchar(50)
        FatturaElettronicaHeader.XML.query('CedentePrestatore/Sede/Provincia').value('.', 'CHAR(2)'),       -- Provincia - nvarchar(50)
        @Nazione,       -- Nazione - nvarchar(50)
        NULL,       -- Pag_Modalita - nvarchar(100)
        NULL,      -- Pag_CalcolaImporti - bit
        NULL,       -- Pag_Banca - nvarchar(100)
        NULL,       -- Pag_Cin - nvarchar(1)
        NULL,       -- Pag_Abi - nvarchar(5)
        NULL,       -- Pag_Cab - nvarchar(5)
        NULL,       -- Pag_Cc - nvarchar(50)
        NULL,       -- Pag_Iban - nvarchar(50)
        NULL,       -- Pag_Bic - nvarchar(50)
        NULL,      -- Pag_Spese - bit
        NULL,       -- Pag_ExtraSconto - nvarchar(20)
        NULL,       -- Pag_ExtraSconto_Perc - float
        NULL,       -- Dest_Intestazione - nvarchar(100)
        NULL,       -- Dest_Intestazione2 - nvarchar(50)
        NULL,       -- Dest_Indirizzo - nvarchar(50)
        NULL,       -- Dest_Cap - nvarchar(50)
        NULL,       -- Dest_Comune - nvarchar(50)
        NULL,       -- Dest_Provincia - nvarchar(50)
        NULL,       -- Dest_Nazione - nvarchar(50)
        NULL,       -- Note - nvarchar(2500)
        NULL,      -- TotRighe - numeric(19, 6)
        NULL,      -- Inps - numeric(19, 6)
        NULL,      -- TotImp - numeric(19, 6)
        NULL,      -- TotIva - numeric(19, 6)
        NULL,      -- TotLordo - numeric(19, 6)
        NULL,      -- RitAcc - numeric(19, 6)
        NULL,      -- TotDoc - numeric(19, 6)
        NULL,         -- Righe - int
        NULL,         -- RigheEvase - int
        NULL,         -- RigheEvaseParz - int
        NULL,       -- CondFor_Validita - nvarchar(50)
        NULL,       -- CondFor_Tempi - nvarchar(50)
        NULL,       -- CondFor_Trasporto - nvarchar(50)
        NULL,       -- CondFor_Resa - nvarchar(50)
        NULL,       -- CondFor_Note - nvarchar(500)
        NULL,       -- Trasp_TsInizio - nvarchar(50)
        NULL,       -- Trasp_Mezzo - nvarchar(100)
        NULL,       -- Trasp_Aspetto - nvarchar(100)
        NULL,         -- Trasp_Colli - int
        NULL,      -- Trasp_Peso - numeric(19, 6)
        NULL,       -- Trasp_Porto - nvarchar(100)
        NULL,       -- Trasp_Vettore1 - nvarchar(200)
        NULL,       -- Trasp_Vettore2 - nvarchar(200)
        NULL,       -- Trasp_Vettore3 - nvarchar(200)
        NULL,       -- Trasp_IDVeicolo - nvarchar(50)
        NULL,         -- Trasp_DistanzaKm - int
        NULL,      -- Trasp_MezzoCedente - bit
        NULL,      -- Trasp_MezzoCessionario - bit
        NULL,      -- NascondiTotali - bit
        NULL,      -- SoggettoRitAcc - bit
        NULL,       -- Pag_ModalitaSviluppata - nvarchar(100)
        NULL,       -- Protocollo - nvarchar(50)
        NULL,       -- DescrizioneRidottaSingolare - nvarchar(50)
        NULL,       -- AllegatoModello - nvarchar(255)
        NULL,       -- AllegatoFile - nvarchar(255)
        NULL,       -- IDFornitura - nvarchar(20)
        NULL,       -- IDBancaRB - nvarchar(50)
        CURRENT_TIMESTAMP, -- Creazione_Ts - datetime
        NULL,       -- Creazione_IDUtente - nvarchar(20)
        CURRENT_TIMESTAMP, -- Modifica_Ts - datetime
        NULL,       -- Modifica_IDUtente - nvarchar(20)
        NULL,       -- Allegato - nvarchar(255)
        NULL,       -- Rif_CodiceFornitore - nvarchar(50)
        NULL,       -- Rif_Ordine - nvarchar(255)
        NULL,       -- Rif_Magazzino - nvarchar(50)
        NULL,      -- SitPag_TotPagato - numeric(19, 6)
        NULL,      -- SitPag_TotProvvigione - numeric(19, 6)
        NULL,      -- SitPag_TotProvvigionePagato - numeric(19, 6)
        NULL,      -- Pdf - bit
        NULL, -- Pdf_Ts - datetime
        NULL,       -- Riferimenti - nvarchar(2500)
        NULL,       -- Evaso - nvarchar(255)
        NULL,       -- Evade - nvarchar(255)
        NULL,       -- IDReferente - nvarchar(20)
        NULL, -- DataRichiesta - datetime
        @ModelloReport,       -- ModelloReport - nvarchar(50)
        NULL,      -- Qta - numeric(19, 6)
        NULL,      -- QtaEvasa - numeric(19, 6)
        -1,         -- SDI_Stato - int
        CURRENT_TIMESTAMP, -- SDI_StatoTs - datetime
        NULL,       -- SDI_LogEvento - nvarchar(500)
        NULL,       -- SDI_LogValidazione - nvarchar(1500)
        NULL,       -- CodiceCIG - nvarchar(15)
        NULL,       -- CodiceCUP - nvarchar(15)
        CAST(0 AS BIT),      -- Sospeso - bit
        CAST(0 AS BIT),      -- HasDatiBollo - bit
        0.0       -- ImportoBollo - decimal(14, 2)
        -- #071 Richieste di modifica/integrazione - 28/11/2020 - BEGIN
        , @XML_TipoDocumento
        -- #071 Richieste di modifica/integrazione - 28/11/2020 - END

    FROM FXML.ImportXML IXML
    CROSS APPLY @XML.nodes('//FatturaElettronicaHeader') AS FatturaElettronicaHeader (XML)
    WHERE IXML.PKImportXML = @PKImportXML;

    PRINT 'Post insert dbo.Documenti';

    PRINT 'Pre update dbo.Documenti';

    DECLARE @Numero NVARCHAR(20);
    DECLARE @Data DATETIME;
    DECLARE @HasDatiBollo BIT;
    DECLARE @ImportoBollo DECIMAL(14, 2);
    DECLARE @TotRighe DECIMAL(19, 6);
    DECLARE @Inps DECIMAL(19, 6);
    DECLARE @ImportoInps DECIMAL(19, 6);
    DECLARE @TotImp DECIMAL(19, 6);
    DECLARE @TotIva DECIMAL(19, 6);
    DECLARE @TotLordo DECIMAL(19, 6);
    DECLARE @RitAcc DECIMAL(19, 6);
    DECLARE @ImportoRitAcc DECIMAL(19, 6);
    --DECLARE @SoggettoRitAcc BIT;
    DECLARE @TotDoc DECIMAL(19, 6);

    SELECT
        @Numero = FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/Numero').value('.', N'NVARCHAR(20)'),
        @Data = FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/Data').value('.', N'DATE'),

        @HasDatiBollo = CASE WHEN COALESCE(FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/DatiBollo/BolloVirtuale').value('.', N'CHAR(2)'), '') = '' THEN 0 ELSE 1 END,
        @ImportoBollo = CASE WHEN COALESCE(FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/DatiBollo/ImportoBollo').value('.', N'NVARCHAR(20)'), N'') = N'' THEN 0.0 ELSE CONVERT(DECIMAL(14, 2), FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/DatiBollo/ImportoBollo').value('.', N'NVARCHAR(20)')) END,
        @Inps = CASE WHEN COALESCE(FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/DatiCassaPrevidenziale/TipoCassa').value('.', N'NVARCHAR(20)'), N'') = N'TC22'
            THEN CONVERT(DECIMAL(19, 6), FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/DatiCassaPrevidenziale/AlCassa').value('.', N'NVARCHAR(20)'))
            ELSE 0.0
        END,
        @ImportoInps = CASE WHEN COALESCE(FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/DatiCassaPrevidenziale/TipoCassa').value('.', N'NVARCHAR(20)'), N'') = N'TC22'
            THEN CONVERT(DECIMAL(19, 6), FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/DatiCassaPrevidenziale/ImportoContributoCassa').value('.', N'NVARCHAR(20)'))
            ELSE 0.0
        END,
        @RitAcc = CASE WHEN COALESCE(FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/DatiRitenuta/AliquotaRitenuta').value('.', N'NVARCHAR(20)'), N'') = N'' THEN 0.0 ELSE CONVERT(DECIMAL(19, 6), FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/DatiRitenuta/AliquotaRitenuta').value('.', N'NVARCHAR(20)')) END,
        @ImportoRitAcc = CASE WHEN COALESCE(FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/DatiRitenuta/ImportoRitenuta').value('.', N'NVARCHAR(20)'), N'') = N'' THEN 0.0 ELSE CONVERT(DECIMAL(19, 6), FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/DatiRitenuta/ImportoRitenuta').value('.', N'NVARCHAR(20)')) END,
        @TotLordo = CONVERT(DECIMAL(19, 6), FatturaElettronicaBody.XML.query('DatiGenerali/DatiGeneraliDocumento/ImportoTotaleDocumento').value('.', N'NVARCHAR(20)'))
    
	FROM dbo.Documenti D
    INNER JOIN FXML.ImportXML TXML ON TXML.PKImportXML = @PKImportXML
    CROSS APPLY @XML.nodes('//FatturaElettronicaBody') AS FatturaElettronicaBody (XML)
    WHERE D.ID = @IDDocumento;

    UPDATE D
    SET D.Numero = @Numero,
        D.[Data] = @Data,

        D.HasDatiBollo = @HasDatiBollo,
        D.ImportoBollo = @ImportoBollo,

        D.TotLordo = @TotLordo,
        D.TotDoc = @TotLordo - COALESCE(@ImportoRitAcc, 0.0),

        D.Inps = @Inps,

		D.SoggettoRitAcc = CASE WHEN COALESCE(@RitAcc, 0.0) = 0.0 THEN 0 ELSE 1 END,
        D.RitAcc = @RitAcc
    
	FROM dbo.Documenti D
    INNER JOIN FXML.ImportXML TXML ON TXML.PKImportXML = @PKImportXML
    CROSS APPLY @XML.nodes('//FatturaElettronicaBody') AS FatturaElettronicaBody (XML)
    WHERE D.ID = @IDDocumento;

    PRINT 'Post update dbo.Documenti';

    EXEC FXML.ssp_ImportaXMLPassivo_Documenti_Righe @PKImportXML = @PKImportXML, @IDDocumento = @IDDocumento;

    EXEC FXML.ssp_ImportaXMLPassivo_Documenti_Scadenze @PKImportXML = @PKImportXML, @IDDocumento = @IDDocumento;

	EXEC FXML.ssp_ImportaXMLPassivo_Documenti_Iva @PKImportXML = @PKImportXML, @IDDocumento = @IDDocumento;	

    UPDATE FXML.ImportXML
    SET IDStatoImportazione = 2, -- 2: importazione terminata correttamente
        IDDocumento = @IDDocumento
    WHERE PKImportXML = @PKImportXML;
    
    COMMIT TRANSACTION

    --SELECT * FROM dbo.Documenti WHERE ID = @IDDocumento;

    --SELECT * FROM dbo.Documenti_Righe WHERE IDDocumento = @IDDocumento ORDER BY SDI_NumeroLinea;

    --SELECT * FROM dbo.Documenti_Scadenze WHERE IDDocumento = @IDDocumento ORDER BY Numero;

END TRY
BEGIN CATCH

    PRINT 'Rollback!';

    ROLLBACK TRANSACTION

    UPDATE FXML.ImportXML
    SET IDStatoImportazione = 99 -- 99: importazione terminata con errori
    WHERE PKImportXML = @PKImportXML;

    SET @IDDocumento = NULL;

END CATCH

-- #071 Richieste di modifica/integrazione - 28/11/2020 - BEGIN
END;
-- #071 Richieste di modifica/integrazione - 28/11/2020 - END

END;
GO
