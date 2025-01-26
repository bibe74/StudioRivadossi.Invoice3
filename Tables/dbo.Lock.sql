CREATE TABLE [dbo].[Lock]
(
[TableName] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[WhereCondition] [nvarchar] (255) COLLATE Latin1_General_CI_AS NOT NULL,
[Lock] [bit] NULL,
[Lock_Ts] [datetime] NULL,
[Lock_Usr] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Lock] ADD CONSTRAINT [PK_Lock] PRIMARY KEY CLUSTERED  ([TableName], [WhereCondition]) ON [PRIMARY]
GO
