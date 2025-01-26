CREATE TABLE [dbo].[Documenti_Righe]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Documenti_Righe_ID] DEFAULT (newid()),
[IDDocumento] [uniqueidentifier] NULL,
[IDArticolo] [uniqueidentifier] NULL,
[IDFamiglia] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDUnitaMisura] [nvarchar] (5) COLLATE Latin1_General_CI_AS NULL,
[IDDocumento_Origine] [uniqueidentifier] NULL,
[IDDocumento_RigaOrigine] [uniqueidentifier] NULL,
[IDStato] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[Posizione] [int] NULL,
[Qta] [numeric] (19, 6) NULL,
[QtaEvasa] [numeric] (19, 6) NULL,
[Codice] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Descrizione1] [nvarchar] (1000) COLLATE Latin1_General_CI_AS NULL,
[Descrizione2] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Descrizione3] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Descrizione4] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[ImpUnitario] [numeric] (19, 6) NULL,
[ImpNetto] [numeric] (19, 6) NULL,
[Sconto] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[ImpSconto] [numeric] (19, 6) NULL,
[ImpUnitarioScontato] [numeric] (19, 6) NULL,
[ImpNettoScontato] [numeric] (19, 6) NULL,
[CodIva] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[ImpIva] [numeric] (19, 6) NULL,
[ImpLordo] [numeric] (19, 6) NULL,
[NoteRiga] [nvarchar] (2500) COLLATE Latin1_General_CI_AS NULL,
[Lock_Delete] [bit] NULL CONSTRAINT [DF_Documenti_Righe_Lock_Delete] DEFAULT ((0)),
[Lock_Qta] [bit] NULL CONSTRAINT [DF_Documenti_Righe_Lock_Qta] DEFAULT ((0)),
[Lock_Codice] [bit] NULL CONSTRAINT [DF_Documenti_Righe_Lock_Codice] DEFAULT ((0)),
[Lock_Descrizione1] [bit] NULL CONSTRAINT [DF_Documenti_Righe_Lock_Descrizione1] DEFAULT ((0)),
[Lock_Descrizione2] [bit] NULL CONSTRAINT [DF_Documenti_Righe_Lock_Descrizione2] DEFAULT ((0)),
[Lock_Descrizione3] [bit] NULL CONSTRAINT [DF_Documenti_Righe_Lock_Descrizione3] DEFAULT ((0)),
[Lock_Descrizione4] [bit] NULL CONSTRAINT [DF_Documenti_Righe_Lock_Descrizione4] DEFAULT ((0)),
[Nascondi] [bit] NULL,
[DisegnoNumero] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[CommessaNumero] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[CommessaDataConsegna] [datetime] NULL,
[IDPreventivoPrevio] [uniqueidentifier] NULL,
[DdtEntrataNumero] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[DdtEntrataData] [datetime] NULL,
[OrdCliNumero] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[OrdCliData] [datetime] NULL,
[SDI_NumeroLinea] [int] NULL,
[CodiceEsterno] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[CodiceEsternoTipo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDDichiarazioneIntento] [int] NULL,
[DichiarazioneIntento_Protocollo] [nvarchar] (17) COLLATE Latin1_General_CI_AS NULL,
[DichiarazioneIntento_Progressivo] [nvarchar] (6) COLLATE Latin1_General_CI_AS NULL,
[DichiarazioneIntento_DataRicevuta] [date] NULL,
[SDI_Dest_IDTipoDocumento] [char] (4) COLLATE Latin1_General_CI_AS NULL,
[SDI_Dest_IDDocumento] [char] (12) COLLATE Latin1_General_CI_AS NULL,
[SDI_Dest_CodIva] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[SDI_Dest_IDTipo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Righe] ADD CONSTRAINT [PK_Documenti_Righe] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Documenti_Righe_IDArticolo] ON [dbo].[Documenti_Righe] ([IDArticolo]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Documenti_Righe_IDDocumento_CommessaDataConsegna] ON [dbo].[Documenti_Righe] ([IDDocumento], [CommessaDataConsegna]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Documenti_Righe_IDDocumento_Origine] ON [dbo].[Documenti_Righe] ([IDDocumento_Origine]) INCLUDE ([IDDocumento]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Documenti_Righe_IDDocumento_RigaOrigine] ON [dbo].[Documenti_Righe] ([IDDocumento_RigaOrigine]) INCLUDE ([IDDocumento]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Righe] ADD CONSTRAINT [FK_Documenti_Righe_Articoli] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Righe] ADD CONSTRAINT [FK_Documenti_Righe_CodiciIva] FOREIGN KEY ([CodIva]) REFERENCES [dbo].[CodiciIva] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Righe] ADD CONSTRAINT [FK_Documenti_Righe_DichiarazioniIntento] FOREIGN KEY ([IDDichiarazioneIntento]) REFERENCES [dbo].[DichiarazioniIntento] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Righe] ADD CONSTRAINT [FK_Documenti_Righe_Documenti] FOREIGN KEY ([IDDocumento]) REFERENCES [dbo].[Documenti] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Documenti_Righe] ADD CONSTRAINT [FK_Documenti_Righe_Documenti_Origine] FOREIGN KEY ([IDDocumento_Origine]) REFERENCES [dbo].[Documenti] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Righe] ADD CONSTRAINT [FK_Documenti_Righe_Documenti_Righe_Origine] FOREIGN KEY ([IDDocumento_RigaOrigine]) REFERENCES [dbo].[Documenti_Righe] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Righe] ADD CONSTRAINT [FK_Documenti_Righe_Documenti_Stati] FOREIGN KEY ([IDStato]) REFERENCES [dbo].[Documenti_Stati] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Righe] ADD CONSTRAINT [FK_Documenti_Righe_Famiglie] FOREIGN KEY ([IDFamiglia]) REFERENCES [dbo].[Famiglie] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Righe] ADD CONSTRAINT [FK_Documenti_Righe_IDDocumento_Origine] FOREIGN KEY ([IDDocumento_Origine]) REFERENCES [dbo].[Documenti] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Righe] ADD CONSTRAINT [FK_Documenti_Righe_UnitaMisura] FOREIGN KEY ([IDUnitaMisura]) REFERENCES [dbo].[UnitaMisura] ([ID])
GO
