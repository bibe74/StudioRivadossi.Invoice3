CREATE TABLE [dbo].[Documenti_ModelliReport]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Sottocartella] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[IsDefault] [bit] NULL CONSTRAINT [DF_Documenti_CartelleReport_IsDefault] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_ModelliReport] ADD CONSTRAINT [PK_Documenti_CartelleReport] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
