SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[RenderTodaysForumPosts] ()
RETURNS 
@Results TABLE (Html Varchar(MAX), PlainText Varchar(MAX))
AS
BEGIN
	DECLARE @UrlRoot VARCHAR(100)
	SET @UrlRoot = 'http://www.sqlservercentral.com'

	DECLARE @LineBreak CHAR(2)
	SET @LineBreak = CHAR(13) + CHAR(10)

	DECLARE @ResultHTML VARCHAR(MAX)
	DECLARE @ResultPlainText VARCHAR(MAX)
	SET @ResultHTML = ''
	SET @ResultPlainText = ''

	DECLARE @HorizontalRule VARCHAR(MAX)
	SET @HorizontalRule = '<hr style="display: block; clear: both; height: 1px; border: 0; border-top: 1px solid #dddddd; margin: 8px 0; padding: 0;"/>'
	
	DECLARE @ParentForumSortOrder TABLE (ForumId INT, SortOrder int)
	INSERT INTO @ParentForumSortOrder SELECT ForumId, SortOrder FROM SQLServerCentralForums.dbo.InstantForum_Forums WHERE ParentID = 0
	
	DECLARE post CURSOR FAST_FORWARD FOR 
	SELECT rft.PostID, rft.UserID, rft.Username, rft.DateStamp, rft.Title, rft.MESSAGE, rft.ForumID, rft.ForumName, rft.ParentForumID, rft.ParentForumName
	FROM SQLServerCentralForums.dbo.RecentForumTopics rft
	JOIN SQLServerCentralForums.dbo.InstantForum_Forums all_forums_sort_order ON all_forums_sort_order.ForumID = rft.ForumID
	JOIN @ParentForumSortOrder ParentForumSortOrder ON all_forums_sort_order.ParentID = ParentForumSortOrder.ForumID
	ORDER BY ParentForumSortOrder.SortOrder, all_forums_sort_order.SortOrder ASC, rft.DateStamp DESC
	OPEN post

	DECLARE @PostID INT
	DECLARE @UserID INT
	DECLARE @Username VARCHAR(MAX)
	DECLARE @DateStamp DATETIME
	DECLARE @Title VARCHAR(MAX)
	DECLARE @Message VARCHAR(MAX)
	DECLARE @ForumID INT
	DECLARE @ForumName VARCHAR(MAX)
	DECLARE @ParentForumID INT
	DECLARE @ParentForumName VARCHAR(MAX)
	DECLARE @LastForumID INT
	SET @LastForumID = -1
	FETCH NEXT FROM post INTO @PostID, @UserID, @Username, @DateStamp, @Title, @Message, @ForumID, @ForumName, @ParentForumID, @ParentForumName
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @LastForumID <> @ForumID
		BEGIN
			-- Insert forum title link
			DECLARE @ForumURL VARCHAR(MAX)
			DECLARE @ParentForumURL VARCHAR(MAX)
			SET @ForumURL = @UrlRoot + '/Forums/Forum' + CAST(@ForumID AS VARCHAR(20)) + '-1.aspx'

			-- Render HTML version
			DECLARE @ParentForumLink VARCHAR(MAX)
			DECLARE @ForumLink VARCHAR(MAX)
			SET @ForumLink = '<a href="' + @ForumURL + '" style="color: #1c3664; font-weight: bold; font-family: Helvetica, Arial, sans-serif; font-size: 14px; text-decoration: underline;">' + @ForumName + '</a>'
			IF @ParentForumID IS NULL
				SET @ParentForumLink = NULL
			ELSE
				SET @ParentForumLink = '<a href="' + @UrlRoot + '/Forums/Forum' + CAST(@ParentForumID AS VARCHAR(20)) + '-1.aspx" style="color: #1c3664; font-weight: bold; font-family: Helvetica, Arial, sans-serif; font-size: 14px; text-decoration: underline;">' + @ParentForumName + '</a>'
			SET @ResultHTML = @ResultHTML + @HorizontalRule + '<h4 style="text-align: left;">' + (CASE WHEN @ParentForumLink IS NULL THEN '' ELSE @ParentForumLink + ' : ' END) + @ForumLink + '</h4> '
			SET @ResultHTML = @ResultHTML + @LineBreak

			-- Render plain text version
			SET @ResultPlainText = @ResultPlainText + @LineBreak + @LineBreak
			DECLARE @Line VARCHAR(MAX)
			SET @Line = UPPER(@ForumName) + ' (' + @ForumURL + ')'
			SET @ResultPlainText = @ResultPlainText + @Line + @LineBreak
			SET @ResultPlainText = @ResultPlainText + REPLICATE('-', LEN(@Line)) + @LineBreak
		END	

		-- Clean the post HTML
		IF LEN(@Message) > 400 
			SELECT @Message = SUBSTRING(@Message, 1, 400)
		SELECT @Message = [SqlServerCentral].[dbo].[ExtractWordsFromHTML](@Message, 20)
		SELECT @Message = REPLACE(@Message, '<BR/>', ' ')

		-- Get some parameters relating to this post
		DECLARE @PostURL VARCHAR(MAX)
		SET @PostURL = @UrlRoot + '/Forums/FindPost' + CAST(@PostID AS VARCHAR(20)) + '.aspx'

		-- Render HTML version
		SET @ResultHTML = @ResultHTML + '<p>' + @LineBreak
		SET @ResultHTML = @ResultHTML + '<a href="' + @PostURL + '" style="color: #1c3664; font-weight: bold; font-family: Helvetica, Arial, sans-serif; font-size: 12px; text-decoration: underline;">' + @Title + '</a>' + @LineBreak
		SET @ResultHTML = @ResultHTML + ' - ' + @Message
		SET @ResultHTML = @ResultHTML + '</p>' + @LineBreak

		-- Render plain text version, using ugly multiple-string-replacement to approximate plain-text version of HTML post
		SET @ResultPlainText = @ResultPlainText + @LineBreak
		SET @ResultPlainText = @ResultPlainText + UPPER(@Title) + ' - ' + REPLACE(REPLACE(REPLACE(REPLACE(@Message, '<P>', ' '), '<BR>', @LineBreak), '</P>', ''), '&nbsp;', ' ') + @LineBreak
		SET @ResultPlainText = @ResultPlainText + '(' + @PostURL + ')' + @LineBreak

		SET @LastForumID = @ForumID
		FETCH NEXT FROM post INTO @PostID, @UserID, @Username, @DateStamp, @Title, @Message, @ForumID, @ForumName, @ParentForumID, @ParentForumName
	END

	CLOSE post
	DEALLOCATE post

	-- Return the results
	INSERT INTO @Results SELECT @ResultHTML, @ResultPlainText
	RETURN
END
GO
GRANT SELECT ON  [dbo].[RenderTodaysForumPosts] TO [Emailer]
GO
GRANT SELECT ON  [dbo].[RenderTodaysForumPosts] TO [ssc_emailer]
GO
GRANT SELECT ON  [dbo].[RenderTodaysForumPosts] TO [ssc_webapplication]
GO
