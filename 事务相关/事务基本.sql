CREATE DATABASE IF NOT EXISTS mydb3;
USE mydb3;
CREATE TABLE account(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(10),
	balance DOUBLE
);
INSERT INTO account (NAME, balance) VALUES('zhangsan', 1000), ('lisi', 1000);
SELECT * FROM account;

UPDATE account SET balance = 1000; -- 都还原回1000

-- 张三给李四转账500元

-- 1. 张三账户-500
UPDATE account SET balance = balance - 500 WHERE NAME = 'zhangsan';

出错了 -- 报错地点. 此时还没有用事务管理.
-- 2. 李四账户+500
UPDATE account SET balance = balance + 500 WHERE NAME = "lisi";

# 于是我们使用事务进行管理:
# 0. 开启事务:
START TRANSACTION; -- 开启事务, 然后进行接下来的操作.
# 事务就像是修改了数据,但是没有保存, 一旦提交(commit)事务就相当于保存了

-- 1. 张三账户-500
UPDATE account SET balance = balance - 500 WHERE NAME = 'zhangsan';

出错了 -- 报错地点. 此时还没有用事务管理.
-- 2. 李四账户+500
UPDATE account SET balance = balance + 500 WHERE NAME = "lisi";


-- 执行没有问题, 提交事务 -> 相当于保存操作
COMMIT -- 持久的更新

-- 发现错误了, 回滚事务, 从哪开启事务, 就回滚到哪
ROLLBACK

SELECT @@autocommit; -- 1代表自动提交, 0代表手动提交
# 修改默认提交方式
SET @@autocommit = 0; -- 此时默认提交为手动提交, 此时执行DML后, 不commit则会自动回滚





