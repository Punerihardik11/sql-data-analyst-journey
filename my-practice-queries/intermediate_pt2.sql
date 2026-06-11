-- 🧠 Conditional Logic with CASE Statements

-- Q1 : Show player_name, mmr, and create a new column called Skill_Tier.
SELECT player_name, mmr,
CASE
	WHEN mmr > 12500 THEN 'Godlike'
    WHEN mmr > 11000 THEN 'Immortal'
END AS Skill_Tier
FROM players ;

-- Q2 : The Win/Loss Flag
--      Show player_name, match_result, and create a new column called Result_Flag.
SELECT player_id, match_result,
CASE
	WHEN match_result = 'Victory' THEN 'W' ELSE 'L'
END AS Result_Flag
FROM match_history;

-- Q3 : The Farming Efficiency Check
--      Show hero_name, gpm (Gold Per Minute), and create a column called Farm_Status.

SELECT hero_name, gpm ,
CASE
	WHEN gpm > 600 THEN 'High Farm'
    WHEN gpm < 300 THEN 'Low Farm' ELSE 'Medium Farm'
END AS Farm_Status
FROM match_history;

-- Q4 : The Kill Bracket Show player_name, hero_name, kills, and create a column called Kill_Bracket.
SELECT player_id, hero_name, kills,
CASE
	WHEN kills >= 5 THEN 'Rampage'
    WHEN kills >= 3 THEN 'Mega Kill'
    WHEN kills >= 1 THEN 'Normal'
    WHEN kills = 0 THEN 'NOOB'
END AS Kill_Bracket
FROM match_history;

-- Q5 : The Win Rate Performance Level Show player_name, win_rate, and create a column called Performance_Level.
SELECT player_name, win_rate,
CASE
	WHEN win_rate > 52 THEN 'GLOBAL ELITE'
    WHEN win_rate > 50 THEN 'PROFESSIONAL'
    WHEN win_rate > 48 THEN 'AVERAGE'
END AS Performance_Level
FROM players;

-- Q6 : The "Carry" vs "Feeder" Flag Show player_name, hero_name, kills, deaths, and create a column called Match_Impact.
SELECT player_id, hero_name, kills, deaths,
CASE
	WHEN (kills > deaths * 2) THEN 'Carry'
    WHEN (deaths > kills * 2) THEN 'Feeder' ELSE 'Average'
END AS Match_Impact
FROM match_history;

-- Q7 : The Veteran Status Show player_name, total_wins, and create a column called Player_Status.
SELECT player_name, total_wins,
CASE
	WHEN total_wins > 1500 THEN 'Veteran'
    WHEN total_wins > 1000 THEN 'Experienced'
END AS Player_Status 
FROM players;

#############################################################################################
-- Introduction to SQL Subqueries

-- Q1 : The Puppey Benchmark
--      Find all players whose MMR is strictly greater than the MMR of the player named 'Puppey'. Show player_name and mmr.
SELECT player_name, mmr
FROM players
WHERE mmr > ( 
	SELECT mmr
    FROM players
    WHERE player_name = 'Puppey'
);

-- Q2 : The "Compare to Average" Subquery (Most Common in Interviews)
SELECT player_name, mmr
FROM players
WHERE mmr > (
	SELECT AVG(mmr)
    FROM players
);

-- Q3 : The Top MMR Player(s)
--      Find the player_name and mmr of the player(s) who have the highest MMR in the entire database.

SELECT player_name, mmr
FROM players
WHERE mmr = (SELECT MAX(mmr) FROM players) ;

-- Q4 : The Invoker Players
--  Show the player_name of all players who have played the hero 'Invoker' in the match_history table.
SELECT player_name
FROM players
WHERE player_id IN (
	SELECT player_id
    FROM match_history
    WHERE hero_name = 'Invoker'
    );
    
-- Q5 : The Pudge Haters

SELECT player_name
FROM players
WHERE player_id NOT IN (
	SELECT player_id
    FROM match_history
    WHERE hero_name = 'Pudge'
);

#################################################################################################
-- WINDOW FUCNTIONS (ROW_NUMBER), RANK , DENSE_RANK AND NTILE

-- Q1 : The Global Leaderboard Show player_name, mmr, and assign a unique rank number to every player from highest MMR to lowest using ROW_NUMBER().
SELECT
player_name,
team_name,
mmr,
ROW_NUMBER() OVER (ORDER BY mmr DESC) AS Leaderboard
FROM players;

-- Q2 : The Tie-Breaker Show player_name, total_wins, and calculate both RANK() and DENSE_RANK() ordered by total_wins descending. Look at the results to see how they handle players with the exact same number of wins.
SELECT 
player_name,
total_wins,
team_name,
RANK () OVER (ORDER BY total_wins DESC) AS rank_val,
DENSE_RANK () OVER (ORDER BY total_wins DESC) AS dense_rank_val
FROM players;

-- Q3 : The Country Champions Show country, player_name, mmr, and use ROW_NUMBER() to rank players within their own country based on MMR (highest to lowest).
SELECT
country,
player_name,
mmr,
ROW_NUMBER () OVER (PARTITION BY country ORDER BY mmr DESC) AS TheCountryChamps
FROM players;

-- Q4 : The MMR Quartiles Show player_name, mmr, and divide all players into 4 equal buckets (quartiles) based on their MMR using NTILE.
SELECT
player_name,
mmr,
NTILE(4) OVER (ORDER BY mmr DESC) AS quartile
FROM players;

-- Q5 : Combining Window Functions with Subqueries/CTEs
WITH ranked_players AS (
	SELECT
		player_name,
        country,
        mmr,
        ROW_NUMBER() OVER (PARTITION BY country ORDER BY mmr DESC) AS row_num
	FROM players
)
SELECT player_name, country, mmr
FROM ranked_players
WHERE row_num = 1;

-- Q6 : The Global Kill Average Show hero_name, kills, and on every single row, also show the average kills of the entire match_history table.
SELECT 
hero_name,
kills,
AVG(kills) OVER ()
FROM match_history;

-- Q7 : Partitioned Aggregation (Comparing to Group Average) Show player_name, country, mmr, and the average MMR of that player's specific country on the same row.
SELECT
player_name,
country,
mmr,
AVG(mmr) OVER (PARTITION BY country)
FROM players;