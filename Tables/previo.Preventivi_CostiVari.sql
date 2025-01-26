CREATE TABLE [previo].[Preventivi_CostiVari]
(
[ID] [uniqueidentifier] NOT NULL,
[IDPreventivo] [uniqueidentifier] NULL,
[Descrizione] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Fornitura_Qta] [numeric] (19, 6) NULL,
[Fornitura_CostoUnitario] [numeric] (19, 6) NULL,
[Fornitura_CostoCalcolato] [numeric] (19, 6) NULL,
[Fornitura_PercRicarico] [numeric] (19, 6) NULL,
[Fornitura_Lotto] [numeric] (19, 6) NULL
) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_CostiVari] ADD CONSTRAINT [PK_Preventivi_CostiVari] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [previo].[Preventivi_CostiVari] ADD CONSTRAINT [FK_Preventivi_CostiVari_Preventivi] FOREIGN KEY ([IDPreventivo]) REFERENCES [previo].[Preventivi] ([ID]) ON DELETE CASCADE
GO
