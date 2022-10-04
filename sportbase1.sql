DROP DATABASE IF EXISTS sportshop;
CREATE DATABASE sportshop;
USE sportshop;

DROP TABLE IF EXISTS menu;
CREATE TABLE menu (
id SERIAL PRIMARY KEY,
news VARCHAR(255),
media VARCHAR(255),
information VARCHAR(255),
section_title VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Разделы интернет-магазина';
DESCRIBE menu;

DROP TABLE IF EXISTS user_information;
CREATE TABLE user_information(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
created_at DATETIME DEFAULT NOW(),
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

);

DROP TABLE IF EXISTS users;
CREATE TABLE users (
id SERIAL PRIMARY KEY,
user_information_id BIGINT UNSIGNED,
menu_id BIGINT UNSIGNED NOT NULL,
user_name VARCHAR(255) COMMENT 'Имя покупателя',
birthday_at DATE COMMENT 'Дата рождения',
hometown VARCHAR(100),
gender char,
is_deleted bit default 0,
created_at DATETIME DEFAULT NOW(),
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX (menu_id),
FOREIGN KEY (menu_id) REFERENCES menu(id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (user_information_id) REFERENCES user_information(id) ON UPDATE CASCADE ON DELETE SET NULL
) COMMENT = 'Покупатели';


DROP TABLE IF EXISTS products_discounts;
CREATE TABLE products_discounts (
	id SERIAL PRIMARY KEY,
    discount_name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Скидки на товары';


 DROP TABLE IF EXISTS products;
CREATE TABLE products (
id SERIAL PRIMARY KEY,
menu_id BIGINT UNSIGNED NOT NULL,
products_discounts_id BIGINT UNSIGNED ,
product_name VARCHAR(255) COMMENT 'Название',
desription TEXT COMMENT 'Описание',
price DECIMAL (11,2) COMMENT 'Цена',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 FOREIGN KEY (menu_id) REFERENCES menu(id) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY (products_discounts_id) REFERENCES products_discounts(id) ON UPDATE CASCADE ON DELETE SET NULL
) COMMENT = 'Товары'; 
  

  DROP TABLE IF EXISTS oders;
CREATE TABLE oders(
	id SERIAL PRIMARY KEY,
    menu_id BIGINT UNSIGNED,
    users_id BIGINT UNSIGNED,
     created_at DATETIME DEFAULT NOW(),

    FOREIGN KEY (menu_id) REFERENCES menu(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (users_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL
)COMMENT = 'Заказы';
	



DROP TABLE IF EXISTS products_in_user_basket;
CREATE TABLE products_in_user_basket(
	id SERIAL PRIMARY KEY,
    menu_id BIGINT UNSIGNED,
    users_id BIGINT UNSIGNED,
    oders_id BIGINT UNSIGNED,
   products_id BIGINT UNSIGNED,
     created_at DATETIME DEFAULT NOW(),

    FOREIGN KEY (menu_id) REFERENCES menu(id) ON UPDATE CASCADE ON DELETE CASCADE,
     FOREIGN KEY (products_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE SET null,
     FOREIGN KEY (oders_id) REFERENCES oders(id) ON UPDATE CASCADE ON DELETE SET null,
    FOREIGN KEY (users_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL
) COMMENT= 'Корзина покупок';




DROP TABLE IF EXISTS `discounts`;
CREATE TABLE `discounts` (
id SERIAL PRIMARY KEY,
menu_id BIGINT UNSIGNED NOT NULL,
products_discounts_id BIGINT UNSIGNED ,
discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
finished_at DATETIME NULL,
started_at DATETIME NULL,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 FOREIGN KEY (menu_id) REFERENCES menu(id) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY (products_discounts_id) REFERENCES products_discounts(id) ON UPDATE CASCADE ON DELETE SET NULL
) COMMENT = 'Скидки';


    
DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
id SERIAL PRIMARY KEY,
menu_id BIGINT UNSIGNED NOT NULL,
name VARCHAR(255) COMMENT 'Название',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (menu_id) REFERENCES menu(id) ON UPDATE CASCADE ON DELETE CASCADE
) COMMENT = 'Склады';




DROP TABLE IF EXISTS directory_of_sections;
CREATE TABLE directory_of_sections(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),
    INDEX directory_of_sections_name_idx(name)
) COMMENT = 'Перечень каталогов';


DROP TABLE IF EXISTS `catalogs`;
CREATE TABLE `catalogs` (
	menu_id BIGINT UNSIGNED NOT NULL,
	directory_of_sections_id BIGINT UNSIGNED NOT NULL,
	/*
	 Здесь, for_run  и другие - это названия каталогов
	 */
	`for_run` varchar(255) DEFAULT NULL,
	`for_swim` varchar(255) DEFAULT NULL,
	`for_for skiing` varchar(255) DEFAULT NULL,
	`for_snowboard` varchar(255) DEFAULT NULL,
	`for_mountains` varchar(255) DEFAULT NULL,
	`for_forest` varchar(255) DEFAULT NULL,
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (menu_id, directory_of_sections_id),
    FOREIGN KEY (menu_id) REFERENCES menu(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (directory_of_sections_id) REFERENCES directory_of_sections(id) ON UPDATE CASCADE ON DELETE CASCADE
) COMMENT = 'Каталоги товаров';

  
  