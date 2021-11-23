CREATE DATABASE IF NOT EXISTS mydb2;
USE mydb2;




# 创建部门表
CREATE TABLE dept(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20)
)
INSERT INTO dept (NAME) VALUES ('开发部'),('市场部'),('财务部'); 
# 创建员工表
CREATE TABLE emp (
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(10),	
	gender CHAR(1), -- 性别
	salary DOUBLE, -- 工资
	join_date DATE, -- 入职日期
	dept_id INT,
	FOREIGN KEY (dept_id) REFERENCES dept(id) -- 外键，关联部门表(部门表的主键)
) 
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('孙悟空','男',7200,'2013-02-24',1);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('猪八戒','男',3600,'2010-12-02',2);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('唐僧','男',9000,'2008-08-08',2);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('白骨精','女',5000,'2015-10-07',3);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('蜘蛛精','女',4500,'2011-03-14',1);



SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM dept, emp; 

TRUNCATE TABLE emp;

/* 笛卡尔积：
	有两个集合A,B .取这两个集合的所有组成情况。
	要完成多表查询，需要消除无用的数据.
*/
-- 消除无用的数据-> 就用到三种查询方式

-- 查询所有员工信息和对应的部门信息
-- 内连接 隐式查询
SELECT * FROM emp,dept WHERE emp.`dept_id` = dept.`id`; -- 有引号和无引号都行

-- 查询员工表的名称, 性别, 部门表的名称
SELECT emp.`name`, emp.`gender`, dept.`name` FROM emp, dept WHERE  emp.`dept_id` = dept.`id`;

# 我们也可以为表起别名等操作
# 规范的SQL语法格式: 
SELECT
	t1.`name`, -- name in emp
	t1.`gender`,  -- gender in emp
	t2.`name`
FROM
	emp AS t1, 
	dept t2 -- 同样可以使用AS或者空格(缺省)
WHERE
	t1.`dept_id` = t2.`id`;




# 显式内连接:
SELECT * FROM emp INNER JOIN dept ON emp.`dept_id` = dept.`id`;
SELECT * FROM emp JOIN dept ON emp.`dept_id` = dept.`id`; -- inner 可以省略


# 添加一条数据:
INSERT INTO emp (id, NAME, gender, salary, join_date, dept_id) VALUES(6, "白龙马", "男", 3000, NULL, NULL);
# 左外连接
-- 查询所有员工信息，如果员工有部门，则查询部门名称，没有部门，则不显示部门名称
SELECT 	t1.*,t2.`name` FROM emp t1 LEFT JOIN dept t2 ON t1.`dept_id` = t2.`id`;



# 下面开始介绍子查询部分 -> 也称为嵌套查询




# 子查询 -> 嵌套查询
-- 查询工资最高的员工信息
-- 1. 查询最高的工资是多少
SELECT MAX(salary) FROM emp; -- 9000

-- 2. 查询员工信息, 并且工资等于9000的
SELECT * FROM emp WHERE emp.`salary` = 9000;

-- 一条sql就完成: 子查询
SELECT * FROM emp WHERE emp.`salary` = (SELECT MAX(emp.`salary`) FROM emp);

# 同理查询工资最小的员工信息
SELECT * FROM emp WHERE emp.`salary` = (SELECT MIN(emp.`salary`) FROM emp);




# 子查询不同情况 
# 单行单列的情况 -> 可以用作where查询条件
-- 查询员工工资小于平均工资的人
SELECT AVG(emp.`salary`) FROM emp;
SELECT * FROM emp WHERE	 emp.`salary` <= 5383.333;
# 一条SQL查询 -> 子查询
SELECT * FROM emp WHERE emp.`salary` < (SELECT AVG(emp.`salary`) FROM emp);


# 多行单列的情况 -> 也可以用作where查询条件, 但是相当于一个集合, 所以我们运算符使用in
-- 查询'财务部'和'市场部'所有的员工信息
SELECT id FROM dept WHERE NAME = '财务部' OR '市场部';
SELECT * FROM emp WHERE dept_id = 3 OR dept_id = 2;
SELECT * FROM emp WHERE dept_id IN (2,3); -- 或者用in

-- 一条sql做到:
-- 使用的运算符是in, 
SELECT * FROM emp WHERE dept_id IN (SELECT id FROM dept WHERE NAME = '财务部' OR NAME = '市场部');



# 多行多列的情况 -> 作为虚拟表(或者认为是临时表), 可以作为查询源
DESC emp;
-- 查询员工入职日期是2011-11-11日之后的员工信息和部门信息


-- 子查询方式:
# 先查询日期大于2011-11-11的员工信息;
SELECT * FROM emp WHERE emp.`join_date` > '2011-11-11'; # date(日期类型)可以直接与 "字符串"进行比较
# 然后将查询出来的表, 一起查询
SELECT * FROM dept AS t1, (SELECT * FROM emp WHERE emp.`join_date` > '2011-11-11') t2
WHERE t1.`id` = t2.dept_id;



-- 也可以使用普通内连接进行查询
SELECT * FROM emp, dept
WHERE emp.`dept_id` = dept.`id` AND emp.`join_date` > '2011-11-11';



