-- https://leetcode.com/problems/market-analysis-ii/description/
CREATE TABLE Market_Users (
    user_id INT PRIMARY KEY,
    join_date DATE,
    favorite_brand VARCHAR(50)
);

CREATE TABLE Market_Items (
    item_id INT PRIMARY KEY,
    item_brand VARCHAR(50)
);

CREATE TABLE Market_Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    item_id INT,
    buyer_id INT,
    seller_id INT,
    FOREIGN KEY (item_id) REFERENCES Market_Items(item_id),
    FOREIGN KEY (buyer_id) REFERENCES Market_Users(user_id),
    FOREIGN KEY (seller_id) REFERENCES Market_Users(user_id)
);

-- Insert into Users
INSERT INTO Market_Users (user_id, join_date, favorite_brand) VALUES
(1, '2019-01-01', 'Lenovo'),
(2, '2019-02-09', 'Samsung'),
(3, '2019-01-19', 'LG'),
(4, '2019-05-21', 'HP');

-- Insert into Items
INSERT INTO Market_Items (item_id, item_brand) VALUES
(1, 'Samsung'),
(2, 'Lenovo'),
(3, 'LG'),
(4, 'HP');

-- Insert into Orders
INSERT INTO Market_Orders (order_id, order_date, item_id, buyer_id, seller_id) VALUES
(1, '2019-08-01', 4, 1, 2),
(2, '2019-08-02', 2, 1, 3),
(3, '2019-08-03', 3, 2, 3),
(4, '2019-08-04', 1, 4, 2),
(5, '2019-08-04', 1, 3, 4),
(6, '2019-08-05', 2, 2, 4);

WITH CTE AS(
SELECT MU.user_id AS seller_id, MI.item_brand, MU.favorite_brand, ROW_NUMBER() OVER(PARTITION BY MU.user_id  ORDER BY MO.order_date) AS RNK FROM Market_Users MU LEFT JOIN Market_Orders MO
ON MU.user_id = MO.seller_id
LEFT JOIN Market_Items MI ON MO.item_id = MI.item_id)

SELECT MU.user_id AS seller_id, CASE WHEN seller_id is NULL THEN 'no'
WHEN C.item_brand = MU.favorite_brand THEN 'yes' 
ELSE 'no' END AS `2nd_item_fav_brand`
FROM Market_Users MU
LEFT JOIN CTE C
    ON MU.user_id = C.seller_id
    AND C.RNK = 2;
