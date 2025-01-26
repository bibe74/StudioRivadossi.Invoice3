CREATE TABLE [dbo].[MenuRibbon]
(
[MenuRibbonID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[MenuRibbonParentID] [int] NULL,
[MenuText] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Command] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IconName] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[IsActive] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MenuRibbon] ADD CONSTRAINT [PK_MenuRibbon] PRIMARY KEY CLUSTERED  ([MenuRibbonID]) ON [PRIMARY]
GO
