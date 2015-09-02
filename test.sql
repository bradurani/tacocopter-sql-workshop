SELECT stores.*, COUNT(*) 
FROM stores 
JOIN store_tacos ON stores.id = store_tacos.store_id 
JOIN tacos ON store_tacos.taco_id = tacos.id
           AND tacos.vegetarian = true
GROUP by stores.id;
