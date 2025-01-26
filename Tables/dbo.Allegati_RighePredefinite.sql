CREATE TABLE [dbo].[Allegati_RighePredefinite]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[RefTableID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Tipo] [nchar] (8) COLLATE Latin1_General_CI_AS NOT NULL,
[Nome] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[FullPath] [nvarchar] (255) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_Allegati_RighePredefinite_FullPath] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Allegati_RighePredefinite] ADD CONSTRAINT [PK_Allegati_RighePredefinite] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
