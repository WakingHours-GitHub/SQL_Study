# 案例: 演示一下多表关系
# 一个旅游网站
# 利用数据库设计 -> 设计一个这样的数据库

/*
旅游线路分类, 旅游线路, 用户
分类 包含多个 线路, 所以是1:n的关系 -> 在线路创建外键, 指向分类
用户 可以有多个 线路, 线路 也可以被多个用户收藏, 所以是n:m的关系, 需要有中间表来完成

*/

# 具体操作:
-- 创建旅游分类表:tab_category
-- cid是旅游分类表的主键, 自动增长
-- cname为分类名字, 非空,唯一
CREATE TABLE IF NOT EXISTS tab_category(
	cid INT PRIMARY KEY AUTO_INCREMENT,
	cname VARCHAR(20) NOT NULL UNIQUE
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
	 -- 添加外键, 这是一种省略形式, 系统会自动的生成唯一的外键名称
	 -- 标准形式:
	 -- constraint 外键名称 foreign key (cid) references tab_category(cid);
);

-- 用户表
/*
	创建用户表 tab_user
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
	 uid INT PRIMARY KEY AUTO_INCREMENT, -- 用户id, 主键, 自动增长
	 username VARCHAR(100) UNIQUE NOT NULL, -- 用户名, 非空, 唯一
	 PASSWORD VARCHAR(30) NOT NULL, -- 密码 非空
	 NAME VARCHAR(100), -- 真实名字, 
	 birthday DATE,
	 sex CHAR(1) DEFAULT '男', -- 性别, 默认是为'男'
	 telephone VARCHAR(11),
	 email VARCHAR(100)
);


-- 中间表, 
CREATE TABLE tab_favorite (
	 rid INT, -- 线路id
	 DATE DATETIME,
	 uid INT, -- 用户id
	 -- 创建复合主键
	 PRIMARY KEY(rid,uid), -- 联合主键, 这两个外键,作为该表的主键
	 -- 即:这两个元素组成的元组, 是不能重复的
	 
	 -- 创建外键, 分别关联到线路表的主键, 和用户表的主键
	 FOREIGN KEY (rid) REFERENCES tab_route(rid),
	 FOREIGN KEY(uid) REFERENCES tab_user(uid)
	 -- 这里仍然使用的省略形式
);


# 创建完表之后, 我们用架构设计器将这些表的关系展示出来

























