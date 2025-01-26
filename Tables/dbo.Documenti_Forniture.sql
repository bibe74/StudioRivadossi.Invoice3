CREATE TABLE [dbo].[Documenti_Forniture]
(
[ID] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Forniture] ADD CONSTRAINT [PK_Documenti_Forniture] PRIMARY KEY NONCLUSTERED  ([ID]) ON [PRIMARY]
GO
