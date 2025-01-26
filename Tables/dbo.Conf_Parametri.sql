CREATE TABLE [dbo].[Conf_Parametri]
(
[ID] [nvarchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[Valore] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Immagine] [image] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Conf_Parametri] ADD CONSTRAINT [PK_Parametri] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
