USE sportshop;

truncate orders;
SELECT * FROM users;
SELECT * FROM orders;
SELECT * FROM products_in_user_basket;

INSERT INTO products_in_user_basket (user_id)
SELECT id FROM users WHERE name LIKE 'кар%';

INSERT INTO products_in_user_basket (order_id, product_id, total, created_at)
SELECT last_insert_id(), id, 5, now()
FROM products WHERE name like 'int%';


INSERT INTO orders (user_id)
SELECT id FROM users WHERE name LIKE 'нат%';

INSERT INTO oproducts_in_user_basket (order_id, product_id, total, created_at)
	SELECT last_insert_id(), id, 2, now()
FROM products WHERE id IN (1, 6);

INSERT INTO orders (user_id)
SELECT id FROM users WHERE name LIKE '%рия';

INSERT INTO products_in_user_basket (order_id, product_id, total, created_at)
	SELECT last_insert_id(), id, 1, now()
FROM products WHERE id IN (1, 3, 4, 6, 7);

SELECT * FROM users
WHERE id IN (SELECT user_id FROM orders);

-- Решение через JOIN
SELECT users.id, users.name, users.birthday_at, orders.created_at FROM users
JOIN orders ON users.id = products_in_user_basket_id;

-- Вывожу  список каталлогов  catalogs и разделов directory_of_sections, который соответствует товару.

INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('12', 'Accusamus vel et beatae adipisci aperiam quis.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('13', 'Animi quis autem soluta atque.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('7', 'Aspernatur quia tenetur excepturi repellat.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('10', 'Culpa voluptatem facere quibusdam.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('15', 'Deserunt aut aut libero et et.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('14', 'Eum dolor iste quod earum eum non fuga.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('8', 'Fugiat est ut facere consequatur doloremque officia sit.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('1', 'Fugit doloremque quo qui consequatur.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('6', 'Illo accusantium asperiores numquam ut quisquam non recusandae.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('17', 'Illo et praesentium dolorem consequatur fuga.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('16', 'Iusto est dolore accusantium suscipit in aliquid repellendus.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('3', 'Laborum necessitatibus sed amet qui illo animi.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('20', 'Magnam sunt ut eveniet est.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('11', 'Molestiae doloremque molestiae sed dolorem voluptatem ad molestiae.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('19', 'Quam qui similique totam quam ut qui sed.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('2', 'Qui quae laudantium sed omnis illo occaecati.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('9', 'Temporibus incidunt tenetur quia ut quia.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('5', 'Voluptas cupiditate eos repellendus.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('4', 'Voluptatem fuga sed voluptatum ad dolores.');
INSERT INTO `directory_of_sections` (`id`, `name`) VALUES ('18', 'Voluptatem rerum doloremque minima illo rerum provident.');
;

SELECT
	directory_of_sections.name AS directory_of_sections_name,
	catalogs.name AS catalogs_name,

	catalogs.desсription AS catalogs_description
FROM catalogs
LEFT JOIN catalogs ON catalogs.id = catalogs.directory_of_sections_id;