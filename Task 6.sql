
/*
 Задание 1
 Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека,
 который больше всех общался с нашим пользователем.
 */



SELECT
    from_user_id, 
    (select concat(firstname,'', lastname) from users where id = messages.from_user_id) as name,
    COUNT(*) as send
FROM messages 
where to_user_id = 1 
AND from_user_id IN (
     select initiator_user_id from friend_requests 
     WHERE (target_user_id = 1) and status ='approved'
     UNION
     select target_user_id from friend_requests 
     WHERE (initiator_user_id = 1) and status ='approved' 
)
GROUP BY from_user_id
ORDER BY send desc 
limit 6;






/*
 Задание 2
 Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.
 */


SELECT count(*) -- Количество лайков
FROM likes
WHERE media_id IN ( -- Все медиа записи таких пользователей
SELECT id 
FROM media 
WHERE user_id IN ( -- Все пользователи младше 11 лет
SELECT 
user_id -- , birthday
FROM profiles AS p
WHERE  YEAR(CURDATE()) - YEAR(birthday) < 11));

SELECT count(*) -- Количество лайков
FROM likes l
JOIN media m ON l.media_id = m.id
JOIN profiles p ON p.user_id = m.user_id
WHERE  YEAR(CURDATE()) - YEAR(birthday) < 11;


/*
 Задание 3
Определить кто больше поставил лайков (всего): мужчины или женщины. 
*/

SELECT 
gender,
count(*)
FROM ( SELECT user_id AS USER, 
( SELECT gender FROM vk.profiles WHERE user_id = user ) AS gender
FROM likes ) AS dummy
GROUP BY gender;
