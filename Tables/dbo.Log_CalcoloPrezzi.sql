CREATE TABLE [dbo].[Log_CalcoloPrezzi]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Ts] [datetime] NOT NULL CONSTRAINT [DF_Log_CalcoloPrezzi_Ts] DEFAULT (getdate()),
[Doc_ID] [uniqueidentifier] NULL,
[Doc_IDTipo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Doc_Numero] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Doc_Data] [date] NULL,
[Clifor_ID] [uniqueidentifier] NULL,
[CliFor_Codice] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Clifor_IDCategoria] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_ID] [uniqueidentifier] NULL,
[Articolo_Codice] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Articolo_Prezzo] [numeric] (19, 6) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Log_CalcoloPrezzi] ADD CONSTRAINT [PK_Log_CalcoloPrezzi] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
