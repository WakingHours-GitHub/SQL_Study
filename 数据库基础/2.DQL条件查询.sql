DROP TABLE IF EXISTS test;
# 创建列表
CREATE TABLE test (
 id INT, -- 编号
 NAME VARCHAR(20), -- 姓名
 age INT, -- 年龄
 sex VARCHAR(5), -- 性别
 address VARCHAR(100), -- 地址
 math INT, -- 数学
 english INT -- 英语
);

# 添加数据, 可以一次添加多行数据, 中间用, 分割
INSERT INTO test(id,NAME,age,sex,address,math,english) VALUES 
(1,'马云',55,'男','杭州',66,78),
(2,'马化腾',45,'女','深圳',98,87),
(3,'马景涛',55,'男','香港',56,77),
(4,'柳岩',20,'女','湖南',76,65),
(5,'柳青',20,'男','湖南',86,NULL),
(6,'刘德华',57,'男','香港',99,99),
(7,'马德',22,'女','香港',99,99),
(8,'德玛西亚',18,'男','南京',56,65);


SELECT * FROM test;

# SQL中DQL的条件查询
-- 查询年龄大于20岁
SELECT * FROM test WHERE age > 20;
-- 查询年龄大于等于20岁的
SELECT * FROM test WHERE age >= 20;
-- 查询年龄等于20岁. 注意在sql中, =只需要用一个=即可.
SELECT * FROM test WHERE age = 20;
-- 查询年龄不等于20岁, != 和 <> 
SELECT * FROM test WHERE age != 20;
SELECT * FROM test WHERE age <> 20;

-- 查询年龄大于等于20小玉等于32
SELECT * FROM test WHERE age >= 20 && age <= 30; -- 但是这样并不推荐
SELECT * FROM test WHERE age >= 20 AND age <= 30; -- 与 用关键字: AND
SELECT * FROM test WHERE age BETWEEN 20 AND 30; -- SQL给我们准备的简单写法

-- 查询年龄22岁, 18岁, 25岁的信息
SELECT * FROM test WHERE age = 22 OR age = 18 OR age = 25;
SELECT * FROM test WHERE age IN (22, 18, 25); -- sql给我们准备的, 只要是在in里面有的, 就查询出来

-- 查询英语成绩为null
 SELECT * FROM test WHERE english = NULL; -- 此条语句不对. null不能使用 =  != 来去判断
 -- 应该是用IS进行判断
 SELECT * FROM test WHERE english IS NULL;
 -- 查询英语成绩不为null
 SELECT * FROM test WHERE english IS NOT NULL;
 
# like: 模糊查询
# _单个字符
# %多个字符(可以为0个, 可以为多个)
-- 查询姓是 马 的
SELECT * FROM test WHERE NAME LIKE "马%";
-- 查询姓名第二个字是化的人
SELECT * FROM test WHERE NAME LIKE '_化%';
-- 查询名字是三个字的人
SELECT * FROM test WHERE NAME LIKE '___';
-- 查询姓名中包含 马 的人, 有马就行, 前面后面有多少个字不用管
SELECT * FROM test WHERE NAME LIKE "%马%";
-- 查询姓名中包含 德 的人
SELECT NAME FROM test WHERE NAME LIKE "%德%";





