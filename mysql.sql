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
	LIMIT 用于分组查询
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
UPDATE table_name SET field1=new-value1, field2=new-value2 [WHERE Clause]
	更改数据;

UPDATE runoob_tbl SET runoob_title = REPLACE(runoob_title, 'C++', 'Python') where runoob_id = 3;
	更新 runoob_id 为 3 的runoob_title 字段值的 "C++" 替换为 "Python"：

SELECT field1, field2,...fieldN FROM table_name WHERE field1 LIKE condition1 [AND [OR]] filed2 = 'somevalue'
	LIKE 通常与 % 一同使用，类似于一个元字符的搜索。

SELECT expression1, expression2, ... expression_n
    FROM tables
    [WHERE conditions]
    UNION [ALL | DISTINCT]
    SELECT expression1, expression2, ... expression_n
    FROM tables
    [WHERE conditions];
	expression1, expression2, ... expression_n: 要检索的列。

	tables: 要检索的数据表。

	WHERE conditions: 可选， 检索条件。
	
	DISTINCT: 可选，删除结果集中重复的数据。默认情况下 UNION 操作符已经删除了重复数据，所以 DISTINCT 修饰符对结果没啥影响。
	
	ALL: 可选，返回所有结果集，包含重复数据。
   
SELECT * FROM table_name WHERE field IS NULL
SELECT * FROM table_name WHERE field IS NOT NULL
	查询空值或非空用这个

SELECT name FROM person_tbl WHERE name REGEXP '^s';
	查找以s开头的name.
	
	正则表达式：
	^: 匹配输入字符串的开始位置。如果设置了 RegExp 对象的 Multiline 属性，^ 也匹配 '\n' 或 '\r' 之后的位置。
	$: 匹配输入字符串的结束位置。如果设置了RegExp 对象的 Multiline 属性，$ 也匹配 '\n' 或 '\r' 之前的位置。
	.: 匹配除 "\n" 之外的任何单个字符。要匹配包括 '\n' 在内的任何字符，请使用象 '[.\n]' 的模式。
	[...]：字符集合。匹配所包含的任意一个字符。例如， '[abc]' 可以匹配 "plain" 中的 'a'。
	[^...]： 负值字符集合。匹配未包含的任意字符。例如， '[^abc]' 可以匹配 "plain" 中的'p'。
	p1|p2|p3：匹配 p1 或 p2 或 p3。例如，'z|food' 能匹配 "z" 或 "food"。'(z|f)ood' 则匹配 "zood" 或 "food"。
	*：匹配前面的子表达式零次或多次。例如，zo* 能匹配 "z" 以及 "zoo"。* 等价于{0,}。
	+：匹配前面的子表达式一次或多次。例如，'zo+' 能匹配 "zo" 以及 "zoo"，但不能匹配 "z"。+ 等价于 {1,}。
	{n}：n 是一个非负整数。匹配确定的 n 次。例如，'o{2}' 不能匹配 "Bob" 中的 'o'，但是能匹配 "food" 中的两个 o。
	{n,m}：m 和 n 均为非负整数，其中n <= m。最少匹配 n 次且最多匹配 m 次

事务：1 用BEGIN、ROLLBACK、COMMIT
      2 用SET AUTOCOMMIT=0禁止自动提交
        用SET AUTOCOMMIT=1开启自动提交












DELETE FROM table_name [WHERE Clause]
	删除数据，如果没有指定条件删除所有记录

DROP TABLE 表名;
	删除表