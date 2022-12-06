use fictional_recipe_book;
CREATE TABLE dishes (recipe_id INT NOT NULL,
dish VARCHAR(50) NOT NULL, 
book_title VARCHAR (50) NOT NULL);
insert into dishes (recipe_id, dish, book_title)
values
('1', 'Blueberry Pie', 'Charlottes Web'),
('2', 'Fried Green Tomatoes', 'Fried Green Tomatoes at the Whistle Stop Cafe'),
('3', 'Roasted Potatoes', 'The Secret Garden'),
('4', 'Raspberry Cordial', 'Anne of Green Gables'),
('5', 'Seed cake', 'Jane Eyre'),
('6', 'Pickled limes', 'Little Women'),
('7', 'Turkish Delight', 'The Lion, The Witch, and the Wardrobe'),
('8', 'Lembas bread', 'The Lord of the Rings'),
('9', 'Cheese and toast', 'Heidi'),
('10', 'Spanakopita', 'Middlesex'),
('11', 'Miso soup', 'Norwegian Wood');

CREATE TABLE authors (author_id INT NOT NULL,
author_name VARCHAR(50) NOT NULL, 
book_title VARCHAR (50) NOT NULL,
dish VARCHAR (50) NOT NULL);
insert into authors (author_id, author_name, book_title, dish)
values
('1', 'E. B. White', 'Charlottes Web', 'Blueberry Pie'),
('2', 'Fannie Flagg', 'Fried Green Tomatoes at the Whistle Stop Cafe', 'Fried Green Tomatoes'),
('3', 'Frances Hodgson Burnett', 'The Secret Garden', 'Roasted Potatoes'),
('4', 'L. M. Montgomery', 'Anne of Green Gables', 'Raspberry Cordial'),
('5', 'Charlotte Bronte', 'Jane Eyre', 'cooking_idcooking_minutesSeed cake'),
('6', 'Louisa May Alcott', 'Little Women', 'Pickled limes'),
('7', 'C. S. Lewis', 'The Lion, The Witch, and the Wardrobe', 'Turkish Delight'),
('8', 'J. R. R. Tolkien', 'The Lord of the Rings', 'Lembas bread'),
('9', 'Johanna Spyri', 'Heidi', 'Cheese and toast'),
('10', 'Jeffrey Eugenides', 'Middlesex', 'Spanakopita'),
('11', 'Haruki Murakami', 'Norwegian Wood', 'Miso soup');

CREATE TABLE dish_types (type_id INT NOT NULL,
type_name VARCHAR(50) NOT NULL, 
dish_name VARCHAR (50) NOT NULL);
INSERT INTO dish_types (type_id, type_name, dish_name)
values
('1', 'dessert', 'Blueberry Pie'),
('2', 'starter', 'Fried Green Tomatoes'),
('3', 'side', 'Roasted Potatoes'),
('4', 'beverage', 'Raspberry Cordial'),
('5', 'dessert', 'Seed cake'),
('6', 'starter', 'Pickled limes'),
('7', 'dessert', 'Turkish Delight'),
('8', 'pastry', 'Lembas bread'),
('9', 'starter', 'Cheese and toast'),
('10', 'pastry', 'Spanakopita'),
('11', 'first dish', 'Miso soup');

CREATE TABLE cooking_time (cooking_id INT NOT NULL,
cooking_minutes INT NOT NULL, 
dish_name VARCHAR (50) NOT NULL);
insert into cooking_time (cooking_id, cooking_minutes, dish_name)
values
('1', '75', 'Blueberry Pie'),
('2', '25', 'Fried Green Tomatoes'),
('3', '35', 'Roasted Potatoes'),
('4', '30', 'Raspberry Cordial'),
('5', '60', 'Seed cake'),
('6', '180', 'Pickled limes'),
('7', '610', 'Turkish Delight'),
('8', '40', 'Lembas bread'),
('9', '10', 'Cheese and toast'),
('10', '80', 'Spanakopita'),
('11', '20', 'Miso soup');

CREATE TABLE recipe_sources (source_id INT NOT NULL,
source_web VARCHAR(50) NOT NULL, 
dish_name VARCHAR (50) NOT NULL);
insert into recipe_sources (source_id, source_web, dish_name)
values
('1', 'natashaskitchen.com', 'Blueberry Pie'),
('2', 'southernliving.com', 'Fried Green Tomatoes'),
('3', 'southernliving.com', 'Roasted Potatoes'),
('4', 'nourishingsimplicity.org', 'Raspberry Cordial'),
('5', 'theenglishkitchen.co', 'Seed cake'),
('6', 'worldturndupsidedown.com', 'Pickled limes'),
('7', 'thespruceeats.com', 'Turkish Delight'),
('8', 'inliterature.net', 'Lembas bread'),
('9', 'thekitchn.com', 'Cheese and toast'),
('10', 'themediterraneandish.com', 'Spanakopita'),
('11', 'justonecookbook.com', 'Miso soup');

-- creating a join

select a.author_id, a.author_name, a.book_title, a.dish_name
from authors a
inner join dish_types d
on  a.dish_name = d.dish_name;

-- creating a view

create view authors_and_types
as
select a.author_id, a.author_name, a.book_title, a.dish_name
from authors a
inner join dish_types d
on  a.dish_name = d.dish_name;

-- adding constraints

alter table cooking_time
add constraint fk_dish_name
foreign key (dish_name)
references dishes (dish_name);

alter table dish_types
add constraint fk_dish_name_d
foreign key (dish_name)
references dishes (dish_name);

alter table recipe_sources
add constraint fk_dish_name_r
foreign key (dish_name)
references dishes (dish_name);

alter table authors
add constraint fk_dish_name_a
foreign key (dish_name)
references dishes (dish_name);

alter table authors
add constraint fk_author_id
foreign key (author_id)
references cooking_time (cooking_id);

alter table authors
add constraint fk_author_id_d
foreign key (author_id)
references dish_types (type_id);

alter table authors
add constraint fk_author_id_r
foreign key (author_id)
references recipe_sources (source_id);

alter table cooking_time
add constraint fk_cooking_id
foreign key (cooking_id)
references dish_types (type_id);

alter table cooking_time
add constraint fk_cooking_id_r
foreign key (cooking_id)
references recipe_sources (source_id);

alter table dish_types
add constraint fk_type_id_r
foreign key (type_id)
references recipe_sources (source_id);

-- creating a function

delimiter //
create function recipe_level(
cooking_minutes int
)
returns VARCHAR (20)
DETERMINISTIC
begin
declare recipe_level VARCHAR (50);
if cooking_minutes > 79 then
set recipe_level = 'hard';
elseif cooking_minutes < 36 then
set recipe_level = 'easy';
elseif cooking_minutes > 39 AND
cooking_minutes < 76 then
set recipe_level = 'medium';
end if;
return (recipe_level);
end//recipe_level
delimiter ;

select c.cooking_id, c.dish_name, c.cooking_minutes, recipe_level(c.cooking_minutes) from cooking_time c order by c.cooking_id DESC;

-- group by

select d.type_id, d.type_name, count(d.type_id) from dish_types d group by d.type_name;

-- subquery

select c.cooking_id, c.dish_name, c.cooking_minutes, recipe_level(c.cooking_minutes) from cooking_time c where c.cooking_minutes >
(select c.cooking_minutes 
from cooking_time c
where c.cooking_minutes = 20)
order by c.cooking_minutes DESC;

-- creating a trigger

delimiter //
create trigger sugar_ingredient before update on dish_types
for each row
if new.type_name = 'dessert' then
set new.type_name = 'dessert containing sugar';
end if;
end;//
delimiter //

insert into dishes (recipe_id, dish_name, book_title)
values (12, 'Pepparkakor', 'Pippi Longstocking');
insert into recipe_sources (source_id, source_web, dish_name)
values
(12, 'nogarlicnoonions.com', 'Pepparkakor');
insert into dish_types (type_id, type_name, dish_name)
values
(12, 'dessert', 'Pepparkakor');
select * from dish_types;

--testing the trigger

update dish_types
set type_name = 'dessert', dish_name = 'Pepparkakor'
where type_id = '12';

update cooking_time
set cooking_minutes = '35', dish_name = 'Roasted Potatoes'
where cooking_id = '3';

select * from authors;
select * from cooking_time;
select * from dish_types;
select * from dishes;
select * from recipe_sources;