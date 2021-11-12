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

SHOW TABLES;
DESC test;
SELECT * FROM test;

# 练习查询语句
SELECT NAME, age FROM test;

SELECT address FROM test;

-- 去除重复的结果集, 必须保证两条数据的结果集完全一样
SELECT DISTINCT address FROM test;
SELECT DISTINCT NAME, address FROM test; -- 查询名字和地址

-- 计算math和english分数之和
SELECT NAME, math, english FROM test; -- 查询名字,math和english
SELECT NAME, math, english, math+english FROM test; -- 计算列
-- 如果null参与的运算, 计算结果都为null
-- 这显然是不可理的. 所以在sql中有一个函数,来解决这个问题, 就是ifnull
-- ifnull(expr1, expr2) 这个函数的意思是, 如果expr1为null, 那么就会被expr2替换
-- 所以即: 如果expr1这个字段为null, 则替换为exp2
SELECT NAME, math, english, math + IFNULL(english, 0) FROM test;

-- 起别名 在计算列的后面加上 AS 别名. 这样新的计算列, 这样新的列就是名字就是别名
SELECT NAME, math, english, math+IFNULL(english, 0) AS 总分 FROM test;
-- 简化的书写形式, 用一个或者多个空格, 来代替AS
SELECT NAME, math 数学, english 英语, math+IFNULL(english, 0) 总分 FROM test;