CREATE TABLE [prod].[Stati]
(
[IDStato] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [prod].[Stati] ADD CONSTRAINT [PK_Prod_Stati] PRIMARY KEY CLUSTERED  ([IDStato]) ON [PRIMARY]
GO
