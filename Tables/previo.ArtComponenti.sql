CREATE TABLE [previo].[ArtComponenti]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[IDArticoloProduzione] [uniqueidentifier] NOT NULL,
[IDComponente] [uniqueidentifier] NOT NULL,
[CodiceComponente] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Qta] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Data] [datetime] NULL,
[Cliente] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArtComponenti] ADD CONSTRAINT [PK_ArtComponenti] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArtComponenti] ADD CONSTRAINT [idxUnique] UNIQUE NONCLUSTERED ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[ArtComponenti] ADD CONSTRAINT [FK_ArtComponenti_ArticoliProduzione] FOREIGN KEY ([IDArticoloProduzione]) REFERENCES [previo].[ArticoliProduzione] ([ID]) ON DELETE CASCADE
GO
ALTER TABLE [previo].[ArtComponenti] ADD CONSTRAINT [FK_ArtComponenti_ArticoliProduzione1] FOREIGN KEY ([IDComponente]) REFERENCES [previo].[ArticoliProduzione] ([ID])
GO
