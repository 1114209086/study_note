CREATE DATABASE IF NOT EXISTS RUNOOB DEFAULT CHARSET utf8 COLLATE utf8_general_ci; 

	创建数据库，该命令的作用：

	    1. 如果数据库不存在则创建，存在则不创建。  
	    2. 创建RUNOOB数据库，并设定编码集为utf8 

USE RUNOOB;  

	使用数据库。  

CREATE TABLE IF NOT EXISTS `test`(
`id` INT  UNSIGNED  AUTO_INCREMENT,
`name` VARCHAR (100) NOT NULL,
`data` DATE,
PRIMARY KEY (id)
)ENGINE=INNODB DEFAULT CHARSET=utf8;

	创建数据表
