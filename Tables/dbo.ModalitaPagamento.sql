CREATE TABLE [dbo].[ModalitaPagamento]
(
[ID] [nvarchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[Tipo] [nvarchar] (4) COLLATE Latin1_General_CI_AS NULL,
[CalcoloScadenza] [int] NULL,
[NumeroRate] [int] NULL,
[RateUguali] [bit] NULL,
[IvaSullaPrimaRata] [bit] NULL,
[Rata1_Giorni] [int] NULL,
[Rata1_Perc] [numeric] (9, 4) NULL,
[Rata2_Giorni] [int] NULL,
[Rata2_Perc] [numeric] (9, 4) NULL,
[Rata3_Giorni] [int] NULL,
[Rata3_Perc] [numeric] (9, 4) NULL,
[Rata4_Giorni] [int] NULL,
[Rata4_Perc] [numeric] (9, 4) NULL,
[Rata5_Giorni] [int] NULL,
[Rata5_Perc] [numeric] (9, 4) NULL,
[Rata6_Giorni] [int] NULL,
[Rata6_Perc] [numeric] (9, 4) NULL,
[PagamentoImmediato] [bit] NULL,
[RateIvaUguali] [bit] NULL,
[Rata1_PercIva] [numeric] (9, 4) NULL,
[Rata2_PercIva] [numeric] (9, 4) NULL,
[Rata3_PercIva] [numeric] (9, 4) NULL,
[Rata4_PercIva] [numeric] (9, 4) NULL,
[Rata5_PercIva] [numeric] (9, 4) NULL,
[Rata6_PercIva] [numeric] (9, 4) NULL,
[Sospesa] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ModalitaPagamento] ADD CONSTRAINT [PK_ModalitaPagamento] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ModalitaPagamento] ADD CONSTRAINT [FK_ModalitaPagamento_ModalitaPagamento_Tipi] FOREIGN KEY ([Tipo]) REFERENCES [dbo].[ModalitaPagamento_Tipi] ([ID]) ON UPDATE CASCADE
GO
