CREATE TABLE [prod].[FogliLavoro_Reparti]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [prod].[FogliLavoro_Reparti] ADD CONSTRAINT [PK_FogliLavoro_Reparti] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
