-- https://leetcode.com/problems/find-median-given-frequency-of-numbers/description/

CREATE TABLE Numbers(
    num INT,
    frequency INT
)

INSERT INTO Numbers(num, frequency) VALUES
(0, 7),
(1, 1),
(2, 3),
(3, 1)

-- find the median of the num
-- median is not the value but the position of the value
-- hence finding the position by adding the all frequencies as median_num
WITH running_total AS (
SELECT num, frequency,SUM(frequency) OVER (ORDER BY num) as cumm_freq,
(sum(frequency) over())/2 AS median_num
FROM Numbers
)

-- checking where the median_num falls and find the average becuase if the median is even then num1 + num2 / 2
SELECT ROUND(AVG(num),1) as median FROM running_total
WHERE median_num between (cumm_freq-frequency) and cumm_freq
