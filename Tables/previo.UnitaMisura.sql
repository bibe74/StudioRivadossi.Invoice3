CREATE TABLE [previo].[UnitaMisura]
(
[ID] [nvarchar] (5) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[UnitaMisura] ADD CONSTRAINT [PK_UnitaMisura] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
