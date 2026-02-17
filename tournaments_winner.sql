-- https://leetcode.com/problems/tournament-winners/description/

CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    group_id INT
);

-- Insert data into Players
INSERT INTO Players (player_id, group_id) VALUES
(15, 1),
(25, 1),
(30, 1),
(45, 1),
(10, 2),
(35, 2),
(50, 2),
(20, 3),
(40, 3);


-- Create Matches table
CREATE TABLE Tour_Matches (
    match_id INT PRIMARY KEY,
    first_player INT,
    second_player INT,
    first_score INT,
    second_score INT
);

-- Insert data into Matches
INSERT INTO Tour_Matches (match_id, first_player, second_player, first_score, second_score) VALUES
(1, 15, 45, 3, 0),
(2, 30, 25, 1, 2),
(3, 30, 15, 2, 0),
(4, 40, 20, 5, 2),
(5, 35, 50, 1, 1);

WITH all_scores AS (
    SELECT first_player AS player_id, first_score AS score
    FROM Tour_Matches
    UNION ALL
    SELECT second_player AS player_id, second_score AS score
    FROM Tour_Matches
),
all_scores AS (SELECT p.player_id,
           p.group_id,
           a.score,
           IFNULL(SUM(a.score), 0) AS total_points
    FROM Players p
    LEFT JOIN all_scores a
        ON p.player_id = a.player_id
    GROUP BY p.player_id, p.group_id, a.score
)
SELECT group_id, player_id
FROM (
    SELECT *,
           RANK() OVER (
               PARTITION BY group_id
               ORDER BY total_points DESC, player_id ASC
           ) AS rnk
    FROM total_scores
) ranked
WHERE rnk = 1;

