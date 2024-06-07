--Channel Analysis
SELECT channelGrouping, country, SUM(productRevenue) AS total_revenue
FROM all_sessions
GROUP BY channelGrouping, country
ORDER BY total_revenue DESC
LIMIT 5;

--User Behavior Analysis
WITH user_metrics AS (
    SELECT fullVisitorId,
           AVG(timeOnSite) AS avg_timeOnSite,
           AVG(pageviews) AS avg_pageviews,
           AVG(sessionQualityDim) AS avg_sessionQualityDim
    FROM all_sessions
    GROUP BY fullVisitorId
),
overall_averages AS (
    SELECT AVG(timeOnSite) AS overall_avg_timeOnSite,
           AVG(pageviews) AS overall_avg_pageviews
    FROM all_sessions
)
SELECT um.fullVisitorId, um.avg_timeOnSite, um.avg_pageviews, um.avg_sessionQualityDim
FROM user_metrics um, overall_averages oa
WHERE um.avg_timeOnSite > oa.overall_avg_timeOnSite
  AND um.avg_pageviews < oa.overall_avg_pageviews;

--Product Performance
SELECT v2ProductName,
       SUM(productRevenue) AS total_revenue,
       SUM(productQuantity) AS total_quantity_sold,
       SUM(productRefundAmount) AS total_refund_amount,
       (SUM(productRevenue) - SUM(productRefundAmount)) AS net_revenue,
       CASE
           WHEN SUM(productRefundAmount) > 0.1 * SUM(productRevenue) THEN 'Flagged'
           ELSE 'Not Flagged'
       END AS refund_flag
FROM all_sessions
GROUP BY v2ProductName
ORDER BY net_revenue DESC;
