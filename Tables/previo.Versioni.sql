CREATE TABLE [previo].[Versioni]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Tipo] [char] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[Data] [datetime] NULL,
[Major] [int] NULL,
[Minor] [int] NULL,
[Build] [int] NULL,
[Revision] [int] NULL,
[Bin] [varbinary] (max) NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Versioni] ADD CONSTRAINT [PK_Versioni] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
