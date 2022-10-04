/* 
 Задание 1
 Пусть в таблице users поля  created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем*/


CREATE TABLE IF EXISTS USER;
CREATE TABLE USER;
USE USER;
UPDATE users SET created_at = NOW(), updated_at = NOW() WHERE created_at is NULL or updated_at is NULL;
UPDATE users SET created_at = IF(created_at is NULL, NOW(), created_at), updated_at = IF(updated_at is NULL, NOW(), updated_at);
UPDATE users SET created_at = NOW() WHERE created_at = NULL;
UPDATE users SET updated_at = NOW() WHERE updated_at = NULL;
UPDATE users SET created_at = NOW(), updated_at = NOW();

/*
 Задание 2
 Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
 */

CREATE TABLE IF EXISTS USER_2;
CREATE TABLE USER_2;
USE USER_2;
UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i');
UPDATE users SET updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
ALTER TABLE users MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE users MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


/*
Задание 3
*/
CREATE TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products;
USE storehouses_products;
SELECT * FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN TRUE ELSE FALSE END, value;

/*
 Задание 4
 (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)
 */
SELECT id, name, birthday_at FROM users WHERE (birthday_at LIKE '%may%' OR birthday_at LIKE '%august%');
/*
 Задиние 5
 (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN. 
 */

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIND_IN_SET(id,'5,1,2');





/*
 Задание 1.1
 Подсчитайте средний возраст пользователей в таблице users.
 */ 
SELECT CASE WEEKDAY(birthday_at)
WHEN 0 THEN 'Понедельник'
WHEN 1 THEN 'Вторник'
WHEN 2 THEN 'Среда'
WHEN 3 THEN 'Четверг'
WHEN 4 THEN 'Пятница'
WHEN 5 THEN 'Суббота'
WHEN 6 THEN 'Воскресенье'
ELSE -1
END as wd, COUNT(birthday_at) as num FROM users GROUP BY wd ORDER BY FIELD(wd,'Понедельник','Вторник','Среда','Четверг','Пятница','Суббота','Воскресенье');

/*
 Задание 1.2
 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
 */
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
COUNT(*) AS total FROM users GROUP BY day ORDER BY otal DESC;


/*
 Задание 1.3
 (по желанию) Подсчитайте произведение чисел в столбце таблицы.
 
 */
CREATE TABLE cat (id SERIAL PRIMARY KEY,   value INT NULL );
CREATE TABLE cat (id SERIAL PRIMARY KEY, value INT NULL );

INSERT INTO cat (value) VALUES
    ->     (1),
    ->     (2),
    ->     (3),
    ->     (4),
    ->     (5);
    
SELECT exp(SUM(ln(value))) summ FROM cat;