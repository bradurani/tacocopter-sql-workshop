BEGIN;

  DROP TABLE IF EXISTS cities CASCADE;
  CREATE TABLE cities
  (
    id serial PRIMARY KEY,
    name varchar(255),
    allows_drones boolean
  );

  DROP TABLE IF EXISTS stores CASCADE;
  CREATE TABLE stores
  (
    id serial PRIMARY KEY,
    name varchar(255),
    city_id int REFERENCES cities,
    sells_beer boolean,
    zagat_rating int
  );

  DROP TABLE IF EXISTS car_washes CASCADE;
  CREATE TABLE car_washes
  (
    id serial PRIMARY KEY,
    store_id int UNIQUE REFERENCES stores,
    hot_wax boolean,
    full_detail boolean
  );

  DROP TABLE IF EXISTS tacos CASCADE;
  CREATE TABLE tacos
  (
    id serial PRIMARY KEY,
    name varchar(255),
    vegetarian boolean
  );

  DROP TABLE IF EXISTS stores_tacos CASCADE;
  CREATE TABLE stores_tacos
  (
    id serial PRIMARY KEY,
    store_id int REFERENCES stores,
    taco_id int REFERENCES tacos,
    price numeric(6, 2)
  );

  DROP TABLE IF EXISTS salsas CASCADE;
  CREATE TABLE salsas
  (
    id serial PRIMARY KEY,
    name varchar(255)
  );

  DROP TABLE IF EXISTS stores_salsas CASCADE;
  CREATE TABLE stores_salsas
  (
    id serial PRIMARY KEY,
    store_id int REFERENCES stores,
    salsa_id int REFERENCES tacos,
    spiciness int
  );

  INSERT INTO cities (id, name, allows_drones) VALUES
  (1, 'Goleta', true),
  (2, 'Santa Barbara', true),
  (3, 'Montecito', false),
  (4, 'Summerland', false),
  (5, 'Carpinteria', true),
  (6, 'La Conchita', true);

  INSERT INTO stores (id, name, city_id, sells_beer, zagat_rating) VALUES
  (1, 'Juan''s Tacos', 1, true, 6),
  (2, 'Tacos Del Gato', 1, true, 5),
  (3, 'Jeanette''s Tacos', 1, false, 8),
  (4, 'Lily''s Tacos', 2, false, 9),
  (5, 'Shivering Cactus Tacos', 2, true, 8),
  (6, 'La Super Rica', 2, true, 10),
  (7, 'Lily''s Tacos', 2, false, 8),
  (8, 'California Market', 3, false, 3),
  (9, 'Dan''s Bait Shop', 3, false, 2),
  (10, 'Archibald''s Bistro', 3, true, 6),
  (11, 'Tri Tip Market', 4, false, 8), 
  (12, 'Reyes Market', 5, false, 10),
  (13, 'Rincon Alteño', 5, false, 8),
  (14, 'Don Roge', 5, true, 9),
  (15, 'Beach Liquor', 5, false, 8),
  (16, 'Don Roge', 5, true, 8),
  (17, 'Tri Tip Market', 5, false, 8);

  INSERT INTO tacos (id, name, vegetarian) VALUES
  (1, 'Carne Asada', false),
  (2, 'Birria', false),
  (3, 'Pollo', false),
  (4, 'Al Pastor', false),
  (5, 'Carnitas', false),
  (6, 'Adobada', false),
  (7, 'Pescado', false),
  (8, 'Nopales', true),
  (9, 'Chile Relleno', true),
  (10,'Veggie', true),
  (11,'The Green Monster', true),
  (12,'Jeanette''s Mushrooms', true),
  (13,'Lilly''s Special', false),
  (14,'Lobster Alfredo', false),
  (15,'Saffron Caviar', false),
  (16,'Fillet Mignon', false),
  (17,'Braised Artichoke', true),
  (18, 'Deep Fried Buffalo', false);

  INSERT INTO salsas (id, name) VALUES
  (1, 'Tomatillo Jalapeño'),
  (2, 'Chile de Arbol'),
  (3, 'Pico de Gallo'),
  (4, 'Salsa Roja'),
  (5, 'Habeñero'),
  (6, 'Salsa de Piña'),
  (7, 'Salsa Don Roge'),
  (8, 'Lily''s Devil Worship'),
  (9, 'Sweet Mango and Radish');

  INSERT INTO car_washes(store_id, hot_wax, full_detail) VALUES
  (1, true, false),
  (9, false, false),
  (11, true, true),
  (17, true, true);

  INSERT INTO stores_tacos (store_id, taco_id, price) VALUES
  (1, 1, 3.50),
  (1, 2, 3.50),
  (1, 3, 3.50),
  (1, 4, 3.50),
  (1, 5, 3.50),
  (1, 6, 3.50),
  (2, 1, 4.00),
  (2, 2, 3.75),
  (2, 3, 3.00),
  (2, 4, 3.50),
  (2, 5, 3.75),
  (2, 6, 3.50),
  (3, 8, 4.00),
  (3, 9, 4.00),
  (3, 10, 4.00),
  (3, 11, 4.50),
  (3, 12, 4.50),
  (4, 1, 3.50),
  (4, 2, 3.50),
  (4, 3, 3.50),
  (4, 4, 3.50),
  (4, 5, 3.50),
  (4, 10, 3.50),
  (4, 13, 3.50),
  (5, 8, 3.25),
  (5, 9, 3.25),
  (5, 10, 3.25),
  (6, 1, 4.24),
  (6, 2, 4.50),
  (6, 3, 4.40),
  (6, 9, 5.00),
  (7, 1, 3.50),
  (7, 2, 3.50),
  (7, 3, 3.50),
  (7, 4, 3.50),
  (7, 5, 3.50),
  (7, 10, 3.50),
  (7, 13, 3.50),
  (8, 1, 4.00),
  (8, 2, 4.00),
  (8, 7, 4.00),
  (8, 8, 4.00),
  (9, 7, 4.50),
  (10, 14, 8.00),
  (10, 15, 9.00),
  (10, 16, 9.50),
  (10, 17, 10.00),
  (11, 1, 4.50),
  (11, 2, 4.00),
  (12, 1, 3.50),
  (12, 2, 3.50),
  (12, 3, 3.50),
  (12, 4, 3.50),
  (12, 5, 3.50),
  (12, 6, 3.50),
  (12, 7, 3.50),
  (12, 8, 3.50),
  (13, 1, 2.95),
  (13, 2, 2.95),
  (13, 3, 2.95),
  (13, 10, 2.50),
  (14, 2, 3.25), 
  (14, 3, 3.25),
  (14, 4, 3.25),
  (14, 5, 3.25),
  (14, 6, 3.25),
  (14, 7, 3.25),
  (15, 1, 3.50),
  (15, 2, 3.50),
  (15, 3, 3.50),
  (15, 4, 3.50),
  (15, 5, 3.50),
  (15, 6, 3.50),
  (16, 2, 3.25), 
  (16, 3, 3.25),
  (16, 4, 3.25),
  (16, 5, 3.25),
  (16, 6, 3.25),
  (16, 7, 3.25),
  (16, 8, 3.25),
  (16, 9, 3.25),
  --17. Tri Tip Market --same menu different city
  (17, 1, 4.50),
  (17, 2, 4.00);


INSERT INTO stores_salsas (store_id, salsa_id, spiciness) VALUES
   --Goletta
  --1. Juan's tacos #all same price, no vegetarian
  (1, 1, 5),
  (1, 3, 2),
  (1, 5, 8),
  --2. Taco's Del Gato -- same menu different prices and different salsas
  (2, 2, 7),
  (2, 4, 6),
  (2, 6, 2),
  --3. Jeanette's Tacos
  (3, 3, 2),
  (3, 4, 6),
  --Santa Barbara
  --4. Lilly's Tacos --all same price, 1 special, spiciest on avg.
  (4, 1, 7),
  (4, 2, 8),
  (4, 3, 6), --spiciest pico
  (4, 4, 7),
  (4, 5, 9),
  (4, 8, 10),
  --5. Shivering Cactus --vegetarian
  (5, 1, 2), --mildest tomatillo
  (5, 3, 2),
  (5, 6, 2),
  --6. La Super Rica
  (6, 1, 6),
  (6, 2, 8),
  (6, 3, 2),
  (6, 5, 8),
  --7. Lilly's Tacos #2 --exact same menu
  (7, 1, 7),
  (7, 2, 8),
  (7, 3, 6), --spiciest pico
  (7, 4, 7),
  (7, 5, 9),
  (7, 8, 10),
  --Montecito--
  --8. California Market --no pork
  (8, 1, 5),
  (8, 2, 5),
  (8, 3, 6),
  --9. Dan's Bait Shop -- only 1 type (fish)
  (9, 1, 6),
  (9, 4, 7),
  --10. Archibald's Bistro
  (10, 3, 2),
  --Summerland
  --11. Tri-Tip Market --only beef
  (11, 1, 2), --mildest tomatillo
  (11, 3, 2),
  (11, 6, 2),
  --Carpinteria
  --12. Reyes Market -Largest selection
  (12, 1, 8),
  (12, 4, 8),
  (12, 5, 9),
  --13. Rincoln Alteno
  (13, 3, 4),
  --14. Don Roge #1 --largest selection of non vegetarian
  (14, 1, 8),
  (14, 2, 8),
  (14, 3, 4),
  (14, 4, 7),
  (14, 5, 9),
  (14, 6, 2),
  (14, 7, 7), --speciality Don Roge
  --15. Beach Liquor --same menu as Juan's, same salsas, different spiciness, different city
  (1, 1, 6),
  (1, 3, 6),
  (1, 5, 7),
  --16. Don Roge #2 -- same menu plus additional
  (16, 1, 8),
  (16, 2, 8),
  (16, 3, 4), 
  (16, 4, 7),
  (16, 5, 9),
  (16, 6, 2),
  --17. Tri Tip Market --same menu different city
  (11, 1, 2), --mildest tomatillo
  (11, 3, 2),
  (11, 6, 2);

COMMIT;



