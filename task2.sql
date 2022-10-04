#Было удобнее и интереснее попробовать через Ubuntu но так как нужен файл в формате, то решила вставить в данное рабочее простарнство , а не в блокнот
#Буду рада комментариям, может быть стоит по другому делать ?


/* Задание 1
Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке
*/


user@user-VirtualBox:~$ sudo apt-get update
user@user-VirtualBox:~$ sudo apt-get upgrade
user@user-VirtualBox:~$ sudo apt-get install mysql-server
mysqld is running as pid 28267
Created symlink /etc/systemd/system/multi-user.target.wants/mysql.service → /lib/systemd/system/mysql.service.
Setting up mysql-server (8.0.28-0ubuntu0.20.04.3) ...
Processing triggers for systemd (245.4-4ubuntu3.16) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.7) ...
user@user-VirtualBox:~$ exit
logout
Connection to 192.168.8.104 closed.
user@user-VirtualBox:~$ sudo apt-get install mysql-server
Reading package lists... Done
Building dependency tree       
Reading state information... Done
mysql-server is already the newest version (8.0.28-0ubuntu0.20.04.3).
0 upgraded, 0 newly installed, 0 to remove and 3 not upgraded.
user@user-VirtualBox:~$ ps aux | grep mysqld
mysql      28469  0.5 15.6 1326348 387568 ?      Ssl  00:20   0:01 /usr/sbin/mysqld
user       29609  0.0  0.0   9048   724 pts/0    S+   00:24   0:00 grep --color=auto mysqld
user@user-VirtualBox:~$ 
user@user-VirtualBox:~$ 
user@user-VirtualBox:~$ 
user@user-VirtualBox:~$ sudo service mysql start
user@user-VirtualBox:~$ sudo service mysql stop
user@user-VirtualBox:~$ 
user@user-VirtualBox:~$ sudo mysql_secure_installation

Securing the MySQL server deployment.

Enter password for user root: 
Error: Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)
user@user-VirtualBox:~$ ssh -p22 user@192.168.8.104
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-40-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

5 updates can be applied immediately.
3 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.
Last login: Thu Apr 21 00:11:43 2022 from 192.168.8.104
user@user-VirtualBox:~$ sudo systemctl start mysql
[sudo] password for user: 
user@user-VirtualBox:~$ sudo systemctl start mysql
user@user-VirtualBox:~$ sudo nano /etc/mysql/mysql.conf.d/mysql.cnf
user@user-VirtualBox:~$ ls -a /var/run/mysqld/
.  ..  mysqld.sock  mysqld.sock.lock  mysqlx.sock  mysqlx.sock.lock
user@user-VirtualBox:~$ sudo chmod -R 755 /var/run/mysqld/
user@user-VirtualBox:~$ sudo systemctl restart mysql
user@user-VirtualBox:~$ sudo mysql_secure_installation

Securing the MySQL server deployment.

Connecting to MySQL using a blank password.

VALIDATE PASSWORD COMPONENT can be used to test passwords
and improve security. It checks the strength of password
and allows the users to set only those passwords which are
secure enough. Would you like to setup VALIDATE PASSWORD component?

Press y|Y for Yes, any other key for No: y

There are three levels of password validation policy:

LOW    Length >= 8
MEDIUM Length >= 8, numeric, mixed case, and special characters
STRONG Length >= 8, numeric, mixed case, special characters and dictionary                  file

Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG: 1111
Please set the password for root here.

New password: 

Re-enter new password: 

Estimated strength of the password: 25 
Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) : y
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) : n

 ... skipping.


Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.


Remove test database and access to it? (Press y|Y for Yes, any other key for No) : n

 ... skipping.
Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y
Success.

All done! 
user@user-VirtualBox:~$ sudo snap dbeaver-ce
error: unknown command "dbeaver-ce", see 'snap help'.
user@user-VirtualBox:~$ sudo snap install dbeaver-ce
dbeaver-ce 22.0.3.202204170718 from DBeaver (dbeaver-corp) installed
user@user-VirtualBox:~$ exit
logout
Connection to 192.168.8.104 closed.
user@user-VirtualBox:~$ sudo systemctl restart mysql
[sudo] password for user: 
user@user-VirtualBox:~$ sudo mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.0.28-0ubuntu0.20.04.3 (Ubuntu)

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '1111ROOT';
ERROR 1819 (HY000): Your password does not satisfy the current policy requirements
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '1111ROOT';
ERROR 1819 (HY000): Your password does not satisfy the current policy requirements
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '1234567ROOT';
ERROR 1819 (HY000): Your password does not satisfy the current policy requirements
mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0,01 sec)

mysql> SELECT user, authentication_string,plugin,host From mysql.user;
+------------------+------------------------------------------------------------------------+-----------------------+-----------+
| user             | authentication_string                                                  | plugin                | host      |
+------------------+------------------------------------------------------------------------+-----------------------+-----------+
| debian-sys-maint | $A$005$ jIgeZ@2
                                    WC%C&E:D^SSYHKTZ0unKJme7QA/9oQ.RR7XxUNUo2cQXHWQUFPq3 | caching_sha2_password | localhost |
| mysql.infoschema | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password | localhost |
| mysql.session    | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password | localhost |
| mysql.sys        | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password | localhost |
| root             |                                                                        | auth_socket           | localhost |
+------------------+------------------------------------------------------------------------+-----------------------+-----------+
5 rows in set (0,00 sec)

mysql> exit
Bye
user@user-VirtualBox:~$ ssh user@192.168.8.104
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-40-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

5 updates can be applied immediately.
3 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.
Last login: Thu Apr 21 00:27:53 2022 from 192.168.8.104
user@user-VirtualBox:~$ 
user@user-VirtualBox:~$ sudo mysql
[sudo] password for user: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.28-0ubuntu0.20.04.3 (Ubuntu)

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql-nqtive-password BY '1234567ROOT';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '-nqtive-password BY '1234567ROOT'' at line 1
mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0,01 sec)

mysql> SELECT user,authentication-string,plugin,host FROM mysql.user;
ERROR 1054 (42S22): Unknown column 'authentication' in 'field list'
mysql> SELECT user,authentication_string,plugin,host FROM mysql.user;
+------------------+------------------------------------------------------------------------+-----------------------+-----------+
| user             | authentication_string                                                  | plugin                | host      |
+------------------+------------------------------------------------------------------------+-----------------------+-----------+
| debian-sys-maint | $A$005$ jIgeZ@2
                                    WC%C&E:D^SSYHKTZ0unKJme7QA/9oQ.RR7XxUNUo2cQXHWQUFPq3 | caching_sha2_password | localhost |
| mysql.infoschema | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password | localhost |
| mysql.session    | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password | localhost |
| mysql.sys        | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password | localhost |
| root             |                                                                        | auth_socket           | localhost |
+------------------+------------------------------------------------------------------------+-----------------------+-----------+
5 rows in set (0,00 sec)

mysql> CREATE USER 'USER 'user'@'localhost' IDENTIFIED BY '1111ROOT';
    '> GRANT ALL PRIVILEGES ON *.* to 'user'@'localhost' WITH GRANT OPTION;
    '> 
    '> 
    '> 
    '> exit
    '> 
    '> ^C

^C
mysql> exit
Bye
user@user-VirtualBox:~$ nano .my.cnf
user@user-VirtualBox:~$ mysql
ERROR 1698 (28000): Access denied for user 'root'@'localhost'






/* Задание 2
Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
*/

user@user-VirtualBox:~$ sudo mysql
[sudo] password for user: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.0.28-0ubuntu0.20.04.3 (Ubuntu)

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE example;
Query OK, 1 row affected (0,03 sec)

mysql> USE example;
Database changed
mysql> CREATE TABLE 
Display all 757 possibilities? (y or n) 
mysql> CREATE TABLE users (id INT, name TEXT);
Query OK, 0 rows affected (0,07 sec)

mysql> DESCRIBE users;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| id    | int  | YES  |     | NULL    |       |
| name  | text | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
2 rows in set (0,00 sec)







/* Задание 3
Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
*/


mysql> CREATE DATABASE sample;
Query OK, 1 row affected (0,01 sec)

mysql> exit
Bye
user@user-VirtualBox:~$ sudo mysqldump -u root example > example.sql
user@user-VirtualBox:~$ sudo mysqldump -u root -p  example > example.sql
Enter password: 
user@user-VirtualBox:~$ ls -la
total 104
drwxr-xr-x 15 user user 4096 апр 23 19:55 .
drwxr-xr-x  3 root root 4096 апр 20 23:26 ..
-rw-------  1 user user  435 апр 21 00:48 .bash_history
-rw-r--r--  1 user user  220 апр 20 23:26 .bash_logout
-rw-r--r--  1 user user 3771 апр 20 23:26 .bashrc
drwx------ 12 user user 4096 апр 21 00:16 .cache
drwx------ 11 user user 4096 апр 20 23:52 .config
drwxr-xr-x  2 user user 4096 апр 20 23:41 Desktop
drwxr-xr-x  2 user user 4096 апр 20 23:41 Documents
drwxr-xr-x  2 user user 4096 апр 20 23:41 Downloads
-rw-rw-r--  1 user user 1816 апр 23 19:55 example.sql
drwx------  3 user user 4096 апр 20 23:57 .gnupg
drwx------  3 user user 4096 апр 20 23:41 .local
drwxr-xr-x  2 user user 4096 апр 20 23:41 Music
-rw-rw-r--  1 user user   32 апр 23 19:47 .my.cnf
drwxr-xr-x  2 user user 4096 апр 20 23:41 Pictures
-rw-r--r--  1 user user  807 апр 20 23:26 .profile
drwxr-xr-x  2 user user 4096 апр 20 23:41 Public
drwx------  2 user user 4096 апр 21 00:06 .ssh
-rw-r--r--  1 user user    0 апр 20 23:43 .sudo_as_admin_successful
drwxr-xr-x  2 user user 4096 апр 20 23:41 Templates
-rw-r-----  1 user user    5 апр 20 23:56 .vboxclient-clipboard.pid
-rw-r-----  1 user user    5 апр 20 23:56 .vboxclient-display-svga-x11.pid
-rw-r-----  1 user user    5 апр 20 23:56 .vboxclient-draganddrop.pid
-rw-r-----  1 user user    5 апр 20 23:56 .vboxclient-seamless.pid
drwxr-xr-x  2 user user 4096 апр 20 23:41 Videos
-rw-------  1 user user  987 апр 21 00:05 .viminfo
user@user-VirtualBox:~$ sudo mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 14
Server version: 8.0.28-0ubuntu0.20.04.3 (Ubuntu)

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> USE sample;
Database changed
mysql> SHOW TABLES;
Empty set (0,00 sec)

mysql> exit
Bye
user@user-VirtualBox:~$ sudo mysql sample < example.sql
user@user-VirtualBox:~$ sudo mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 16
Server version: 8.0.28-0ubuntu0.20.04.3 (Ubuntu)

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SHOW TABLES
    -> ;
ERROR 1046 (3D000): No database selected
mysql> USE SAMPLE;
ERROR 1049 (42000): Unknown database 'SAMPLE'
mysql> use sample;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+------------------+
| Tables_in_sample |
+------------------+
| users            |
+------------------+
1 row in set (0,01 sec)

mysql> exit
Bye

/* Задание 4
(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
*/



user@user-VirtualBox:~$ sudo mysqldump -u root -p --opt --where"1 limit 100" mysql help_keyword > hk100.sql
mysqldump: [ERROR] unknown option '--where1 limit 100'.
user@user-VirtualBox:~$ sudo mysqldump -u root -p --opt --where="1 limit 100" mysql help_keyword > hk100.sql
Enter password: 
user@user-VirtualBox:~$ ls -la
total 108
drwxr-xr-x 15 user user 4096 апр 23 20:00 .
drwxr-xr-x  3 root root 4096 апр 20 23:26 ..
-rw-------  1 user user  435 апр 21 00:48 .bash_history
-rw-r--r--  1 user user  220 апр 20 23:26 .bash_logout
-rw-r--r--  1 user user 3771 апр 20 23:26 .bashrc
drwx------ 12 user user 4096 апр 21 00:16 .cache
drwx------ 11 user user 4096 апр 20 23:52 .config
drwxr-xr-x  2 user user 4096 апр 20 23:41 Desktop
drwxr-xr-x  2 user user 4096 апр 20 23:41 Documents
drwxr-xr-x  2 user user 4096 апр 20 23:41 Downloads
-rw-rw-r--  1 user user 1816 апр 23 19:55 example.sql
drwx------  3 user user 4096 апр 20 23:57 .gnupg
-rw-rw-r--  1 user user 3657 апр 23 20:01 hk100.sql
drwx------  3 user user 4096 апр 20 23:41 .local
drwxr-xr-x  2 user user 4096 апр 20 23:41 Music
-rw-rw-r--  1 user user   32 апр 23 19:47 .my.cnf
drwxr-xr-x  2 user user 4096 апр 20 23:41 Pictures
-rw-r--r--  1 user user  807 апр 20 23:26 .profile
drwxr-xr-x  2 user user 4096 апр 20 23:41 Public
drwx------  2 user user 4096 апр 21 00:06 .ssh
-rw-r--r--  1 user user    0 апр 20 23:43 .sudo_as_admin_successful
drwxr-xr-x  2 user user 4096 апр 20 23:41 Templates
-rw-r-----  1 user user    5 апр 20 23:56 .vboxclient-clipboard.pid
-rw-r-----  1 user user    5 апр 20 23:56 .vboxclient-display-svga-x11.pid
-rw-r-----  1 user user    5 апр 20 23:56 .vboxclient-draganddrop.pid
-rw-r-----  1 user user    5 апр 20 23:56 .vboxclient-seamless.pid
drwxr-xr-x  2 user user 4096 апр 20 23:41 Videos
-rw-------  1 user user  987 апр 21 00:05 .viminfo
user@user-VirtualBox:~$ cat hk100.sql
-- MySQL dump 10.13  Distrib 8.0.28, for Linux (x86_64)
--
-- Host: localhost    Database: mysql
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.20.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_keyword`
--
-- WHERE:  1 limit 100

LOCK TABLES `help_keyword` WRITE;
/*!40000 ALTER TABLE `help_keyword` DISABLE KEYS */;
INSERT INTO `help_keyword` VALUES (108,'%'),(264,'&'),(422,'(JSON'),(86,'*'),(84,'+'),(85,'-'),(423,'->'),(425,'->>'),(87,'/'),(75,':='),(59,'<'),(266,'<<'),(58,'<='),(56,'<=>'),(57,'<>'),(55,'='),(61,'>'),(60,'>='),(267,'>>'),(90,'ABS'),(879,'ACCOUNT'),(91,'ACOS'),(659,'ACTION'),(49,'ADD'),(120,'ADDDATE'),(121,'ADDTIME'),(913,'ADMIN'),(270,'AES_DECRYPT'),(271,'AES_ENCRYPT'),(581,'AFTER'),(247,'AGAINST'),(934,'AGGREGATE'),(582,'ALGORITHM'),(721,'ALL'),(50,'ALTER'),(583,'ANALYZE'),(62,'AND'),(526,'ANY_VALUE'),(660,'ARCHIVE'),(254,'ARRAY'),(722,'AS'),(464,'ASC'),(185,'ASCII'),(92,'ASIN'),(774,'ASSIGN_GTIDS_TO_ANONYMOUS_TRANSACTIONS'),(6,'ASYMMETRIC_DECRYPT'),(7,'ASYMMETRIC_DERIVE'),(8,'ASYMMETRIC_ENCRYPT'),(9,'ASYMMETRIC_SIGN'),(10,'ASYMMETRIC_VERIFY'),(643,'AT'),(93,'ATAN'),(94,'ATAN2'),(880,'ATTRIBUTE'),(911,'AUTHENTICATION'),(743,'AUTOCOMMIT'),(584,'AUTOEXTEND_SIZE'),(585,'AUTO_INCREMENT'),(458,'AVG'),(586,'AVG_ROW_LENGTH'),(755,'BACKUP'),(769,'BEFORE'),(744,'BEGIN'),(288,'BENCHMARK'),(63,'BETWEEN'),(186,'BIN'),(253,'BINARY'),(563,'BINLOG'),(527,'BIN_TO_UUID'),(460,'BIT_AND'),(269,'BIT_COUNT'),(187,'BIT_LENGTH'),(461,'BIT_OR'),(462,'BIT_XOR'),(17,'BOOL'),(18,'BOOLEAN'),(230,'BOTH'),(647,'BTREE'),(465,'BY'),(42,'BYTE'),(969,'CACHE'),(689,'CALL'),(497,'CAN_ACCESS_COLUMN'),(498,'CAN_ACCESS_DATABASE'),(499,'CAN_ACCESS_TABLE'),(500,'CAN_ACCESS_USER'),(501,'CAN_ACCESS_VIEW'),(661,'CASCADE'),(76,'CASE'),(255,'CAST'),(860,'CATALOG_NAME'),(95,'CEIL'),(96,'CEILING'),(745,'CHAIN'),(881,'CHALLENGE_RESPONSE'),(587,'CHANGE'),(564,'CHANNEL'),(43,'CHAR'),(39,'CHARACTER'),(189,'CHARACTER_LENGTH');
/*!40000 ALTER TABLE `help_keyword` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-23 20:01:31
user@user-VirtualBox:~$ 