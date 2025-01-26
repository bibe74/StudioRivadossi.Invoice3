CREATE TABLE [dbo].[Documenti_Stati]
(
[ID] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Stati] ADD CONSTRAINT [PK_Documenti_Stati] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
