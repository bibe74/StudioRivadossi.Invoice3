CREATE TABLE [dbo].[CliFor_ScontiArticolo]
(
[ID] [uniqueidentifier] NOT NULL,
[IDCliFor] [uniqueidentifier] NULL,
[CodiceArticolo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Sconto] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[PrezzoFisso] [numeric] (19, 6) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_ScontiArticolo] ADD CONSTRAINT [PK_CliFor_ScontiArticolo] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_ScontiArticolo] ADD CONSTRAINT [FK_CliFor_ScontiArticolo_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID]) ON DELETE CASCADE
GO
