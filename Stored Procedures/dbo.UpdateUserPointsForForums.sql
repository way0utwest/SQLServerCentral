SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[UpdateUserPointsForForums] 
	-- Updates the point count for users who've scored any points in the last @RecentThresholdMinutes minutes
	@RecentThresholdMinutes int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	; WITH RecentlyChangedPoints (IFUserID, TotalPoints) AS (
		SELECT  iau.UserID,
			SUM([PointsScored])
		FROM (SELECT DISTINCT UserID FROM UserPoints WHERE (@RecentThresholdMinutes=0) or ([Date] > DATEADD(minute, -1*@RecentThresholdMinutes, GETDATE()) AND date < GETDATE())) rpu
		JOIN [UserPoints] up ON rpu.[UserID] = up.[UserID]
		JOIN [Users] u ON u.[UserID] = up.[UserID]
		JOIN SSCFORUMS.SqlServerCentralForums.dbo.InstantASP_Users iau ON iau.[EmailAddress]=u.EmailAddress
		GROUP BY iau.UserID)
	UPDATE ifu SET PostCount = rcp.TotalPoints
	FROM SSCFORUMS.SqlServerCentralForums.dbo.InstantForum_Users ifu
	JOIN RecentlyChangedPoints rcp ON rcp.IFUserID = ifu.UserID
END

GO
