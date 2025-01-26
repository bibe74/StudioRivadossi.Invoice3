CREATE TABLE [dbo].[CliFor_Riferimenti]
(
[ID] [uniqueidentifier] NOT NULL,
[IDCliFor] [uniqueidentifier] NULL,
[Posizione] [int] NULL,
[Riferimento] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Tipo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Dato] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_Riferimenti] ADD CONSTRAINT [PK_Riferimenti] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CliFor_Riferimenti] ADD CONSTRAINT [FK_CliFor_Riferimenti_CliFor] FOREIGN KEY ([IDCliFor]) REFERENCES [dbo].[CliFor] ([ID]) ON DELETE CASCADE
GO
