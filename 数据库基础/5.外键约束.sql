# 添加外键约束
DROP TABLE IF EXISTS emp;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;

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
	dep_id INT, -- 外键对应主表的主键 -- 部门的编号
# constraint 外键名 foreign key (主表的外键字段) references 副表名(附表字段)
	CONSTRAINT emp_dept_fk FOREIGN KEY (dep_id) REFERENCES department(id)
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


# 删除外键 -> alter 修改表
ALTER TABLE employee DROP FOREIGN KEY emp_dept_fk

# 添加外键
ALTER TABLE employee ADD CONSTRAINT emp_dept_fk FOREIGN KEY (dep_id) REFERENCES department(id);

# 级联操作 -> 所谓级联操作, 就是联动, 当更改关联外键时, 关联的外键值同样改变
# 这里我们使用架构设计器来观察多表之间的关系
# 我们先删除外键, 然后再添加外键并且设置级联更新
ALTER TABLE employee DROP FOREIGN KEY emp_dept_fk; -- 删除外键
# 然后添加外键并且设置级联更新
ALTER TABLE employee ADD CONSTRAINT emp_dept_fk FOREIGN KEY
(dep_id) REFERENCES department(id) ON UPDATE CASCADE;

# 然后查询一下
SELECT * FROM department;
SELECT * FROM employee;
# 当department的id改变时, 级联的(联动)employee的dep_id也会改变

# 同时也有一个级联删除的操作
# 同样, 我们也需要删除外键, 然后在设置级联更新的时候, 设置级联删除
ALTER TABLE employee DROP FOREIGN KEY emp_dept_fk;

# 添加外键约束, 同时设置级联更新和级联约束
ALTER TABLE employee ADD CONSTRAINT emp_dept_fk FOREIGN KEY
(dep_id) REFERENCES department(id) ON UPDATE CASCADE ON DELETE CASCADE;





