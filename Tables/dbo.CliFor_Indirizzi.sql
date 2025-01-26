CREATE TABLE [dbo].[CliFor_Indirizzi]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Indirizzi_ID] DEFAULT (newid()),
[IDCliFor] [uniqueidentifier] NULL,
[Posizione] [int] NULL,
[Intestazione] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Intestazione2] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Nazione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Indirizzo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Cap] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Comune] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Provincia] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[DefaultPerDoc] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[DistanzaKm] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_Indirizzi] ADD CONSTRAINT [PK_Indirizzi] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_Indirizzi] ADD CONSTRAINT [FK_CliFor_Indirizzi_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CliFor_Indirizzi] ADD CONSTRAINT [FK_CliFor_Indirizzi_Nazioni] FOREIGN KEY ([Nazione]) REFERENCES [dbo].[Nazioni] ([ID])
GO
