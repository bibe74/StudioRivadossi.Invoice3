CREATE TABLE [prod].[Macchine]
(
[IDMacchina] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[IDFase] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IDFamigliaMateriale] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[PathOut] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[PathIn] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [prod].[Macchine] ADD CONSTRAINT [PK_prod_Macchine] PRIMARY KEY CLUSTERED  ([IDMacchina]) ON [PRIMARY]
GO
ALTER TABLE [prod].[Macchine] ADD CONSTRAINT [FK_prod_Macchine_Famiglie] FOREIGN KEY ([IDFamigliaMateriale]) REFERENCES [dbo].[Famiglie] ([ID])
GO
ALTER TABLE [prod].[Macchine] ADD CONSTRAINT [FK_prod_Macchine_Fasi] FOREIGN KEY ([IDFase]) REFERENCES [prod].[FogliLavoro_Fasi] ([ID])
GO
