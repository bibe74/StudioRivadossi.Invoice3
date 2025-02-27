SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qAnalisi_Inventario]
AS
SELECT     dbo.Articoli.ID, dbo.Articoli.IDFamiglia, dbo.Articoli.Codice, dbo.Articoli.Descrizione1, dbo.Articoli.Descrizione2, dbo.Articoli.Descrizione3, dbo.Articoli.Descrizione4, 
                      dbo.Articoli_Movimenti.IDMagazzino, dbo.Magazzini.Descrizione AS DescrizioneMagazzino, SUM(dbo.Articoli_Movimenti.Qta) AS Esistenza
FROM         dbo.Magazzini INNER JOIN
                      dbo.Articoli_Movimenti ON dbo.Magazzini.ID = dbo.Articoli_Movimenti.IDMagazzino INNER JOIN
                      dbo.Articoli ON dbo.Articoli_Movimenti.IDArticolo = dbo.Articoli.ID
GROUP BY dbo.Articoli.ID, dbo.Articoli.IDFamiglia, dbo.Articoli.Codice, dbo.Articoli.Descrizione1, dbo.Articoli.Descrizione2, dbo.Articoli.Descrizione3, dbo.Articoli.Descrizione4, 
                      dbo.Articoli_Movimenti.IDMagazzino, dbo.Magazzini.Descrizione
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[10] 3) )"
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
         Begin Table = "Magazzini"
            Begin Extent = 
               Top = 93
               Left = 751
               Bottom = 197
               Right = 911
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Articoli_Movimenti"
            Begin Extent = 
               Top = 5
               Left = 415
               Bottom = 322
               Right = 606
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Articoli"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 291
               Right = 234
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
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1845
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
', 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_Inventario', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_Inventario', NULL, NULL
GO
