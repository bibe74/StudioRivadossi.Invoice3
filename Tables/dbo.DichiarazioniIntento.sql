CREATE TABLE [dbo].[DichiarazioniIntento]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDCliFor] [uniqueidentifier] NOT NULL,
[DataInizio] [date] NULL,
[DataFine] [date] NULL,
[Protocollo] [nvarchar] (17) COLLATE Latin1_General_CI_AS NOT NULL,
[Progressivo] [nvarchar] (6) COLLATE Latin1_General_CI_AS NOT NULL,
[DataRicevuta] [date] NOT NULL,
[Descrizione] [nvarchar] (200) COLLATE Latin1_General_CI_AS NULL,
[ImpTotale] [numeric] (19, 6) NULL,
[Numero] AS (concat(rtrim(ltrim([Protocollo])),'-',rtrim(ltrim([Progressivo]))))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DichiarazioniIntento] ADD CONSTRAINT [PK_DichiarazioniIntento] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DichiarazioniIntento] ADD CONSTRAINT [FK_DichiarazioniIntento_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID])
GO
