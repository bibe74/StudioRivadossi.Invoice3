CREATE TABLE [dbo].[Conf_Colonne]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Conf_DataGrid_ID] DEFAULT (newid()),
[Controllo] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Posizione] [int] NULL,
[Nome] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Intestazione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Campo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Visibile] [bit] NULL CONSTRAINT [DF_Conf_DataGrid_Visibile] DEFAULT ((1)),
[SolaLettura] [bit] NULL,
[Dimensionabile] [bit] NULL,
[Larghezza] [int] NULL,
[AutosizeFill] [bit] NULL,
[Formato] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[FillWeight] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Conf_Colonne] ADD CONSTRAINT [PK_Conf_DataGrid] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
