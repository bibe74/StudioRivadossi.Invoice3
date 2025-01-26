CREATE TABLE [dbo].[Comuni]
(
[ID] [uniqueidentifier] NOT NULL,
[CodiceProvincia] [int] NULL,
[CodiceComune] [int] NULL,
[DenominazioneComune] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Comuni] ADD CONSTRAINT [PK_Comuni] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
