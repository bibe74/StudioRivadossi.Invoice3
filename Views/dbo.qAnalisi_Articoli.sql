SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qAnalisi_Articoli] AS SELECT  SUM(dbo.Documenti_Righe.Qta) AS SumQta, dbo.Documenti_Righe.Codice, dbo.Articoli.Descrizione1, SUM(dbo.Documenti_Righe.ImpNetto * dbo.Documenti_Tipi.ContributoAnalisi) AS SumImpNetto,  SUM(dbo.Documenti_Righe.ImpSconto * dbo.Documenti_Tipi.ContributoAnalisi) AS SumImpSconto, SUM(dbo.Documenti_Righe.ImpNettoScontato * dbo.Documenti_Tipi.ContributoAnalisi)  AS SumImpNettoScontato, SUM(dbo.Documenti_Righe.ImpIva * dbo.Documenti_Tipi.ContributoAnalisi) AS SumImpIva, SUM(dbo.Documenti_Righe.ImpLordo * dbo.Documenti_Tipi.ContributoAnalisi)  AS SumImpLordo, dbo.Articoli.IDFamiglia FROM dbo.Documenti INNER JOIN dbo.CliFor ON dbo.Documenti.IDCliFor = dbo.CliFor.ID INNER JOIN dbo.Documenti_Righe ON dbo.Documenti.ID = dbo.Documenti_Righe.IDDocumento INNER JOIN dbo.Documenti_Tipi ON dbo.Documenti.IDTipo = dbo.Documenti_Tipi.ID LEFT OUTER JOIN dbo.Articoli ON dbo.Documenti_Righe.IDArticolo = dbo.Articoli.ID LEFT OUTER JOIN dbo.CodiciIva ON dbo.Documenti_Righe.CodIva = dbo.CodiciIva.ID LEFT OUTER JOIN dbo.Province ON dbo.Documenti.Provincia = dbo.Province.SiglaProvincia WHERE  (dbo.Documenti.Data BETWEEN CONVERT(DATETIME, '2008-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2008-12-31 23:59:59', 102)) AND (dbo.CodiciIva.ImpEsigibile = 1) AND  (dbo.Documenti_Tipi.ContributoAnalisi <> 0) GROUP BY dbo.CliFor.Cliente, dbo.Documenti_Righe.Codice, dbo.Articoli.Descrizione1, dbo.Articoli.IDFamiglia HAVING  (dbo.Documenti_Righe.Codice IS NOT NULL) AND (dbo.CliFor.Cliente = 1)
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
               Bottom = 123
               Right = 245
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CliFor"
            Begin Extent = 
               Top = 125
               Left = 329
               Bottom = 242
               Right = 532
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Documenti_Righe"
            Begin Extent = 
               Top = 6
               Left = 524
               Bottom = 123
               Right = 755
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Documenti_Tipi"
            Begin Extent = 
               Top = 6
               Left = 793
               Bottom = 123
               Right = 1031
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CodiciIva"
            Begin Extent = 
               Top = 6
               Left = 1069
               Bottom = 123
               Right = 1245
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Province"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 243
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         W', 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_Articoli', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'idth = 1500
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
         Column = 1440
         Alias = 900
         Table = 1170
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
', 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_Articoli', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_Articoli', NULL, NULL
GO
