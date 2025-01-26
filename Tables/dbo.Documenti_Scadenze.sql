CREATE TABLE [dbo].[Documenti_Scadenze]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Documenti_Scadenze_ID] DEFAULT (newid()),
[IDDocumento] [uniqueidentifier] NULL,
[BancaCassa] [nvarchar] (5) COLLATE Latin1_General_CI_AS NULL,
[Insoluto] [bit] NULL,
[RbEsportata] [bit] NULL,
[RbEsportataData] [datetime] NULL,
[RbBanca] [nvarchar] (80) COLLATE Latin1_General_CI_AS NULL,
[Descrizione] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Note] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Data] [datetime] NULL,
[Numero] [int] NULL,
[Tipo] [int] NULL,
[Importo] [numeric] (19, 6) NULL,
[IDTipoPagamento] [nvarchar] (4) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Scadenze] ADD CONSTRAINT [PK_Documenti_Scadenze] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Documenti_Scadenze_IDDocumentoNumero] ON [dbo].[Documenti_Scadenze] ([IDDocumento], [Numero]) INCLUDE ([Importo], [Tipo]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Documenti_Scadenze_Tipo] ON [dbo].[Documenti_Scadenze] ([Tipo]) INCLUDE ([IDDocumento], [Importo]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Scadenze] ADD CONSTRAINT [FK_Documenti_Scadenze_Documenti] FOREIGN KEY ([IDDocumento]) REFERENCES [dbo].[Documenti] ([ID]) ON DELETE CASCADE
GO
