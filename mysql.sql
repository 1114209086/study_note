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

INSERT INTO 表名 ( field1, field2,...fieldN )
                       VALUES
                       ( value1, value2,...valueN )
	插入数据的语法
INSERT INTO table_name  (field1, field2,...fieldN)  VALUES  (valueA1,valueA2,...valueAN),(valueB1,valueB2,...valueBN),(valueC1,valueC2,...valueCN)......;
	插入多条数据

SELECT * FROM 表名;
	查询表里面所有的数据
SELCT field1, field2 FROM 表名;
	查询表里面的field1, field2数据
SELECT DISTINCT field1 FROM 表名;
	查询表里面的field1不重复的数据，如果是field1，field2 就是field1不同或者field2也不同的
	eg: select distinct name from students;//查询名字不相同的学生;
	select distinct name,age from students;//查询名字和年龄同时不同的学生
SELECT field FROM 表名 WHERE 条件 
	条件查询语句
	where后面的条件可以用>、<、>=、<=、!=等多种比较运算符，多个条件之间可以用or、and等逻辑运算符
SELECT * FROM 表名 [WHERE 条件] [ ORDER BY  field1 [DESC/ASC],field2 [DESC/ASC]... ];
	查询按照排序
SELECT * FROM 表名 ORDER BY mark DESC LIMIT 2,2 
	查询成绩第三四名的学生
SELECT count(1) FROM 表名;
	统计总条数；
SELECT field，count(1) FROM 表名 GROUP BY field;
	分组与统计放在一起。少了统计的话 与SELECT DISTINCT field1 FROM 表名; 一样

SELECT 字段 fun_name FROM 表名 [WHERE 条件] [GROUP BY field1,field2...] [WITH ROLLUP] [HAVING 条件];
	1.fun_name 表示要做的聚合操作，也就是说聚合函数，常用的有 : sum(求和)、count(*)(记录数)、max(最大值)、min(最小值)。
	2.group by关键字 表示要进行分类聚合的字段。比如要按照部门分类统计员工数量，部门就应该写在group by 后面。
	3.with rollup 是可选语法，表明是否对分类聚合后的结果进行再汇总
	4.having 关键字表示对分类后的结果再进行条件过滤

SELECT table1.field , table2.field FROM table1,table2 WHERE table1.field = table2.field;
	内联查询

SELECT table1.field , table2.field FROM table1 LEFT JOIN table2 ON table1.field = table2.field;
	做外联查询

SELECT table1.field , table2.field FROM table1 RIGHT JOIN table2 ON table1.field = table2.field;
	右外联查询

DROP TABLE 表名;
	删除表