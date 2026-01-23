CREATE TABLE Products (
    product_id INT,
    store VARCHAR(50),
    price INT
);

INSERT INTO Products (product_id, store, price) VALUES
(1, 'Shop', 110),
(1, 'LC_Store', 100),
(2, 'Nozama', 200),
(2, 'Souq', 190),
(3, 'Shop', 1000),
(3, 'Souq', 1900);

-- using if statement
select
    product_id, 
    MAX(if(store = "LC_Store", price, null)) as LC_Store,
    MAX(if(store = "Nozama", price, null)) as Nozama,
    MAX(if(store = "Shop", price, null)) as Shop,
    MAX(if(store = "Souq", price, null)) as Souq
FROM Products GROUP BY product_id

-- using case statement
SELECT product_id,
MAX(CASE WHEN store = "LC_Store" THEN price END) AS LC_Store,
MAX(CASE WHEN store = 'Nozama' THEN price END) AS Nozama,
MAX(CASE WHEN store = 'Shop' THEN price END) AS Shop,
MAX(CASE WHEN store = 'Souq' THEN price END) AS Souq
FROM Products
GROUP BY product_id
