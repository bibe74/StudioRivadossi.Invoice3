SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qAnalisi_RegioniClienti] AS SELECT     dbo.Province.DenominazioneRegione, dbo.CliFor.ProvvigioneDiretta, dbo.CliFor.ProvvigioneIndiretta, dbo.CliFor.Sospeso, dbo.CliFor.Cliente, dbo.CliFor.Intestazione,  SUM(dbo.Documenti.TotImp * dbo.Documenti_Tipi.ContributoAnalisi) AS SumTotImp, SUM(dbo.Documenti.TotIva * dbo.Documenti_Tipi.ContributoAnalisi) AS SumTotIva, SUM(dbo.Documenti.TotDoc * dbo.Documenti_Tipi.ContributoAnalisi) AS SumTotDoc, dbo.CliFor.IDCliFor_Categoria, (SELECT     TOP (1) Dato FROM          dbo.CliFor_Riferimenti WHERE      (IDCliFor = dbo.CliFor.ID) AND (Tipo = 'Telefono')) AS Telefono, (SELECT     TOP (1) Dato FROM          dbo.CliFor_Riferimenti AS CliFor_Riferimenti_3 WHERE      (IDCliFor = dbo.CliFor.ID) AND (Tipo = 'Fax')) AS Fax, (SELECT     TOP (1) Dato FROM          dbo.CliFor_Riferimenti AS CliFor_Riferimenti_2 WHERE      (IDCliFor = dbo.CliFor.ID) AND (Tipo = 'E-mail')) AS Email, (SELECT     TOP (1) Dato FROM          dbo.CliFor_Riferimenti AS CliFor_Riferimenti_1 WHERE      (IDCliFor = dbo.CliFor.ID) AND (Tipo = 'Cellulare')) AS Cellulare, dbo.CliFor.Indirizzo, dbo.CliFor.Cap, dbo.CliFor.Comune, dbo.CliFor.Provincia FROM         dbo.Documenti INNER JOIN dbo.CliFor ON dbo.Documenti.IDCliFor = dbo.CliFor.ID INNER JOIN dbo.Documenti_Tipi ON dbo.Documenti.IDTipo = dbo.Documenti_Tipi.ID LEFT OUTER JOIN dbo.Province ON dbo.CliFor.Provincia = dbo.Province.SiglaProvincia WHERE     (dbo.Documenti.Data BETWEEN CONVERT(DATETIME, '2008-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2008-12-31 23:59:59', 102)) AND  (dbo.Documenti.TotImp <> 0) GROUP BY dbo.CliFor.ID, dbo.CliFor.Intestazione, dbo.CliFor.ProvvigioneDiretta, dbo.CliFor.ProvvigioneIndiretta, dbo.CliFor.Sospeso, dbo.CliFor.Cliente,  dbo.Province.DenominazioneRegione, dbo.CliFor.IDCliFor_Categoria, dbo.Documenti_Tipi.ContributoAnalisi, dbo.CliFor.Indirizzo, dbo.CliFor.Cap, dbo.CliFor.Comune,  dbo.CliFor.Provincia HAVING      (dbo.CliFor.Sospeso = 0) AND (dbo.CliFor.Cliente = 1) AND (dbo.Documenti_Tipi.ContributoAnalisi <> 0)
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[41] 2[14] 3) )"
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
               Bottom = 117
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CliFor"
            Begin Extent = 
               Top = 6
               Left = 266
               Bottom = 164
               Right = 460
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Province"
            Begin Extent = 
               Top = 6
               Left = 730
               Bottom = 174
               Right = 941
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Documenti_Tipi"
            Begin Extent = 
               Top = 137
               Left = 73
               Bottom = 252
               Right = 303
            End
            DisplayFlags = 280
            TopColumn = 4
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
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 4080
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350', 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_RegioniClienti', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_RegioniClienti', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'qAnalisi_RegioniClienti', NULL, NULL
GO
