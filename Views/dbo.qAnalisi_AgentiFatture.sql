SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qAnalisi_AgentiFatture]
AS
SELECT     dbo.CliFor.IDAgente, dbo.Agenti.Nominativo, dbo.CliFor.ProvvigioneDiretta, dbo.CliFor.ProvvigioneIndiretta, dbo.CliFor.Sospeso, dbo.CliFor.Cliente, 
                      dbo.Documenti.Numero, dbo.Documenti.NumeroPre, dbo.Documenti.NumeroInt, dbo.Documenti.NumeroPos, dbo.Documenti.Data, 
                      dbo.Documenti.Intestazione, dbo.Documenti.TotImp * dbo.Documenti_Tipi.ContributoAnalisi AS TotImp, 
                      dbo.Documenti.TotIva * dbo.Documenti_Tipi.ContributoAnalisi AS TotIva, dbo.Documenti.TotDoc * dbo.Documenti_Tipi.ContributoAnalisi AS TotDoc
FROM         dbo.Documenti INNER JOIN
                      dbo.CliFor ON dbo.Documenti.IDCliFor = dbo.CliFor.ID INNER JOIN
                      dbo.Agenti ON dbo.CliFor.IDAgente = dbo.Agenti.ID INNER JOIN
                      dbo.Documenti_Tipi ON dbo.Documenti.IDTipo = dbo.Documenti_Tipi.ID
WHERE     (dbo.Documenti.Data BETWEEN CONVERT(DATETIME, '2008-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2008-12-31 23:59:59', 102)) AND 
                      (dbo.CliFor.Sospeso = 0) AND (dbo.CliFor.Cliente = 1) AND (dbo.Documenti_Tipi.ContributoAnalisi <> 0)
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[19] 2[19] 3) )"
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
               Top = 13
               Left = 498
               Bottom = 209
               Right = 672
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CliFor"
            Begin Extent = 
               Top = 14
               Left = 264
               Bottom = 187
               Right = 442
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Agenti"
            Begin Extent = 
               Top = 14
               Left = 25
               Bottom = 125
               Right = 203
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Documenti_Tipi"
            Begin Extent = 
               Top = 6
               Left = 710
               Bottom = 121
               Right = 924
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 19
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5850
         Alias = 2715
         Table = 1170
         ', 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_AgentiFatture', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 3360
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_AgentiFatture', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_AgentiFatture', NULL, NULL
GO
