


/*
 Задание 1. 
 Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека,
 который больше всех общался с выбранным пользователем (написал ему сообщений).
*/

SELECT 
concat ( u.firstname, '' ,  u.lastname) as отправитель,
m.to_user_id as получатель,
count(*) as количество_сообщений
FROM users u
JOIN messages m ON u.id = m.from_user_id
WHERE m.to_user_id = 1 
GROUP BY m.to_user_id
ORDER BY COUNT(*) DESC
LIMIT 1


/*
Задание 2. 
Подсчитать общее количество лайков,которые получили пользователи младше 10 лет.
*/



SELECT COUNT(*) as 'likes '
FROM profiles 
WHERE (YEAR(NOW())-YEAR(birthday)) < 10;

/*
Задание 3. 
Определить кто больше поставил лайков (всего): мужчины или женщины.
*/

SELECT CASE (gender)
        WHEN 'm' THEN 'мужчин'
        WHEN 'f' THEN 'женщин'
    	END AS 'Кого больше', COUNT(*) as 'лайков'
FROM profiles p 
JOIN
likes l 
WHERE l.user_id = p.user_id
GROUP BY gender 
LIMIT 1