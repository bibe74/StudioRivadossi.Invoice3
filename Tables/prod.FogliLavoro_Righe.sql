CREATE TABLE [prod].[FogliLavoro_Righe]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_FogliLavoro_Righe_ID] DEFAULT (newid()),
[IDFoglioLavoro] [uniqueidentifier] NOT NULL,
[IDDocumento_Riga] [uniqueidentifier] NULL,
[IDArticolo] [uniqueidentifier] NULL,
[IDComponente] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDFase] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDReparto] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Note] [nvarchar] (2500) COLLATE Latin1_General_CI_AS NULL,
[RichiestoData] [date] NULL,
[Evaso] [bit] NULL,
[EvasoData] [date] NULL,
[Posizione] [int] NULL,
[EvasoTs] [datetime] NULL,
[EvasoIDUtente] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [prod].[FogliLavoro_Righe] ADD CONSTRAINT [PK_FogliLavoro_Righe] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [prod].[FogliLavoro_Righe] ADD CONSTRAINT [FK_FogliLavoro_Righe_Articoli] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID])
GO
ALTER TABLE [prod].[FogliLavoro_Righe] ADD CONSTRAINT [FK_FogliLavoro_Righe_Documenti_Righe] FOREIGN KEY ([IDDocumento_Riga]) REFERENCES [dbo].[Documenti_Righe] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [prod].[FogliLavoro_Righe] ADD CONSTRAINT [FK_FogliLavoro_Righe_FogliLavoro] FOREIGN KEY ([IDFoglioLavoro]) REFERENCES [prod].[FogliLavoro] ([ID]) ON DELETE CASCADE
GO
