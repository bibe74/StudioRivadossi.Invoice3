SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[usp_DocumentInfo](
	@idTipo NVARCHAR(20),
	@numero NVARCHAR(20),
	@data	DATE
) AS
BEGIN
	DECLARE @doc TABLE (ID UNIQUEIDENTIFIER NOT NULL);
	INSERT INTO @doc
	(
	    ID
	)
	SELECT ID FROM dbo.Documenti D WHERE (@idTipo = '' OR D.IDTipo = @idTipo)
	AND D.Numero = @numero
	AND D.Data = @data;

	SELECT 'Documenti' AS TableName, * FROM dbo.Documenti D INNER JOIN @doc D2 ON D2.ID = D.ID ORDER BY D.Data, D.Numero;
	SELECT 'Documenti_Righe' AS TableName, * FROM dbo.Documenti_Righe DR INNER JOIN @doc D ON D.ID = DR.IDDocumento ORDER BY DR.Posizione;
	SELECT 'Documenti_Spese' AS TableName, * FROM dbo.Documenti_Spese DS INNER JOIN @doc D ON D.ID = DS.IDDocumento ORDER BY DS.Posizione;
	SELECT 'Documenti_Iva' AS TableName, * FROM dbo.Documenti_Iva DI INNER JOIN @doc D ON D.ID = DI.IDDocumento ORDER BY DI.CodIva;
	SELECT 'Documenti_Scadenze' AS TableName, * FROM dbo.Documenti_Scadenze DS INNER JOIN @doc D ON D.ID = DS.IDDocumento ORDER BY DS.Data;
END
GO
