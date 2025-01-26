CREATE TABLE [dbo].[Nazioni]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[SDI_IDNazione] [char] (2) COLLATE Latin1_General_CI_AS NULL,
[SDI_Esportazione] [bit] NULL CONSTRAINT [DF_dbo_Nazioni_SDI_Esportazione] DEFAULT ((0)),
[BolloVirtuale] [bit] NOT NULL CONSTRAINT [DF_dbo_Nazioni_BolloVirtuale] DEFAULT ((0)),
[IDAreaGeografica] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Nazioni] ADD CONSTRAINT [PK_Nazioni] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Nazioni] ADD CONSTRAINT [FK_Nazioni_AreeGeografiche] FOREIGN KEY ([IDAreaGeografica]) REFERENCES [dbo].[AreeGeografiche] ([IDAreaGeografica])
GO
