CREATE TABLE [dbo].[ModalitaPagamento_Tipi]
(
[ID] [nvarchar] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[EmissioneRiba] [bit] NULL,
[PagamentoAutomatico] [bit] NULL,
[SDI_ModalitaPagamento] [char] (4) COLLATE Latin1_General_CI_AS NULL,
[SDI_HasDataScadenza] [bit] NULL,
[SDI_HasDatiIstitutoFinanziario] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ModalitaPagamento_Tipi] ADD CONSTRAINT [PK_ModalitaPagamento_Tipi] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
