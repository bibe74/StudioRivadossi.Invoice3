CREATE TABLE [dbo].[CondizioniFornitura]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CondizioniFornitura_ID] DEFAULT (newid()),
[Campo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CondizioniFornitura] ADD CONSTRAINT [PK_CondizioniFornitura] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
