SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [FXML].[sfn_SplitString] (
    @input VARCHAR(MAX),
    @splitter VARCHAR(99)
) RETURNS TABLE
AS
RETURN
    SELECT
        Split.a.value('.', 'VARCHAR(max)') AS Data
    FROM (
        SELECT CAST ('<M>' + REPLACE(@input, @splitter, '</M><M>') + '</M>' AS XML) AS Data 
    ) AS A CROSS APPLY Data.nodes ('/M') AS Split(a);
GO
