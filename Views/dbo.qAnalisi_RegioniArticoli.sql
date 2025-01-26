SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qAnalisi_RegioniArticoli] AS SELECT  dbo.Province.DenominazioneRegione, dbo.CliFor.ProvvigioneDiretta, dbo.CliFor.ProvvigioneIndiretta, dbo.CliFor.Sospeso, dbo.CliFor.Cliente, SUM(dbo.Documenti_Righe.Qta) AS SumQta,  dbo.Documenti_Righe.Codice, dbo.Articoli.Descrizione1, SUM(dbo.Documenti_Righe.ImpNetto * dbo.Documenti_Tipi.ContributoAnalisi) AS SumImpNetto,  SUM(dbo.Documenti_Righe.ImpSconto * dbo.Documenti_Tipi.ContributoAnalisi) AS SumImpSconto, SUM(dbo.Documenti_Righe.ImpNettoScontato * dbo.Documenti_Tipi.ContributoAnalisi)  AS SumImpNettoScontato, SUM(dbo.Documenti_Righe.ImpIva * dbo.Documenti_Tipi.ContributoAnalisi) AS SumImpIva, SUM(dbo.Documenti_Righe.ImpLordo * dbo.Documenti_Tipi.ContributoAnalisi)  AS SumImpLordo FROM dbo.Documenti INNER JOIN dbo.CliFor ON dbo.Documenti.IDCliFor = dbo.CliFor.ID INNER JOIN dbo.Documenti_Righe ON dbo.Documenti.ID = dbo.Documenti_Righe.IDDocumento INNER JOIN dbo.Documenti_Tipi ON dbo.Documenti.IDTipo = dbo.Documenti_Tipi.ID INNER JOIN dbo.Articoli ON dbo.Documenti_Righe.IDArticolo = dbo.Articoli.ID LEFT OUTER JOIN dbo.CodiciIva ON dbo.Documenti_Righe.CodIva = dbo.CodiciIva.ID LEFT OUTER JOIN dbo.Province ON dbo.Documenti.Provincia = dbo.Province.SiglaProvincia WHERE  (dbo.Documenti.Data BETWEEN CONVERT(DATETIME, '2008-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2008-12-31 23:59:59', 102)) AND (dbo.CodiciIva.ImpEsigibile = 1) AND  (dbo.Documenti_Tipi.ContributoAnalisi <> 0) GROUP BY dbo.CliFor.ProvvigioneDiretta, dbo.CliFor.ProvvigioneIndiretta, dbo.CliFor.Sospeso, dbo.CliFor.Cliente, dbo.Documenti_Righe.Codice, dbo.Articoli.Descrizione1,  dbo.Province.DenominazioneRegione
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[28] 2[6] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Documenti"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 283
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CliFor"
            Begin Extent = 
               Top = 39
               Left = 280
               Bottom = 150
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Documenti_Righe"
            Begin Extent = 
               Top = 4
               Left = 511
               Bottom = 265
               Right = 733
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "Documenti_Tipi"
            Begin Extent = 
               Top = 270
               Left = 522
               Bottom = 385
               Right = 752
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "CodiciIva"
            Begin Extent = 
               Top = 227
               Left = 765
               Bottom = 342
               Right = 954
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Province"
            Begin Extent = 
               Top = 179
               Left = 273
               Bottom = 289
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Articoli"
            Begin Extent = 
               Top = 19
               Left = 796
               Bottom = 151
               Right = 1028
            End
          ', 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_RegioniArticoli', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'  DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 3570
         Alias = 900
         Table = 2940
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_RegioniArticoli', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_RegioniArticoli', NULL, NULL
GO
