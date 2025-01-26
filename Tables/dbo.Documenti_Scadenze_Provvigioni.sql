CREATE TABLE [dbo].[Documenti_Scadenze_Provvigioni]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDDocumento] [uniqueidentifier] NOT NULL,
[IDDocumento_Riga] [uniqueidentifier] NOT NULL,
[IDArticolo] [uniqueidentifier] NOT NULL,
[IDClasseProvvigione] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[IDScadenza] [uniqueidentifier] NOT NULL,
[IDPagamento] [int] NULL,
[Data] [datetime] NULL,
[ImpRiga] [numeric] (19, 6) NULL,
[DataPagamento] [datetime] NULL,
[Codice] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Descrizione] [nvarchar] (1000) COLLATE Latin1_General_CI_AS NULL,
[Qta] [float] NULL,
[CostoProgetto] [numeric] (19, 6) NULL,
[CostoProduzione] [numeric] (19, 6) NULL,
[PercProvvigione] [numeric] (19, 6) NULL,
[ImpProvvigione] [numeric] (19, 6) NULL,
[ImpPagato] [numeric] (19, 6) NULL,
[Pagare] [bit] NOT NULL,
[Pagato] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Scadenze_Provvigioni] ADD CONSTRAINT [PK_Documenti_Scadenze_Provvigioni] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Scadenze_Provvigioni] ADD CONSTRAINT [FK_Documenti_Scadenze_Provvigioni_Articoli] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Scadenze_Provvigioni] ADD CONSTRAINT [FK_Documenti_Scadenze_Provvigioni_ClassiProvvigione] FOREIGN KEY ([IDClasseProvvigione]) REFERENCES [dbo].[ClassiProvvigione] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Scadenze_Provvigioni] ADD CONSTRAINT [FK_Documenti_Scadenze_Provvigioni_Documenti] FOREIGN KEY ([IDDocumento]) REFERENCES [dbo].[Documenti] ([ID])
GO
ALTER TABLE [dbo].[Documenti_Scadenze_Provvigioni] ADD CONSTRAINT [FK_Documenti_Scadenze_Provvigioni_Documenti_Righe] FOREIGN KEY ([IDDocumento_Riga]) REFERENCES [dbo].[Documenti_Righe] ([ID])
GO
