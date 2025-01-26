SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qDocumenti] AS
                SELECT  D.ID ,
                        D.IDTipo ,
                        D.IDCliFor ,
                        D.IDMagazzino ,
                        D.IDStato ,
                        D.Numero ,
                        D.NumeroPre ,
                        D.NumeroInt ,
                        D.NumeroPos ,
                        D.Data ,
                        D.CF ,
                        D.PI ,
                        D.Intestazione ,
                        D.Intestazione2 ,
                        D.Indirizzo ,
                        D.Cap ,
                        D.Comune ,
                        D.Provincia ,
                        D.Nazione ,
                        D.Pag_Modalita ,
                        MP.Tipo AS Pag_Tipo ,
                        D.Pag_CalcolaImporti ,
                        D.Pag_Banca ,
                        D.Pag_Cin ,
                        D.Pag_Abi ,
                        D.Pag_Cab ,
                        D.Pag_Cc ,
                        D.Pag_Iban ,
                        D.Pag_Bic ,
                        D.IDCliFor_Indirizzo ,
                        D.Dest_Intestazione ,
                        D.Dest_Intestazione2 ,
                        D.Dest_Indirizzo ,
                        D.Dest_Cap ,
                        D.Dest_Comune ,
                        D.Dest_Provincia ,
                        D.Dest_Nazione ,
                        D.Note ,
                        D.SoggettoRitAcc ,
                        D.TotRighe ,
                        D.Inps ,
                        D.TotImp ,
                        D.TotIva ,
                        D.TotLordo ,
                        D.RitAcc ,
                        D.TotDoc ,
                        C.Descrizione AS Causale ,
                        C.Fatturare ,
                        D.IDCausale ,
                        SUM(DS.Importo) AS TotPagato
                FROM    Documenti D
                        LEFT OUTER JOIN Causali C ON D.IDCausale = C.ID
                        LEFT OUTER JOIN Documenti_Scadenze DS ON D.ID = DS.IDDocumento
                                                                    AND DS.Tipo = -1
                        LEFT OUTER JOIN ModalitaPagamento MP ON D.Pag_Modalita = MP.ID
                GROUP BY D.ID ,
                        D.IDTipo ,
                        D.IDCliFor ,
                        D.IDMagazzino ,
                        D.IDStato ,
                        D.Numero ,
                        D.NumeroPre ,
                        D.NumeroInt ,
                        D.NumeroPos ,
                        D.Data ,
                        D.CF ,
                        D.PI ,
                        D.Intestazione ,
                        D.Intestazione2 ,
                        D.Indirizzo ,
                        D.Cap ,
                        D.Comune ,
                        D.Provincia ,
                        D.Nazione ,
                        D.Pag_Modalita ,
                        MP.Tipo ,
                        D.Pag_CalcolaImporti ,
                        D.Pag_Banca ,
                        D.Pag_Cin ,
                        D.Pag_Abi ,
                        D.Pag_Cab ,
                        D.Pag_Cc ,
                        D.Pag_Iban ,
                        D.Pag_Bic ,
                        D.IDCliFor_Indirizzo ,
                        D.Dest_Intestazione ,
                        D.Dest_Intestazione2 ,
                        D.Dest_Indirizzo ,
                        D.Dest_Cap ,
                        D.Dest_Comune ,
                        D.Dest_Provincia ,
                        D.Dest_Nazione ,
                        D.Note ,
                        D.SoggettoRitAcc ,
                        D.TotRighe ,
                        D.Inps ,
                        D.TotImp ,
                        D.TotIva ,
                        D.TotLordo ,
                        D.RitAcc ,
                        D.TotDoc ,
                        C.Descrizione ,
                        C.Fatturare ,
                        D.IDCausale;
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[27] 2[11] 3) )"
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
               Bottom = 114
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Documenti_Scadenze"
            Begin Extent = 
               Top = 6
               Left = 266
               Bottom = 114
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ModalitaPagamento"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Causali"
            Begin Extent = 
               Top = 138
               Left = 272
               Bottom = 240
               Right = 448
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
      Begin ColumnWidths = 42
         Width = 284
         Width = 2790
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
 ', 'SCHEMA', N'dbo', 'VIEW', N'qDocumenti', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'        Width = 1500
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
      Begin ColumnWidths = 12
         Column = 1590
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
', 'SCHEMA', N'dbo', 'VIEW', N'qDocumenti', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'qDocumenti', NULL, NULL
GO
