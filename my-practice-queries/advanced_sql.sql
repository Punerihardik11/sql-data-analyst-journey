#################################### C T E #################################################
-- COMMON  TABLE  EXPRESSION --
-- Temporary, named result set (virtual table), that can be used multiple times within your query to simplify and organize complex query.

# WITH CTE - Name AS
# (
#	SELECT ...
#	FROM ...					-- SYNTAX
#	WHERE ...
# )
-- ----------------
# SELECT...
# FROM CTE - NAME              -- Main Query
# WHERE ...

-- Q1 : BASIC CTE to filter data 
--     Find all players with an MMR greater than 12,000. Show their name, country, and MMR.

WITH HighMMRPlayers AS (
	SELECT player_name, country, mmr
    FROM players
    WHERE mmr > 12000
    )
SELECT * FROM HighMMRPlayers;

-- Q2 : CTE with Aggregation
--      Calculate the average MMR for each country. Show the country name and the average MMR
WITH CountryAvgMMR AS (
	SELECT country, AVG(mmr) AS avg_mmr
    FROM players
    GROUP BY country
 )
SELECT * FROM CountryAvgMMR;

-- Q3 : Find the single best player (highest MMR) from each country. CTE + Window Function (The Classic Interview Pattern)
WITH RankedPlayers AS (
	SELECT 
		player_name,
		country,
		mmr,
		ROW_NUMBER() OVER(PARTITION BY country ORDER BY mmr DESC) as rank_num
    FROM players
)
SELECT player_name, country, mmr
FROM RankedPlayers
WHERE rank_num = 1;

-- Q4 : Find the total kills for each player across all their matches in match_history. Then, only show players who have more than 50 total kills.
WITH PlayerTotalKills AS (
	SELECT
		player_id,
        SUM(kills) AS total_kills
	FROM match_history
    GROUP BY player_id
)

SELECT player_id, total_kills
FROM PlayerTotalKills
WHERE total_kills > 35;

-- Q5 : Find high-kill matches (> 15 kills) played by Team Secret players
WITH HighKillMatches AS (
	SELECT player_id, hero_name, kills
    FROM match_history
    WHERE kills > 15
),
TeamSecretPlayers AS (
	SELECT player_id, player_name
    FROM players
    WHERE team_name = 'Team Secret'
)
SELECT tsp.player_name, hkm.hero_name, hkm.kills
FROM HighKillMatches hkm
INNER JOIN TeamSecretPlayers tsp ON hkm.player_id = tsp.player_id;
	
-- Q6 : Find all heroes whose average GPM (Gold Per Minute) across all matches is greater than 500.
WITH HeroAvgGPM AS (
	SELECT 
		hero_name,
        AVG(gpm) AS avg_gpm
	FROM match_history
    GROUP BY hero_name
)

SELECT hero_name, avg_gpm
FROM HeroAvgGPM
WHERE avg_gpm > 500;

-- Q7 : Categorize all players into 'High MMR' (> 12500) or 'Low MMR'. Then, count how many players fall into each category.
WITH MMRCategory AS (
	SELECT
		player_id,
        player_name,
        mmr,
        team_name,
        CASE
        WHEN mmr > 12500 THEN 'High MMR' ELSE 'Low MMR' END AS player_category
        FROM players
        )
SELECT 
	player_category,
    COUNT(*) AS player_count
FROM MMRCategory
GROUP BY player_category;


-- Q8 : Show every player's name, their MMR, and how much higher or lower they are compared to the global average MMR.
WITH GlobalAverage AS (
	SELECT AVG(mmr) AS avg_mmr
    FROM players
)
SELECT 
	p.player_name,
    p.mmr,
    p.mmr - g.avg_mmr AS difference
FROM players p, GlobalAverage g;

-- Q9 : Find the player with the absolute highest win_rate in the database. Show their name, team, and win rate
WITH MaxWin AS (
	SELECT MAX(win_rate) AS max_win_rate
    FROM players
)
SELECT player_name, team_name, win_rate
FROM players
WHERE win_rate = (SELECT max_win_rate FROM MaxWin);

-- Q10 : For each team, find the player with the highest total_wins. Show the team name and the MVP's name
WITH TeamMVP AS (
	SELECT
		player_name,
        team_name,
        total_wins,
        ROW_NUMBER() OVER(PARTITION BY team_name ORDER BY total_wins DESC) AS rank_num
	FROM players
)
SELECT team_name, player_name, total_wins
FROM TeamMVP
WHERE rank_num = 1;

#################################### TEMPORARY TABLES ######################################
-- Temporary table = save an intermediate result temporarily, then query it like a normal table.
SELECT *
FROM match_history;

-- Q1 : Create a temporary table of high MMR players
CREATE TEMPORARY TABLE temp_high_mmr_players AS
SELECT
	player_id,
    player_name,
    team_name,
    country,
    mmr,
    win_rate
FROM players
WHERE mmr > 12500;

SELECT *
FROM temp_high_mmr_players;

-- Q2 : Create a temporary table of player match performance
CREATE TEMPORARY TABLE temp_player_match_performance AS
SELECT
	mh.match_id,
    p.player_id,
    p.player_name,
    p.team_name,
    mh.hero_name,
    mh.role,
	mh.kills,
    mh.deaths,
    mh.assists,
    mh.kda_ratio,
    mh.gpm,
    mh.xpm,
    mh.match_result
FROM match_history AS mh
JOIN players AS p
	ON mh.player_id = p.player_id;
    
SELECT *
FROM temp_player_match_performance;

-- Q3 : Temporary table for winning matches only
CREATE TEMPORARY TABLE temp_winning_matches AS 
SELECT 
hero_name,
role
FROM match_history 
WHERE match_result = 'Victory' ;

SELECT *
FROM temp_winning_matches ;

-- Q4 : Temporary table for high KDA performances
CREATE TEMPORARY TABLE temp_high_kda_matches AS
SELECT
player_id,
hero_name,
kills,
deaths,
assists,
kda_ratio,
match_result
FROM match_history
WHERE kda_ratio >= 7;

SELECT *
FROM temp_high_kda_matches ;

-- Q5 : Temporary table for team-level player summary
CREATE TEMPORARY TABLE temp_team_player_summary AS 
SELECT
	team_name,
	AVG(mmr) AS avg_mmr,
	AVG(win_rate) AS avg_winrate
FROM players
GROUP BY team_name ;

SELECT *
FROM temp_team_player_summary ;

SELECT *
FROM players;

-- Q6 : Temporary table for hero performance summary
CREATE TEMPORARY TABLE temp_hero_summary AS 
SELECT 
	AVG(kills) AS avg_kills,
    AVG(deaths) AS avg_deaths,
    AVG(assists) AS avg_assists,
    AVG(gpm) AS avg_gpm,
    AVG(xpm)
FROM match_history 
GROUP BY hero_name ;

SELECT *
FROM temp_hero_summary ;

-- Q7 : Temporary table for possible outlier matches
CREATE TEMPORARY TABLE temp_outlier_matches AS
SELECT
	match_id,
    player_id,
    hero_name,
	kills,
    match_result,
    hero_damage,
    gpm
FROM match_history
WHERE kills >= 18
	OR hero_damage >= 45000
	OR gpm >= 700 ;
    
SELECT *
FROM temp_outlier_matches;

################################### CREATING STORED PROCEDURES ##############################

-- Q1. Create stored procedure for high KDA matches

DROP PROCEDURE IF EXISTS GetHighKDAMatches;
DELIMITER //
CREATE PROCEDURE GetHighKDAMatches()
BEGIN
	SELECT
		match_id,
        player_id,
        hero_name,
        kills,
        deaths,
        assists,
        kda_ratio,
        match_result
	FROM match_history
    WHERE kda_ratio >= 7;
END //

DELIMITER ;

CALL GetHighKDAMatches();

-- Q2 : Stored procedure for high GPM matches
DROP PROCEDURE IF  EXISTS GetHighGPMMatches;
DELIMITER //
CREATE PROCEDURE GetHighGPMMatches ()
BEGIN
	SELECT
    hero_name,
    role,
    gpm
	FROM match_history
    WHERE gpm >= 650;
END //
DELIMITER ;

CALL GetHighGPMMatches ();

-- Q3 : Stored procedure with input parameter for minimum kills
DROP PROCEDURE IF EXISTS GetMatchesByMinKills;
DELIMITER //
CREATE PROCEDURE GetMatchesByMinKills(IN min_kills INT)
BEGIN
	SELECT
	hero_name,
    match_result,
    role
    FROM match_history
    WHERE kills >= min_kills;
END //
DELIMITER ;

CALL GetMatchesByMinKills(15);
CALL GetMatchesByMinKills(20);

-- Q4 : Stored procedure to show matches by hero name
DROP PROCEDURE IF EXISTS GetMatchesByHero;
DELIMITER //
CREATE PROCEDURE GetMatchesByHero(IN hero_input VARCHAR(100))
BEGIN
	SELECT
		match_id,
        player_id,
        hero_name,
        role,
        kills,
        deaths,
        assists,
        kda_ratio,
        gpm,
        xpm,
        match_result
	FROM match_history
    WHERE hero_name = hero_input;
END //
DELIMITER ;

CALL GetMatchesByHero('Invoker');

-- Q5 : Stored procedure for player performance report 
DROP PROCEDURE IF EXISTS GetPlayerPerformance;
DELIMITER //
CREATE PROCEDURE GetPlayerPerformance(IN input_player_id INT)
BEGIN
	SELECT
		player_id,
        player_name,
        team_name,
        mmr
	FROM players
    WHERE player_id = input_player_id;
END //
DELIMITER ;

CALL GetPlayerPerformance(2);