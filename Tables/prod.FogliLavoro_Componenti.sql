CREATE TABLE [prod].[FogliLavoro_Componenti]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [prod].[FogliLavoro_Componenti] ADD CONSTRAINT [PK_FogliLavoro_Componenti] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [prod].[FogliLavoro_Componenti] ADD CONSTRAINT [FK_FogliLavoro_Componenti_FogliLavoro_Componenti] FOREIGN KEY ([ID]) REFERENCES [prod].[FogliLavoro_Componenti] ([ID])
GO
