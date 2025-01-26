CREATE TABLE [dbo].[Articoli_Fasi]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Articoli_Fasi_ID] DEFAULT (newid()),
[IDArticolo] [uniqueidentifier] NOT NULL,
[IDComponente] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDFase] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDReparto] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Note] [nvarchar] (2500) COLLATE Latin1_General_CI_AS NULL,
[Posizione] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articoli_Fasi] ADD CONSTRAINT [PK_Articoli_Fasi] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articoli_Fasi] ADD CONSTRAINT [FK_Articoli_Fasi_Articoli] FOREIGN KEY ([IDArticolo]) REFERENCES [dbo].[Articoli] ([ID]) ON DELETE CASCADE
GO
