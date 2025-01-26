CREATE TABLE [dbo].[Province]
(
[ID] [uniqueidentifier] NOT NULL,
[Area] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[CodiceRegione] [int] NULL,
[DenominazioneRegione] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[CodiceProvincia] [int] NULL,
[DenominazioneProvincia] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[SiglaProvincia] [nchar] (2) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Province] ADD CONSTRAINT [PK_Province] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
