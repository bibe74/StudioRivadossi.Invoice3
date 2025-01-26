CREATE TABLE [prod].[FogliLavoro_Fasi]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [prod].[FogliLavoro_Fasi] ADD CONSTRAINT [PK_FogliLavoro_Fasi] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
