CREATE TABLE [dbo].[Agenti]
(
[ID] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[Nominativo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[ProvvigioneDiretta] [bit] NULL,
[ProvvigioneIndiretta] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Agenti] ADD CONSTRAINT [PK_Agenti] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
