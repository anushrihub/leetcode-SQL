CREATE TABLE Tree (
    id   INT ,
    p_id INT
);

INSERT INTO Tree (id, p_id) VALUES (1, NULL);
INSERT INTO Tree (id, p_id) VALUES (2, 1);
INSERT INTO Tree (id, p_id) VALUES (3, 1);
INSERT INTO Tree (id, p_id) VALUES (4, 2);
INSERT INTO Tree (id, p_id) VALUES (5, 2);


SELECT * FROM Tree

SELECT id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (
            SELECT p_id
            FROM Tree
        ) THEN 'Inner'
        ELSE 'Leaf'
    END AS Type
FROM Tree
