CREATE DATABASE ipl_analysis;
USE ipl_analysis;
SHOW DATABASES;
SELECT *
FROM matches;
SELECT *
FROM deliveries;
SELECT COUNT(*) AS Total_Matches
FROM matches;
SELECT season,
       COUNT(*) AS Matches_Played
FROM matches
GROUP BY season
ORDER BY season;
SELECT winner,
       COUNT(*) AS Matches_Won
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY Matches_Won DESC;
SELECT batter,
       SUM(batsman_runs) AS Total_Runs
FROM deliveries
GROUP BY batter
ORDER BY Total_Runs DESC
LIMIT 10;
SELECT bowler,
       COUNT(*) AS Wickets
FROM deliveries
WHERE dismissal_kind NOT IN ('run out', 'retired hurt', 'obstructing the field')
      AND is_wicket = 1
GROUP BY bowler
ORDER BY Wickets DESC
LIMIT 10;
SELECT batter,
       COUNT(*) AS Sixes
FROM deliveries
WHERE batsman_runs = 6
GROUP BY batter
ORDER BY Sixes DESC
LIMIT 10;
SELECT batter,
       COUNT(*) AS Fours
FROM deliveries
WHERE batsman_runs = 4
GROUP BY batter
ORDER BY Fours DESC
LIMIT 10;
SELECT batting_team,
       SUM(total_runs) AS Team_Runs
FROM deliveries
GROUP BY batting_team
ORDER BY Team_Runs DESC;
SELECT player_of_match,
       COUNT(*) AS Awards
FROM matches
WHERE player_of_match IS NOT NULL
GROUP BY player_of_match
ORDER BY Awards DESC
LIMIT 10;
SELECT match_id,
       batting_team,
       SUM(total_runs) AS Total_Score
FROM deliveries
GROUP BY match_id, batting_team
ORDER BY Total_Score DESC
LIMIT 10;
SELECT team,
       COUNT(*) AS Matches_Played
FROM
(
    SELECT team1 AS team FROM matches
    UNION ALL
    SELECT team2 AS team FROM matches
) AS teams
GROUP BY team
ORDER BY Matches_Played DESC;
SELECT AVG(first_innings_score) AS Avg_First_Innings
FROM
(
    SELECT match_id,
           SUM(total_runs) AS first_innings_score
    FROM deliveries
    WHERE inning = 1
    GROUP BY match_id
) AS scores;
SELECT batter,
       match_id,
       SUM(batsman_runs) AS Runs
FROM deliveries
GROUP BY batter, match_id
ORDER BY Runs DESC
LIMIT 10;
SELECT bowler,
       COUNT(*) AS Dot_Balls
FROM deliveries
WHERE total_runs = 0
GROUP BY bowler
ORDER BY Dot_Balls DESC
LIMIT 10;
SELECT batter,
       COUNT(*) AS Boundaries
FROM deliveries
WHERE batsman_runs IN (4,6)
GROUP BY batter
ORDER BY Boundaries DESC
LIMIT 10;
SELECT toss_winner,
       COUNT(*) AS Tosses_Won
FROM matches
GROUP BY toss_winner
ORDER BY Tosses_Won DESC;
SELECT venue,
       COUNT(*) AS Matches
FROM matches
GROUP BY venue
ORDER BY Matches DESC
LIMIT 10;
SELECT city,
       COUNT(*) AS Matches
FROM matches
WHERE city IS NOT NULL
GROUP BY city
ORDER BY Matches DESC;
SELECT m.season,
       d.batter,
       SUM(d.batsman_runs) AS Total_Runs
FROM deliveries d
JOIN matches m
ON d.match_id = m.id
GROUP BY m.season, d.batter
ORDER BY m.season, Total_Runs DESC;
SELECT m.season,
       d.bowler,
       COUNT(*) AS Wickets
FROM deliveries d
JOIN matches m
ON d.match_id = m.id
WHERE d.is_wicket = 1
      AND d.dismissal_kind NOT IN ('run out', 'retired hurt', 'obstructing the field')
GROUP BY m.season, d.bowler
ORDER BY m.season, Wickets DESC;
SELECT batter,
       COUNT(*) AS Balls_Faced,
       SUM(batsman_runs) AS Runs,
       ROUND((SUM(batsman_runs) * 100.0) / COUNT(*), 2) AS Strike_Rate
FROM deliveries
GROUP BY batter
HAVING COUNT(*) >= 500
ORDER BY Strike_Rate DESC
LIMIT 10;
SELECT bowler,
       COUNT(*) AS Balls_Bowled,
       SUM(total_runs) AS Runs_Conceded,
       ROUND((SUM(total_runs) * 6.0) / (COUNT(*) / 6), 2) AS Economy
FROM deliveries
GROUP BY bowler
HAVING COUNT(*) >= 300
ORDER BY Economy ASC
LIMIT 10;
SELECT player_of_match,
       COUNT(*) AS Awards
FROM matches
WHERE player_of_match IS NOT NULL
GROUP BY player_of_match
ORDER BY Awards DESC
LIMIT 10;
SELECT winner,
       AVG(result_margin) AS Avg_Win_Margin
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY Avg_Win_Margin DESC;
SELECT venue,
       winner,
       COUNT(*) AS Wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY venue, winner
ORDER BY venue, Wins DESC;
SELECT winner,
       COUNT(*) AS Wins_After_Losing_Toss
FROM matches
WHERE winner <> toss_winner
GROUP BY winner
ORDER BY Wins_After_Losing_Toss DESC;
WITH SeasonRuns AS (
    SELECT
        m.season,
        d.batter,
        SUM(d.batsman_runs) AS Total_Runs,
        RANK() OVER (
            PARTITION BY m.season
            ORDER BY SUM(d.batsman_runs) DESC
        ) AS Rank_No
    FROM deliveries d
    JOIN matches m
        ON d.match_id = m.id
    GROUP BY m.season, d.batter
)

SELECT season,
       batter,
       Total_Runs
FROM SeasonRuns
WHERE Rank_No = 1
ORDER BY season;
WITH SeasonWickets AS (
    SELECT
        m.season,
        d.bowler,
        COUNT(*) AS Wickets,
        RANK() OVER (
            PARTITION BY m.season
            ORDER BY COUNT(*) DESC
        ) AS Rank_No
    FROM deliveries d
    JOIN matches m
        ON d.match_id = m.id
    WHERE d.is_wicket = 1
      AND d.dismissal_kind NOT IN
      ('run out','retired hurt','obstructing the field')
    GROUP BY m.season, d.bowler
)

SELECT season,
       bowler,
       Wickets
FROM SeasonWickets
WHERE Rank_No = 1
ORDER BY season;
WITH SeasonRuns AS (
    SELECT
        m.season,
        d.batter,
        SUM(d.batsman_runs) AS Runs,
        DENSE_RANK() OVER (
            PARTITION BY m.season
            ORDER BY SUM(d.batsman_runs) DESC
        ) AS Rank_No
    FROM deliveries d
    JOIN matches m
        ON d.match_id = m.id
    GROUP BY m.season, d.batter
)

SELECT *
FROM SeasonRuns
WHERE Rank_No <= 3
ORDER BY season, Rank_No;
WITH SeasonWickets AS (
    SELECT
        m.season,
        d.bowler,
        COUNT(*) AS Wickets,
        DENSE_RANK() OVER (
            PARTITION BY m.season
            ORDER BY COUNT(*) DESC
        ) AS Rank_No
    FROM deliveries d
    JOIN matches m
        ON d.match_id = m.id
    WHERE d.is_wicket = 1
      AND d.dismissal_kind NOT IN
      ('run out','retired hurt','obstructing the field')
    GROUP BY m.season, d.bowler
)

SELECT *
FROM SeasonWickets
WHERE Rank_No <= 3
ORDER BY season, Rank_No;

























