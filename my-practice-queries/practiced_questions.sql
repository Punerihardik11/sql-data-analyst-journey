CREATE DATABASE dota2_esports;
USE dota2_esports;

CREATE TABLE players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(100),
    country VARCHAR(50),
    team_name VARCHAR(100),
    player_rank VARCHAR(20),
    mmr INT,
    total_matches INT,
    total_wins INT,
    total_losses INT,
    win_rate DECIMAL(5,2)
);

INSERT INTO players VALUES
(1, 'Puppey', 'Estonia', 'Team Secret', 'Immortal', 12500, 2847, 1523, 1324, 53.50),
(2, 'N0tail', 'Denmark', 'OG', 'Immortal', 12300, 2156, 1189, 967, 55.15),
(3, 'Miracle-', 'Jordan', 'Nigma', 'Immortal', 12800, 1987, 1134, 853, 57.07),
(4, 'Arteezy', 'Canada', 'Evil Geniuses', 'Immortal', 12600, 2345, 1245, 1100, 53.09),
(5, 'SumaiL', 'Pakistan', 'Evil Geniuses', 'Immortal', 12400, 1876, 1023, 853, 54.53),
(6, 'Topson', 'Finland', 'OG', 'Immortal', 12700, 1654, 945, 709, 57.13),
(7, 'ana', 'Australia', 'OG', 'Immortal', 12500, 1789, 1012, 777, 56.57),
(8, 'Ceb', 'France', 'OG', 'Immortal', 12200, 2012, 1089, 923, 54.13),
(9, 'JerAx', 'Finland', 'Team Liquid', 'Immortal', 12400, 1567, 891, 676, 56.86),
(10, 'GH', 'Lebanon', 'Nigma', 'Immortal', 12300, 1834, 1001, 833, 54.58),
(11, 'KuroKy', 'Germany', 'Nigma', 'Immortal', 12100, 2567, 1378, 1189, 53.68),
(12, 'MinD_ContRoL', 'Bulgaria', 'Nigma', 'Immortal', 12000, 1923, 1034, 889, 53.77),
(13, 'w33', 'Romania', 'Nigma', 'Immortal', 12350, 1756, 945, 811, 53.82),
(14, 'MATUMBAMAN', 'Finland', 'Team Secret', 'Immortal', 12250, 2134, 1145, 989, 53.65),
(15, 'YapzOr', 'Jordan', 'Team Secret', 'Immortal', 12300, 1678, 923, 755, 55.01),
(16, 'Zai', 'Sweden', 'Evil Geniuses', 'Immortal', 12150, 2245, 1189, 1056, 52.96),
(17, 'Cr1t-', 'Denmark', 'Evil Geniuses', 'Immortal', 12200, 1834, 978, 856, 53.33),
(18, 'Abed', 'Philippines', 'Evil Geniuses', 'Immortal', 12400, 1567, 856, 711, 54.63),
(19, 'Nightfall', 'Russia', 'Team Secret', 'Immortal', 12350, 1456, 812, 644, 55.77),
(20, 'Resolut1on', 'Ukraine', 'Team Secret', 'Immortal', 12300, 1789, 945, 844, 52.82);

CREATE TABLE match_history (
    match_id INT PRIMARY KEY,
    player_id INT,
    hero_name VARCHAR(100),
    role VARCHAR(50),
    lane VARCHAR(50),
    kills INT,
    deaths INT,
    assists INT,
    kda_ratio DECIMAL(5,2),
    gpm INT,
    xpm INT,
    last_hits INT,
    denies INT,
    hero_damage INT,
    tower_damage INT,
    healing INT,
    level INT,
    duration_minutes INT,
    match_result VARCHAR(10),
    match_date DATE,
    FOREIGN KEY (player_id) REFERENCES players(player_id)
);

INSERT INTO match_history VALUES
(7001, 1, 'Pudge', 'Support', 'Safe Lane', 12, 8, 28, 5.00, 425, 512, 145, 12, 28450, 1250, 3400, 25, 67, 'Victory', '2024-01-15'),
(7002, 2, 'Io', 'Support', 'Mid Lane', 2, 5, 35, 7.40, 312, 445, 78, 8, 12300, 890, 8900, 22, 52, 'Victory', '2024-01-15'),
(7003, 3, 'Invoker', 'Core', 'Mid Lane', 18, 4, 15, 8.25, 687, 745, 312, 28, 45600, 5670, 1200, 25, 71, 'Victory', '2024-01-16'),
(7004, 4, 'Anti-Mage', 'Core', 'Safe Lane', 22, 3, 8, 10.00, 745, 698, 387, 35, 38900, 8900, 890, 25, 58, 'Victory', '2024-01-16'),
(7005, 5, 'Storm Spirit', 'Core', 'Mid Lane', 15, 7, 19, 4.86, 612, 678, 278, 22, 42300, 3450, 2100, 24, 63, 'Defeat', '2024-01-17'),
(7006, 6, 'Tinker', 'Core', 'Mid Lane', 14, 6, 12, 4.33, 598, 645, 298, 25, 39800, 4560, 1500, 23, 68, 'Victory', '2024-01-17'),
(7007, 7, 'Phantom Assassin', 'Core', 'Safe Lane', 25, 5, 10, 7.00, 698, 612, 356, 18, 52300, 9870, 670, 25, 55, 'Victory', '2024-01-18'),
(7008, 8, 'Mars', 'Offlane', 'Off Lane', 8, 9, 22, 3.33, 445, 534, 167, 15, 23400, 2340, 1890, 22, 61, 'Defeat', '2024-01-18'),
(7009, 9, 'Rubick', 'Support', 'Safe Lane', 3, 7, 31, 4.86, 334, 423, 89, 11, 15600, 1120, 4500, 21, 54, 'Victory', '2024-01-19'),
(7010, 10, 'Crystal Maiden', 'Support', 'Safe Lane', 1, 8, 29, 3.75, 298, 389, 67, 9, 13400, 890, 3200, 19, 49, 'Defeat', '2024-01-19'),
(7011, 11, 'Chen', 'Support', 'Jungle', 4, 4, 26, 7.50, 378, 467, 123, 14, 18900, 2340, 5600, 23, 58, 'Victory', '2024-01-20'),
(7012, 12, 'Axe', 'Offlane', 'Off Lane', 11, 10, 18, 2.90, 467, 523, 145, 12, 26700, 3450, 2100, 23, 62, 'Victory', '2024-01-20'),
(7013, 13, 'Queen of Pain', 'Core', 'Mid Lane', 16, 6, 14, 5.00, 623, 678, 267, 23, 41200, 4120, 1800, 24, 65, 'Defeat', '2024-01-21'),
(7014, 14, 'Juggernaut', 'Core', 'Safe Lane', 19, 4, 11, 7.50, 678, 634, 334, 21, 44500, 7890, 1200, 25, 59, 'Victory', '2024-01-21'),
(7015, 15, 'Shadow Shaman', 'Support', 'Mid Lane', 5, 7, 27, 4.57, 356, 445, 98, 10, 17800, 4560, 2890, 21, 56, 'Victory', '2024-01-22'),
(7016, 16, 'Tidehunter', 'Offlane', 'Off Lane', 6, 8, 21, 3.38, 412, 489, 134, 13, 21300, 2890, 3400, 22, 60, 'Defeat', '2024-01-22'),
(7017, 17, 'Oracle', 'Support', 'Safe Lane', 2, 6, 33, 5.83, 312, 401, 76, 8, 14500, 1120, 6700, 20, 53, 'Victory', '2024-01-23'),
(7018, 18, 'Ember Spirit', 'Core', 'Mid Lane', 17, 5, 16, 6.60, 645, 689, 289, 24, 43200, 4890, 1600, 24, 64, 'Victory', '2024-01-23'),
(7019, 19, 'Spectre', 'Core', 'Safe Lane', 21, 6, 13, 5.67, 712, 656, 367, 19, 48900, 6780, 980, 25, 61, 'Victory', '2024-01-24'),
(7020, 20, 'Drow Ranger', 'Core', 'Safe Lane', 18, 7, 12, 4.29, 634, 612, 312, 20, 40100, 5670, 890, 24, 62, 'Defeat', '2024-01-24'),
(7021, 1, 'Crystal Maiden', 'Support', 'Safe Lane', 3, 9, 24, 3.00, 289, 378, 67, 7, 12800, 780, 4100, 18, 48, 'Defeat', '2024-01-25'),
(7022, 2, 'Enigma', 'Support', 'Jungle', 7, 5, 29, 7.20, 423, 512, 156, 16, 24500, 3450, 2300, 23, 59, 'Victory', '2024-01-25'),
(7023, 3, 'Shadow Fiend', 'Core', 'Mid Lane', 20, 6, 11, 5.17, 698, 723, 323, 27, 46700, 5890, 1100, 25, 66, 'Victory', '2024-01-26'),
(7024, 4, 'Juggernaut', 'Core', 'Safe Lane', 23, 4, 9, 8.00, 723, 678, 378, 22, 47800, 8900, 1050, 25, 57, 'Victory', '2024-01-26'),
(7025, 5, 'Puck', 'Core', 'Mid Lane', 13, 8, 20, 4.13, 578, 634, 245, 21, 38900, 3890, 2200, 23, 64, 'Victory', '2024-01-27');

### The SELECT Statement & Math Operations ###

-- Q1: Select all columns from players table
SELECT *
FROM players
;

-- Q2: Select only player_name, country, and mmr from player 
SELECT player_name, country, mmr
FROM players;

-- Q3: Calculate win rate percentage for each player
SELECT 
	player_name,
    total_wins,
    total_losses,
    (total_wins * 100 / total_matches) AS win_rate_percentage
FROM players;

-- Q4: Show player name, kills, deaths and calculate KDA (kills + assists/ deaths)
SELECT
	player_id,
    hero_name,
    kills,
    deaths,
    assists,
    (kills + assists) / deaths AS KDA
FROM match_history;

-- Q5: Calculate total gold and XP earned
SELECT
	player_id,
    hero_name,
    gpm,
    xpm,
    duration_minutes,
    (gpm * duration_minutes / 60) AS total_gold,
    (xpm * duration_minutes / 60) AS total_xp
FROM match_history;

SELECT *
FROM players;

-- BONUS Q6 : Calculate the net MMR gain/loss for each player by finding the difference between their total_wins and total_losses, and show it alongside their player_name and current_mmr.
SELECT
	player_name,
    mmr,
    total_wins,
    total_losses,
    (total_wins - total_losses) AS DIFFERENCE
FROM players;
    
-- Bonus Q7 : Show each player's total games played (wins + losses) and verify it matches the total_matches column.
SELECT 
	player_name,
    total_wins,
    total_losses,
    total_matches,
    (total_wins + total_losses) AS calculated_total_matches
FROM players;

-- Bonus Q8 : For match history, show each match's performance score by calculating: (kills × 2 + assists) - deaths. This gives weight to kills and assists while penalizing deaths. Display: player_id, hero_name, kills, deaths, assists, and your calculated performance_score.
SELECT
	player_id,
    hero_name,
    kills,
    deaths,
    assists,
    (kills * 2 + assists) - deaths AS calculated_performance_score
FROM match_history;

### Filtering Data with the WHERE Clause & LIKE Operator ###

-- Q1 : Find all players from Team Secret. Show: player_name, country, team_name, mmr.
SELECT *
FROM dota2_esports.players
WHERE team_name = 'Team Secret'

-- Q2 : Find all matches where the hero_name starts with 'C'. Show: player_id, hero_name, kills, deaths, match_result.
SELECT 
	player_id,
    hero_name,
    kills,
    deaths,
    match_result
    FROM dota2_esports.match_history
    WHERE hero_name LIKE 'C%' 
    
-- Q3 : Find all players with MMR greater than 12,400. Show: player_name, team_name, mmr, win_rate.
SELECT 
	player_name,
    team_name,
    mmr,
    win_rate
FROM dota2_esports.players
WHERE mmr >= 12400 ;

-- Q4 : Find all matches where the player got more than 15 kills. Show: player_id, hero_name, kills, deaths, assists, match_result.
SELECT
	player_id,
    hero_name,
    kills,
    deaths,
    assists
FROM dota2_esports.match_history
WHERE kills > 15 ;

-- Q5 : Find all players whose country name contains the letter 'a'. Show: player_name, country, team_name.
SELECT
	player_name,
    country,
    team_name
FROM dota2_esports.players
WHERE country LIKE '%a%' ;

### GROUP BY and ORDER BY Statements ###
-- Q1 : Count how many players are on each team. Show: team_name and the count of players. Sort by team name alphabetically.
SELECT 
	team_name,
    COUNT(*) AS player_count
FROM players
GROUP BY team_name
ORDER BY team_name ASC;

SELECT *
FROM players;

-- Q2 : Find the average MMR for each team. Show: team_name and average_mmr
SELECT
	team_name,
    AVG(mmr) AS average_mmr
FROM players
GROUP BY team_name
ORDER BY team_name;

SELECT *
FROM match_history;

-- Q3 : Count how many times each hero has been played. Show: hero_name and match_count
SELECT
	hero_name,
    COUNT(*) AS match_count
FROM match_history
GROUP BY hero_name
ORDER BY hero_name;

-- Q4 : Find the average kills for each hero. Show: hero_name and avg_kills.
SELECT
	hero_name,
    AVG(kills) AS avg_kills
FROM match_history
GROUP BY hero_name
ORDER BY hero_name ;

-- Q5 : Count how many players are from each country. Show: country and player_count.
SELECT
	country,
    COUNT(*) AS player_count
FROM players
GROUP BY country
ORDER BY country ;

### HAVING vs. WHERE Clauses
SELECT *
FROM match_history;
SELECT *
FROM players;

-- Q1 : Find all players with MMR greater than 12,300. Show: player_name, mmr, team_name.
SELECT
	player_name,
    mmr,
    team_name
FROM players
HAVING mmr > 12300;

-- Q2 : Count how many players are on each team, but only show teams with more than 3 players. Show: team_name and player_count.
SELECT
	team_name,
    COUNT(*) AS player_count
FROM players
GROUP BY team_name
HAVING player_count > 3;

-- 	Q3 : Find all matches where the player got more than 10 kills, then group by hero_name and count how many times each hero achieved this. Show: hero_name and high_kill_matches.
SELECT
	hero_name,
    COUNT(*) AS high_kill_matches
FROM match_history
WHERE kills > 10
GROUP BY hero_name
ORDER BY high_kill_matches DESC;

-- Q4 : Find the average kills per hero, but only show heroes with average kills greater than 10.
SELECT 
    hero_name, AVG(kills) AS avg_kills
FROM
    match_history
GROUP BY hero_name
HAVING AVG(kills) > 10
ORDER BY avg_kills DESC;

-- Q5 : Find all players from Team Secret OR OG with win_rate greater than 54%.
SELECT 
    player_name,
    team_name,
    win_rate,
    mmr
FROM players
WHERE (team_name = 'Team Secret' OR team_name = 'OG') 
  AND win_rate > 54
ORDER BY win_rate DESC;

### LIMIT Clause and Aliasing ###

-- Q1 : Select the player_name and mmr columns, but rename them to Pro_Player and MMR_Score.
SELECT
	player_name AS Pro_Player,
    mmr AS MMR_Score
FROM players ;

-- Q2 : Show the top 3 players with the highest MMR. Display their name, team, and MMR.
SELECT
	player_name,
    team_name,
    mmr
FROM players 
WHERE mmr > 12500
ORDER BY mmr ASC
LIMIT 3
;

SELECT *
FROM players;

-- Q3 : Calculate the win rate for each player (total_wins / total_matches) * 100. Rename this calculation to Win_Percentage. Show the player name and this new column. Limit the results to the first 5 players.
SELECT
	player_name,
    team_name,
    (total_wins / total_matches) * 100 AS Win_percentage
FROM players
LIMIT 5;

-- Q4 : Skip the first 5 players in the players table, and show the next 5 players. Display their name, country, and team. (Hint: LIMIT 5, 5 or LIMIT 5 OFFSET 5)
SELECT
	player_name,
    country,
    team_name
FROM players
LIMIT 5 OFFSET 5;

SELECT *
FROM match_history;

-- Q5 : Select hero_name, kills, and deaths from the match_history table. Give the match_history table a short alias like mh. Limit the results to 10 rows.
SELECT
	hero_name,
    kills,
    deaths
FROM match_history AS mh
LIMIT 10;