-- SET sql_mode = 'ORACLE';
CREATE OR REPLACE DATABASE cook_book;
use cook_book;
DROP TABLE IF EXISTS Recipes;
Create table Recipes(
    recipe_id INT AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    descr TEXT,
    cooktime DECIMAL(10,2),
    unit VARCHAR(10),
    PRIMARY KEY (recipe_id)
);
DROP TABLE IF EXISTS Ingredients;
Create table Ingredients(
    ingredient_id INT AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    descr TEXT,
    PRIMARY KEY (ingredient_id)
);
DROP TABLE IF EXISTS Recipe_ingredient;
Create table Recipe_ingredient(
    recipeId INT NOT NULL,
    ingredientId INT NOT NULL,
    PRIMARY KEY (recipeId, ingredientId),
    FOREIGN KEY (recipeId) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (ingredientId) REFERENCES Ingredients(Ingredient_id)
);
DROP TABLE IF EXISTS Recipe_images;
Create table Recipe_images(
    imageId INT AUTO_INCREMENT,
    image blob DEFAULT NULL,
    recipeId INT NOT NULL, 
    PRIMARY KEY (imageId),
    FOREIGN KEY (recipeId) REFERENCES recipes(recipe_id)
);
-- 1
INSERT INTO Recipes(name,descr,cooktime,unit) VALUES ('Goat Cheese Trio', 'Foreign food', 0.45, 'hr');
INSERT INTO Recipes(name,descr,cooktime,unit) VALUES ('Cannellini Bruschetta', 'Foreign food',  1, 'hr');
INSERT INTO Recipes(name,descr,cooktime,unit) VALUES ('Spiced Olives', 'Foreign food',  2, 'hr');
INSERT INTO Recipes(name,descr,cooktime,unit) VALUES ('Radish-Anchovy Canapes', 'Foreign food',  1, 'hr');
INSERT INTO Recipes(name,descr,cooktime,unit) VALUES ('Blue Cheese–Pecan Spread', 'Foreign food',  1, 'hr');
INSERT INTO Recipes(name,descr,cooktime,unit) VALUES ('Jollof Rice', 'Nigerian food', 0.35, 'hr');
INSERT INTO Recipes(name,descr,cooktime,unit) VALUES ('Beans', 'Nigerian food',  2, 'hr');
INSERT INTO Recipes(name,descr,cooktime,unit) VALUES ('Baked Yam', 'Nigerian food', 0.25, 'hr');
INSERT INTO Recipes(name,descr,cooktime,unit) VALUES ('Boiled Yam', 'Nigerian food',  0.15, 'hr');
INSERT INTO Recipes(name,descr,cooktime,unit) VALUES ('Shawarma', 'Nigerian food',  0.55, 'hr');

INSERT INTO Ingredients(name,descr) VALUES ('12-ounce log of goat cheese', '');
INSERT INTO Ingredients(name,descr) VALUES ('1 drained can cannellini beans', '');
INSERT INTO Ingredients(name,descr) VALUES ('1 smashed garlic clove', '');
INSERT INTO Ingredients(name,descr) VALUES ('rinsed anchovies', '');
INSERT INTO Ingredients(name,descr) VALUES ('soft blue cheese', '');
INSERT INTO Ingredients(name,descr) VALUES ('Pepper', '');
INSERT INTO Ingredients(name,descr) VALUES ('Brown beans', '');
INSERT INTO Ingredients(name,descr) VALUES ('vegetable Oil', '');
INSERT INTO Ingredients(name,descr) VALUES ('1 large Yam', '');
INSERT INTO Ingredients(name,descr) VALUES ('I large cabbage', '');

INSERT INTO Recipe_ingredient VALUES (1,1);
INSERT INTO Recipe_ingredient VALUES (2,1);
INSERT INTO Recipe_ingredient VALUES (1,2);
INSERT INTO Recipe_ingredient VALUES (2,2);
INSERT INTO Recipe_ingredient VALUES (2,3);
INSERT INTO Recipe_ingredient VALUES (2,4);
INSERT INTO Recipe_ingredient VALUES (3,5);
INSERT INTO Recipe_ingredient VALUES (3,2);
INSERT INTO Recipe_ingredient VALUES (3,1);
INSERT INTO Recipe_ingredient VALUES (4,3);

INSERT INTO Recipe_images(image, recipeId) VALUES (('C:\Users\user\Documents\mentorshp\images\diary.png'), 1);
INSERT INTO Recipe_images(image, recipeId) VALUES (('C:\Users\user\Documents\mentorshp\images\strawberry.png'), 1);
INSERT INTO Recipe_images(image, recipeId) VALUES (('C:\Users\user\Documents\mentorshp\images\orange.png'), 2);
INSERT INTO Recipe_images(image, recipeId) VALUES (('C:\Users\user\Documents\mentorshp\images\strawberry.png'), 2);
INSERT INTO Recipe_images(image, recipeId) VALUES (('C:\Users\user\Documents\mentorshp\images\strawberry.png'), 3);
INSERT INTO Recipe_images(image, recipeId) VALUES (('C:\Users\user\Documents\mentorshp\images\strawberry.png'), 4);
INSERT INTO Recipe_images(image, recipeId) VALUES (('C:\Users\user\Documents\mentorshp\images\strawberry.png'), 4);
INSERT INTO Recipe_images(image, recipeId) VALUES (('C:\Users\user\Documents\mentorshp\images\strawberry.png'), 4);
INSERT INTO Recipe_images(image, recipeId) VALUES (('C:\Users\user\Documents\mentorshp\images\strawberry.png'), 5);
INSERT INTO Recipe_images(image, recipeId) VALUES (('C:\Users\user\Documents\mentorshp\images\strawberry.png'), 5);

-- 2.	Write a query to SELECT ingredients for a recipe.
select i.ingredient_id, i.name from Recipe_ingredient ri
join recipes r on r.recipe_id = ri.recipeId
join ingredients i on i.ingredient_id = ri.ingredientId
WHERE recipe_id = 1;

-- -- 3.	Write query to SELECT the cook time of a particular  recipe
select cooktime from recipes where recipe_id = 5;

-- -- 4.	Make an update to the cook time of a particular recipe
update recipes SET name = 'fried Potatoes' where recipe_id = 4;

-- 5.	Write a query to select the recipe that takes less than an hour to cook(this highly depend on what you inserted as values into the database)

select * from Recipes where cooktime < 1;
-- 6.	Write a query to calculate the average cook time of a recipe
select AVG(cooktime) from recipes;

-- 7.	Write a query to display the recipe’s ingredients and the recipe picture of a particular recipe
select i.name, rim.image from Recipes r
join Recipe_ingredient rig on rig.recipeId= r.recipe_id
join ingredients i on i.ingredient_id = rig.ingredientId
join Recipe_images rim on rim.recipeId = r.recipe_id;

-- 8.	Write a query to find the name and cook time of a recipe who has a higher cooktime than the recipe whose name= ‘Rice’.
SELECT name, cooktime
from recipes where cooktime > (
select cooktime from recipes where name = 'Jollof Rice');

-- 9.	Write a query to find the name of recipes that have a picture
SELECT name 
FROM recipes r 
WHERE recipe_id IN (SELECT recipe_id FROM recipes r join recipe_images ri on 
ri.recipeId = r.recipe_id);
-- 10.	 Write a query to find the recipe having the same cook time
-- SELECT 
-- select cooktime from recipes group by cooktime having count(*) >1;

select * from recipes where cooktime in (
    select cooktime from recipes group by cooktime having count(*) >1
);

