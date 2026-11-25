WITH collab_songs AS (
    SELECT song_id
    FROM song_artists
    GROUP BY song_id
    HAVING COUNT(DISTINCT artist_id) > 1
)
SELECT
    a.title AS album,
    ar.name AS artist,
    COUNT(DISTINCT s.song_id) AS collab_count
FROM albums AS a
JOIN artists AS ar ON ar.artist_id = a.artist_id
JOIN songs AS s ON s.album_id = a.album_id
JOIN collab_songs AS cs ON cs.song_id = s.song_id
GROUP BY a.album_id, a.title, ar.name
ORDER BY collab_count DESC, a.album_id
LIMIT 1;