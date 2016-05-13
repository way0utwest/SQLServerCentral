SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetRollingStats]
 AS
 BEGIN
     SELECT TOP 3
     ss.StatMonth
     ,ss.StatYear
     ,ss.PageVisits
     ,ss.TimeOnSite
     ,ss.Engagement
	 , 'EngagementChange' = ISNULL(Engagement - LAG(ss.Engagement, 1) OVER (ORDER BY (SELECT NULL)), 0)
	  FROM dbo.SiteStats AS ss
	  ORDER BY ss.StatYear DESC, ss.StatMonth desc
 END
GO
