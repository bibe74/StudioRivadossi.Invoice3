SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [Setup].[usp_CreateDocumentiForniture]
AS
    INSERT INTO dbo.Documenti_Forniture ( ID ) VALUES  ( N'Fornitura completa')
GO
