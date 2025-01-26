CREATE TABLE [dbo].[Documenti]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Documenti_ID] DEFAULT (newid()),
[IDTipo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[IDStato] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[IDCliFor] [uniqueidentifier] NULL,
[IDCliFor_Indirizzo] [uniqueidentifier] NULL,
[IDCausale] [nvarchar] (3) COLLATE Latin1_General_CI_AS NULL,
[IDMagazzino] [nvarchar] (3) COLLATE Latin1_General_CI_AS NULL,
[IDMagazzinoOpposto] [nvarchar] (3) COLLATE Latin1_General_CI_AS NULL,
[Numero] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[NumeroPre] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[NumeroInt] [int] NULL,
[NumeroPos] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[Data] [datetime] NULL,
[DataConsegna] [datetime] NULL,
[CF] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[PI] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Intestazione] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Intestazione2] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Indirizzo] [nvarchar] (60) COLLATE Latin1_General_CI_AS NULL,
[Cap] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Comune] [nvarchar] (60) COLLATE Latin1_General_CI_AS NULL,
[Provincia] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Nazione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Pag_Modalita] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Pag_CalcolaImporti] [bit] NULL,
[Pag_Banca] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Pag_Cin] [nvarchar] (1) COLLATE Latin1_General_CI_AS NULL,
[Pag_Abi] [nvarchar] (5) COLLATE Latin1_General_CI_AS NULL,
[Pag_Cab] [nvarchar] (5) COLLATE Latin1_General_CI_AS NULL,
[Pag_Cc] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Pag_Iban] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Pag_Bic] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Pag_Spese] [bit] NULL,
[Pag_ExtraSconto] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Pag_ExtraSconto_Perc] [float] NULL,
[Dest_Intestazione] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Dest_Intestazione2] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Dest_Indirizzo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Dest_Cap] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Dest_Comune] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Dest_Provincia] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Dest_Nazione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Note] [nvarchar] (2500) COLLATE Latin1_General_CI_AS NULL,
[TotRighe] [numeric] (19, 6) NULL,
[Inps] [numeric] (19, 6) NULL,
[TotImp] [numeric] (19, 6) NULL,
[TotIva] [numeric] (19, 6) NULL,
[TotLordo] [numeric] (19, 6) NULL,
[RitAcc] [numeric] (19, 6) NULL,
[TotDoc] [numeric] (19, 6) NULL,
[Righe] [int] NULL,
[RigheEvase] [int] NULL,
[RigheEvaseParz] [int] NULL,
[CondFor_Validita] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[CondFor_Tempi] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[CondFor_Trasporto] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[CondFor_Resa] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[CondFor_Note] [nvarchar] (500) COLLATE Latin1_General_CI_AS NULL,
[Trasp_TsInizio] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Trasp_Mezzo] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Trasp_Aspetto] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Trasp_Colli] [int] NULL,
[Trasp_Peso] [numeric] (19, 6) NULL,
[Trasp_Porto] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Trasp_Vettore1] [nvarchar] (200) COLLATE Latin1_General_CI_AS NULL,
[Trasp_Vettore2] [nvarchar] (200) COLLATE Latin1_General_CI_AS NULL,
[Trasp_Vettore3] [nvarchar] (200) COLLATE Latin1_General_CI_AS NULL,
[Trasp_IDVeicolo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Trasp_DistanzaKm] [int] NULL,
[Trasp_MezzoCedente] [bit] NULL,
[Trasp_MezzoCessionario] [bit] NULL,
[NascondiTotali] [bit] NULL,
[SoggettoRitAcc] [bit] NULL,
[Pag_ModalitaSviluppata] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Protocollo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[DescrizioneRidottaSingolare] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[AllegatoModello] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[AllegatoFile] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[IDFornitura] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[IDBancaRB] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Creazione_Ts] [datetime] NULL,
[Creazione_IDUtente] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Modifica_Ts] [datetime] NULL,
[Modifica_IDUtente] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Allegato] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Rif_CodiceFornitore] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Rif_Ordine] [nvarchar] (512) COLLATE Latin1_General_CI_AS NULL,
[Rif_Magazzino] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[SitPag_TotPagato] [numeric] (19, 6) NULL,
[SitPag_TotProvvigione] [numeric] (19, 6) NULL,
[SitPag_TotProvvigionePagato] [numeric] (19, 6) NULL,
[Pdf] [bit] NULL,
[Pdf_Ts] [datetime] NULL,
[Riferimenti] [nvarchar] (2500) COLLATE Latin1_General_CI_AS NULL,
[Evaso] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Evade] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[IDReferente] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[DataRichiesta] [datetime] NULL,
[ModelloReport] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Qta] [numeric] (19, 6) NULL,
[QtaEvasa] [numeric] (19, 6) NULL,
[SDI_Stato] [int] NULL,
[SDI_StatoTs] [datetime] NULL,
[SDI_LogEvento] [nvarchar] (500) COLLATE Latin1_General_CI_AS NULL,
[SDI_LogValidazione] [nvarchar] (1500) COLLATE Latin1_General_CI_AS NULL,
[CodiceCIG] [nvarchar] (15) COLLATE Latin1_General_CI_AS NULL,
[CodiceCUP] [nvarchar] (15) COLLATE Latin1_General_CI_AS NULL,
[Sospeso] [bit] NOT NULL CONSTRAINT [DF_Documenti_Sospeso] DEFAULT ('0'),
[HasDatiBollo] [bit] NOT NULL CONSTRAINT [DFT_dbo_Documenti_HasDatiBollo] DEFAULT ((0)),
[ImportoBollo] [decimal] (14, 2) NOT NULL CONSTRAINT [DFT_dbo_Documenti_ImportoBollo] DEFAULT ((0.0)),
[BolloVirtuale_Soglia] [numeric] (19, 6) NULL,
[BolloVirtuale_Importo] [numeric] (19, 6) NULL,
[BolloVirtuale_AddebitaSpesa] [bit] NOT NULL CONSTRAINT [DFT_dbo_Documenti_BolloVirtuale_AddebitaSpesa] DEFAULT ((0)),
[BolloVirtuale_CodIvaSpesa] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[BolloVirtuale_DescrizioneSpesa] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[SDI_IDTipoDocumento] [char] (4) COLLATE Latin1_General_CI_AS NULL,
[IDDocumento_Origine] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti] ADD CONSTRAINT [PK_Documenti] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Documenti] ON [dbo].[Documenti] ([IDTipo], [IDCliFor], [Data]) INCLUDE ([AllegatoFile], [AllegatoModello], [Cap], [CondFor_Tempi], [CondFor_Trasporto], [Creazione_Ts], [DataConsegna], [CF], [Comune], [Dest_Intestazione], [Dest_Intestazione2], [CondFor_Note], [CondFor_Resa], [CondFor_Validita], [Creazione_IDUtente], [IDCausale], [IDCliFor_Indirizzo], [DescrizioneRidottaSingolare], [Dest_Cap], [Dest_Comune], [Dest_Indirizzo], [Indirizzo], [Inps], [Dest_Nazione], [Dest_Provincia], [ID], [IDBancaRB], [NascondiTotali], [Nazione], [IDFornitura], [IDMagazzino], [IDMagazzinoOpposto], [IDStato], [NumeroPre], [Pag_Abi], [Intestazione], [Intestazione2], [Modifica_IDUtente], [Modifica_Ts], [Pag_Cc], [Pag_Cin], [Note], [Numero], [NumeroInt], [NumeroPos], [Pag_ModalitaSviluppata], [Pag_Spese], [Pag_Banca], [Pag_Bic], [Pag_Cab], [Pag_CalcolaImporti], [RigheEvase], [RigheEvaseParz], [Pag_ExtraSconto], [Pag_ExtraSconto_Perc], [Pag_Iban], [Pag_Modalita], [TotIva], [TotLordo], [PI], [Protocollo], [Provincia], [Righe], [Trasp_MezzoCedente], [Trasp_MezzoCessionario], [RitAcc], [SoggettoRitAcc], [TotDoc], [TotImp], [Trasp_TsInizio], [Trasp_Vettore1], [TotRighe], [Trasp_Aspetto], [Trasp_Vettore2], [Trasp_Vettore3], [Trasp_Colli], [Trasp_Mezzo], [Trasp_Peso], [Trasp_Porto]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti] ADD CONSTRAINT [FK_Documenti_Causali] FOREIGN KEY ([IDCausale]) REFERENCES [dbo].[Causali] ([ID])
GO
ALTER TABLE [dbo].[Documenti] ADD CONSTRAINT [FK_Documenti_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID])
GO
ALTER TABLE [dbo].[Documenti] ADD CONSTRAINT [FK_Documenti_Documenti_Forniture] FOREIGN KEY ([IDFornitura]) REFERENCES [dbo].[Documenti_Forniture] ([ID]) ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Documenti] ADD CONSTRAINT [FK_Documenti_Documenti_ModelliReport] FOREIGN KEY ([ModelloReport]) REFERENCES [dbo].[Documenti_ModelliReport] ([ID])
GO
ALTER TABLE [dbo].[Documenti] ADD CONSTRAINT [FK_Documenti_Documenti_Stati] FOREIGN KEY ([IDStato]) REFERENCES [dbo].[Documenti_Stati] ([ID])
GO
ALTER TABLE [dbo].[Documenti] ADD CONSTRAINT [FK_Documenti_Documenti_Tipi] FOREIGN KEY ([IDTipo]) REFERENCES [dbo].[Documenti_Tipi] ([ID])
GO
ALTER TABLE [dbo].[Documenti] ADD CONSTRAINT [FK_Documenti_IDDocumento_Origine] FOREIGN KEY ([IDDocumento_Origine]) REFERENCES [dbo].[Documenti] ([ID])
GO
ALTER TABLE [dbo].[Documenti] ADD CONSTRAINT [FK_Documenti_Magazzini] FOREIGN KEY ([IDMagazzino]) REFERENCES [dbo].[Magazzini] ([ID])
GO
ALTER TABLE [dbo].[Documenti] ADD CONSTRAINT [FK_Documenti_Magazzini_IDMagazzinoOpposto] FOREIGN KEY ([IDMagazzinoOpposto]) REFERENCES [dbo].[Magazzini] ([ID])
GO
ALTER TABLE [dbo].[Documenti] ADD CONSTRAINT [FK_Documenti_ModalitaPagamento] FOREIGN KEY ([Pag_Modalita]) REFERENCES [dbo].[ModalitaPagamento] ([ID]) ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Documenti] ADD CONSTRAINT [FK_Documenti_Veicoli] FOREIGN KEY ([Trasp_IDVeicolo]) REFERENCES [dbo].[Veicoli] ([ID]) ON UPDATE CASCADE
GO
