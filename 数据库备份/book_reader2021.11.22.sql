/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.5.40 : Database - book_reader
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`book_reader` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `book_reader`;

/*Table structure for table `books` */

DROP TABLE IF EXISTS `books`;

CREATE TABLE `books` (
  `book_num` char(10) NOT NULL,
  `TYPE` char(12) DEFAULT NULL,
  `publisher` char(30) DEFAULT NULL,
  `author` char(20) DEFAULT NULL,
  `book_name` char(50) DEFAULT NULL,
  `price` decimal(9,2) DEFAULT NULL,
  UNIQUE KEY `book_num` (`book_num`),
  UNIQUE KEY `book_num_2` (`book_num`),
  UNIQUE KEY `book_num_3` (`book_num`),
  UNIQUE KEY `book_num_4` (`book_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `books` */

insert  into `books`(`book_num`,`TYPE`,`publisher`,`author`,`book_name`,`price`) values ('1001','计算机','电子工业出版社','李明','计算机导论','18.00'),('1002','计算机','高等教育出版社','王晓红','数据结构','22.00'),('1003','计算机','电子工业出版社','李和名','C语言','25.50'),('1004','计算机','机械工业出版社','刘洪亮','操作系统','49.80'),('1005','计算机','机械工业出版社','王晓红','计算机文化','20.00'),('1006','计算机','清华大学出版社','刘洪亮','数据结构','21.60'),('2007','数学','电子工业出版社','吴非','高等数学','18.00'),('2008','数学','电子工业出版社','丁羽','概率统计','22.30'),('2009','数学','机械工业出版社','赵明','线性代数','15.00'),('3010','物理','机械工业出版社','张可','力学','19.80');

/*Table structure for table `borrow_list` */

DROP TABLE IF EXISTS `borrow_list`;

CREATE TABLE `borrow_list` (
  `book_id` char(10) DEFAULT NULL,
  `reader_id` char(10) DEFAULT NULL,
  `Borrow_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `borrow_list` */

insert  into `borrow_list`(`book_id`,`reader_id`,`Borrow_date`) values ('1001','10001','2009-11-05 00:00:00'),('1002','10002','2008-12-20 00:00:00'),('1003','10003','2009-06-05 00:00:00'),('1004','10004','2010-11-25 00:00:00'),('1006','10001','2010-11-25 00:00:00'),('1005','10001','2010-11-25 00:00:00'),('2007','10001','2010-11-25 00:00:00'),('2008','10003','2010-11-25 00:00:00'),('2009','10004','2010-11-25 00:00:00'),('3010','10001','2010-11-25 00:00:00');

/*Table structure for table `readers` */

DROP TABLE IF EXISTS `readers`;

CREATE TABLE `readers` (
  `reader_id` char(8) NOT NULL,
  `reader_name` char(8) DEFAULT NULL,
  `company` char(30) DEFAULT NULL,
  `gender` char(2) DEFAULT NULL,
  `phone_number` char(11) DEFAULT NULL,
  UNIQUE KEY `reader_id` (`reader_id`),
  UNIQUE KEY `reader_id_2` (`reader_id`),
  UNIQUE KEY `reader_id_3` (`reader_id`),
  UNIQUE KEY `reader_id_4` (`reader_id`),
  UNIQUE KEY `reader_id_5` (`reader_id`),
  UNIQUE KEY `reader_id_6` (`reader_id`),
  UNIQUE KEY `reader_id_7` (`reader_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `readers` */

insert  into `readers`(`reader_id`,`reader_name`,`company`,`gender`,`phone_number`) values ('10001','李晓明','计算机系','男','13826388323'),('10002','王宏','计算机系','男','18263883785'),('10003','李和平','计算机系','女','13826387623'),('10004','刘亮','计算机系','男','13826385523'),('10005','刘晓亮','计算机系','男','13626356323'),('10006','吴小','数学系','女','13826366323'),('10007','丁宇','数学系','男','13826356333'),('10008','赵牧','数学系','男','13826898323'),('10009','王晓华','数学系','女','13826348546'),('10010','张弓','计算机系','男','13826384213');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
