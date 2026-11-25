WITH song_listens AS (
    SELECT
        s.song_id,
        COUNT(ll.song_id) AS listens
    FROM songs AS s
    LEFT JOIN listening_logs AS ll ON ll.song_id = s.song_id
    GROUP BY s.song_id
),
ranked_songs AS (
    SELECT
        song_id,
        ROW_NUMBER() OVER (
            ORDER BY listens DESC, song_id
        ) AS position,
        COUNT(*) OVER () AS total_songs
    FROM song_listens
),
top_songs AS (
    SELECT song_id
    FROM ranked_songs
    WHERE position <= (total_songs + 4) / 5
)
SELECT
    ar.name AS artist,
    COUNT(DISTINCT ts.song_id) AS top_songs
FROM top_songs AS ts
JOIN song_artists AS sa ON sa.song_id = ts.song_id
JOIN artists AS ar ON ar.artist_id = sa.artist_id
GROUP BY ar.artist_id, ar.name
ORDER BY top_songs DESC
LIMIT 1;