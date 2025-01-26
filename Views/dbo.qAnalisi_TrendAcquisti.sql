SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[qAnalisi_TrendAcquisti] AS WITH MESE(IDTipoDoc, Anno, Mese, Imp, NumDoc) AS
	(
	SELECT	IDTipo AS IDTipoDoc,
			YEAR(Data) AS Anno, 
			MONTH(Data) AS Mese, 
			SUM(TotImp) AS Imp,
			COUNT(1) 
	FROM	dbo.Documenti 
  WHERE   IDTipo='For_Fattura'	GROUP BY IDTipo,
	        YEAR(Data), 
			MONTH(Data)
	)
SELECT  *,
		CASE WHEN ImpMeseAnnoPrec=0 THEN 1 ELSE ImpMese/ImpMeseAnnoPrec-1 END IncrementoMesePerc,
		CASE WHEN ImpProgressivoAnnoPrec=0 THEN 1 ELSE ImpProgressivo/ImpProgressivoAnnoPrec-1 END IncrementoProgressivoPerc
		--(ImpMese-ImpMeseAnnoPrec)/ImpMese IncrementoMesePerc,
		--(ImpProgressivo-ImpProgressivoAnnoPrec)/ImpProgressivo IncrementoProgressivoPerc
FROM
	(
	SELECT	M.IDTipoDoc,
			M.Anno,
			M.Mese,
			M.NumDoc,
			ISNULL(M1.NumDoc,0) NumDocAnnoPrec,
			M.Imp ImpMese,
			ISNULL(M1.Imp,0) ImpMeseAnnoPrec,
			--(M.Imp-ISNULL(M1.Imp,0))/M.Imp IncrementoMesePerc,
			ISNULL((SELECT SUM(Imp) FROM MESE WHERE Anno=M.Anno AND Mese<=M.Mese),0) ImpProgressivo,
			ISNULL((SELECT SUM(Imp) FROM MESE WHERE Anno=M.Anno-1 AND Mese<=M.Mese),0) ImpProgressivoAnnoPrec
	FROM	MESE M
			LEFT JOIN MESE M1 ON M1.IDTipoDoc=M.IDTipoDoc AND M1.Anno=M.Anno-1 AND M1.Mese=M.Mese 
	) TREND

GO
