SELECT
    g.name AS genre,
    l.region AS region,
    COUNT(*) AS total_listens
FROM listening_logs AS l
JOIN song_genres AS sg ON sg.song_id = l.song_id
JOIN genres AS g ON g.genre_id = sg.genre_id
GROUP BY g.genre_id, g.name, l.region
ORDER BY genre, region;