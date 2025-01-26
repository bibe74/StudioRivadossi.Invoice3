CREATE TABLE [dbo].[Conf_DataGridView]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Conf_DataGridView_ID] DEFAULT (newid()),
[Categoria] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Controllo] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Predefinito] [bit] NULL,
[XML] [xml] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Conf_DataGridView] ADD CONSTRAINT [PK_Conf_DataGridView] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
