CREATE TABLE [prod].[FogliLavoro_RighePredefinite]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IDComponente] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDFase] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDReparto] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [prod].[FogliLavoro_RighePredefinite] ADD CONSTRAINT [PK_FogliLavoro_RighePredefinite] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
