SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_refresh_all_views]
(
       @SkipSchemas NVARCHAR(127) = N'' -- Comma-separated list. Add a comma at the end (e.g. 'AS400,AX2009,')
) AS
BEGIN

       -- This sp will refresh all views in the catalog. 
       --     It enumerates all views, and runs sp_RefreshView for each of them

       DECLARE abc CURSOR FOR
       SELECT TABLE_SCHEMA + N'.' + TABLE_NAME AS ViewName
       FROM INFORMATION_SCHEMA.VIEWS
       WHERE CHARINDEX(TABLE_SCHEMA + N',', COALESCE(@SkipSchemas, N'')) = 0
       ORDER BY TABLE_SCHEMA,
             TABLE_NAME;
       OPEN abc;

       DECLARE @ViewName VARCHAR(261);

       -- Build select string
       DECLARE @SQLString NVARCHAR(2048);

       FETCH NEXT FROM abc INTO @ViewName;

       WHILE @@FETCH_STATUS = 0 
       BEGIN
             SET @SQLString = 'EXECUTE sp_RefreshView ''' + @ViewName + '''';
             --PRINT @SQLString

             BEGIN TRY
                    EXECUTE sp_ExecuteSQL @SQLString;

                    --PRINT 'OK ==> ' + @SQLString;
             END TRY
             BEGIN CATCH
                    IF (@@TRANCOUNT > 0) ROLLBACK;

                    PRINT 'KO ==> ' + @SQLString;
             END CATCH

             FETCH NEXT FROM abc INTO @ViewName;
       END;

       CLOSE abc;
       DEALLOCATE abc;

END;


GO
