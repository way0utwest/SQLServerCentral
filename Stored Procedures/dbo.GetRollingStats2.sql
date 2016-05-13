SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetRollingStats]
 AS
 BEGIN
 WITH statCTE
 AS 
 (
     SELECT TOP 3
     ss.StatMonth
     ,ss.StatYear
     ,ss.PageVisits
     ,ss.TimeOnSite
     ,ss.Engagement
	 , 'DailyAverage' = ss.Engagement / DAY(EOMONTH(CAST( CAST(StatMonth AS varCHAR(2)) + '/01/' + CAST(statyear AS CHAR(4)) AS DATE)))
	  FROM dbo.SiteStats AS ss
 )
 SELECT *
	 , 'EngagementChange' = ISNULL(statCTE.DailyAverage - LAG(statCTE.DailyAverage, 1) OVER (ORDER BY (SELECT NULL)), 0)
  FROM statCTE
  ORDER BY StatYear DESC, StatMonth desc
 END
GO
