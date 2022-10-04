/* 
 ������� 1
 ����� � ������� users ����  created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������*/


CREATE TABLE IF EXISTS USER;
CREATE TABLE USER;
USE USER;
UPDATE users SET created_at = NOW(), updated_at = NOW() WHERE created_at is NULL or updated_at is NULL;
UPDATE users SET created_at = IF(created_at is NULL, NOW(), created_at), updated_at = IF(updated_at is NULL, NOW(), updated_at);
UPDATE users SET created_at = NOW() WHERE created_at = NULL;
UPDATE users SET updated_at = NOW() WHERE updated_at = NULL;
UPDATE users SET created_at = NOW(), updated_at = NOW();

/*
 ������� 2
 ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� 20.10.2017 8:10. ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
 */

CREATE TABLE IF EXISTS USER_2;
CREATE TABLE USER_2;
USE USER_2;
UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i');
UPDATE users SET updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
ALTER TABLE users MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE users MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


/*
������� 3
*/
CREATE TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products;
USE storehouses_products;
SELECT * FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN TRUE ELSE FALSE END, value;

/*
 ������� 4
 (�� �������) �� ������� users ���������� ������� �������������, ���������� � ������� � ���. ������ ������ � ���� ������ ���������� �������� (may, august)
 */
SELECT id, name, birthday_at FROM users WHERE (birthday_at LIKE '%may%' OR birthday_at LIKE '%august%');
/*
 ������� 5
 (�� �������) �� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2); ������������ ������ � �������, �������� � ������ IN. 
 */

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIND_IN_SET(id,'5,1,2');





/*
 ������� 1.1
 ����������� ������� ������� ������������� � ������� users.
 */ 
SELECT CASE WEEKDAY(birthday_at)
WHEN 0 THEN '�����������'
WHEN 1 THEN '�������'
WHEN 2 THEN '�����'
WHEN 3 THEN '�������'
WHEN 4 THEN '�������'
WHEN 5 THEN '�������'
WHEN 6 THEN '�����������'
ELSE -1
END as wd, COUNT(birthday_at) as num FROM users GROUP BY wd ORDER BY FIELD(wd,'�����������','�������','�����','�������','�������','�������','�����������');

/*
 ������� 1.2
 ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.
 */
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
COUNT(*) AS total FROM users GROUP BY day ORDER BY otal DESC;


/*
 ������� 1.3
 (�� �������) ����������� ������������ ����� � ������� �������.
 
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