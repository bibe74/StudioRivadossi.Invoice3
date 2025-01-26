CREATE TABLE [dbo].[UnitaMisura]
(
[ID] [nvarchar] (5) COLLATE Latin1_General_CI_AS NOT NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UnitaMisura] ADD CONSTRAINT [PK_UnitaMisura] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
