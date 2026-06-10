SELECT *
FROM match_history;
SELECT *
FROM players;

-- Q1 : Show player names and their match details (hero played, kills, deaths) using INNER JOIN.
SELECT 
	player_name,
    hero_name,
    kills,
    deaths
FROM match_history AS mh
	INNER JOIN players
    ON mh.player_id = players.player_id
    ;
    
-- Q2 : Display all players and their team names, even if they haven't played any matches recently.
SELECT 
    player_name,
    team_name
FROM players
	LEFT JOIN match_history AS mh
    ON mh.player_id = players.player_id
    ;
-- 📝 The Rule:
-- When doing JOINs, if both tables have the same column name, you MUST specify:
-- table_name.column_name
-- OR use table aliases: p.player_id or mh.player_id

-- Q3 : Find all matches with player names, hero played, and match result. Only show matches where the player got more than 10 kills.
SELECT
	player_name,
    hero_name,
    mh.match_result 
FROM match_history AS mh
	INNER JOIN players
    ON mh.player_id = players.player_id
    WHERE kills > 10 ;

-- Q4 : Show team names and count how many players from each team appear in the match history.
SELECT
	players.team_name,
    COUNT(*) AS match_count
FROM players 
INNER JOIN match_history as mh
	ON players.player_id = mh.player_id
GROUP BY players.team_name
ORDER BY match_count DESC;

-- Q5 :  Show each player's name and their average GPM (Gold Per Minute) from all their matches.
SELECT 
	players.player_name,
    AVG(gpm)
FROM players
INNER JOIN match_history as mh
	ON players.player_id = mh.player_id
GROUP BY players.player_name
;

-- Q6 : Show player name, team name, and match result for all matches where role is 'Support'.
SELECT
	player_name,
    team_name,
    match_result
FROM players
INNER JOIN match_history AS mh
	ON players.player_id = mh.player_id
WHERE role = 'support' ;

-- Q7 :  Show player name, hero name, and calculate total impact (kills + assists) for each match. Sort by highest impact first.
SELECT 
	player_name,
    hero_name,
    (kills + assists)  AS total_impact
FROM players
INNER JOIN match_history AS mh
	ON players.player_id = mh.player_id
ORDER BY total_impact  DESC ;

-- Q8 : Show a list of all players from 'Team Secret' and all players from 'OG'. Display player_name and team_name
SELECT team_name, player_name
FROM players
WHERE team_name = 'Team Secret'
UNION
SELECT team_name, player_name
FROM players
WHERE team_name = 'OG' ;

SELECT *
FROM players ;
SELECT *
FROM match_history ;

-- Q9 : Create two lists: (1) Players with MMR > 12500, label them 'High MMR'. (2) Players with win_rate > 55%, label them 'High Win Rate'. Combine both lists.
SELECT player_name, 'High MMR' AS Label
FROM players
UNION
SELECT win_rate, 'High Win Rate' AS Label
FROM players
WHERE win_rate > 55 ;

-- Q10 : Show all unique countries from players table combined with all unique roles from match_history table. Name the column "Category".
SELECT country
FROM players
UNION DISTINCT 
SELECT role
FROM match_history;

-- Q11: Combine two lists into one column: (1) All player names from 'Nigma' team. (2) All hero names where kills > 15.
SELECT player_name 
FROM players
WHERE team_name = 'Nigma'
UNION
SELECT hero_name
FROM match_history
WHERE kills > 15 ;

-- Q12: Show players who are either from 'Finland' OR have total_wins > 1000. Remove duplicates.
SELECT player_name
FROM players
WHERE country = 'Finland'
UNION distinct
SELECT player_name
FROM players
WHERE total_wins > 1000 ;

-- Q13 : Show top 3 players by MMR combined with top 3 players by win_rate.
(SELECT player_name, mmr
FROM players
ORDER BY mmr DESC
LIMIT 3)
UNION 
(SELECT player_name, win_rate
FROM players
ORDER BY win_rate DESC
LIMIT 3);

-- Q14 : Show all unique team names from players combined with all unique lanes from match_history in one column.
SELECT team_name AS Category
FROM players
UNION
SELECT role AS Category
FROM match_history;

##############################################################################################
-- Topic 3 : String functions 

-- Q15: Show player names in UPPERCASE and their country in lowercase 
SELECT
	 UPPER(player_name),
     LOWER(country)
FROM players ;

-- Q16: Combine first_name and last_name into one column called "full_name". Also show the length of the full name.
SELECT first_name, last_name,
CONCAT(first_name, ' ' , last_name) AS full_name
FROM employee_data;

-- Q17 : For each hero in match_history, show the hero name and the first 3 characters of the name.
SELECT hero_name,
SUBSTRING(hero_name,1,3)
FROM match_history;
-- SUBSTRING(column_name, starting_position, number_of_characters)
-- Position:  1   2   3   4   5   6   7   8
-- Letter:    I   n   v   o   k   e   r
     --       ↑           ↑
     --       └───Start───┘
     --       Take 3 chars
           
-- Result: "Inv"

-- Q18 : Find all player names that contain the letter 'a'. Show the name and the position where 'a' appears
SELECT player_name, LOCATE('a',player_name)
FROM players
WHERE player_name LIKE '%a%';

-- Q19 : Show team_name and a new column where you remove the word "Team " from team names.
SELECT team_name,
REPLACE(team_name, 'Team','')
FROM players;

-- Q20 : Show player names with all leading and trailing spaces removed.
SELECT TRIM(player_name) AS cleaned_name
FROM players;

-- Q21 : Show player names where the name length is more than 10 characters. Also show the actual length.
SELECT player_name, LENGTH(player_name) AS name_length
FROM players
WHERE LENGTH(player_name) > 10;