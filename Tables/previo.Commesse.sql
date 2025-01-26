CREATE TABLE [previo].[Commesse]
(
[ID] [uniqueidentifier] NOT NULL,
[IDPreventivo] [uniqueidentifier] NOT NULL,
[Numero] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Data] [datetime] NOT NULL,
[DataControllo] [datetime] NULL,
[DataConsegnaPrevista] [datetime] NULL,
[Revisione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[RevisioneData] [datetime] NULL,
[DataInizioProduzione] [datetime] NULL,
[TipoImballo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Qta] [int] NULL,
[LottoMateriaPrima] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[PesoScatola] [numeric] (18, 2) NULL,
[PesoScatole] [numeric] (18, 2) NULL,
[ScatoleSovrapposte] [int] NULL,
[ScatoleBancale] [int] NULL,
[TipoBancale] [nchar] (10) COLLATE Latin1_General_CI_AS NULL,
[Conservazione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Note] [nvarchar] (4000) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Commesse] ADD CONSTRAINT [PK_Commesse] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Commesse] ADD CONSTRAINT [FK_Commesse_Preventivi] FOREIGN KEY ([IDPreventivo]) REFERENCES [previo].[Preventivi] ([ID])
GO
