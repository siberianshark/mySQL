/* Задача №1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
 	  Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции. 
 	  */

USE shop;

DROP TABLE IF EXISTS users_from_shop_course_database;
CREATE TABLE IF NOT EXISTS shop.users_from_shop_course_database LIKE shop_course_database.users;
INSERT INTO shop.users_from_shop_course_database
	SELECT * FROM shop_course_database.users WHERE id IN (2,3,4,5,6);

SELECT * FROM users_from_shop_course_database;
START TRANSACTION;

INSERT INTO shop.users_from_shop_course_database
	SELECT * FROM shop_course_database.users WHERE id = 1;
SELECT * FROM users_from_shop_course_database;

COMMIT;

	/* Задача №2. Создайте представление, которое выводит название name товарной позиции из таблицы products
	  и соответствующее название каталога name из таблицы catalogs. 
	  */

USE shop_course_database;

-- Решим задачу без представления
SELECT
	p.name,
	c.name
FROM
	products AS p
JOIN
	catalogs AS c
ON
	p.catalog_id = c.id;

CREATE OR REPLACE VIEW products_catalogs AS
	SELECT
		p.name AS product,
		c.name AS catalog
FROM
	products AS p
JOIN
	catalogs AS c
ON
	p.catalog_id = c.id;

SELECT * FROM products_catalogs;

	/* Задача №3. (По желанию) Пусть имеется таблица с календарным полем created_at.
	  В ней размещены разряженые календарные записи за август 2018 года
	 2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
	  Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1,
	  если дата присутствует в исходной таблице и 0, если она отсутствует.
	  */

USE different;

CREATE TABLE IF NOT EXISTS posts (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	created_at DATE NOT NULL
);

INSERT INTO posts VALUES
	(NULL, 'Первая запись', '2018-08-01'),
	(NULL, 'Вторая запись', '2018-08-04'),
	(NULL, 'Третья запись', '2018-08-16'),
	(NULL, 'Четвертая запись', '2018-08-17');
SELECT * FROM posts;

CREATE TEMPORARY TABLE last_days (
	day INT
);

INSERT INTO last_days VALUES
	(0), (1), (3), (4), (5), (6), (7), (8), (9), (10),
	(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
	(21), (22), (23), (24), (25), (26), (27), (28), (29), (30);


SELECT
	DATE(DATE('2018-08-31') - INTERVAL l.day DAY) AS day
FROM
	last_days AS l
ORDER BY
	day;
SELECT
	DATE(DATE('2018-08-31') - INTERVAL l.day DAY) AS day,
	NOT ISNULL(p.name) AS order_exist
FROM
	last_days AS l
LEFT JOIN
	posts AS p
ON
	DATE(DATE('2018-08-31') - INTERVAL l.day DAY) = p.created_at
ORDER BY
	day;

	/* Задача №4 (По желанию) Пусть имеется любая таблица с календарным полем created_at.
	 Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
	  */

DROP TABLE IF EXISTS posts;

CREATE TABLE IF NOT EXISTS posts (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	created_at DATE NOT NULL
);
INSERT INTO posts VALUES
	(NULL, 'Первая запись', '2018-11-01'),
	(NULL, 'Вторая запись', '2018-11-02'),
	(NULL, 'Третья запись', '2018-11-03'),
	(NULL, 'Четвертая запись', '2018-11-04'),
	(NULL, 'Пятая запись', '2018-11-05'),
	(NULL, 'Шестая запись', '2018-11-06'),
	(NULL, 'Седьмая запись', '2018-11-07'),
	(NULL, 'Восьмая запись', '2018-11-08'),
	(NULL, 'Девятая запись', '2018-11-09'),
	(NULL, 'Десятая запись', '2018-11-10');

SELECT * FROM posts;

START TRANSACTION;


SELECT COUNT(*) FROM posts;

SELECT 10 - 5;

DELETE FROM posts ORDER BY created_at LIMIT 5;
COMMIT;
SELECT * FROM posts;

TRUNCATE posts;

INSERT INTO posts VALUES
	(NULL, 'Первая запись', '2018-11-01'),
	(NULL, 'Вторая запись', '2018-11-02'),
	(NULL, 'Третья запись', '2018-11-03'),
	(NULL, 'Четвертая запись', '2018-11-04'),
	(NULL, 'Пятая запись', '2018-11-05'),
	(NULL, 'Шестая запись', '2018-11-06'),
	(NULL, 'Седьмая запись', '2018-11-07'),
	(NULL, 'Восьмая запись', '2018-11-08'),
	(NULL, 'Девятая запись', '2018-11-09'),
	(NULL, 'Десятая запись', '2018-11-10');

SELECT * FROM posts;


START TRANSACTION;

PREPARE postdel FROM ;
SET @total = (SELECT COUNT(*) - 5 FROM posts);
EXECUTE postdel USING @total;

COMMIT;
SELECT * FROM posts;

TRUNCATE posts;

INSERT INTO posts VALUES
	(NULL, 'Первая запись', '2018-11-01'),
	(NULL, 'Вторая запись', '2018-11-02'),
	(NULL, 'Третья запись', '2018-11-03'),
	(NULL, 'Четвертая запись', '2018-11-04'),
	(NULL, 'Пятая запись', '2018-11-05'),
	(NULL, 'Шестая запись', '2018-11-06'),
	(NULL, 'Седьмая запись', '2018-11-07'),
	(NULL, 'Восьмая запись', '2018-11-08'),
	(NULL, 'Девятая запись', '2018-11-09'),
	(NULL, 'Десятая запись', '2018-11-10');


SELECT * FROM posts;

DELETE
	posts
FROM
	posts
JOIN
	(SELECT
		created_at
	FROM
		posts
	ORDER BY
		created_at DESC
	LIMIT 5, 1) AS delpst
ON
	posts.created_at <= delpst.created_at;


SELECT * FROM posts;

					
	/* Задача №1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
	  С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
	  с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
	 с 18:00 до 00:00 — "Добрый вечер",
	 с 00:00 до 6:00 — "Доброй ночи".
	  */

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
CREATE FUNCTION hello ()
RETURNS TEXT NOT DETERMINISTIC
BEGIN
	SET @nowtime = HOUR(NOW());
	CASE
		WHEN @nowtime BETWEEN 0 AND 5 THEN
			RETURN 'Доброй ночи';
		WHEN @nowtime BETWEEN 6 AND 11 THEN
			RETURN 'Доброе утро';
		WHEN @nowtime BETWEEN 12 AND 17 THEN
			RETURN 'Добрый день';
		WHEN @nowtime BETWEEN 18 AND 23 THEN
			RETURN 'Добрый вечер';
	END CASE;
END//

SELECT hello ()//

SHOW FUNCTION STATUS LIKE 'hello%';
DROP FUNCTION hello;

	/* Задача №2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
	  Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
	  Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
	  При попытке присвоить полям NULL-значение необходимо отменить операцию
	  */

USE shop_course_database;

DELIMITER //
CREATE TRIGGER correct_name_description BEFORE INSERT ON products
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET message_text = 'Поля name и description = NULL';
	END IF;
END//

INSERT INTO products
	(name, description, price, catalog_id)
VALUES
	(NULL, NULL, 1000, 1)//

SHOW TRIGGERS;
DROP TRIGGER correct_name_description;

DELIMITER //

CREATE TRIGGER correct_name_description BEFORE UPDATE ON products
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET message_text = 'Поля name и description = NULL';
	END IF;
END//