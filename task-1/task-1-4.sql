SELECT
    strftime('%Y-%m', listen_time) AS year_month,
    COUNT(*) AS total_listens
FROM listening_logs
GROUP BY strftime('%Y-%m', listen_time)
ORDER BY year_month;