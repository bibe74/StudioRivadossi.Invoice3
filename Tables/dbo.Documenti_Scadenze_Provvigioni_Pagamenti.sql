CREATE TABLE [dbo].[Documenti_Scadenze_Provvigioni_Pagamenti]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Data] [datetime] NULL,
[Descrizione] [nvarchar] (200) COLLATE Latin1_General_CI_AS NULL,
[DescrizioneExt] [nvarchar] (215) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Scadenze_Provvigioni_Pagamenti] ADD CONSTRAINT [PK_Documenti_Scadenze_Provvigioni_Pagamenti] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
