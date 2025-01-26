CREATE TABLE [dbo].[Listini_Righe]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDListino] [int] NULL,
[IDArticolo] [uniqueidentifier] NOT NULL,
[IDCliFor] [uniqueidentifier] NULL,
[IDCliFor_Categoria] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[DataInizio] [date] NULL,
[DataFine] [date] NULL,
[ImpNetto] [numeric] (19, 6) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Listini_Righe] ADD CONSTRAINT [PK_Listini_Righe] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Listini_Righe_IDArticolo_Date] ON [dbo].[Listini_Righe] ([IDListino]) INCLUDE ([DataFine], [DataInizio], [IDArticolo], [ImpNetto]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Listini_Righe] ADD CONSTRAINT [FK_Listini_Righe_Articoli] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Listini_Righe] ADD CONSTRAINT [FK_Listini_Righe_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Listini_Righe] ADD CONSTRAINT [FK_Listini_Righe_CliFor_Categorie] FOREIGN KEY ([IDCliFor_Categoria]) REFERENCES [dbo].[CliFor_Categorie] ([ID])
GO
ALTER TABLE [dbo].[Listini_Righe] ADD CONSTRAINT [FK_Listini_Righe_Listini] FOREIGN KEY ([IDListino]) REFERENCES [dbo].[Listini] ([ID]) ON DELETE CASCADE
GO
