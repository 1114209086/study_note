一、用户创建、权限、删除
1. 连接mysql操作
连接：mysql -h host -u username -p pswd （注：-p与密码之间可以不加空格，其他也一样）
断开：exit
2. 创建用户
命令：create user 'username'@'host' identified by 'pswd';
说明：
host-指定该用户在哪个主机上可以登陆，如果想让该用户从任意远程主机登陆，可以使用通配符%
pswd-该用户的登陆密码，可以为空，如果为空则该用户登陆时不许要密码
3. 授权
命令：grant privileges on databasename.tablename to 'username'@'host';
说明：
privileges-用户的操作权限，如select,insert,update等，如果要授予所有的权限则用all。
如果要授予该用户所有数据库和表的操作则用*.*
注：这样授权的用户不可再授权与他人，如果想让该用户可以授权则使用
命令：grant privileges on databasename.tablename to 'username'@'host' with grant options;
4. 撤消用户权限
revoke privileges on databasename.tablename from 'username'@'host';
注意: 假如你在给用户'pig'@'%'授权的时候是这样的(或类似的):GRANT SELECT ON test.user TO 'pig'@'%', 
则在使用REVOKE SELECT ON *.* FROM 'pig'@'%';命令并不能撤销该用户对test数据库中user表的SELECT 操作.
相反,如果授权使用的是GRANT SELECT ON *.* TO 'pig'@'%';则REVOKE SELECT ON test.user FROM 'pig'@'%';
命令也不能撤销该用户对test数据库中user表的Select 权限. 
具体信息可以用命令SHOW GRANTS FOR 'pig'@'%'; 查看. 
5. 设置与更改用户密码
命令：set password for 'username'@'host' = password('pswd');
如果是当前用户 set password = password('pswd');
6. 删除用户
命令：drop user 'username'@'host';
二、数据库与表显示、创建、删除
1. 显示数据库
命令：show databases;
2. 创建数据库
命令：create databse databasename;
3. 删除数据库
命令：drop databse databasename;
4. 使用库
命令：use databasename;
5. 显示数据表
命令：show tables;
6. 显示表结构
命令：desc tablename; 或者describe tablename;
7. 创建表
命令：create table tablename (field-define)ENGINE=InnoDB DEFAULT CHARSET=utf8;
8. 删除表 
命令：drop table tablename;
三、表复制及备份还原
1. 复制表结构（含有主键等信息的完整表结构 并不包含数据）
命令：create table newtablename like oldtablename;
2. 只有表结构
命令：create table newtablename select * from oldtablename;
    或create table newtablename as(select * from oldtablename);
	或create table newtablename select * from oldtablename where 1=2;
3. 如果你要真正的复制一个表。可以用下面的语句。 
命令：CREATE TABLE newtablename LIKE oldtablename; 
      INSERT INTO newtablename SELECT * FROM oldtablename;
4. 输入创建表的DDL语句
命令：show create table tablename;
5. 清空数据
命令：truncate table tablename;
6. 备份数据库
	比如备份library数据库
	进去Mysql的bin目录
	E:\mysql-5.6.23-win32\bin
	利用命令：mysqldump  -u username -p databasename>备份名字 导出数据库到文件
	C:\Program Files\MySQL\MySQL Server 5.5\bin>mysqldump -u root -p test >test.sql
	Enter password: ***
	即可.
7. 还原数据库
	还原test数据库为例
	先create database test1
	然后 下mysql>下
	输入命令：source path-name;
	即可。
	要注意test.sql所在的路径！
8. 导出数据
命令：select field1... from tablename into outfile "filename_path";
9. 导入数据
命令：load data infile "filedname" into table tablename;
四、修改表
1. 给列更名
命令：alter table tablename change oldfieldname newfieldname 新类型 新参数;
2. 修改表名
命令：alter table tablename rename newtablename;
3. 添加字段
命令：alter table tablename add column newfieldname fieldtype default value [after filedname];(添加到哪个字段之后)
4. 删除字段
命令：alter table tablename drop column newfieldname;
5. 调整顺序
命令：alter table tablename change oldfieldname newfieldname fieldtype default value after filedname;(跳到哪个字段之后)
6. 增加一个字段作为主键
命令：alter table tablename add column newfieldname fieldtype auto_increment primarykey;
7. 改变列的类型
命令：与 给列更名 语法一样，新旧名字一样就行。
五：索引
1. 添加索引
命令：alter table tablename add index indexname (filedname1[,filedname2...]);
命令：ALTER TABLE tablename ADD UNIQUE (filedname1[,filedname2...]);
命令：ALTER TABLE tablename ADD PRIMARY KEY (filedname1[,filedname2...]);
命令：CREATE INDEX indexname ON tablename (filedname1[,filedname2...]);
命令：CREATE UNIQUE INDEX indexname ON tablename (filedname1[,filedname2...]);
2. 删除索引
命令：alter table tablename drop index indexname;
命令：DROP INDEX indexname ON tablename;
3. 查看索引
命令：show index from tablename;
命令：show keys from tablename;

索引创建规则：
1、表的主键、外键必须有索引；
2、数据量超过300的表应该有索引；
3、经常与其他表进行连接的表，在连接字段上应该建立索引；
4、经常出现在Where子句中的字段，特别是大表的字段，应该建立索引；
5、索引应该建在选择性高的字段上；
6、索引应该建在小字段上，对于大的文本字段甚至超长字段，不要建索引；
7、复合索引的建立需要进行仔细分析；尽量考虑用单字段索引代替：
　　A、正确选择复合索引中的主列字段，一般是选择性较好的字段；
　　B、复合索引的几个字段是否经常同时以AND方式出现在Where子句中？单字段查询是否极少甚至没有？如果是，则可以建立复合索引；否则考虑单字段索引；
　　C、如果复合索引中包含的字段经常单独出现在Where子句中，则分解为多个单字段索引；
　　D、如果复合索引所包含的字段超过3个，那么仔细考虑其必要性，考虑减少复合的字段；
　　E、如果既有单字段索引，又有这几个字段上的复合索引，一般可以删除复合索引；
8、频繁进行数据操作的表，不要建立太多的索引；
9、删除无用的索引，避免对执行计划造成负面影响；

建索引的几大原则

1.最左前缀匹配原则，非常重要的原则，mysql会一直向右匹配直到遇到范围查询(>、<、between、like)就停止匹配，比如a = 1 and b = 2 and c > 3 and d = 4 如果建立(a,b,c,d)顺序的索引，d是用不到索引的，如果建立(a,b,d,c)的索引则都可以用到，a,b,d的顺序可以任意调整。
2.=和in可以乱序，比如a = 1 and b = 2 and c = 3 建立(a,b,c)索引可以任意顺序，mysql的查询优化器会帮你优化成索引可以识别的形式
3.尽量选择区分度高的列作为索引,区分度的公式是count(distinct col)/count(*)，表示字段不重复的比例，比例越大我们扫描的记录数越少，唯一键的区分度是1，而一些状态、性别字段可能在大数据面前区分度就是0，那可能有人会问，这个比例有什么经验值吗？使用场景不同，这个值也很难确定，一般需要join的字段我们都要求是0.1以上，即平均1条扫描10条记录
4.索引列不能参与计算，保持列“干净”，比如from_unixtime(create_time) = ’2014-05-29’就不能使用到索引，原因很简单，b+树中存的都是数据表中的字段值，但进行检索时，需要把所有元素都应用函数才能比较，显然成本太大。所以语句应该写成create_time = unix_timestamp(’2014-05-29’);
5.尽量的扩展索引，不要新建索引。比如表中已经有a的索引，现在要加(a,b)的索引，那么只需要修改原来的索引即可

查询优化神器 – explain命令
关于explain命令相信大家并不陌生，具体用法和字段含义可以参考官网explain-output，这里需要强调rows是核心指标，绝大部分rows小的语句执行一定很快（有例外，下面会讲到）。所以优化语句基本上都是在优化rows。

慢查询优化基本步骤

0.先运行看看是否真的很慢，注意设置SQL_NO_CACHE
1.where条件单表查，锁定最小返回记录表。这句话的意思是把查询语句的where都应用到表中返回的记录数最小的表开始查起，单表每个字段分别查询，看哪个字段的区分度最高
2.explain查看执行计划，是否与1预期一致（从锁定记录较少的表开始查询）
3.order by limit 形式的sql语句让排序的表优先查
4.了解业务方使用场景
5.加索引时参照建索引的几大原则
6.观察结果，不符合预期继续从0分析
