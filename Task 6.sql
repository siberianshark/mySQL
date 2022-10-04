
/*
 ������� 1
 ����� ����� ��������� ������������. �� ���� ������ ����� ������������ ������� ��������,
 ������� ������ ���� ������� � ����� �������������.
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
 ������� 2
 ���������� ����� ���������� ������, ������� �������� ������������ ������ 11 ���.
 */


SELECT count(*) -- ���������� ������
FROM likes
WHERE media_id IN ( -- ��� ����� ������ ����� �������������
SELECT id 
FROM media 
WHERE user_id IN ( -- ��� ������������ ������ 11 ���
SELECT 
user_id -- , birthday
FROM profiles AS p
WHERE  YEAR(CURDATE()) - YEAR(birthday) < 11));

SELECT count(*) -- ���������� ������
FROM likes l
JOIN media m ON l.media_id = m.id
JOIN profiles p ON p.user_id = m.user_id
WHERE  YEAR(CURDATE()) - YEAR(birthday) < 11;


/*
 ������� 3
���������� ��� ������ �������� ������ (�����): ������� ��� �������. 
*/

SELECT 
gender,
count(*)
FROM ( SELECT user_id AS USER, 
( SELECT gender FROM vk.profiles WHERE user_id = user ) AS gender
FROM likes ) AS dummy
GROUP BY gender;
