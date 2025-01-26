CREATE TABLE [dbo].[Veicoli]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Marca] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Modello] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Targa] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[TariffaKm] [numeric] (16, 4) NULL,
[Attivo] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Veicoli] ADD CONSTRAINT [PK_Veicoli] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
