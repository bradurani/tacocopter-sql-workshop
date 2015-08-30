-- SELECT * 
-- FROM cities
-- INNER JOIN stores ON cities.id = stores.city_id;

-- SELECT stores.name, car_washes.hot_wax, car_washes.full_detail
-- FROM stores
-- JOIN car_washes ON stores.id = car_washes.store_id;

-- SELECT stores.name
-- FROM stores
-- LEFT OUTER JOIN car_washes ON stores.id = car_washes.store_id
-- WHERE car_washes.id IS NULL
-- ORDER BY stores.id;

-- SELECT sub.name as city_name, stores.name, sub.max_rating
-- FROM (
--   SELECT cities.id, cities.name, MAX(stores.zagat_rating) AS max_rating
--   FROM cities
--   JOIN stores ON cities.id = stores.city_id
--   GROUP BY cities.id
-- ) as sub
-- JOIN stores ON sub.max_rating = stores.zagat_rating
--             AND sub.id = stores.city_id;
-- SELECT stores.name, SUM(store_tacos.price)
-- FROM stores
-- JOIN store_tacos ON stores.id = store_tacos.store_id
-- GROUP BY stores.id;

-- SELECT stores.*
-- FROM stores
-- JOIN store_salsas ON stores.id = store_salsas.store_id
-- WHERE store_salsas.salsa_id = 2;

-- SELECT stores.*, COUNT(*)
-- FROM stores
-- JOIN store_tacos ON stores.id = store_tacos.store_id
-- JOIN tacos on store_tacos.taco_id = tacos.id
-- WHERE tacos.vegetarian
-- GROUP BY stores.id;

-- SELECT stores.*, count(tacos.id)
-- FROM stores
-- JOIN store_tacos ON stores.id = store_tacos.store_id
-- LEFT JOIN tacos ON store_tacos.taco_id = tacos.id
--                 AND tacos.vegetarian
-- GROUP BY stores.id;

-- SELECT stores.*, COUNT(*)
-- FROM stores
-- JOIN store_tacos ON stores.id = store_tacos.store_id
-- JOIN tacos on store_tacos.taco_id = tacos.id
-- WHERE tacos.vegetarian
-- AND store_tacos.price < 3
-- GROUP BY stores.id;

--Stores with and number of vegetarian taco less than $5 with zeros
--Store and number of vegetarian tacos with zeros:
-- SELECT stores.*, count(tacos.id)
-- FROM stores
-- JOIN store_tacos ON stores.id = store_tacos.store_id
-- LEFT JOIN tacos ON store_tacos.taco_id = tacos.id
--                 AND tacos.vegetarian
--                 AND store_tacos.price < 3
-- GROUP BY stores.id;

-- SELECT stores.*, count(veggie.id) as veggie_count, count(cheap.id) as cheap_count
-- FROM stores
-- JOIN store_tacos ON stores.id = store_tacos.store_id
-- LEFT JOIN tacos as veggie ON store_tacos.taco_id = veggie.id
--                           AND veggie.vegetarian
-- LEFT JOIN tacos as cheap ON store_tacos.taco_id = cheap.id
--                          AND store_tacos.price < 3.50
-- GROUP BY stores.id;

-- SELECT DISTINCT stores.*
-- FROM stores
-- JOIN store_tacos ON stores.id = store_tacos.store_id
-- JOIN tacos AS veggie ON store_tacos.taco_id = veggie.id
--                      AND veggie.vegetarian
-- JOIN tacos AS cheap ON store_tacos.taco_id = cheap.id
--                     AND store_tacos.price < 3.50

-- SELECT *
-- FROM stores
-- JOIN store_tacos AS pastor ON stores.id = pastor.store_id
--                            AND pastor.taco_id = 4
-- JOIN store_tacos AS birria ON stores.id = birria.store_id
--                            AND birria.taco_id = 2
-- JOIN store_salsas ON stores.id = store_salsas.store_id
-- WHERE store_salsas.salsa_id = 2
-- AND stores.zagat_rating > 7;
-- SELECT cities.name, stores.name, stores.zagat_rating
-- FROM cities
-- JOIN stores ON cities.id = stores.city_id
-- JOIN (
--   SELECT cities.id as city_id, MAX(zagat_rating) as max_rating
--   FROM cities
--   JOIN stores on cities.id = stores.city_id
--   GROUP BY cities.id
-- ) AS sub ON sub.city_id = cities.id 
--          AND stores.zagat_rating = max_rating; 

-- SELECT cities.name, COUNT(*) as store_count
-- FROM cities
-- JOIN stores ON cities.id = stores.city_id
-- GROUP BY cities.id
-- HAVING count(*) > 5;

-- SELECT stores.name, SUM(store_tacos.price)
-- FROM stores
-- JOIN store_tacos ON stores.id = store_tacos.store_id
-- WHERE stores.id IN (
--   SELECT store_tacos.store_id
--   FROM store_tacos
--   WHERE store_tacos.taco_id = 1
-- )
-- GROUP BY stores.id;

-- SELECT stores.name, SUM(store_tacos.price)
-- FROM stores
-- JOIN store_tacos ON stores.id = store_tacos.store_id
-- WHERE stores.id IN (
--   SELECT store_tacos.store_id
--   FROM store_tacos
--   WHERE store_tacos.taco_id = 1
-- ) 
-- AND stores.id IN (
--   SELECT store_salsas.store_id
--   FROM store_salsas
--   WHERE store_salsas.salsa_id = 3
-- )
-- GROUP BY stores.id;

-- SELECT stores.name, SUM(store_tacos.price)
-- FROM stores
-- JOIN store_tacos ON stores.id = store_tacos.store_id
-- WHERE stores.id IN (
--   SELECT stores.id
--   FROM stores
--   JOIN store_tacos ON stores.id = store_tacos.store_id
--                    AND store_tacos.taco_id = 1
--   JOIN store_salsas ON stores.id = store_salsas.store_id
--                     AND store_salsas.salsa_id = 3
-- ) 
-- GROUP BY stores.id;

-- SELECT DISTINCT stores.*
-- FROM stores
-- JOIN store_tacos ON stores.id = store_tacos.store_id
--                  AND store_tacos.taco_id = 1
-- JOIN store_salsas ON stores.id = store_salsas.store_id
--                   AND store_salsas.salsa_id = 3;

-- SELECT stores.*
-- FROM stores
-- WHERE stores.id NOT IN (
--   SELECT stores.id
--   FROM stores
--   JOIN store_tacos ON stores.id = store_tacos.store_id
--   WHERE store_tacos.price < 5
-- );

-- SELECT stores.*
-- FROM stores
-- WHERE stores.id NOT IN (
--   SELECT stores.id
--   FROM stores
--   JOIN store_salsas ON stores.id = store_salsas.store_id
--   WHERE store_salsas.spiciness > 7
-- );

-- SELECT stores.*
-- FROM stores
-- WHERE stores.id NOT IN (
--   SELECT stores.id
--   FROM stores
--   JOIN store_salsas ON stores.id = store_salsas.store_id
--   WHERE store_salsas.spiciness > 7
-- )
-- AND stores.city_id = 3;

SELECT cities.name, COUNT(*)
FROM stores
JOIN cities ON stores.city_id = cities.id
WHERE stores.id NOT IN (
  SELECT stores.id
  FROM stores
  JOIN store_tacos ON stores.id = store_tacos.store_id
  JOIN tacos ON store_tacos.taco_id = tacos.id
  WHERE tacos.vegetarian = false
)
GROUP BY cities.id;
