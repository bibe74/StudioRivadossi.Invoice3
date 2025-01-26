CREATE TABLE [dbo].[Conf_Parametri_Immagini]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Immagine] [image] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Conf_Parametri_Immagini] ADD CONSTRAINT [PK_Parametri_Immagini] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
