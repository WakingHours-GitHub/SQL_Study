USE mydb1;
# 约束： 对数据进行限定，保证CIA

# 非空约束: 
# 创建时添加约束: 再创建时在需要的列明后面写上约束类型
CREATE TABLE IF NOT EXISTS stu(
	id INT,
	NAME VARCHAR(20) NOT NULL -- name为非空
);
# 添加约束后, name不能为空, 如果为NULL, 则报错

# 删除name的非空约束 -> 实际上就是修改表的字段
ALTER TABLE stu MODIFY NAME VARCHAR(20);
# 通过[改变表] F6 查看约束

# 创建表后, 添加非空约束 -> 同样也是修改表字段
ALTER TABLE stu MODIFY NAME VARCHAR(20) NOT NULL;

SELECT * FROM stu;

DROP TABLE IF EXISTS stu;

# unique 唯一约束
# 创建表时, 添加唯一约束
CREATE TABLE stu(
	id INT,
	phone_number VARCHAR(20) UNIQUE -- 添加了唯一约束
);
# 添加唯一约束后, phone_number字段, 不允许出现一样的值,否则报错
# 注意: mysql中, 唯一约束限定的列的值:可以添加NULL, 并且可以有多个NULL

# 删除唯一约束
-- alter table stu modify phone_number varchar(20); 无法删除唯一约束
ALTER TABLE stu DROP INDEX phone_number; -- 修改表 stu 删除索引 phone_number
# 因为唯一约束我们也称为索引

# 在创建表后, 添加唯一约束
ALTER TABLE stu MODIFY phone_number VARCHAR(20) UNIQUE;
# 这样添加约束之前, 需要确保里面没有重复的数据, 再添加唯一约束

SELECT * FROM stu;

DROP TABLE IF EXISTS stu;


# 主键约束
# 创建表的时候添加主键约束
CREATE TABLE stu(
	id INT PRIMARY KEY, -- 给id添加主键约束
	NAME VARCHAR(20)
);
# 添加主键后, 我们的id字段, 非空, 并且唯一

# 删除主键:
-- alter table stu modify id int; -- 虽然执行成功了,但是主键并没有被删除
ALTER TABLE stu DROP PRIMARY KEY; -- 不用指定字段, 因为一个表只有一个主键

# 创建表后, 添加主键:
ALTER TABLE stu MODIFY id INT PRIMARY KEY;
# 同样, 添加主键前, 我们要看条件是否满足， 否则, 条件不满足, 则报错

SELECT * FROM stu;

DROP TABLE IF EXISTS stu;

# 自动增长
CREATE TABLE stu(
	id INT PRIMARY KEY AUTO_INCREMENT, -- 主键, 并且自动增长
	NAME VARCHAR(20)
);
-- 添加完自动增长后, 我们主键就可以插入NULL值了, (没添加自动增长, 主键必须非空)
-- , 是根据主键上面的数值+1

SELECT * FROM stu;

INSERT INTO stu VALUES(NULL, 'ccc');

# 你也可以委派这个值:
INSERT INTO stu VALUES(10, 'ddd'); # id = 10 
INSERT INTO stu VALUES(NULL, 'eee'); # id = 11 了
# 自动增长, 只读取上一条id的值然后+1即可

# 删除自动增长
ALTER TABLE stu MODIFY id INT;

# 添加自动增长
ALTER TABLE stu MODIFY id INT AUTO_INCREMENT; 

# 外键约束
# 涉及到多张表的操作
# 所以我们先看一下例子
DROP TABLE IF EXISTS emp;
CREATE TABLE emp( -- 创建emp表
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(30),
	age INT,
	dep_name VARCHAR(30), -- 部门名称
	dep_location VARCHAR(30) -- 部门地址
);

TRUNCATE TABLE emp; -- 删除所有数据
# 添加数据
# id是主键, 不赋值默认为null, 但是有自动增长, 所以从1自动开始增长
INSERT INTO emp (NAME, age, dep_name, dep_location) VALUES ('张三', 20, '研发部', '广州');
INSERT INTO emp (NAME, age, dep_name, dep_location) VALUES ('李四', 21, '研发部', '广州');
INSERT INTO emp (NAME, age, dep_name, dep_location) VALUES ('王五', 20, '研发部', '广州');
INSERT INTO emp (NAME, age, dep_name, dep_location) VALUES ('老王', 20, '销售部', '深圳');
INSERT INTO emp (NAME, age, dep_name, dep_location) VALUES ('大王', 22, '销售部', '深圳');
INSERT INTO emp (NAME, age, dep_name, dep_location) VALUES ('小王', 18, '销售部', '深圳');

SELECT * FROM emp;
-- 发现数据有冗余
-- 并不符合我们数据库涉及的准测

# 应该怎么做: 表的拆分
# 我们拆成两张表: 一张表存放员工信息, 另一张表存放部门信息
CREATE TABLE department( -- 部门表
	id INT PRIMARY KEY AUTO_INCREMENT,
	dep_name VARCHAR(20),
	dep_location VARCHAR(20) 
);
-- 创建员工表(id,name,age,dep_id)
-- 多方，从表
CREATE TABLE employee(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20),
	age INT,
	dep_id INT -- 外键对应主表的主键 -- 部门的编号
);
-- 添加 2 个部门

INSERT INTO department VALUES(NULL, '研发部','广州'),(NULL, '销售部', '深圳');
SELECT * FROM department; -- 查询部门

-- 添加员工,dep_id 表示员工所在的部门
INSERT INTO employee (NAME, age, dep_id) VALUES ('张三', 20, 1);
INSERT INTO employee (NAME, age, dep_id) VALUES ('李四', 21, 1);
INSERT INTO employee (NAME, age, dep_id) VALUES ('王五', 20, 1);
INSERT INTO employee (NAME, age, dep_id) VALUES ('老王', 20, 2);
INSERT INTO employee (NAME, age, dep_id) VALUES ('大王', 22, 2);
INSERT INTO employee (NAME, age, dep_id) VALUES ('小王', 18, 2);

SELECT * FROM employee; -- 查询员工



















