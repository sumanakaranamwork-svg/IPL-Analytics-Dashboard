# 🏏 IPL Analytics Dashboard

This project analyzes IPL match data using Python, MySQL, and Power BI to uncover insights into team performance, batting, bowling, and venue statistics. The goal was to work through a complete data analytics workflow—from data cleaning to visualization—using real-world data.

## Tools Used

- Python (Pandas)
- MySQL
- Power BI
- Git & GitHub

## Dataset

The project uses two datasets:

- `matches.csv` – Match-level information
- `deliveries.csv` – Ball-by-ball data

## Project Workflow

- Cleaned and prepared the data using Python (Pandas)
- Performed exploratory analysis and handled missing values
- Imported the cleaned data into MySQL
- Wrote SQL queries to analyze player and match statistics
- Built an interactive Power BI dashboard using DAX measures, KPIs, charts, and slicers

## Dashboard Overview

### Executive Overview
- Total Matches
- Total Runs
- Total Wickets
- Total Sixes
- Total Fours
- Total Teams
- Matches Across Seasons
- Top Winning Teams
- Toss Decision Distribution

### Batting Analysis
- Total Runs
- Total Sixes
- Total Fours
- Average Strike Rate
- Top Run Scorers
- Top Six Hitters
- Top Four Hitters
- Top Strike Rates

### Bowling Analysis
- Total Wickets
- Total Dot Balls
- Average Economy
- Bowling Strike Rate
- Top Wicket Takers
- Most Dot Balls Bowled
- Wickets by Season

### Team & Venue Analysis
- Total Venues
- Host Cities
- Highest Successful Chase
- Largest Win by Runs
- Largest Win by Wickets
- Top Venues
- Top Winning Teams
- Toss Decision Distribution
- Top Cities Hosting Matches

## Project Structure

```text
IPL-Analytics-Dashboard
│
├── data
│   ├── matches.csv
│   ├── deliveries.csv
│
├── notebooks
│   └── ipl_cleaned.ipynb
│
├── SQL
│   └── SQL_Queries.sql
│
├── IPL_Analytics_Dashboard.pbix
│
└── README.md
```

## Key Learnings

Through this project, I gained hands-on experience in:

- Cleaning and preparing datasets using Pandas
- Writing SQL queries for data analysis
- Creating DAX measures and KPIs in Power BI
- Building interactive dashboards with filters and visualizations
- Presenting insights in a clear and user-friendly way

## Future Improvements

- Add player comparison features
- Perform predictive analysis using machine learning
- Connect the dashboard to live IPL data
- Include additional advanced DAX measures

## Author

Karanam Naga Sumana
