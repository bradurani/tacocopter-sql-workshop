\c postgres
DROP DATABASE IF EXISTS tacocopter;
CREATE DATABASE tacocopter;
\c tacocopter

BEGIN;

  CREATE TABLE cities
  (
    id serial PRIMARY KEY,
    name varchar(255),
    allows_drones boolean
  );

  CREATE TABLE stores
  (
    id serial PRIMARY KEY,
    name varchar(255),
    city_id int REFERENCES cities,
    sells_beer boolean,
    zagat_rating int
  );

  CREATE TABLE tacos
  (
    id serial PRIMARY KEY,
    name varchar(255),
    vegetarian boolean
  );

  CREATE TABLE store_tacos
  (
    id serial PRIMARY KEY,
    store_id int REFERENCES stores,
    taco_id int REFERENCES tacos,
    price money
  );

  CREATE TABLE salsas
  (
    id serial PRIMARY KEY,
    name varchar(255)
  );

  CREATE TABLE store_salsas
  (
    id serial PRIMARY KEY,
    store_id int REFERENCES stores,
    salsa_id int REFERENCES tacos,
    spiciness int
  );

  INSERT INTO cities (id, name, allows_drones) VALUES
  (1, 'Goletta', true),
  (2, 'Santa Barbara', true),
  (3, 'Montecito', false),
  (4, 'Summerland', false),
  (5, 'Carpinteria', true);

  INSERT INTO stores (id, name, city_id, sells_beer, zagat_rating) VALUES
  --1. Goletta
  (1, 'Juan''s Tacos', 1, true, 6),
  (2, 'Tacos Del Gato', 1, false, 5),
  (3, 'Jeanette''s Tacos', 1, false, 8), --vegetarian
  --2. Santa Barbara
  (4, 'Lily''s Tacos', 2, false, 9),
  (5, 'Shivering Cactus Tacos', 2, true, 8), --vegetarian
  (6, 'La Super Rica', 2, true, 10),
  (7, 'Lily''s Tacos', 2, false, 8), --same name, same cities, different ratings
  --3. Montecito #all rated lower than 7
  (8, 'California Market', 3, false, 3),
  (9, 'Dan''s Bait Shop', 3, false, 2),
  (10, 'Archibald''s Bistro', 3, true, 6), --most expensive
  --4. Summerland #none serving beer
  (11, 'Tri Tip Market', 4, false, 8), 
  --5 Carpinteria
  (12, 'Reyes Market', 5, false, 10),
  (13, 'Rincon Alteño', 5, false, 8),
  (14, 'Don Roge', 5, true, 9),
  (15, 'Beach Liquor', 5, false, 8),
  (16, 'Don Roge', 5, true, 8), --same name, same cities, different ratings
  (17, 'Tri Tip Market', 5, false, 8); --same name different cities

  INSERT INTO tacos (id, name, vegetarian) VALUES
  (1, 'Carne Asada', false),
  (2, 'Birria', false), #beef
  (3, 'Pollo', false),
  (4, 'Al Pastor', false),
  (5, 'Carnitas', false),
  (6, 'Adobada', false),
  (7, 'Pescado', false),
  (8, 'Nopales', true),
  (9, 'Chile Relleno', true),
  (10,'Veggie', true),
  (11,'The Green Monster', true), #Jeanette's special
  (12,'Lilly''s Special', false),
  (13, )


  INSERT INTO salsas (id, name) VALUES
  (1, 'Tomatillo Jalapeño'),
  (2, 'Chile de Arbol'),
  (3, 'Pico de Gallo'),
  (4, 'Salsa Roja'),
  (5, 'Salsa de Piña'),
  (6, 'Salsa Don Roge'),
  (7, 'Lily''s Devil Worship');

COMMIT;



