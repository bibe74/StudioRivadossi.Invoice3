CREATE TABLE [dbo].[Documenti_Tipi_ValoriPredefiniti]
(
[ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Documenti_Tipi_ValoriPredefiniti_ID] DEFAULT (newid()),
[IDTipo] [nvarchar] (20) COLLATE Latin1_General_CI_AS NULL,
[NomeCampo] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Valore] [nvarchar] (500) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documenti_Tipi_ValoriPredefiniti] ADD CONSTRAINT [PK_Documenti_Tipi_ValoriPredefiniti] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
