CREATE TABLE [dbo].[Causali]
(
[ID] [nvarchar] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[IDOpposta] [nvarchar] (3) COLLATE Latin1_General_CI_AS NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[SoggettoRitAcc] [bit] NULL,
[MovimentazioneMagazzino] [bit] NULL,
[Fatturare] [bit] NULL,
[SDI_TipoRitenuta] [char] (4) COLLATE Latin1_General_CI_AS NULL,
[SDI_CausalePagamentoRitenuta] [char] (1) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Causali] ADD CONSTRAINT [PK_Magazzini_Causali] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Causali] ADD CONSTRAINT [FK_Causali_Causali] FOREIGN KEY ([IDOpposta]) REFERENCES [dbo].[Causali] ([ID])
GO
