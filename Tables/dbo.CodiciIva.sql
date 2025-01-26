CREATE TABLE [dbo].[CodiciIva]
(
[ID] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[Descrizione] [nvarchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[Perc] [numeric] (3, 1) NULL,
[ImpEsigibile] [bit] NULL CONSTRAINT [DFT_dbo_CodiciIva_ImpEsigibile] DEFAULT ((0)),
[IvaEsigibile] [bit] NULL CONSTRAINT [DFT_dbo_CodiciIva_IvaEsigibile] DEFAULT ((0)),
[EsenzionePlafond] [bit] NULL,
[SDI_Natura] [varchar] (5) COLLATE Latin1_General_CI_AS NULL,
[SDI_RiferimentoNormativo] [nvarchar] (100) COLLATE Latin1_General_CI_AS NULL,
[SDI_EsigibilitaIVA] [char] (1) COLLATE Latin1_General_CI_AS NULL,
[IsSoggettoBollo] [bit] NOT NULL CONSTRAINT [DFT_dbo_CodiciIva_IsSoggettoBollo] DEFAULT ((0)),
[IsSospesa] [bit] NOT NULL CONSTRAINT [DFT_dbo_CodiciIva_IsSospesa] DEFAULT ((0)),
[DichiarazioneIntento] [bit] NOT NULL CONSTRAINT [DFT_dbo_CodiciIva_DichiarazioneIntento] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodiciIva] ADD CONSTRAINT [PK_CodiciIva] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
