CREATE TABLE [previo].[Preventivi_Componenti]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[IDPreventivo] [uniqueidentifier] NOT NULL,
[IDArticolo] [uniqueidentifier] NOT NULL,
[IDPreventivoComponente] [uniqueidentifier] NOT NULL,
[Codice] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Qta] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[PrezzoUnitario] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_Preventivi_Componenti_PrezzoUnitario] DEFAULT ((0)),
[Codice_Preventivo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Data_Preventivo] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_Componenti] ADD CONSTRAINT [PK_previo.Preventivi_Componenti] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_Componenti] ADD CONSTRAINT [FK_Preventivi_Componenti_Articoli] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID])
GO
ALTER TABLE [previo].[Preventivi_Componenti] ADD CONSTRAINT [FK_Preventivi_Componenti_Preventivi] FOREIGN KEY ([IDPreventivo]) REFERENCES [previo].[Preventivi] ([ID])
GO
