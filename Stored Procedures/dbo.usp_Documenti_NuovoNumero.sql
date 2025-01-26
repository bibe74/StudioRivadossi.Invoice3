SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_Documenti_NuovoNumero] 
	-- Add the parameters for the stored procedure here
	@IDTipo nvarchar(20) = '',
	@Anno int = NULL,
	@NumeroPre nvarchar(10) = NULL,
	@NumeroPos nvarchar(10) = NULL,
	@NumeroCifre int = NULL,
	@NumeroInt int OUTPUT,
	@Numero nvarchar(20) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	BEGIN TRAN

	--parametri numero
	IF @NumeroPre IS NULL SET @NumeroPre='';
	IF @NumeroPos IS NULL SET @NumeroPos='';
	IF @NumeroCifre IS NULL SET @NumeroCifre=0;

	--controllo anno
	IF @Anno IS NULL SELECT @Anno=YEAR(GETDATE());

	--ultimo doc. del tipo indicato (inclusi pre e pos)
	IF @NumeroPre='' AND @NumeroPos='' 
		BEGIN
			-- PRINT 'Pre=null, Pos=null';
			SELECT @NumeroInt=(SELECT MAX(NumeroInt) FROM Documenti WHERE IDTipo=@IDTipo AND YEAR(Data)=@Anno);
		END
	ELSE IF @NumeroPre<>'' AND @NumeroPos=''
		BEGIN	
			-- PRINT 'Pre!=null, Pos=null';
			SELECT @NumeroInt=(SELECT MAX(NumeroInt) FROM Documenti WHERE IDTipo=@IDTipo AND NumeroPre=@NumeroPre AND YEAR(Data)=@Anno);
		END	
	ELSE IF @NumeroPre='' AND @NumeroPos<>''
	    BEGIN	
	        -- PRINT 'Pre=null, Pos=!null';
	        SELECT @NumeroInt=(SELECT MAX(NumeroInt) FROM Documenti WHERE IDTipo=@IDTipo AND NumeroPos=@NumeroPos AND YEAR(Data)=@Anno);
	    END
	ELSE
		BEGIN
			-- PRINT 'Pre!=null, Pos!=null';
			SELECT @NumeroInt=(SELECT MAX(NumeroInt) FROM Documenti WHERE IDTipo=@IDTipo AND NumeroPre=@NumeroPre AND NumeroPos=@NumeroPos AND YEAR(Data)=@Anno);
		END

	--prossimo numero intero
	IF @NumeroInt IS NULL SELECT @NumeroInt = 1;
	ELSE SELECT @NumeroInt=@NumeroInt + 1;

	--costruisco stringa numero = pre + int (formattato) + pos
	-- PRINT 'costruisco numero...';
	IF @NumeroPre IS NULL SELECT @Numero = '' ELSE SELECT @Numero = @NumeroPre; 

	-- PRINT 'numero: ' + CONVERT(nvarchar,@Numero);
	IF (@NumeroCifre IS NULL OR @NumeroCifre=0)
		BEGIN
			SELECT @Numero = @Numero + CONVERT(varchar,@NumeroInt);
			-- PRINT 'numero: ' + CONVERT(nvarchar,@Numero);
		END
	ELSE
		BEGIN
			SELECT @Numero = @Numero + RIGHT('0000000000' + CONVERT(varchar,@NumeroInt),@NumeroCifre);
			-- PRINT 'numero: ' + CONVERT(nvarchar,@Numero);
		END
	IF NOT (@NumeroPos IS NULL) SELECT @Numero = @Numero + @NumeroPos;
	-- PRINT 'numero: ' + CONVERT(nvarchar,@Numero);

	COMMIT TRAN
END
GO
