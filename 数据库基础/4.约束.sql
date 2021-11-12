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
# 同样, 添加主键前, 我们要看条件是否满足




SELECT * FROM stu;














