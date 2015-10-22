ActiveRecord::Base.connection.execute(IO.read("db/tacocopter.sql"))

Answer.destroy_all
Question.destroy_all
Answer.connection.execute('ALTER SEQUENCE answers_id_seq RESTART WITH 1')
Question.connection.execute('ALTER SEQUENCE questions_id_seq RESTART WITH 1')

def create_question(q, a)
  q = Question.create!({
    question: q
  })
  q.answers.create!(answer: a)
  q.output
  q
end

#--------------SELECTING---------------

create_question "All rows and columns from the <code>cities</code> table",
"SELECT *
 FROM cities;"

create_question "All rows from the <code>stores</code> table",
"SELECT * 
 FROM stores;"

create_question "All rows from the <code>salsas</code> table",
"SELECT * 
 FROM salsas;"

create_question "All rows from the <code>tacos</code> table", 
"SELECT * 
 FROM tacos;"

create_question "<code>name</code> and <code>zagat_rating</code> from the <code>stores</code> table",
"SELECT stores.name, stores.zagat_rating
 FROM stores;"

create_question '<code>name</code> from the <code>salsas</code> table',
"SELECT name 
 FROM salsas;"

 create_question '<code>name</code> and <code>vegetarian</code> from the <code>tacos</code> table',
"SELECT name, vegetarian 
 FROM tacos;"

create_question '<code>name</code> and <code>allows_drones</code> from the <code>cities</code> table',
"SELECT name, allows_drones 
 FROM cities;"

#---Filtering---

create_question 'All fields from the <code>cities</code> table for cities that allow drones',
"SELECT * 
 FROM cities 
 WHERE allows_drones = true;"

create_question 'All fields from the <code>stores</code> table for stores with a Zagat rating greater than 7',
"SELECT * 
 FROM stores 
 WHERE zagat_rating > 7;"

create_question '<code>name</code> from the <code>stores</code> table for stores with a Zagat rating greater than or equal to 8',
"SELECT name 
 FROM stores 
 WHERE zagat_rating >= 8;"

create_question '<code>name</code> from the <code>tacos</code> table for vegetarian tacos',
"SELECT name 
 FROM tacos 
 WHERE vegetarian=true;"

create_question '<code>id</code> and <code>name</code> from the <code>stores</code> table for stores that have a Zagat rating less than 5 and don&apos;t sell beer',
"SELECT id, name 
 FROM stores 
 WHERE zagat_rating < 5 
 AND sells_beer = false;"

create_question '<code>name</code> and <code>zagat_rating</code> from <code>stores</code> for stores that have either have a Zagat rating greater than 8, or have a Zagat rating greater than 5 and sell beer',
"SELECT name, zagat_rating 
 FROM stores 
 WHERE zagat_rating > 8 
 OR (zagat_rating > 5 AND sells_beer = true);"

create_question '<code>name</code>, <code>zagat_rating</code>, and <code>sells_beer</code> from <code>stores</code> for stores that have either have a Zagat rating less than 5, or have a Zagat rating less than than 7 and don&apos;t sell beer',
"SELECT name, zagat_rating, sells_beer 
 FROM stores 
 WHERE zagat_rating < 5 
 OR (zagat_rating < 7 AND sells_beer = false);"

create_question 'All fields from <code>stores</code> that have a <code>zagat_rating</code> between 5 and 7',
"SELECT * 
 FROM stores 
 WHERE zagat_rating 
 BETWEEN 5 AND 7;"

 create_question 'All fields from tacos for Pollo and Carne Asada tacos',
 "SELECT *
  FROM tacos
  WHERE tacos.id IN (1, 3)"

#--inner join--

create_question 'All fields from <code>stores</code> plus all fields from the <code>cities</code> they are in',
"SELECT * 
 FROM stores 
 JOIN cities ON stores.city_id = cities.id;"

create_question '<code>name</code> from <code>stores</code> and <code>allows_drones</code> from the city they are in',
"SELECT stores.name, cities.allows_drones 
 FROM stores 
 JOIN cities ON stores.city_id = cities.id;"

create_question '<code>name</code> from <code>cites</code> as <code>city_name</code> and <code>name</code> from <code>stores</code> as <code>store_name</code> for all stores',
"SELECT cities.name as city_name, stores.name as store_name 
 FROM cities 
 JOIN stores 
 ON cities.id = stores.city_id;"

create_question 'All fields from <code>stores</code> plus all fields from the <code>cities</code> they are in for cities that allow drones',
"SELECT * 
 FROM stores 
 JOIN cities ON stores.city_id = cities.id 
 WHERE cities.allows_drones = true;"

create_question 'All fields from <code>stores</code> plus all fields from the <code>salsas</code> they serve',
"SELECT stores.*, salsas.* 
 FROM stores 
 JOIN stores_salsas ON stores.id = stores_salsas.store_id
 JOIN salsas ON stores_salsas.salsa_id = salsas.id;"

create_question 'All fields from <code>stores</code> plus all fields from the <code>tacos</code> they serve',
"SELECT stores.*, tacos.* 
 FROM stores 
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 JOIN tacos ON stores_tacos.taco_id = tacos.id;"

create_question '<code>name</code> from <code>stores</code>, <code>name</code> from <code>tacos</code>, and <code>price</code>',
"SELECT stores.name, tacos.name, stores_tacos.price 
 FROM stores 
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 JOIN tacos ON stores_tacos.taco_id = tacos.id;"

#--Filtering with JOIN

create_question 'All fields from <code>stores</code> plus all fields from the <code>cities</code> they are in for stores with a Zagat rating greater than 8',
"SELECT * 
 FROM stores 
 JOIN cities ON stores.city_id = cities.id 
 WHERE stores.zagat_rating > 8;"

create_question 'All fields from <code>stores</code> with Chile de Arbol Salsa',
"SELECT stores.*
 FROM stores
 JOIN stores_salsas ON stores.id = stores_salsas.store_id
 WHERE stores_salsas.salsa_id = 2;"

create_question 'All fields from <code>stores</code> plus all fields from the <code>tacos</code> they serve if they&apos;re vegetarian',
"SELECT stores.*, tacos.* 
 FROM stores 
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 JOIN tacos ON stores_tacos.taco_id = tacos.id
 WHERE tacos.vegetarian = true;"

create_question 'All fields from <code>stores</code> plus all fields from the <code>cities</code> they are in for cities that allow drones and stores that serve beer and have a zagat rating greater than 7',
"SELECT stores.*, cities.* 
 FROM stores 
 JOIN cities ON stores.city_id = cities.id 
 WHERE cities.allows_drones = true 
 AND stores.sells_beer = true 
 AND stores.zagat_rating > 7;"

create_question 'All fields from <code>stores</code> plus all fields from the <code>salsas</code> they serve if the store sells beer',
"SELECT stores.*, salsas.* 
 FROM stores 
 JOIN stores_salsas ON stores.id = stores_salsas.store_id
 JOIN salsas ON stores_salsas.salsa_id = salsas.id
 WHERE stores.sells_beer = true;"

create_question 'All fields from <code>stores</code> plus all fields from the <code>salsas</code> they serve if the spiciness is 8 or 7',
"SELECT stores.*, salsas.* 
 FROM stores 
 JOIN stores_salsas ON stores.id = stores_salsas.store_id
 JOIN salsas ON stores_salsas.salsa_id = salsas.id
 WHERE stores_salsas.spiciness IN (8, 7);"

create_question '<code>name</code> from <code>stores</code>, <code>name</code> from <code>tacos</code>, and </code>price</code> where the store sells beer, the taco is not vegetarian and the price is less $3.50',
"SELECT stores.name, tacos.name, stores_tacos.price 
 FROM stores 
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 JOIN tacos ON stores_tacos.taco_id = tacos.id
 WHERE stores.sells_beer = true
 AND tacos.vegetarian = false
 AND stores_tacos.price < 3.50;"

create_question 'name from <code>stores</code>, name from <code>cities</code>, name from <code>salsas</code>, and spiciness where the city allows drones and the salsa spiciness is between 4 and 6',
"SELECT stores.name, cities.name, salsas.name, stores_salsas.spiciness 
 FROM stores 
 JOIN cities ON stores.city_id = cities.id
 JOIN stores_salsas ON stores.id = stores_salsas.store_id
 JOIN salsas ON stores_salsas.salsa_id = salsas.id
 WHERE cities.allows_drones = true
 AND stores_salsas.spiciness BETWEEN 4 AND 6;"

create_question 'Stores with Al Pastor tacos and Chile de Arbol Salsa',
"SELECT stores.*
FROM stores
JOIN stores_salsas ON stores.id = stores_salsas.store_id
JOIN stores_tacos ON stores.id = stores_tacos.store_id
WHERE stores_salsas.salsa_id = 2
AND stores_tacos.taco_id = 4;"

create_question 'Stores with Al Pastor tacos and Zagat rating > 9 and and Chile de Arbol Salsa',
"SELECT stores.*
 FROM stores
 JOIN stores_salsas ON stores.id = stores_salsas.store_id
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 WHERE stores_salsas.salsa_id = 2
 AND stores_tacos.taco_id = 4
 AND stores.zagat_rating > 8;"

create_question 'Stores with Al Pastor tacos and Zagat rating > 9 and Chile de Arbol Salsa with spiciness higher than 7',
"SELECT stores.*
FROM stores
JOIN stores_salsas ON stores.id = stores_salsas.store_id
JOIN stores_tacos ON stores.id = stores_tacos.store_id
WHERE stores_salsas.salsa_id = 2
AND stores_tacos.taco_id = 4
AND stores.zagat_rating > 8
AND stores_salsas.spiciness > 7;"

create_question 'All fields from <code>stores</code> with a vegetarian taco',
"SELECT DISTINCT stores.*
 FROM stores 
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 JOIN tacos ON stores_tacos.taco_id = tacos.id
 WHERE tacos.vegetarian = true;"

create_question 'Stores with vegetarian tacos with price < $3.50',
"SELECT DISTINCT stores.*
 FROM stores
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 JOIN tacos on stores_tacos.taco_id = tacos.id
 WHERE tacos.vegetarian
 AND stores_tacos.price < 3.50;" 

create_question 'Stores with vegetarian tacos and tacos < $3.50',
"SELECT DISTINCT stores.*
 FROM stores
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 JOIN tacos AS veggie ON stores_tacos.taco_id = veggie.id
                      AND veggie.vegetarian
 JOIN tacos AS cheap ON stores_tacos.taco_id = cheap.id
                     AND stores_tacos.price < 3.50;"

#--Left Join--
create_question 'Store name and zagat rating for stores that have hot wax',
"SELECT stores.name, stores.zagat_rating
 FROM stores
 JOIN car_washes ON stores.id = car_washes.store_id
 WHERE car_washes.hot_wax = true;"

create_question 'Store <code>name</code>, <code>sells_beer<code>, and <code>hot_wax<code> for all stores',
"SELECT stores.name, stores.sells_beer, car_washes.hot_wax
 FROM stores
 LEFT JOIN car_washes ON stores.id = car_washes.store_id;"

create_question 'Store <code>name</code>, city <code>name</code> and <code>hot_wax</code> for all stores',
"SELECT stores.name, cities.name, car_washes.hot_wax
 FROM stores
 LEFT JOIN car_washes ON stores.id = car_washes.store_id
 JOIN cities ON stores.city_id = cities.id;"

create_question 'Store <code>name</code>, and spiciness of Pico de Gallo if they have it',
"SELECT stores.name, stores_salsas.spiciness
 FROM stores
 LEFT JOIN stores_salsas ON stores.id = stores_salsas.store_id
                        AND stores_salsas.salsa_id = 3;"

create_question 'City <code>name</code> and <code>hot_wax</code> for all cities, even if they have no stores',
"SELECT cities.name, car_washes.hot_wax
 FROM cities 
 LEFT JOIN stores ON cities.id = stores.city_id
 LEFT JOIN car_washes ON stores.id = car_washes.store_id;"

create_question 'Store <code>name</code>, <code>hot_wax</code> and price of Al Pastor taco if they have it',
"SELECT stores.name, car_washes.hot_wax, stores_tacos.price
 FROM stores
 LEFT JOIN car_washes ON stores.id = car_washes.store_id
 LEFT JOIN stores_tacos ON stores.id = stores_tacos.store_id
                       AND stores_tacos.taco_id = 4;"

q = create_question 'Store name for stores that don&apos;t have a car wash',
"SELECT stores.name 
 FROM stores
 LEFT JOIN car_washes ON stores.id = car_washes.store_id
 WHERE car_washes.id IS NULL;"
q.answers.create({ answer: 'SELECT stores.name
                  FROM stores
                  WHERE stores.id NOT IN
                  (SELECT store_id 
                   FROM car_washes);'})
q = create_question 'Stores that don&apos;t serve an Al Pastor taco',
"SELECT stores.*
 FROM stores
 LEFT JOIN stores_tacos ON stores.id = stores_tacos.store_id
                       AND stores_tacos.taco_id = 4
WHERE stores_tacos.id IS NULL;"
q.answers.create!({answer: "SELECT stores.*
                           FROM stores 
                           WHERE stores.id NOT IN (
                             SELECT id
                             FROM stores
                             JOIN stores_tacos ON stores.id = stores_tacos.store_id
                             WHERE stores_tacos.taco_id = 4
                           )"})

#--Aggregating--
  
create_question 'All rows from <code>cities</code> and number of stores',
"SELECT cities.id, cities.name, COUNT(stores.*)
 FROM cities JOIN stores ON cities.id = stores.city_id
 GROUP BY cities.id;"

 create_question 'All rows from <code>cities</code> and number of stores including cities with zero',
"SELECT cities.id, cities.name, COUNT(stores.*)
 FROM cities LEFT JOIN stores ON cities.id = stores.city_id
 GROUP BY cities.id;"

create_question '<code>id</code> and <code>name</code> from <code>cities</code> with highest Zagat rating and avgerage Zagat rating',
"SELECT cities.id, cities.name, MAX(stores.zagat_rating) AS max_rating, AVG(stores.zagat_rating) as avg_rating
 FROM cities JOIN stores ON cities.id = stores.city_id
 GROUP BY cities.id;"

create_question 'Store name and price of taco bonanza',
"SELECT stores.name, SUM(stores_tacos.price)
 FROM stores
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 GROUP BY stores.id;"

 create_question 'Store and number of vegetarian tacos:',
"SELECT stores.*, COUNT(*)
 FROM stores
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 JOIN tacos on stores_tacos.taco_id = tacos.id
 WHERE tacos.vegetarian
 GROUP BY stores.id;"

create_question 'Stores and number of vegetarian taco less than $3.50',
"SELECT stores.*, COUNT(*)
 FROM stores
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 JOIN tacos ON stores_tacos.taco_id = tacos.id
 WHERE tacos.vegetarian
 AND stores_tacos.price < 3.50
 GROUP BY stores.id;"

create_question 'Stores and number of vegetarian tacos with including stores with none',
"SELECT stores.*, count(tacos.id)
 FROM stores
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 LEFT JOIN tacos ON stores_tacos.taco_id = tacos.id
                 AND tacos.vegetarian
 GROUP BY stores.id;"

create_question 'Stores and number of vegetarian taco less than $3.50 with including stores with none',
"SELECT stores.*, count(tacos.id)
 FROM stores
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 LEFT JOIN tacos ON stores_tacos.taco_id = tacos.id
                 AND tacos.vegetarian
                 AND stores_tacos.price < 3.50
 GROUP BY stores.id;"

 create_question 'City and rating of highest rated store by city',
"SELECT cities.name, MAX(zagat_rating)
 FROM cities
 JOIN stores ON cities.id = stores.city_id
 GROUP BY cities.id;"

 create_question 'Price of most expensive taco by city',
"SELECT cities.name, MAX(stores_tacos.price)
 FROM cities
 JOIN stores ON cities.id = stores.city_id
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 GROUP BY cities.id"

create_question 'City and number of stores for cities with more than 5 stores',
"SELECT cities.name, COUNT(*) as store_count
 FROM cities
 JOIN stores ON cities.id = stores.city_id
 GROUP BY cities.id
 HAVING count(*) > 5;"


#--Advanced Joining

create_question 'Stores with carne asada tacos and chili de arbol salsa',
"SELECT DISTINCT stores.*
 FROM stores
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
                  AND stores_tacos.taco_id = 1
 JOIN stores_salsas ON stores.id = stores_salsas.store_id
                   AND stores_salsas.salsa_id = 3;"

create_question 'Stores with carne asada tacos and pollo tacos',
"SELECT DISTINCT stores.*
 FROM stores
 JOIN stores_tacos AS carne ON stores.id = carne.store_id
                  AND carne.taco_id = 1
 JOIN stores_tacos AS pollo ON stores.id = pollo.store_id
                           AND pollo.taco_id = 3;"

create_question 'Stores with veggie tacos and tacos for less than $3.50',
"SELECT DISTINCT stores.*
 FROM stores
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 JOIN tacos AS veggie ON stores_tacos.taco_id = veggie.id
                     AND veggie.vegetarian = true
 JOIN tacos AS cheap ON stores_tacos.taco_id = cheap.id
                     AND stores_tacos.price < 3.50;"

create_question 'Stores and number of vegetarian, and number of cheap tacos including stores with none',
"SELECT stores.*, count(veggie.id) as veggie_count, count(cheap.id) as cheap_count
 FROM stores
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 LEFT JOIN tacos as veggie ON stores_tacos.taco_id = veggie.id
                           AND veggie.vegetarian
 LEFT JOIN tacos as cheap ON stores_tacos.taco_id = cheap.id
                          AND stores_tacos.price < 3.50
 GROUP BY stores.id;"

create_question 'Stores with Al Pastor and Birria and Zagat rating > 7 and Chile de Arbol Salsa',
"SELECT *
 FROM stores
 JOIN stores_tacos AS pastor ON stores.id = pastor.store_id
                           AND pastor.taco_id = 4
 JOIN stores_tacos AS birria ON stores.id = birria.store_id
                           AND birria.taco_id = 2
 JOIN stores_salsas ON stores.id = stores_salsas.store_id
 WHERE stores_salsas.salsa_id = 2
 AND stores.zagat_rating > 7;"

create_question 'City name and count of vegetarian stores',
"SELECT cities.name, COUNT(*)
 FROM stores
 JOIN cities ON stores.city_id = cities.id
 WHERE stores.id NOT IN (
   SELECT stores.id
   FROM stores
   JOIN stores_tacos ON stores.id = stores_tacos.store_id
   JOIN tacos ON stores_tacos.taco_id = tacos.id
   WHERE tacos.vegetarian = false
)
GROUP BY cities.id;"

#--Subselects in WHERE--

create_question 'store name and price of taco bonanza for stores that sell a Carne Asada',
"SELECT stores.name, SUM(stores_tacos.price)
 FROM stores
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 WHERE stores.id IN (
   SELECT stores_tacos.store_id
   FROM stores_tacos
   WHERE stores_tacos.taco_id = 1
)
GROUP BY stores.id;"

q = create_question 'store name and price of taco bonanza for stores that sell a Carne Asada and Pico de Gallo',
"SELECT stores.name, SUM(stores_tacos.price)
 FROM stores
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 WHERE stores.id IN (
   SELECT stores_tacos.store_id
   FROM stores_tacos
   WHERE stores_tacos.taco_id = 1
) 
AND stores.id IN (
   SELECT stores_salsas.store_id
   FROM stores_salsas
   WHERE stores_salsas.salsa_id = 3
)
GROUP BY stores.id;"
q.answers.create!({
  answer: "SELECT stores.name, SUM(stores_tacos.price)
           FROM stores
           JOIN stores_tacos ON stores.id = stores_tacos.store_id
           WHERE stores.id IN (
             SELECT stores.id
             FROM stores
             JOIN stores_tacos ON stores.id = stores_tacos.store_id
                              AND stores_tacos.taco_id = 1
             JOIN stores_salsas ON stores.id = stores_salsas.store_id
                               AND stores_salsas.salsa_id = 3
            )
            GROUP BY stores.id;"
})

create_question 'List of stores with no tacos less than $5',
"SELECT stores.*
 FROM stores
 WHERE stores.id NOT IN (
   SELECT stores.id
   FROM stores
   JOIN stores_tacos ON stores.id = stores_tacos.store_id
   WHERE stores_tacos.price < 5
);"

create_question 'List of stores with no salsa spicier than 7',
"SELECT stores.*
 FROM stores
 WHERE stores.id NOT IN (
   SELECT stores.id
   FROM stores
   JOIN stores_salsas ON stores.id = stores_salsas.store_id
   WHERE stores_salsas.spiciness > 7
 );"

create_question 'List of stores in Montecito with no salsa spicier than 7',
"SELECT stores.*
 FROM stores
 WHERE stores.id NOT IN (
   SELECT stores.id
   FROM stores
   JOIN stores_salsas ON stores.id = stores_salsas.store_id
   WHERE stores_salsas.spiciness > 7
)
AND stores.city_id = 3;"

create_question 'List of stores in Montecito or Santa Barbara with no salsa spicier than 7',
"SELECT stores.*
 FROM stores
 WHERE stores.id NOT IN (
   SELECT stores.id
   FROM stores
   JOIN stores_salsas ON stores.id = stores_salsas.store_id
   WHERE stores_salsas.spiciness > 7
)
AND stores.city_id IN (3, 2);"

create_question 'Stores that are serve only vegetarian tacos',
"SELECT *
 FROM stores
 WHERE stores.id NOT IN (
   SELECT stores.id
   FROM stores
   JOIN stores_tacos ON stores.id = stores_tacos.store_id
   JOIN tacos ON stores_tacos.taco_id = tacos.id
   WHERE tacos.vegetarian = false
);"

#--- Subselect in FROM ----

create_question 'City name, store name and Zagat rating of store with highest rating by city',
"SELECT sub.name as city_name, stores.name as store_name, sub.max_rating as rating
 FROM (
   SELECT cities.id, cities.name, MAX(stores.zagat_rating) AS max_rating
   FROM cities
   JOIN stores ON cities.id = stores.city_id
   GROUP BY cities.id
 ) as sub
 JOIN stores ON sub.max_rating = stores.zagat_rating
             AND sub.id = stores.city_id;"


create_question 'City, rating and name of highest rated store by city',
"SELECT cities.name, stores.name, stores.zagat_rating
 FROM cities
 JOIN stores ON cities.id = stores.city_id
 JOIN (
   SELECT cities.id as city_id, MAX(zagat_rating) as max_rating
   FROM cities
   JOIN stores on cities.id = stores.city_id
   GROUP BY cities.id
 ) AS sub ON sub.city_id = cities.id 
          AND stores.zagat_rating = max_rating;"

create_question 'City name, store name, taco name and price of most expensive taco by city',
"SELECT cities.name, stores.name, tacos.name, stores_tacos.price
 FROM cities
 JOIN stores ON cities.id = stores.city_id
 JOIN stores_tacos ON stores.id = stores_tacos.store_id
 JOIN tacos ON stores_tacos.taco_id = tacos.id
 JOIN (
   SELECT cities.id as city_id, MAX(stores_tacos.price) as highest_price
   FROM cities
   JOIN stores ON cities.id = stores.city_id
   JOIN stores_tacos ON stores.id = stores_tacos.store_id
   GROUP BY cities.id
) AS sub ON stores_tacos.price = sub.highest_price
         AND cities.id = sub.city_id;"

