CREATE TABLE [dbo].[Trasporto]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Trasporto_ID] DEFAULT (newid()),
[Campo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Descrizione] [nvarchar] (200) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Trasporto] ADD CONSTRAINT [PK_Trasporto] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
