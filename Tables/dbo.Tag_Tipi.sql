CREATE TABLE [dbo].[Tag_Tipi]
(
[ID] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[Automatico] [bit] NOT NULL CONSTRAINT [DF__Tag_Tipi__Automa__7CF02BB0] DEFAULT ((1)),
[Obbligatorio] [bit] NOT NULL CONSTRAINT [DF__Tag_Tipi__Obblig__7DE44FE9] DEFAULT ((0)),
[TestoLibero] [bit] NOT NULL CONSTRAINT [DF__Tag_Tipi__TestoL__7ED87422] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tag_Tipi] ADD CONSTRAINT [PK_Tag_Tipi] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
