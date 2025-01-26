CREATE TABLE [prod].[FogliLavoro]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_FogliLavoro_ID] DEFAULT (newid()),
[IDDocumento] [uniqueidentifier] NULL,
[Numero] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Data] [datetime] NULL,
[NumeroDocumento] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[DataDocumento] [datetime] NULL,
[Descrizione] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Note] [nvarchar] (2500) COLLATE Latin1_General_CI_AS NULL,
[Fasi] [int] NULL,
[FasiEvase] [int] NULL,
[Componenti] [int] NULL,
[ComponentiEvasi] [int] NULL,
[Righe] [int] NULL,
[RigheEvase] [int] NULL,
[Stato] [nvarchar] (15) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [prod].[FogliLavoro] ADD CONSTRAINT [PK_FogliLavoro] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FogliLavoro_IDDocumento] ON [prod].[FogliLavoro] ([IDDocumento]) ON [PRIMARY]
GO
ALTER TABLE [prod].[FogliLavoro] ADD CONSTRAINT [FK_FogliLavoro_Documenti] FOREIGN KEY ([IDDocumento]) REFERENCES [dbo].[Documenti] ([ID])
GO
