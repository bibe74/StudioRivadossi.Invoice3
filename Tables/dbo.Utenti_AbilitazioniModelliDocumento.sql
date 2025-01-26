CREATE TABLE [dbo].[Utenti_AbilitazioniModelliDocumento]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDUtente] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[ModelloReport] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Abilitato] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Utenti_AbilitazioniModelliDocumento] ADD CONSTRAINT [PK_Utenti_AbilitazioniModelliDocumento] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Utenti_AbilitazioniModelliDocumento] ADD CONSTRAINT [FK_Utenti_AbilitazioniModelliDocumento_Documenti_ModelliReport] FOREIGN KEY ([ModelloReport]) REFERENCES [dbo].[Documenti_ModelliReport] ([ID])
GO
ALTER TABLE [dbo].[Utenti_AbilitazioniModelliDocumento] ADD CONSTRAINT [FK_Utenti_AbilitazioniModelliDocumento_Utenti] FOREIGN KEY ([IDUtente]) REFERENCES [dbo].[Utenti] ([ID])
GO
