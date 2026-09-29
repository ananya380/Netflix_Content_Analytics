CREATE DATABASE ott_content_analysis;
USE ott_content_analysis;
CREATE TABLE ott_titles (
    id VARCHAR(20),
    title VARCHAR(255),
    type VARCHAR(20),
    release_year INT,
    release_decade INT,
    age_certification VARCHAR(20),
    runtime DECIMAL(10,2),
    genres_clean TEXT,
    countries_clean TEXT,
    seasons DECIMAL(10,2),
    imdb_score DECIMAL(4,2),
    imdb_votes INT,
    tmdb_popularity DECIMAL(12,3),
    tmdb_score DECIMAL(4,2)
);
SELECT DATABASE();
LOAD DATA LOCAL INFILE 'C:/OTT_Content_Strategy_Analysis/data/cleaned/ott_sql_data.csv'
INTO TABLE ott_titles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, title, type, release_year, release_decade, age_certification,
 runtime, genres_clean, countries_clean, seasons, imdb_score,
 imdb_votes, tmdb_popularity, tmdb_score);
 SELECT COUNT(*) AS total_rows
FROM ott_titles;
SHOW WARNINGS LIMIT 10;
-- 1. Movies vs Shows
SELECT
    type,
    COUNT(*) AS total_titles
FROM ott_titles
GROUP BY type
ORDER BY total_titles DESC;
-- 2. content growth By year
SELECT
    release_year,
    type,
    COUNT(*) AS total_titles
FROM ott_titles
GROUP BY release_year, type
ORDER BY release_year, type;
-- 3. Top Genres
SELECT
    genre,
    COUNT(*) AS total_titles
FROM (
    SELECT 'drama' AS genre
    UNION ALL SELECT 'comedy'
    UNION ALL SELECT 'action'
    UNION ALL SELECT 'thriller'
    UNION ALL SELECT 'romance'
    UNION ALL SELECT 'documentary'
    UNION ALL SELECT 'crime'
    UNION ALL SELECT 'family'
    UNION ALL SELECT 'animation'
    UNION ALL SELECT 'horror'
) AS genres
JOIN ott_titles
    ON LOWER(ott_titles.genres_clean) LIKE CONCAT('%', genres.genre, '%')
GROUP BY genre
ORDER BY total_titles DESC;

-- 4.Average IMDb Rating by Content Type
 SELECT
    type,
    COUNT(imdb_score) AS rated_titles,
    ROUND(AVG(imdb_score), 2) AS average_imdb_rating
FROM ott_titles
GROUP BY type
ORDER BY average_imdb_rating DESC;

-- 5.Top Production countries
SELECT
    country,
    COUNT(*) AS total_titles
FROM (
    SELECT 'US' AS country
    UNION ALL SELECT 'GB'
    UNION ALL SELECT 'IN'
    UNION ALL SELECT 'CA'
    UNION ALL SELECT 'FR'
    UNION ALL SELECT 'JP'
    UNION ALL SELECT 'DE'
    UNION ALL SELECT 'ES'
    UNION ALL SELECT 'KR'
    UNION ALL SELECT 'AU'
) AS countries
JOIN ott_titles
    ON CONCAT(',', REPLACE(ott_titles.countries_clean, ' ', ''), ',')
       LIKE CONCAT('%,', countries.country, ',%')
GROUP BY country
ORDER BY total_titles DESC;
-- 6.High Rated Content By Genre
SELECT
    genre,
    COUNT(*) AS total_titles,
    ROUND(AVG(imdb_score), 2) AS average_imdb_rating
FROM (
    SELECT 'drama' AS genre
    UNION ALL SELECT 'comedy'
    UNION ALL SELECT 'action'
    UNION ALL SELECT 'thriller'
    UNION ALL SELECT 'romance'
    UNION ALL SELECT 'documentary'
    UNION ALL SELECT 'crime'
    UNION ALL SELECT 'family'
    UNION ALL SELECT 'animation'
    UNION ALL SELECT 'horror'
) AS genres
JOIN ott_titles
    ON LOWER(ott_titles.genres_clean) LIKE CONCAT('%', genres.genre, '%')
WHERE ott_titles.imdb_score IS NOT NULL
GROUP BY genre
HAVING COUNT(*) >= 20
ORDER BY average_imdb_rating DESC;

-- 7. Average Movie Runtime
SELECT
    COUNT(runtime) AS movies_with_runtime,
    ROUND(AVG(runtime), 2) AS average_runtime_minutes,
    MIN(runtime) AS shortest_runtime,
    MAX(runtime) AS longest_runtime
FROM ott_titles
WHERE type = 'MOVIE'
  AND runtime IS NOT NULL;
  
-- 8. Show seasons
SELECT
    COUNT(seasons) AS shows_with_season_data,
    ROUND(AVG(seasons), 2) AS average_seasons,
    MIN(seasons) AS minimum_seasons,
    MAX(seasons) AS maximum_seasons
FROM ott_titles
WHERE type = 'SHOW'
  AND seasons IS NOT NULL;
  
  -- 9. Popularity Vs Rating
  SELECT
    title,
    type,
    imdb_score,
    tmdb_popularity
FROM ott_titles
WHERE tmdb_popularity IS NOT NULL
  AND imdb_score IS NOT NULL
ORDER BY tmdb_popularity DESC
LIMIT 20;