SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO
CREATE FUNCTION [dbo].[ExtractWordsFromHTML] (@htmlSource [nvarchar] (4000), @wordCount [int])
RETURNS [nvarchar] (4000)
WITH EXECUTE AS CALLER
EXTERNAL NAME [SQLHtmlParser].[UserDefinedFunctions].[ExtractWordsFromHTML]
GO
