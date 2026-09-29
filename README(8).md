# Netflix Content Analytics

### Content Trends • Audience Signals • Catalog Insights

An end-to-end Data Analytics portfolio project analyzing a Netflix catalog dataset using **Python, SQL, Excel, and Power BI**.

## Project Overview

This project explores Netflix catalog composition, release trends, genres, production countries, ratings, popularity signals, movie runtime, and show seasons.

> **Dataset scope:** The source is a Netflix catalog snapshot representing titles available in the U.S. as of May 2022. Findings should not be interpreted as a current 2026 Netflix catalog or as industry-wide OTT statistics.

## Business Questions

- What is the mix of movies and shows?
- How does content distribution change over release years and decades?
- Which genres and production countries are most represented?
- How are IMDb ratings distributed?
- How do IMDb ratings relate to TMDB popularity?
- What are the runtime patterns for movies?
- What are the season patterns for shows?

## Dataset

Source: `amirtds/kaggle-netflix-tv-shows-and-movies` on GitHub.

Key fields include: `title`, `type`, `release_year`, `age_certification`, `genres`, `production_countries`, `runtime`, `seasons`, `imdb_score`, `imdb_votes`, `tmdb_popularity`, `tmdb_score`.

### Cleaned dataset

- Original rows: 5,806
- Final cleaned rows: 5,805
- Final analytical columns: 22

## Data Preparation

- Removed the record with a missing title.
- Treated zero runtime as missing for runtime analysis.
- Filled missing age certification with `Not Rated`.
- Parsed genre and production-country list fields.
- Created `release_decade`.
- Created `content_age`.
- Created `is_high_rated` using IMDb score >= 7.

## Key Metrics

| Metric | Value |
|---|---:|
| Total Titles | 5,805 |
| Movies | ~3,759 |
| Shows | ~2,046 |
| Average IMDb Rating | ~6.53 |
| High-Rated Titles | ~2,064 |

## Power BI Dashboard

1. Content Mix
2. Content Growth Over Time
3. Top 10 Genres
4. Top 10 Production Countries
5. Average IMDb Rating by Content Type
6. IMDb Rating Distribution
7. IMDb Rating vs TMDB Popularity
8. Content Distribution by Release Decade
9. Movie Runtime Distribution
10. Show Seasons Distribution

### Interactivity

- Content Type slicer
- Release Year slicer
- Age Certification slicer
- Release Decade slicer
- Reset Filters button

## Tools & Technologies

- **Python:** Pandas, Matplotlib, Seaborn
- **SQL:** MySQL
- **Excel:** Data validation and summary analysis
- **Power BI:** Interactive dashboard and data storytelling
- **GitHub:** Version control and documentation

## Repository Structure

```text
Netflix_Content_Analytics/
├── data/
│   ├── raw/
│   │   └── titles.csv
│   └── cleaned/
│       └── ott_titles_cleaned.csv
├── notebooks/
│   └── OTT_Content_Analysis.ipynb
├── sql/
│   └── ott_content_analysis.sql
├── powerbi/
│   └── Netflix_Content_Strategy_Analysis.pbix
├── visuals/
├── reports/
│   └── Netflix_Content_Analytics_Report.pdf
└── README.md
```

## Limitations

This project uses a historical catalog snapshot and third-party metadata. IMDb and TMDB metrics are external signals and are not direct Netflix engagement metrics. The dataset does not provide viewing hours, completion rates, subscriber behavior, revenue, or current catalog availability.

## Outcome

This project demonstrates an end-to-end analytics workflow from raw data preparation to SQL analysis, spreadsheet validation, interactive Power BI visualization, and business-focused documentation.

**Author:** Ananya Garg  
**Focus:** Data Analytics
