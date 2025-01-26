SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qDocumenti_Scadenze] AS
                WITH    DS_Totali ( IDDocumento, Scad_Numero, Scad_Importo, Scad_Pagato )
                            AS ( SELECT   IDDocumento ,
                                        Numero AS Scad_Numero ,
                                        SUM(CASE Tipo
                                                WHEN 1 THEN Importo
                                                ELSE CAST(0 AS MONEY)
                                            END) AS Scad_Importo ,
                                        SUM(CASE Tipo
                                                WHEN -1 THEN Importo
                                                ELSE CAST(0 AS MONEY)
                                            END) AS Scad_Pagato
                                FROM     Documenti_Scadenze
                                GROUP BY IDDocumento ,
                                        Numero
                                ),
                        DS_PagatoDoc ( IDDocumento, Doc_Pagato )
                            AS ( SELECT   IDDocumento ,
                                        SUM(Importo) AS Doc_Pagato
                                FROM     Documenti_Scadenze
                                WHERE    Tipo = -1
                                GROUP BY IDDocumento
                                )
                SELECT  D.* ,
                        MP.Tipo AS Pag_Tipo ,
                        MPT.EmissioneRiba AS Pag_EmissioneRiba ,
                        DS_Totali.* ,
                        DS_PagatoDoc.Doc_Pagato ,
                        ( CASE WHEN ( Scad_Pagato >= Scad_Importo
                                        OR Doc_Pagato >= D.TotLordo
                                    ) THEN 'PT'
                                WHEN Scad_Pagato > 0 THEN 'PP'
                                ELSE 'NP'
                            END ) AS Stato ,
                        DS_Scadenza.Data AS Scad_Data ,
                        ISNULL(DS_Scadenza.BancaCassa, '') AS Scad_BancaCassa ,
                        DS_Scadenza.ID AS IDScadenza ,
                        ISNULL(DS_Scadenza.Insoluto, 0) AS Scad_Insoluto ,
                        ISNULL(DS_Scadenza.RbEsportata, 0) AS Scad_RbEsportata ,
                        DS_Scadenza.RbEsportataData AS Scad_RbEsportataData ,
                        ISNULL(DS_Scadenza.RbBanca, '') AS Scad_RbBanca
                FROM    Documenti D
                        INNER JOIN DS_Totali ON D.ID = DS_Totali.IDDocumento
                        LEFT JOIN DS_PagatoDoc ON D.ID = DS_PagatoDoc.IDDocumento
                        INNER JOIN Documenti_Scadenze DS_Scadenza ON DS_Totali.IDDocumento = DS_Scadenza.IDDocumento
                                                                        AND DS_Scadenza.Numero = DS_Totali.Scad_Numero
                                                                        AND DS_Scadenza.Tipo = 1
                        LEFT JOIN ModalitaPagamento MP ON D.Pag_Modalita = MP.ID
                        LEFT JOIN ModalitaPagamento_Tipi MPT ON MP.Tipo = MPT.ID;
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[25] 2[7] 3) )"
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
         Begin Table = "Documenti_Scadenze"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Documenti"
            Begin Extent = 
               Top = 126
               Left = 248
               Bottom = 245
               Right = 455
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CliFor"
            Begin Extent = 
               Top = 103
               Left = 615
               Bottom = 290
               Right = 802
            End
            DisplayFlags = 280
            TopColumn = 21
         End
         Begin Table = "ModalitaPagamento"
            Begin Extent = 
               Top = 6
               Left = 7
               Bottom = 125
               Right = 200
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ModalitaPagamento_Tipi"
            Begin Extent = 
               Top = 6
               Left = 269
               Bottom = 125
               Right = 466
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Documenti_Tipi"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 365
               Right = 270
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
      Begin ColumnWidths = 34
         Width = 284
        ', 'SCHEMA', N'dbo', 'VIEW', N'qDocumenti_Scadenze', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N' Width = 1500
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
         Width = 1965
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
         Column = 1440
         Alias = 2520
         Table = 1665
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
', 'SCHEMA', N'dbo', 'VIEW', N'qDocumenti_Scadenze', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'qDocumenti_Scadenze', NULL, NULL
GO
