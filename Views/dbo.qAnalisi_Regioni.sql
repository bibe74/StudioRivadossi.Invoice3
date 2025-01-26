SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qAnalisi_Regioni] AS SELECT  DenominazioneRegione, SUM(TotImpDir) AS SumTotImpDir, SUM(TotIvaDir) AS SumTotIvaDir, SUM(TotDocDir) AS SumTotDocDir, SUM(TotImpInd) AS SumTotImpInd, SUM(TotIvaInd) AS SumTotIvaInd,  SUM(TotDocInd) AS SumTotDocInd FROM     (SELECT  dbo.Province.DenominazioneRegione, (CASE CliFor.ProvvigioneDiretta WHEN 1 THEN TotImp * ContributoAnalisi ELSE 0 END) AS TotImpDir,  (CASE CliFor.ProvvigioneDiretta WHEN 1 THEN TotIva * ContributoAnalisi ELSE 0 END) AS TotIvaDir, (CASE CliFor.ProvvigioneDiretta WHEN 1 THEN TotDoc * ContributoAnalisi ELSE 0 END)  AS TotDocDir, (CASE CliFor.ProvvigioneDiretta WHEN 0 THEN TotImp * ContributoAnalisi ELSE 0 END) AS TotImpInd,  (CASE CliFor.ProvvigioneDiretta WHEN 0 THEN TotIva * ContributoAnalisi ELSE 0 END) AS TotIvaInd, (CASE CliFor.ProvvigioneDiretta WHEN 0 THEN TotDoc * ContributoAnalisi ELSE 0 END)  AS TotDocInd FROM     dbo.Documenti INNER JOIN dbo.CliFor ON dbo.Documenti.IDCliFor = dbo.CliFor.ID INNER JOIN dbo.Documenti_Tipi ON dbo.Documenti.IDTipo = dbo.Documenti_Tipi.ID LEFT OUTER JOIN dbo.Province ON dbo.Documenti.Provincia = dbo.Province.SiglaProvincia WHERE  (dbo.CliFor.Sospeso = 0) AND (dbo.CliFor.Cliente = 1) AND (dbo.Documenti.Data BETWEEN CONVERT(DATETIME, '2008-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2008-12-31 23:59:59', 102)) AND (dbo.Documenti_Tipi.ContributoAnalisi <> 0)) AS Aus GROUP BY DenominazioneRegione
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[27] 2[35] 3) )"
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
         Begin Table = "Aus"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 246
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
', 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_Regioni', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_Regioni', NULL, NULL
GO
