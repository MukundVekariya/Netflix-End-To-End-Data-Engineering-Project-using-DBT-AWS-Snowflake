WITH raw_links AS (
    SELECT * FROM MOVIELENS.RAW.RAW_LINKS
)

SELECT
    movieId AS movie_id,
    imdbID AS imdb_id,
    tmdbID AS tmdb_id,
FROM raw_links