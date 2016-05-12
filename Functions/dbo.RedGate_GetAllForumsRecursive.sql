SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[RedGate_GetAllForumsRecursive] 
(
	@RootForumID AS INT = 0,
	@RowIndex AS INT = 0
)
RETURNS @Table_Var TABLE (RowIndex INT, ForumID INT, ParentForumID INT, [Name] VARCHAR(MAX))
AS
BEGIN
	-- Produces a list of all forums, in the same order as displayed on the site
	-- The hierarchy is traversed via recursive calls
	-- Note we can't use the CROSS APPLY optimisation because it's not supported in Compatibility Level 80 (SQL 2000)
	DECLARE @ChildID INT
	DECLARE eachChild CURSOR LOCAL FAST_FORWARD FOR
		SELECT child.ForumID FROM SSCFORUMS.SqlServerCentralForums.dbo.[InstantForum_Forums] child 
		WHERE child.[ParentID] = @RootForumID 
		ORDER BY child.SortOrder	
	OPEN eachChild
		FETCH NEXT FROM eachChild INTO @ChildID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT INTO @Table_Var 
			SELECT @RowIndex, frm.ForumID, frm.ParentID, (CASE WHEN frm_parent.[Name] IS NULL THEN '' ELSE frm_parent.[Name] + ' : ' END) + frm.[Name] 
			FROM SSCFORUMS.SqlServerCentralForums.dbo.[InstantForum_Forums] frm
			LEFT OUTER JOIN SSCFORUMS.SqlServerCentralForums.dbo.[InstantForum_Forums] frm_parent ON frm.[ParentID]=frm_parent.[ForumID]
			WHERE frm.[ForumID]=@ChildID
			SELECT @RowIndex = 1 + @RowIndex

			INSERT INTO @Table_Var SELECT RowIndex, ForumID, ParentForumID, [Name] FROM RedGate_GetAllForumsRecursive(@ChildID, @RowIndex)
			SELECT @RowIndex = @@ROWCOUNT + @RowIndex

			FETCH NEXT FROM eachChild INTO @ChildID	
		END
	CLOSE eachChild
	DEALLOCATE eachChild

	RETURN 
END

GO
