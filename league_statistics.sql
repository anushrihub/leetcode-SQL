CREATE TABLE Teams (
    team_id INT,
    team_name VARCHAR(50)
);

-- Insert into Teams
INSERT INTO Teams (team_id, team_name) VALUES
(1, 'Ajax'),
(4, 'Dortmund'),
(6, 'Arsenal');

CREATE TABLE Matches (
    home_team_id INT,
    away_team_id INT,
    home_team_goals INT NOT NULL,
    away_team_goals INT NOT NULL
);

-- Insert into Matches
INSERT INTO Matches (home_team_id, away_team_id, home_team_goals, away_team_goals) VALUES
(1, 4, 0, 1),
(1, 6, 3, 3),
(4, 1, 5, 2),
(6, 1, 0, 0);

SELECT * FROM Teams
SELECT * FROM Matches

-- find the fields for home_team
WITH home_team AS
(
SELECT
    
    home_team_id AS team_id,
    CASE WHEN home_team_goals > away_team_goals THEN 3 
         WHEN home_team_goals = away_team_goals THEN 1
         ELSE 0 END AS points,
    home_team_goals AS goal_for,
    away_team_goals AS goal_against
    
FROM Matches
),
-- find the fields for away_team
away_team AS
(
SELECT
    
   away_team_id AS team_id,
    CASE WHEN home_team_goals > away_team_goals THEN 0 
         WHEN home_team_goals = away_team_goals THEN 1
         ELSE 3 END AS points,
    away_team_goals AS goal_for,
    home_team_goals AS goal_against
    
FROM Matches
),

total_team AS
(
SELECT * FROM home_team
UNION ALL
SELECT * FROM away_team
)

SELECT
        team_name,
        COUNT(TT.team_id) AS matches_played,
        SUM(TT.points) AS points,
        SUM(TT.goal_for) AS goal_for,
        SUM(TT.goal_against) AS goal_against,
        SUM(TT.goal_for) - SUM(TT.goal_against) AS goal_diff
FROM total_team TT
 JOIN Teams T
ON TT.team_id = T.team_id
GROUP BY team_name
ORDER BY points DESC, goal_diff DESC, team_name ASC



