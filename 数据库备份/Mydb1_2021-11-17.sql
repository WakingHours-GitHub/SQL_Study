/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.5.40 : Database - mydb1
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mydb1` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `mydb1`;

/*Table structure for table `department` */

DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dep_name` varchar(20) DEFAULT NULL,
  `dep_location` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `department` */

insert  into `department`(`id`,`dep_name`,`dep_location`) values (1,'研发部','广州'),(2,'销售部','深圳');

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(20) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `dep_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `emp_dept_fk` (`dep_id`),
  CONSTRAINT `emp_dept_fk` FOREIGN KEY (`dep_id`) REFERENCES `department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `employee` */

insert  into `employee`(`id`,`NAME`,`age`,`dep_id`) values (1,'张三',20,1),(2,'李四',21,1),(3,'王五',20,1),(4,'老王',20,2),(5,'大王',22,2),(6,'小王',18,2);

/*Table structure for table `stu` */

DROP TABLE IF EXISTS `stu`;

CREATE TABLE `stu` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `stu` */

insert  into `stu`(`id`,`name`) values (1,'ccc'),(2,'ccc'),(3,'ccc'),(4,'ccc'),(5,'ccc'),(10,'ddd'),(11,'eee');

/*Table structure for table `tab_category` */

DROP TABLE IF EXISTS `tab_category`;

CREATE TABLE `tab_category` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(20) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `cname` (`cname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tab_category` */

/*Table structure for table `tab_favorite` */

DROP TABLE IF EXISTS `tab_favorite`;

CREATE TABLE `tab_favorite` (
  `rid` int(11) NOT NULL DEFAULT '0',
  `date` datetime DEFAULT NULL,
  `uid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rid`,`uid`),
  KEY `uid` (`uid`),
  CONSTRAINT `tab_favorite_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `tab_route` (`rid`),
  CONSTRAINT `tab_favorite_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `tab_user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tab_favorite` */

/*Table structure for table `tab_route` */

DROP TABLE IF EXISTS `tab_route`;

CREATE TABLE `tab_route` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `rname` varchar(100) NOT NULL,
  `price` double DEFAULT NULL,
  `rdate` date DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  PRIMARY KEY (`rid`),
  UNIQUE KEY `rname` (`rname`),
  KEY `cid` (`cid`),
  CONSTRAINT `tab_route_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `tab_category` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tab_route` */

/*Table structure for table `tab_user` */

DROP TABLE IF EXISTS `tab_user`;

CREATE TABLE `tab_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(30) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `sex` char(1) DEFAULT '男',
  `telephone` varchar(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tab_user` */

/*Table structure for table `test` */

DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `id` int(11) DEFAULT NULL,
  `NAME` varchar(20) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `sex` varchar(5) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `math` int(11) DEFAULT NULL,
  `english` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `test` */

insert  into `test`(`id`,`NAME`,`age`,`sex`,`address`,`math`,`english`) values (1,'马云',55,'男','杭州',66,78),(2,'马化腾',45,'女','深圳',98,87),(3,'马景涛',55,'男','香港',56,77),(4,'柳岩',20,'女','湖南',76,65),(5,'柳青',20,'男','湖南',86,NULL),(6,'刘德华',57,'男','香港',99,99),(7,'马德',22,'女','香港',99,99),(8,'德玛西亚',18,'男','南京',56,65);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
