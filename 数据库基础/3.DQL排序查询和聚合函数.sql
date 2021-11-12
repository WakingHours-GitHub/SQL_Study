SHOW DATABASES;

USE mydb1;

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

SHOW TABLES;

INSERT INTO test(id,NAME,age,sex,address,math,english) VALUES 
(1,'马云',55,'男','杭州',66,78),
(2,'马化腾',45,'女','深圳',98,87),
(3,'马景涛',55,'男','香港',56,77),
(4,'柳岩',20,'女','湖南',76,65),
(5,'柳青',20,'男','湖南',86,NULL),
(6,'刘德华',57,'男','香港',99,99),
(7,'马德',22,'女','香港',99,99),
(8,'德玛西亚',18,'男','南京',56,65);

SELECT * FROM test; -- 查询所有数据

# 排序: 按照数学成绩来排序查询
SELECT * FROM test ORDER BY math; -- 排序方式; 默认是升序排列ASC
# 按照降序的方式来排列数据
SELECT * FROM test ORDER BY math DESC; -- 按照降序的方式来排列

# 按照数学成绩排名, 如果数学成绩一样, 那么按照英语成绩排名
-- 这是多个字段的排序查询, 第二排序条件,只有在第一排序条件一样的时候, 才能进行比较
SELECT * FROM test ORDER BY math ASC, english ASC;

# 聚合函数, 将一列数据作为整体, 进行纵向计算
# 统计多少个人
SELECT COUNT(NAME) FROM test; # 8

SELECT COUNT(english) FROM test; # 7 -- null不作为参与运算的对象
# 解决方法: IFNULL(), 或者统计非空的列
SELECT COUNT(IFNULL(english, 0)) FROM test; -- 8

# 看math最大和最小
SELECT MAX(math) FROM test;

SELECT MIN(math) FROM test;

# 求和
SELECT SUM(math) FROM test;

SELECT SUM(english) FROM test; -- 排除了null计算

# 求平均值
SELECT AVG(math) FROM test; 

# 聚合函数的特点: 计算完成之后都是单行单列的


# 分组查询
# 注意, 既然是分组查询, 那么查询的内容必须是分组后的字段或者聚合函数
-- 按照性别分组. 分别查询男,女同学的平均分
SELECT sex, AVG(math) FROM test GROUP BY sex;

-- 按照性别统计人数
SELECT sex, COUNT(id) FROM test GROUP BY sex;

# 如果查询字段不是分组字段或者聚合函数
SELECT NAME, sex, COUNT(id) FROM test GROUP BY sex; -- name字段完全没有意义

-- 按照性别分组. 分别查询男, 女同学的math平均分, 人数, 要求: 分数低于70分的人, 不参与分组
SELECT sex, AVG(math), COUNT(id) FROM test WHERE math > 70 GROUP BY sex;

-- 按照性别分组. 分别查询男, 女同学的math平均分, 人数, 要求: 分数低于70分的人, 不参与分组. 查询分组之后人数大于2个人
-- 我们要学另外一个字句: having, 这也是一条限定语句
SELECT sex, AVG(math), COUNT(id) FROM test WHERE math > 70 GROUP BY sex HAVING COUNT(id)>2;

# 其别名操作, 在聚合函数起别名, 然后在having中判断, 可以直接用别名进行判断
SELECT sex, AVG(math), COUNT(id) AS 人数 FROM test WHERE math > 70 GROUP BY sex HAVING 人数 > 2;


# 分页查询
# 语法：limit 开始的索引,每页查询的条数;
-- 每页显示3条数据
SELECT * FROM test LIMIT 0,3; -- 第一页, 从索引0开始, 显示3条数据
SELECT * FROM test LIMIT 3,3; -- 第二页, 从索引3开始, 
SELECT * FROM test LIMIT 6,3;
-- 公式: 开始的索引 = (当前的页码 - 1) * 每页显示的条数












