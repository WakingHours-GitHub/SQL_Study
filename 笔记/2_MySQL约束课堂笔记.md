 # 今日内容
	
	1. DQL:查询语句
		1. 排序查询
		2. 聚合函数
		3. 分组查询
		4. 分页查询

	2. 约束
	3. 多表之间的关系
	4. 范式
	5. 数据库的备份和还原

--------------------------------------------------------------
继续查询语句 
# DQL:查询语句
	1. 排序查询
		* 语法：order by 子句
			* order by 排序字段1 排序方式1 ，  排序字段2 排序方式2...
				可以有多个排序字段和排序方式

		* 排序方式：
			* ASC：升序，默认的。
			* DESC：降序。

		* 注意：
			* 如果有多个排序条件，则只有当前边的条件值一样时，才会使用第二条件判断。

		例：SELECT * FROM student ORDER BY math DESC, ORDER BY english DESC;
		这句话是说对于student这张表对math进行降序，对english进行排序


	2. 聚合函数：将一列数据作为一个整体，进行纵向的计算。
		注意这是进行纵向的计算, 以一列作为整体.
		1. count：计算个数
			1. 一般选择非空的列：主键 (以后学)
			2. count(*) # 这一列数据有一个不为null, 并推荐使用
		2. max：计算最大值
		3. min：计算最小值
		4. sum：计算和
		5. avg：计算平均值
		

		* 注意：聚合函数的计算，是排除null值的。也就是null值不算做计算的数值.
			解决方案: 
				1. 选择不包含非空的列进行计算.
				2. IFNULL函数（将那一列的值替换成第二个参数）

	3. 分组查询:
			统计具有相同特征的数据,并进行分类,看作一个整体
		1. 语法：group by 分组字段；
		2. 注意：
			分组之后看成一个整体，此时再去查看一些个人的字段将毫无意义，所以我们这里只能查询分组字段，以及聚合函数（同样也是对一列进行操作）
			1. 分组之后查询的字段：分组字段、聚合函数
			2. where 和 having 的区别？ （面试常考）
				1. where 在分组之前进行限定，如果不满足条件，则不参与分组。having在分组之后进行限定，如果不满足结果，则不会被查询出来
				2. where 后不可以跟聚合函数，having可以进行聚合函数的判断。
				一定要记住这两个区别
			SQL练习: 

			-- 按照性别分组。分别查询男、女同学的平均分

			SELECT sex , AVG(math) FROM student GROUP BY sex;
			
			-- 按照性别分组。分别查询男、女同学的平均分,人数
			
			SELECT sex , AVG(math),COUNT(id) FROM student GROUP BY sex;
			
			--  按照性别分组。分别查询男、女同学的平均分,人数 要求：分数低于70分的人，不参与分组
			SELECT sex , AVG(math),COUNT(id) FROM student WHERE math > 70 GROUP BY sex;
			
			--  按照性别分组。分别查询男、女同学的平均分,人数 要求：分数低于70分的人，不参与分组,分组之后。人数要大于2个人
			SELECT sex , AVG(math),COUNT(id) FROM student WHERE math > 70 GROUP BY sex HAVING COUNT(id) > 2;

			此时这个Sql语句已经非常长了，并且看起来也不好理解，所以我们用起别名操作，让我们的语句看起来更加容易理解（这里省略了AS)			
			SELECT sex , AVG(math),COUNT(id) 人数 FROM student WHERE math > 70 GROUP BY sex HAVING 人数 > 2;


			
	4. 分页查询
	 	再浏览器搜索时，一个页面上的多条数据(信息)然后每页固定多少条, 最下面还有页码
		这就是分页功能
		1. 语法：limit 开始的索引,每页查询的条数;
		2. 公式：开始的索引 = （当前的页码 - 1） * 每页显示的条数 (这个公式非常重要）
			-- 每页显示3条记录 

			SELECT * FROM student LIMIT 0,3; -- 第1页
			
			SELECT * FROM student LIMIT 3,3; -- 第2页
			
			SELECT * FROM student LIMIT 6,3; -- 第3页
		我们会在以后继续讲解分页,这是一个比较难的知识点

		3. limit 是一个MySQL"方言". 所以limit只能在MySql中使用.

接下来:
[P505](https://www.bilibili.com/video/BV1uJ411k7wy?p=505)

-------------------------------------------------------------------------------
## 约束
	* 概念： 对表中的 数据 进行限定，保证数据的正确性、有效性和完整性。	
     看清对象： 数据, 对数据进行限定
	 否则什么数据都可以添加到我们数据库这里来了 
	* 分类：(MySQL约束的分类)
		1. 主键约束：primary key	一会讲
		2. 非空约束：not null		不能为空(NULL)
		3. 唯一约束：unique		不能重复
		4. 外键约束：foreign key	一会讲
	
	接下来我们讲解一下如何将约束添加到表的列上去
	从简单开始讲

	* 非空约束：not null -> 值不能为null
		1. 创建表时添加约束
			CREATE TABLE stu(
				id INT,
				NAME VARCHAR(20) NOT NULL -- name为非空
			);
		2. 创建表完后，添加非空约束
			ALTER TABLE stu MODIFY NAME VARCHAR(20) NOT NULL;

		3. 删除name的非空约束
			ALTER TABLE stu MODIFY NAME VARCHAR(20);

		需要注意的是：若原来字段列数据有NULL，此时再对该字段添加非空约束，则会出现错误
	
	
	* 唯一约束：unique -> 值不能重复
		1. 创建表时，添加唯一约束
			CREATE TABLE stu(
				id INT,
				phone_number VARCHAR(20) UNIQUE -- 添加了唯一约束
			
			);
			* 注意mysql中，唯一约束限定的列的值可以有多个null（这点也要注意，可以理解成NULL不唯一）
		
		
		2. 删除唯一约束（与其他删除不同，一般来说唯一约束，又称索引约束，所以这里是drop index 字段名）
		
			ALTER TABLE stu DROP INDEX phone_number;
		
		3. 在创建表后，添加唯一约束
			ALTER TABLE stu MODIFY phone_number VARCHAR(20) UNIQUE;
	
	* 主键约束：primary key。
		1. 注意：
			1. 含义：非空且唯一（前面两种的集合）
			2. 一张表只能有一个字段为主键
			3. 主键就是表中记录的唯一标识（唯一，不可空）

		2. 在创建表时，添加主键约束
			create table stu(
				id int primary key,-- 给id添加主键约束
				name varchar(20)
			);

		3. 删除主键
			-- 错误 alter table stu modify id int ;
			ALTER TABLE stu DROP PRIMARY KEY;

		4. 创建完表后，添加主键
			ALTER TABLE stu MODIFY id INT PRIMARY KEY;

		5. 自动增长： -> 数值的自动增长
			1. 概念：如果某一列是数值类型的，使用auto_increment 关键字 -> 可以来完成值得自动增长
			2. 一般来说auto_increment配合int类型的主键一起来使用。
			
			3. 在创建表时，添加主键约束，并且完成主键自增长
			create table stu(
				id int primary key auto_increment,-- 给id添加主键约束, 并且自动增长
				name varchar(20)
			); 
			
			4. 删除自动增长
			ALTER TABLE stu MODIFY id INT;

			5. 添加自动增长
			ALTER TABLE stu MODIFY id INT AUTO_INCREMENT;
			
			一般来说自动增长都是配合主键来使用的. 很少有情况不是配合主键使用，所以我们也就不在介绍了。


	* 外键约束：foreign key -> 让表于表产生关系，从而保证数据的正确性。
		1. 在创建表时，可以添加外键
			* 语法：
				create table 表名(
					.... -- 字段列表
					外键列
					constraint 外键名称 foreign key (外键列名称) references 主表名称(主表列名称)
					-- 约束 外键名称 外键 外键列名称 关联 主表列名称
				);

		2. 删除外键
			ALTER TABLE 表名 DROP FOREIGN KEY 外键名称;

		3. 创建表之后，添加外键
			ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY (外键字段名称) REFERENCES 主表名称(主表列名称);
		
		
		4. 级联操作 -> 联动的操作, 就是当副表被关联的键改变时, 主表关联外键的值也被改变 
			1. 添加级联操作
				语法：ALTER TABLE 表名 ADD CONSTRAINT 外键名称 
						FOREIGN KEY (外键字段名称) REFERENCES 主表名称(主表列名称) [ON UPDATE CASCADE] [ON DELETE CASCADE] ;
			级联更新和级联删除是可选项, 在添加外键约束的时候可以带上
			特别的, 级联删除是将所有的外键关联的数据删除, 所以这个操作要谨慎
			2. 分类：
				1. 级联更新：ON UPDATE CASCADE 
				2. 级联删除：ON DELETE CASCADE 
		SQLyog中有架构设计器, 可以直观的看到我们对于多表之间的关系的操作


## 数据库的设计 -> 重要, 抽象
	数据库设计 -> 设计表 -> 里面有数据, 实际上就是对现实世界的一种抽象
	数据库设计是非常重要的

	1. 多表之间的关系
		1. 分类：
			1. 一对一(了解)： -> 较少情况
				* 如：人和身份证
				* 分析：一个人只有一个身份证，一个身份证只能对应一个人
			2. 一对多(多对一)： -> 最常见
				* 如：部门和员工 
				* 分析：一个部门有多个员工，一个员工只能对应一个部门
			3. 多对多： -> 
				* 如：学生和课程
				* 分析：一个学生可以选择很多门课程，一个课程也可以被很多学生选择
		接下来我们将会学习如何用数据库表示上述的这些关系

		2. 实现关系： -> 如何实现这些关系
			1. 一对多(多对一)：
				* 如：部门和员工
				* 分析:
					我们有一个员工表, 和一个部门表. 一个部门可以有多个员工, 所以部门是1,员工是n, 于是我们如何建立呢: 我们可以通过对员工表创建外键约束指向部门表的主键(或者xxid也行),来实现这种一对多的这种关系.
					即在n的一方建立外键, 指向1的一方的主键
				* 实现方式：在多的一方建立外键，指向一的一方的主键。
				
			2. 多对多：
				* 如：学生和课程
				* 实现方式：多对多关系实现需要借助第三张中间表。中间表至少包含两个字段，这两个字段作为第三张表的外键，分别指向两张表的主键
			3. 一对一(了解)：
				* 如：人和身份证
				* 实现方式：一对一关系实现，可以在任意一方添加唯一外键指向另一方的主键。

		3. 案例
			-- 创建旅游线路分类表 tab_category
			-- cid 旅游线路分类主键，自动增长
			-- cname 旅游线路分类名称非空，唯一，字符串 100
			CREATE TABLE tab_category (
				cid INT PRIMARY KEY AUTO_INCREMENT,
				cname VARCHAR(100) NOT NULL UNIQUE
			);
			
			-- 创建旅游线路表 tab_route
			/*
			rid 旅游线路主键，自动增长
			rname 旅游线路名称非空，唯一，字符串 100
			price 价格
			rdate 上架时间，日期类型
			cid 外键，所属分类
			*/
			CREATE TABLE tab_route(
				rid INT PRIMARY KEY AUTO_INCREMENT,
				rname VARCHAR(100) NOT NULL UNIQUE,
				price DOUBLE,
				rdate DATE,
				cid INT,
				FOREIGN KEY (cid) REFERENCES tab_category(cid)
			);
			
			/*创建用户表 tab_user
			uid 用户主键，自增长
			username 用户名长度 100，唯一，非空
			password 密码长度 30，非空
			name 真实姓名长度 100
			birthday 生日
			sex 性别，定长字符串 1
			telephone 手机号，字符串 11
			email 邮箱，字符串长度 100
			*/
			CREATE TABLE tab_user (
				uid INT PRIMARY KEY AUTO_INCREMENT,
				username VARCHAR(100) UNIQUE NOT NULL,
				PASSWORD VARCHAR(30) NOT NULL,
				NAME VARCHAR(100),
				birthday DATE,
				sex CHAR(1) DEFAULT '男',
				telephone VARCHAR(11),
				email VARCHAR(100)
			);
			
			/*
			创建收藏表 tab_favorite
			rid 旅游线路 id，外键
			date 收藏时间
			uid 用户 id，外键
			rid 和 uid 不能重复，设置复合主键，同一个用户不能收藏同一个线路两次
			*/
			CREATE TABLE tab_favorite (
				rid INT, -- 线路id
				DATE DATETIME,
				uid INT, -- 用户id
				-- 创建复合主键
				PRIMARY KEY(rid,uid), -- 联合主键
				FOREIGN KEY (rid) REFERENCES tab_route(rid),
				FOREIGN KEY(uid) REFERENCES tab_user(uid)
			);

		
	2. 数据库设计的范式 -> 数据库设计的准则
		* 概念：设计数据库时，需要遵循的一些规范。要遵循后边的范式要求，必须先遵循前边的所有范式要求

			设计关系数据库时，遵从不同的规范要求，设计出合理的关系型数据库，这些不同的规范要求被称为不同的范式，各种范式呈递次规范，越高的范式数据库冗余越小。
			目前关系数据库有六种范式：第一范式（1NF）、第二范式（2NF）、第三范式（3NF）、巴斯-科德范式（BCNF）、第四范式(4NF）和第五范式（5NF，又称完美范式）。

		* 分类：
			1. 第一范式（1NF）：每一列都是不可分割的原子数据项
			2. 第二范式（2NF）：在1NF的基础上，非码属性必须完全依赖于码（在1NF基础上消除非主属性对主码的部分函数依赖）
				* 几个概念：
					1. 函数依赖：A-->B,如果通过A属性(属性组)的值，可以确定唯一B属性的值。则称B依赖于A
						例如：学号-->姓名。  （学号，课程名称） --> 分数
					2. 完全函数依赖：A-->B， 如果A是一个属性组，则B属性值得确定需要依赖于A属性组中所有的属性值。
						例如：（学号，课程名称） --> 分数
					3. 部分函数依赖：A-->B， 如果A是一个属性组，则B属性值得确定只需要依赖于A属性组中某一些值即可。
						例如：（学号，课程名称） -- > 姓名
					4. 传递函数依赖：A-->B, B -- >C . 如果通过A属性(属性组)的值，可以确定唯一B属性的值，在通过B属性（属性组）的值可以确定唯一C属性的值，则称 C 传递函数依赖于A
						例如：学号-->系名，系名-->系主任
					5. 码：如果在一张表中，一个属性或属性组，被其他所有属性所完全依赖，则称这个属性(属性组)为该表的码
						例如：该表中码为：（学号，课程名称）
						* 主属性：码属性组中的所有属性
						* 非主属性：除过码属性组的属性
						
			3. 第三范式（3NF）：在2NF基础上，任何非主属性不依赖于其它非主属性（在2NF基础上消除传递依赖）


## 数据库的备份和还原

	1. 命令行：
		* 语法：
			* 备份： mysqldump -u用户名 -p密码 数据库名称 > 保存的路径
			* 还原：
				1. 登录数据库
				2. 创建数据库
				3. 使用数据库
				4. 执行文件。source 文件路径
	2. 图形化工具：