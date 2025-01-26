SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--------------------------------------------------------------------------------------------------------------------------------------
-- InVoice3_1_0_0_68 - Maurizio, BugFix Autofatture
--------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [FXML].[ssp_EsportaDatiFattura_Body] (
	@IDDocumento UNIQUEIDENTIFIER,
	@PKStaging_FatturaElettronicaHeader BIGINT
) AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @PKStaging_FatturaElettronicaBody BIGINT;

	SET @PKStaging_FatturaElettronicaBody = NEXT VALUE FOR InVoiceXML.XMLFatture.seq_Staging_FatturaElettronicaBody;

	DELETE FROM InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody WHERE PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody
	(
		PKStaging_FatturaElettronicaBody,
		PKStaging_FatturaElettronicaHeader,
		DatiGenerali_DatiGeneraliDocumento_TipoDocumento, -- 2.1.1.1
		DatiGenerali_DatiGeneraliDocumento_Divisa, -- 2.1.1.2
		DatiGenerali_DatiGeneraliDocumento_Data, -- 2.1.1.3
		DatiGenerali_DatiGeneraliDocumento_Numero, -- 2.1.1.4
		DatiGenerali_DatiGeneraliDocumento_ImportoTotaleDocumento, -- 2.1.1.9
        DatiGenerali_DatiGeneraliDocumento_DatiBollo_BolloVirtuale, -- 2.1.1.6.1
        DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo -- 2.1.1.6.2
	)
	SELECT
		@PKStaging_FatturaElettronicaBody,
		@PKStaging_FatturaElettronicaHeader,
		-- #071 Richieste di modifica/integrazione - 29/11/2020 - BEGIN
        -- Era: DT.SDI_TipoDocumento,
        D.SDI_IDTipoDocumento,
		-- #071 Richieste di modifica/integrazione - 29/11/2020 - END
		N'EUR',
		D.[Data],
		D.Numero,
		--CONVERT(NVARCHAR(10), D.NumeroInt) + COALESCE(N'/' + DT.Sezionale, N''),
		ROUND(D.TotDoc, 2),
        CASE WHEN D.HasDatiBollo = CAST(1 AS BIT) THEN 'SI' ELSE NULL END,
        CASE WHEN D.HasDatiBollo = CAST(1 AS BIT) THEN D.ImportoBollo ELSE NULL END

	FROM dbo.Documenti D
	INNER JOIN dbo.Documenti_Tipi DT ON DT.ID = D.IDTipo
	LEFT JOIN dbo.Causali C ON C.ID = D.IDCausale
	WHERE D.ID = @IDDocumento;

	UPDATE SFEB
	SET SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta = PTR.Valore, -- 2.1.1.5.1
		SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta = ROUND(D.RitAcc, 2), -- 2.1.1.5.2
		SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_AliquotaRitenuta = CONVERT(DECIMAL(5, 2), PRA.Valore), -- 2.1.1.5.3
		SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento = PCPR.Valore -- 2.1.1.5.4

	FROM dbo.Documenti D
	INNER JOIN dbo.Documenti_Tipi DT ON DT.ID = D.IDTipo
	--LEFT JOIN dbo.Causali C ON C.ID = D.IDCausale
	INNER JOIN dbo.Conf_Parametri PTR ON PTR.ID = N'Company.SDI_TipoRitenuta'
	INNER JOIN dbo.Conf_Parametri PRA ON PRA.ID = N'Documents.RitAcc'
	INNER JOIN dbo.Conf_Parametri PCPR ON PCPR.ID = N'Company.SDI_CausalePagamentoRitenuta'
	INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody SFEB ON SFEB.PKStaging_FatturaElettronicaBody = @PKStaging_FatturaElettronicaBody
	WHERE D.ID = @IDDocumento
		AND D.SoggettoRitAcc = CAST(1 AS BIT);

	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DatiCassaPrevidenziale
	(
		--PKStaging_FatturaElettronicaBody_DatiCassaPrevidenziale,
		PKStaging_FatturaElettronicaBody,
		TipoCassa,
		AlCassa,
		ImportoContributoCassa,
		ImponibileCassa,
		AliquotaIVA,
		Ritenuta,
		Natura--,
		--RiferimentoAmministrazione
	)
	SELECT
		@PKStaging_FatturaElettronicaBody,
		PTC.Valore AS TipoCassa, -- 2.1.1.7.1
		CONVERT(DECIMAL(5, 2), PDI.Valore) AS AlCassa, -- 2.1.1.7.2
		ROUND(D.Inps, 2) AS ImportoContributoCassa, -- 2.1.1.7.3
		ROUND(D.TotRighe, 2) AS ImponibileCassa, -- 2.1.1.7.4
		COALESCE(CI.Perc, NULL) AS AliquotaIVA, -- 2.1.1.7.5
		COALESCE(PRC.Valore, '') AS Ritenuta, -- 2.1.1.7.6
		COALESCE(CI.SDI_Natura, '') AS Natura -- 2.1.1.7.7

	FROM dbo.Documenti D
	INNER JOIN dbo.Conf_Parametri PTC ON PTC.ID = N'Company.SDI_TipoCassa'
	INNER JOIN dbo.Conf_Parametri PDI ON PDI.ID = N'Documents.Inps'
	LEFT JOIN dbo.Conf_Parametri PCIC ON PCIC.ID = N'Company.CodiceIvaCassa'
	LEFT JOIN dbo.CodiciIva CI ON CI.ID = PCIC.Valore
	LEFT JOIN dbo.Conf_Parametri PRC ON PRC.ID = N'Company.RitenutaCassa'
	WHERE D.ID = @IDDocumento
		AND D.Inps > 0.0;

	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_Causale
	(
		--PKStaging_FatturaElettronicaBody_Causale,
		PKStaging_FatturaElettronicaBody,
		DatiGenerali_Causale
	)
	SELECT
		@PKStaging_FatturaElettronicaBody,
		COALESCE(C.Descrizione, N'???') -- 2.1.1.11

	FROM dbo.Documenti D
	INNER JOIN dbo.Documenti_Tipi DT ON DT.ID = D.IDTipo
	LEFT JOIN dbo.Causali C ON C.ID = D.IDCausale
	WHERE D.ID = @IDDocumento;

	DECLARE @PKStaging_FatturaElettronicaBody_DatiDDT BIGINT;

	IF OBJECT_ID('tempdb..#DatiDDT') IS	NOT NULL DROP TABLE #DatiDDT;

	SELECT DISTINCT
		DDDT.Numero AS NumeroDDT,
		CONVERT(DATE, DDDT.Data) AS DataDDT,
		CAST(NULL AS BIGINT) AS PKStaging_FatturaElettronicaBody_DatiDDT

	INTO #DatiDDT

	FROM dbo.Documenti_Righe DR
	INNER JOIN dbo.Documenti D ON D.ID = DR.IDDocumento
	INNER JOIN dbo.Documenti_Righe DRDDT ON DRDDT.ID = DR.IDDocumento_RigaOrigine
	INNER JOIN dbo.Documenti DDDT ON DDDT.ID = DRDDT.IDDocumento
		AND DDDT.IDTipo = N'Cli_DDT'
	WHERE D.ID = @IDDocumento
		AND COALESCE(DR.Qta, 0.0) > 0.0
		AND COALESCE(DR.ImpUnitario, 0.0) <> 0.0;

	DECLARE @NumeroDDT NVARCHAR(20);
	DECLARE @DataDDT DATE;

	DECLARE curDatiDDT CURSOR FAST_FORWARD READ_ONLY FOR
		SELECT
			TT.NumeroDDT,
			TT.DataDDT

		FROM #DatiDDT TT;

	OPEN curDatiDDT

	FETCH NEXT FROM curDatiDDT INTO @NumeroDDT, @DataDDT;

	WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @PKStaging_FatturaElettronicaBody_DatiDDT = NEXT VALUE FOR InVoiceXML.XMLFatture.seq_Staging_FatturaElettronicaBody_DatiDDT;
	
		INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DatiDDT
		(
			PKStaging_FatturaElettronicaBody_DatiDDT,
			PKStaging_FatturaElettronicaBody,
			NumeroDDT,
			DataDDT
		)
		VALUES
		(   @PKStaging_FatturaElettronicaBody_DatiDDT,
			@PKStaging_FatturaElettronicaBody,
			@NumeroDDT, -- 2.1.8.1
			@DataDDT -- 2.1.8.2
		);

		UPDATE #DatiDDT
		SET PKStaging_FatturaElettronicaBody_DatiDDT = @PKStaging_FatturaElettronicaBody_DatiDDT
		WHERE NumeroDDT = @NumeroDDT AND DataDDT = @DataDDT;

		FETCH NEXT FROM curDatiDDT INTO @NumeroDDT, @DataDDT;
	END

	CLOSE curDatiDDT;
	DEALLOCATE curDatiDDT;

	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea
	(
		--PKStaging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea,
		PKStaging_FatturaElettronicaBody_DatiDDT,
		RiferimentoNumeroLinea
	)
	SELECT
		TT.PKStaging_FatturaElettronicaBody_DatiDDT,
		--DDDT.Numero AS NumeroDDT,
		--DDDT.[Data] AS DataDDT,
		DR.SDI_NumeroLinea AS RiferimentoNumeroLinea -- 2.1.8.3

	FROM dbo.Documenti_Righe DR
	INNER JOIN dbo.Documenti D ON D.ID = DR.IDDocumento
	INNER JOIN dbo.Documenti_Righe DRDDT ON DRDDT.ID = DR.IDDocumento_RigaOrigine
	INNER JOIN dbo.Documenti DDDT ON DDDT.ID = DRDDT.IDDocumento
		AND DDDT.IDTipo = N'Cli_DDT'
	INNER JOIN #DatiDDT TT ON TT.NumeroDDT = DDDT.Numero AND TT.DataDDT = DDDT.[Data]
	WHERE D.ID = @IDDocumento
		AND COALESCE(DR.Qta, 0.0) > 0.0
		AND COALESCE(DR.ImpUnitario, 0.0) <> 0.0;

	DECLARE @PKStaging_FatturaElettronicaBody_DettaglioLinee BIGINT;

	IF OBJECT_ID('tempdb..#DettaglioLinee') IS	NOT NULL DROP TABLE #DettaglioLinee;

	SELECT
		DR.ID,
		DR.SDI_NumeroLinea,
		CAST(NULL AS BIGINT) AS PKStaging_FatturaElettronicaBody_DettaglioLinee

	INTO #DettaglioLinee

	FROM dbo.Documenti_Righe DR
	LEFT JOIN dbo.CodiciIva CI ON CI.ID = DR.CodIva
	WHERE DR.IDDocumento = @IDDocumento
		AND COALESCE(DR.Qta, 0.0) > 0.0
		AND COALESCE(DR.ImpUnitario, 0.0) <> 0.0
	ORDER BY DR.SDI_NumeroLinea;

	DECLARE @ID UNIQUEIDENTIFIER;
	DECLARE @SDI_NumeroLinea INT;

    -- 23/1/2022 Gestione campi per lettera d'intento (1/2) :: BEGIN
    --DECLARE @LetteraIntento_Note NVARCHAR(2500);
    DECLARE @LetteraIntento_RiferimentoTesto NVARCHAR(60);
    --DECLARE @LetteraIntento_RiferimentoData_Testo NVARCHAR(10);
    DECLARE @LetteraIntento_RiferimentoData DATE;
    -- 23/1/2022 Gestione campi per lettera d'intento (1/2) :: END

	DECLARE curDettaglioLinee CURSOR FAST_FORWARD READ_ONLY FOR
		SELECT
			TT.ID,
			TT.SDI_NumeroLinea

		FROM #DettaglioLinee TT;

	OPEN curDettaglioLinee

	FETCH NEXT FROM curDettaglioLinee INTO @ID, @SDI_NumeroLinea;

	WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @PKStaging_FatturaElettronicaBody_DettaglioLinee = NEXT VALUE FOR InVoiceXML.XMLFatture.seq_Staging_FatturaElettronicaBody_DettaglioLinee;
	
		INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee
		(
			PKStaging_FatturaElettronicaBody_DettaglioLinee,
			PKStaging_FatturaElettronicaBody,
			NumeroLinea,
			TipoCessionePrestazione,
			Descrizione,
			Quantita,
			UnitaMisura,
			PrezzoUnitario,
			PrezzoTotale,
			AliquotaIVA,
			Ritenuta,
			Natura
		)
		SELECT
			@PKStaging_FatturaElettronicaBody_DettaglioLinee,
			@PKStaging_FatturaElettronicaBody,
			DR.SDI_NumeroLinea, -- 2.2.1.1
			'', -- 2.2.1.2
			DR.Descrizione1, -- 2.2.1.4
			DR.Qta, -- 2.2.1.5
			DR.IDUnitaMisura, -- 2.2.1.6
			DR.ImpUnitario, -- 2.2.1.9
			--DR.ImpNettoScontato, -- 2.2.1.11
			--DR.ImpNettoScontato *  CASE WHEN TRY_CAST(D.Pag_ExtraSconto AS DECIMAL(28, 12)) IS NULL THEN 1.0 ELSE 1.0 - TRY_CAST(D.Pag_ExtraSconto AS DECIMAL(28, 12)) / 100.0 END, -- 2.2.1.11
			DR.ImpNettoScontato * (100.0 - COALESCE(FXML.sfn_PercentualeScontoMaggiorazione(D.Pag_ExtraSconto), 0.0)) / 100.0, -- 2.2.1.11
			COALESCE(CI.Perc, 0.0), -- 2.2.1.12
			CASE WHEN D.SoggettoRitAcc = CAST(1 AS BIT) THEN 'SI' ELSE '' END, -- 2.2.1.13
			COALESCE(CI.SDI_Natura, '') -- 2.2.1.14

		FROM dbo.Documenti_Righe DR
		INNER JOIN dbo.Documenti D ON D.ID = DR.IDDocumento
		LEFT JOIN dbo.CodiciIva CI ON CI.ID = DR.CodIva
		WHERE DR.IDDocumento = @IDDocumento
			AND DR.ID = @ID
			AND COALESCE(DR.Qta, 0.0) > 0.0
			AND COALESCE(DR.ImpUnitario, 0.0) <> 0.0;

		UPDATE #DettaglioLinee
		SET PKStaging_FatturaElettronicaBody_DettaglioLinee = @PKStaging_FatturaElettronicaBody_DettaglioLinee
		WHERE ID = @ID;

        -- 23/1/2022 Gestione campi per lettera d'intento (2/2) :: BEGIN

        /* Prima versione "grezza" rilasciata il 23/1/2022
        SELECT TOP (1)
            @LetteraIntento_Note = DR.NoteRiga
        FROM dbo.Documenti_Righe DR
	    WHERE DR.ID = @ID
            AND DR.NoteRiga LIKE N'Lettera d''intento n._% del __/__/____'
        ORDER BY DR.ID;

        SELECT TOP (1)
            @LetteraIntento_RiferimentoTesto = CONCAT(DI.Protocollo, N'-', DI.Progressivo),
            @LetteraIntento_RiferimentoData = DI.DataRicevuta

        FROM dbo.Documenti_Righe DR
        INNER JOIN dbo.DichiarazioniIntento DI ON DI.ID = DR.IDDichiarazioneIntento
	    WHERE DR.ID = @ID;

        IF @LetteraIntento_Note IS NOT NULL
        BEGIN

            SELECT
                @LetteraIntento_RiferimentoTesto = SUBSTRING(@LetteraIntento_Note, 22, CHARINDEX(' del ', @LetteraIntento_Note) - 22),
                @LetteraIntento_RiferimentoData_Testo = SUBSTRING(@LetteraIntento_Note, CHARINDEX(' del ', @LetteraIntento_Note) + 5, 10);

            BEGIN TRY
                SELECT @LetteraIntento_RiferimentoData = CONVERT(DATE, @LetteraIntento_RiferimentoData_Testo, 103);
            END TRY
            BEGIN CATCH
            END CATCH

            SELECT @LetteraIntento_Note, @LetteraIntento_RiferimentoTesto, @LetteraIntento_RiferimentoData_Testo, @LetteraIntento_RiferimentoData;

            IF @LetteraIntento_RiferimentoData IS NOT NULL
            BEGIN
        
                SELECT N'OK';

                INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali (
                    --PKStaging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali,
                    PKStaging_FatturaElettronicaBody_DettaglioLinee,
                    AltriDatiGestionali_TipoDato,
                    AltriDatiGestionali_RiferimentoTesto,
                    --AltriDatiGestionali_RiferimentoNumero,
                    AltriDatiGestionali_RiferimentoData
                ) VALUES (
                    --DEFAULT, -- PKStaging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali - bigint
                    @PKStaging_FatturaElettronicaBody_DettaglioLinee,       -- PKStaging_FatturaElettronicaBody_DettaglioLinee - bigint
                    N'INTENTO',    -- AltriDatiGestionali_TipoDato - nvarchar(10)
                    @LetteraIntento_RiferimentoTesto,    -- AltriDatiGestionali_RiferimentoTesto - nvarchar(60)
                    @LetteraIntento_RiferimentoData     -- AltriDatiGestionali_RiferimentoData - date
                );

            END;

        END;
        */

        SELECT TOP (1)
            @LetteraIntento_RiferimentoTesto = CONCAT(DI.Protocollo, N'-', DI.Progressivo),
            @LetteraIntento_RiferimentoData = DI.DataRicevuta

        FROM dbo.Documenti_Righe DR
        INNER JOIN dbo.DichiarazioniIntento DI ON DI.ID = DR.IDDichiarazioneIntento
	    WHERE DR.ID = @ID;

        IF @LetteraIntento_RiferimentoTesto IS NOT NULL AND @LetteraIntento_RiferimentoData IS NOT NULL
        BEGIN

            INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali (
                --PKStaging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali,
                PKStaging_FatturaElettronicaBody_DettaglioLinee,
                AltriDatiGestionali_TipoDato,
                AltriDatiGestionali_RiferimentoTesto,
                --AltriDatiGestionali_RiferimentoNumero,
                AltriDatiGestionali_RiferimentoData
            ) VALUES (
                --DEFAULT, -- PKStaging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali - bigint
                @PKStaging_FatturaElettronicaBody_DettaglioLinee,       -- PKStaging_FatturaElettronicaBody_DettaglioLinee - bigint
                N'INTENTO',    -- AltriDatiGestionali_TipoDato - nvarchar(10)
                @LetteraIntento_RiferimentoTesto,    -- AltriDatiGestionali_RiferimentoTesto - nvarchar(60)
                @LetteraIntento_RiferimentoData     -- AltriDatiGestionali_RiferimentoData - date
            );

        END;

        -- 23/1/2022 Gestione campi per lettera d'intento (2/2) :: END

		FETCH NEXT FROM curDettaglioLinee INTO @ID, @SDI_NumeroLinea;
	END

	CLOSE curDettaglioLinee;
	DEALLOCATE curDettaglioLinee;

	/* Gestione documenti esterni (es. ordine di acquisto) - Inizio */

	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DocumentoEsterno
	(
	    --PKStaging_FatturaElettronicaBody_DocumentoEsterno,
	    PKStaging_FatturaElettronicaBody,
	    TipoDocumentoEsterno,
	    IdDocumento,
	    Data,
	    CodiceCUP,
	    CodiceCIG
	)
	SELECT DISTINCT
		@PKStaging_FatturaElettronicaBody,
		'OACQ' AS TipoDocumentoEsterno,
		CASE
		  WHEN DO.IDTipo = 'Cli_Ordine' THEN DO.Numero
		  WHEN DOO.IDTipo = 'Cli_Ordine' THEN DOO.Numero
		  ELSE NULL
		END AS Numero, -- 2.1.2.3
		CASE
		  WHEN DO.IDTipo = 'Cli_Ordine' THEN CAST(DO.Data AS DATE)
		  WHEN DOO.IDTipo = 'Cli_Ordine' THEN CAST(DOO.Data AS DATE)
		  ELSE NULL
		END AS Data, -- 2.1.2.4
		CASE
		  WHEN DO.IDTipo = 'Cli_Ordine' THEN COALESCE(DO.CodiceCUP, NULL)
		  WHEN DOO.IDTipo = 'Cli_Ordine' THEN COALESCE(DOO.CodiceCUP, NULL)
		  ELSE NULL
		END AS CodiceCUP, -- 2.1.2.6
		CASE
		  WHEN DO.IDTipo = 'Cli_Ordine' THEN COALESCE(DO.CodiceCIG, NULL)
		  WHEN DOO.IDTipo = 'Cli_Ordine' THEN COALESCE(DOO.CodiceCIG, NULL)
		  ELSE NULL
		END AS CodiceCIG -- 2.1.2.7

	FROM dbo.Documenti D
	INNER JOIN dbo.CliFor CF ON CF.ID = D.IDCliFor
	INNER JOIN dbo.Documenti_Righe DR ON DR.IDDocumento = D.ID
		AND DR.Qta > 0.0
		AND DR.ImpUnitario > 0.0
	INNER JOIN dbo.Documenti_Righe DRO ON DRO.ID = DR.IDDocumento_RigaOrigine
	INNER JOIN dbo.Documenti DO ON DO.ID = DRO.IDDocumento
	INNER JOIN dbo.Documenti_Tipi DTO ON DTO.ID = DO.IDTipo
	LEFT JOIN dbo.Documenti_Righe DROO ON DROO.ID = DRO.IDDocumento_RigaOrigine
	LEFT JOIN dbo.Documenti DOO ON DOO.ID = DROO.IDDocumento
	LEFT JOIN dbo.Documenti_Tipi DTOO ON DTOO.ID = DOO.IDTipo
	WHERE D.ID = @IDDocumento
		AND COALESCE(DOO.IDTipo, DO.IDTipo) = N'Cli_Ordine';
        
    IF OBJECT_ID('tempdb..#DettaglioLinee_Ordini') IS NOT NULL DROP TABLE #DettaglioLinee_Ordini;

    SELECT DISTINCT
        CASE
		  WHEN DO.IDTipo = 'Cli_Ordine' THEN DO.Numero
		  WHEN DOO.IDTipo = 'Cli_Ordine' THEN DOO.Numero
		  ELSE NULL
		END COLLATE SQL_Latin1_General_CP1_CI_AS AS Numero, -- 2.1.2.3
		CASE
		  WHEN DO.IDTipo = 'Cli_Ordine' THEN CAST(DO.Data AS DATE)
		  WHEN DOO.IDTipo = 'Cli_Ordine' THEN CAST(DOO.Data AS DATE)
		  ELSE NULL
		END AS Data,
        DR.SDI_NumeroLinea

    INTO #DettaglioLinee_Ordini

	FROM dbo.Documenti D
	INNER JOIN dbo.CliFor CF ON CF.ID = D.IDCliFor
	INNER JOIN dbo.Documenti_Righe DR ON DR.IDDocumento = D.ID
		AND DR.Qta > 0.0
		AND DR.ImpUnitario > 0.0
	INNER JOIN dbo.Documenti_Righe DRO ON DRO.ID = DR.IDDocumento_RigaOrigine
	INNER JOIN dbo.Documenti DO ON DO.ID = DRO.IDDocumento
	INNER JOIN dbo.Documenti_Tipi DTO ON DTO.ID = DO.IDTipo
	LEFT JOIN dbo.Documenti_Righe DROO ON DROO.ID = DRO.IDDocumento_RigaOrigine
	LEFT JOIN dbo.Documenti DOO ON DOO.ID = DROO.IDDocumento
	LEFT JOIN dbo.Documenti_Tipi DTOO ON DTOO.ID = DOO.IDTipo
	WHERE D.ID = @IDDocumento
		AND COALESCE(DOO.IDTipo, DO.IDTipo) = N'Cli_Ordine';

    IF ((SELECT COUNT(DISTINCT Numero) FROM #DettaglioLinee_Ordini) > 1)
    BEGIN

        INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea
        (
            --PKStaging_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea,
            PKStaging_FatturaElettronicaBody_DocumentoEsterno,
            RiferimentoNumeroLinea
        )
        SELECT
            DE.PKStaging_FatturaElettronicaBody_DocumentoEsterno,
            DLO.SDI_NumeroLinea AS RiferimentoNumeroLinea

        FROM #DettaglioLinee_Ordini DLO
        INNER JOIN InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DocumentoEsterno DE ON DE.Data = DLO.Data AND DE.IdDocumento = DLO.Numero
        ORDER BY DE.PKStaging_FatturaElettronicaBody_DocumentoEsterno,
            DLO.SDI_NumeroLinea;

    END;

    -- #071 Richieste di modifica/integrazione - 30/11/2020 - BEGIN
	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DocumentoEsterno
	(
	    --PKStaging_FatturaElettronicaBody_DocumentoEsterno,
	    PKStaging_FatturaElettronicaBody,
	    TipoDocumentoEsterno,
	    IdDocumento
	)
	SELECT DISTINCT
		@PKStaging_FatturaElettronicaBody,
		'OACQ' AS TipoDocumentoEsterno,
        --#071 MPI: controllo lunghezza massima descrizione: ERA: SS.Data AS IdDocumento -- 2.1.2.3
		CASE WHEN LEN(SS.Data) <= 20 THEN SS.Data ELSE SUBSTRING(SS.Data,1,20) END AS IdDocumento -- 2.1.2.3 

	FROM dbo.Documenti D
    CROSS APPLY FXML.sfn_SplitString(D.Rif_Ordine, CHAR(13)+CHAR(10)) SS
    WHERE D.ID = @IDDocumento
        AND D.Rif_Ordine <> N'';
    -- #071 Richieste di modifica/integrazione - 30/11/2020 - END

	/* Gestione documenti esterni (es. ordine di acquisto) - Fine */

	/* Gestione fatture collegate - Inizio */
	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DocumentoEsterno
	(
	    --PKStaging_FatturaElettronicaBody_DocumentoEsterno,
	    PKStaging_FatturaElettronicaBody,
	    TipoDocumentoEsterno,
	    IdDocumento,
        Data
	)
    SELECT
        @PKStaging_FatturaElettronicaBody,
        'FTCL' AS TipoDocumentoEsterno,
		DO.Numero, -- 2.1.6.3
		CAST(DO.Data AS DATE) AS Data -- 2.1.6.3

	FROM dbo.Documenti D
    INNER JOIN FXML.TipiDocumentoUscita TDU ON TDU.IDTipoDocumento_InVoice = D.IDTipo AND TDU.IDTipoDocumento_SDI = D.SDI_IDTipoDocumento
        AND TDU.SwitchCedenteCessionario = CAST(1 AS BIT)
    INNER JOIN dbo.Documenti DO ON DO.ID = D.IDDocumento_Origine
    INNER JOIN dbo.CliFor F ON F.ID = DO.IDCliFor
        --AND F.Fornitore = CAST(1 AS BIT)
	WHERE D.ID = @IDDocumento;
	/* Gestione fatture collegate - Fine */

	/* Gestione spese sui pagamenti (es. marca da bollo) - Inizio */

	--DECLARE @IDDocumento UNIQUEIDENTIFIER = '412A0669-4EBB-4364-9477-342B1C5AC25C'
	DECLARE @NumeroLineaOffset INT;
	SELECT @NumeroLineaOffset = COALESCE(MAX(SDI_NumeroLinea), 0) FROM #DettaglioLinee;

	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee
	(
		--PKStaging_FatturaElettronicaBody_DettaglioLinee,
		PKStaging_FatturaElettronicaBody,
		NumeroLinea,
		TipoCessionePrestazione,
		Descrizione,
		Quantita,
		UnitaMisura,
		PrezzoUnitario,
		PrezzoTotale,
		AliquotaIVA,
		Ritenuta,
		Natura
	)
	SELECT
		--@PKStaging_FatturaElettronicaBody_DettaglioLinee,
		@PKStaging_FatturaElettronicaBody,
		@NumeroLineaOffset + ROW_NUMBER() OVER (ORDER BY DS.ID), -- 2.2.1.1
		'', -- 2.2.1.2
		DS.Descrizione, -- 2.2.1.4
		1.0 AS Quantita, -- 2.2.1.5
		'', -- 2.2.1.6
		DS.ImpNetto, -- 2.2.1.9
		DS.ImpNetto, -- 2.2.1.11
		COALESCE(CI.Perc, 0.0), -- 2.2.1.12
		'', -- 2.2.1.13
		COALESCE(CI.SDI_Natura, '') -- 2.2.1.14

	FROM dbo.Documenti_Spese DS
	INNER JOIN dbo.Documenti D ON D.ID = DS.IDDocumento
	LEFT JOIN dbo.CodiciIva CI ON CI.ID = DS.CodIva
	WHERE D.ID = @IDDocumento;

	/* Gestione spese sui pagamenti (es. marca da bollo) - Fine */

	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo
	(
		--PKStaging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo,
		PKStaging_FatturaElettronicaBody_DettaglioLinee,
		CodiceArticolo_CodiceTipo,
		CodiceArticolo_CodiceValore
	)
	SELECT
		DL.PKStaging_FatturaElettronicaBody_DettaglioLinee,
		'ITEM', -- 2.2.1.3.1
		COALESCE(DR.Codice, N'SERVIZIO') -- 2.2.1.3.2

	FROM dbo.Documenti_Righe DR
	INNER JOIN #DettaglioLinee DL ON DL.ID = DR.ID
	WHERE DR.IDDocumento = @IDDocumento
		AND COALESCE(DR.Qta, 0.0) > 0.0
		AND COALESCE(DR.ImpUnitario, 0.0) <> 0.0; -- Ridondante (ho già filtrato #DettaglioLinee)

	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione
	(
		--PKStaging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione,
		PKStaging_FatturaElettronicaBody_DettaglioLinee,
		ScontoMaggiorazione_Tipo,
		ScontoMaggiorazione_Percentuale,
		ScontoMaggiorazione_Importo
	)
	SELECT
		DL.PKStaging_FatturaElettronicaBody_DettaglioLinee,
        'SC' AS Tipo, -- 2.2.1.10.1
        ----NULL AS Percentuale, -- 2.2.1.10.2
        ----ROUND(DR.ImpUnitario * (1.0 - COALESCE((100.0 - FXML.sfn_PercentualeScontoMaggiorazione(DR.Sconto)) / 100.0, 1.0) * COALESCE((100.0 - FXML.sfn_PercentualeScontoMaggiorazione(D.Pag_ExtraSconto)) / 100.0, 1.0)), 2) -- 2.2.1.10.3
        ROUND((1.0 - COALESCE((100.0 - FXML.sfn_PercentualeScontoMaggiorazione(DR.Sconto)) / 100.0, 1.0) * COALESCE((100.0 - FXML.sfn_PercentualeScontoMaggiorazione(D.Pag_ExtraSconto)) / 100.0, 1.0)) * 100.0, 2), -- 2.2.1.10.2
        NULL -- 2.2.1.10.3

	FROM dbo.Documenti_Righe DR
	INNER JOIN #DettaglioLinee DL ON DL.ID = DR.ID
	INNER JOIN dbo.Documenti D ON D.ID = DR.IDDocumento
	WHERE DR.IDDocumento = @IDDocumento
		AND COALESCE(DR.Qta, 0.0) > 0.0
		AND COALESCE(DR.ImpUnitario, 0.0) <> 0.0
		AND (
            COALESCE(DR.Sconto, N'') <> N''
            OR COALESCE(D.Pag_ExtraSconto, N'') <> N''
        );

	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DatiRiepilogo
	(
		--PKStaging_FatturaElettronicaBody_DatiRiepilogo,
		PKStaging_FatturaElettronicaBody,
		AliquotaIVA,
		Natura,
		----SpeseAccessorie,
		Arrotondamento,
		ImponibileImporto,
		Imposta,
		EsigibilitaIVA,
		RiferimentoNormativo
	)
	SELECT
		@PKStaging_FatturaElettronicaBody,
		CI.Perc, -- 2.2.2.1
		CI.SDI_Natura, -- 2.2.2.2
		0.0, -- 2.2.2.4 
		DI.ImpNetto, -- 2.2.2.5
		DI.ImpIva, -- 2.2.2.6
		CI.SDI_EsigibilitaIVA, -- 2.2.2.7
		CI.SDI_RiferimentoNormativo -- 2.2.2.8

	FROM dbo.Documenti_IVA DI
	LEFT JOIN dbo.CodiciIva CI ON CI.ID = DI.CodIva
	WHERE DI.IDDocumento = @IDDocumento;

	--MP: 13/07/2022: Begin
    IF NOT EXISTS (SELECT TOP (1) * FROM dbo.Documenti D 
		INNER JOIN dbo.Documenti_Tipi DT ON DT.ID = D.IDTipo AND DT.SDI_Autofattura = CAST(1 AS BIT)
		WHERE D.ID = @IDDocumento)
    -- IF NOT EXISTS (SELECT TOP (1) * FROM dbo.Documenti D INNER JOIN dbo.Documenti_Tipi DT ON DT.ID = D.IDTipo AND DT.SDI_Autofattura = CAST(1 AS BIT))
    --MP: 13/07/2022: End
    BEGIN

	DECLARE @PKStaging_FatturaElettronicaBody_DatiPagamento BIGINT;
	SET @PKStaging_FatturaElettronicaBody_DatiPagamento = NEXT VALUE FOR InVoiceXML.XMLFatture.seq_FatturaElettronicaBody_DatiPagamento;

	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DatiPagamento
	(
		PKStaging_FatturaElettronicaBody_DatiPagamento,
		PKStaging_FatturaElettronicaBody,
		CondizioniPagamento
	)
	SELECT
		@PKStaging_FatturaElettronicaBody_DatiPagamento,
		@PKStaging_FatturaElettronicaBody,
		CASE WHEN COUNT(1) = 1 THEN 'TP02' ELSE 'TP01' END -- 2.4.1

	FROM dbo.Documenti_Scadenze DS
	INNER JOIN dbo.ModalitaPagamento_Tipi MPT ON MPT.ID = DS.IDTipoPagamento
	INNER JOIN dbo.Documenti D ON D.ID = DS.IDDocumento
	WHERE DS.IDDocumento = @IDDocumento
		AND DS.Tipo = 1; -- 1: Scadenze previste

	INSERT INTO InVoiceXML.XMLFatture.Staging_FatturaElettronicaBody_DatiPagamento_DettaglioPagamento
	(
		--PKStaging_FatturaElettronicaBody_DatiPagamento_DettaglioPagamento,
		PKStaging_FatturaElettronicaBody_DatiPagamento,
		ModalitaPagamento,
		DataScadenzaPagamento,
		ImportoPagamento,
		IstitutoFinanziario,
		IBAN,
		ABI,
		CAB,
		BIC
	)
	SELECT
		@PKStaging_FatturaElettronicaBody_DatiPagamento,
		MPT.SDI_ModalitaPagamento, -- 2.4.2.2
		CASE WHEN MPT.SDI_HasDataScadenza = CAST(1 AS BIT) THEN DS.[Data] ELSE NULL END, -- 2.4.2.5
		DS.Importo, -- 2.4.2.6
		CASE WHEN MPT.SDI_HasDatiIstitutoFinanziario = CAST(1 AS BIT) THEN D.Pag_Banca ELSE NULL END, -- 2.4.2.1.12
		CASE WHEN MPT.SDI_HasDatiIstitutoFinanziario = CAST(1 AS BIT) THEN REPLACE(D.Pag_Iban, N' ', N'') ELSE NULL END, -- 2.4.2.1.13
		CASE WHEN MPT.SDI_HasDatiIstitutoFinanziario = CAST(1 AS BIT) THEN D.Pag_Abi ELSE NULL END, -- 2.4.2.1.14
		CASE WHEN MPT.SDI_HasDatiIstitutoFinanziario = CAST(1 AS BIT) THEN D.Pag_Cab ELSE NULL END, -- 2.4.2.1.15
		CASE WHEN MPT.SDI_HasDatiIstitutoFinanziario = CAST(1 AS BIT) THEN D.Pag_Bic ELSE NULL END -- 2.4.2.1.16

	FROM dbo.Documenti_Scadenze DS
	INNER JOIN dbo.ModalitaPagamento_Tipi MPT ON MPT.ID = DS.IDTipoPagamento
	INNER JOIN dbo.Documenti D ON D.ID = DS.IDDocumento
	WHERE DS.IDDocumento = @IDDocumento
		AND DS.Tipo = 1; -- 1: Scadenze previste

    END;

END;
GO
