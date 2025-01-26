CREATE TABLE [dbo].[Moduli]
(
[ID] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[Descrizione] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Moduli] ADD CONSTRAINT [PK_Moduli] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
