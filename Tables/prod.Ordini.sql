CREATE TABLE [prod].[Ordini]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDFoglioLavoro] [uniqueidentifier] NOT NULL,
[IDFoglioLavoro_Riga] [uniqueidentifier] NOT NULL,
[IDMacchina] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[IDArticolo] [uniqueidentifier] NOT NULL,
[IDArticoloMateriale] [uniqueidentifier] NULL,
[IDStato] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[CodiceArticolo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[CodiceArticoloMateriale] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[PosizioneRiga] [int] NULL,
[PosizioneFase] [int] NULL,
[Qta] [int] NOT NULL,
[NomeFileOriginaleFull] [nvarchar] (255) COLLATE Latin1_General_CI_AS NOT NULL,
[NomeFileOriginale] [nvarchar] (255) COLLATE Latin1_General_CI_AS NOT NULL,
[NomeFileMacchina] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[TsCreazione] [datetime2] NOT NULL,
[TsRilascio] [datetime2] NULL,
[TsInizio] [datetime2] NULL,
[TsFine] [datetime2] NULL,
[Note] [nvarchar] (2500) COLLATE Latin1_General_CI_AS NULL,
[Macchina_CodiceMateriale] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Macchina_TsInizio] [datetime2] NULL,
[Macchina_TsFine] [datetime2] NULL,
[Macchina_Qta] [int] NULL,
[Macchina_Durata] [numeric] (19, 6) NULL,
[Macchina_Xml] [nvarchar] (2500) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [prod].[Ordini] ADD CONSTRAINT [PK_Prod_Ordini] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [prod].[Ordini] ADD CONSTRAINT [FK_Prod_Ordini_Articoli] FOREIGN KEY ([IDArticoloMateriale]) REFERENCES [dbo].[Articoli] ([ID])
GO
ALTER TABLE [prod].[Ordini] ADD CONSTRAINT [FK_Prod_Ordini_FogliLavoro_Righe] FOREIGN KEY ([IDFoglioLavoro_Riga]) REFERENCES [prod].[FogliLavoro_Righe] ([ID])
GO
ALTER TABLE [prod].[Ordini] ADD CONSTRAINT [FK_Prod_Stati] FOREIGN KEY ([IDStato]) REFERENCES [prod].[Stati] ([IDStato])
GO
