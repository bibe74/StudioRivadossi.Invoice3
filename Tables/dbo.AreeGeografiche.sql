CREATE TABLE [dbo].[AreeGeografiche]
(
[IDAreaGeografica] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AreeGeografiche] ADD CONSTRAINT [PK_AreeGeografiche] PRIMARY KEY CLUSTERED ([IDAreaGeografica]) ON [PRIMARY]
GO
