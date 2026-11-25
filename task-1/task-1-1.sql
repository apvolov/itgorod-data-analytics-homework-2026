SELECT
    a.title AS album,
    ar.name AS artist,
    COUNT(*) AS listens
FROM listening_logs AS ll
JOIN songs AS s ON s.song_id = ll.song_id
JOIN albums AS a ON a.album_id = s.album_id
JOIN artists AS ar ON ar.artist_id = a.artist_id
WHERE EXISTS (
    SELECT 1
    FROM song_genres AS sg
    JOIN genres AS g ON g.genre_id = sg.genre_id
    WHERE sg.song_id = s.song_id
      AND g.name = 'Rock'
)
GROUP BY a.album_id, a.title, ar.artist_id, ar.name
ORDER BY listens DESC
LIMIT 1;