CREATE TABLE [dbo].[Utenti_AbilitazioniMagazzini]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Utenti_AbilitazioniMagazzini_ID] DEFAULT (newid()),
[IDUtente] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[IDMagazzino] [nvarchar] (3) COLLATE Latin1_General_CI_AS NULL,
[Attivo] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Utenti_AbilitazioniMagazzini] ADD CONSTRAINT [PK_Utenti_AbilitazioniMagazzini] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Utenti_AbilitazioniMagazzini] ADD CONSTRAINT [FK_Utenti_AbilitazioniMagazzini_Magazzini] FOREIGN KEY ([IDMagazzino]) REFERENCES [dbo].[Magazzini] ([ID]) ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Utenti_AbilitazioniMagazzini] ADD CONSTRAINT [FK_Utenti_AbilitazioniMagazzini_Utenti] FOREIGN KEY ([IDUtente]) REFERENCES [dbo].[Utenti] ([ID])
GO
