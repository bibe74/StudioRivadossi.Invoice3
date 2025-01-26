CREATE TABLE [dbo].[Utenti_AbilitazioniModuli]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Utenti_AbilitazioniModuli_ID] DEFAULT (newid()),
[IDUtente] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[IDModulo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Lettura] [bit] NULL,
[Scrittura] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Utenti_AbilitazioniModuli] ADD CONSTRAINT [PK_Utenti_AbiloitazioniModuli] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Utenti_AbilitazioniModuli] ADD CONSTRAINT [FK_Utenti_AbilitazioniModuli_Moduli] FOREIGN KEY ([IDModulo]) REFERENCES [dbo].[Moduli] ([ID])
GO
ALTER TABLE [dbo].[Utenti_AbilitazioniModuli] ADD CONSTRAINT [FK_Utenti_AbilitazioniModuli_Utenti] FOREIGN KEY ([IDUtente]) REFERENCES [dbo].[Utenti] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
