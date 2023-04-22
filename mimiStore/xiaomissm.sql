/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 80031
Source Host           : localhost:3306
Source Database       : xiaomissm

Target Server Type    : MYSQL
Target Server Version : 80031
File Encoding         : 65001

Date: 2023-04-21 15:34:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `addressId` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `cnee` varchar(50) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`addressId`),
  KEY `FK_Reference_1` (`uid`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`uid`) REFERENCES `yonghu` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('1', '1', 'zar', '15266676667', '北京海淀甲骨文');
INSERT INTO `address` VALUES ('2', '2', 'oracle', '15266678888', '北京朝阳科技文化一条街');
INSERT INTO `address` VALUES ('3', '2', '张三', '15290888162', '北京大兴西红门');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `a_id` int NOT NULL AUTO_INCREMENT,
  `a_name` varchar(20) DEFAULT NULL,
  `a_pass` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '670b14728ad9902aecba32e22fa4f6bd');
INSERT INTO `admin` VALUES ('15', 'cc', '670b14728ad9902aecba32e22fa4f6bd');
INSERT INTO `admin` VALUES ('16', 'cc', '670b14728ad9902aecba32e22fa4f6bd');
INSERT INTO `admin` VALUES ('17', 'dd', '670b14728ad9902aecba32e22fa4f6bd');
INSERT INTO `admin` VALUES ('18', 'dd', '670b14728ad9902aecba32e22fa4f6bd');

-- ----------------------------
-- Table structure for carshop
-- ----------------------------
DROP TABLE IF EXISTS `carshop`;
CREATE TABLE `carshop` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `pid` int DEFAULT NULL,
  `numbers` int DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `FK_Reference_3` (`uid`),
  KEY `FK_Reference_4` (`pid`),
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`uid`) REFERENCES `yonghu` (`uid`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`pid`) REFERENCES `product_info` (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of carshop
-- ----------------------------
INSERT INTO `carshop` VALUES ('1', '1', '1', '2');

-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail` (
  `odid` int NOT NULL AUTO_INCREMENT,
  `oid` char(32) DEFAULT NULL,
  `pid` int DEFAULT NULL,
  `pnumber` int DEFAULT NULL,
  `ptotal` double(10,2) DEFAULT NULL,
  PRIMARY KEY (`odid`),
  KEY `FK_Reference_7` (`oid`),
  KEY `FK_Reference_8` (`pid`),
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`pid`) REFERENCES `product_info` (`p_id`),
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`oid`) REFERENCES `xmorder` (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES ('1', 'abcd111222333444777888999000wwww', '1', '2', '9996.00');
INSERT INTO `orderdetail` VALUES ('2', 'assdfdsfsasafsf', '2', '3', '1000.00');

-- ----------------------------
-- Table structure for product_info
-- ----------------------------
DROP TABLE IF EXISTS `product_info`;
CREATE TABLE `product_info` (
  `p_id` int NOT NULL AUTO_INCREMENT,
  `p_name` varchar(20) DEFAULT NULL,
  `p_content` varchar(200) DEFAULT NULL,
  `p_price` int DEFAULT NULL,
  `p_image` varchar(200) DEFAULT NULL,
  `p_number` int DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  `p_date` date DEFAULT NULL,
  PRIMARY KEY (`p_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `product_info_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `product_type` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of product_info
-- ----------------------------
INSERT INTO `product_info` VALUES ('1', '小米Note2', '双曲面 黑色 6GB内存 64GB闪存', '2899', 'xmNote2.jpg', '500', '1', '2018-01-04');
INSERT INTO `product_info` VALUES ('2', '红米Note5A', '5.5英寸 粉色 2GB内存 16GB闪存', '680', 'hmNote5A.jpg', '500', '1', null);
INSERT INTO `product_info` VALUES ('3', '红米Note4X', '5.5英寸 绿色 4GB内存 64GB闪存', '1299', 'hmNote4X.jpg', '500', '1', '2018-01-06');
INSERT INTO `product_info` VALUES ('5', '红米4X', '5英寸 黑色 3GB内存 32GB闪存', '899', 'hm4X.jpg', '500', '1', '2018-01-08');
INSERT INTO `product_info` VALUES ('6', '小米平板3', '7.9英寸 金色 4GB内存 64GB闪存', '1499', 'xmPad3.jpg', '500', '2', '2018-01-09');
INSERT INTO `product_info` VALUES ('7', '小米Air12', '12.5英寸 银色 4GB内存 128GB闪存', '3599', 'xmAir12.jpg', '500', '2', '2018-01-18');
INSERT INTO `product_info` VALUES ('8', '小米Air13', '13.3英寸 银色 8GB内存 256GB闪存', '4999', 'xmAir13.jpg', '500', '2', '2018-01-17');
INSERT INTO `product_info` VALUES ('10', '小米电视4', '49英寸 原装LG屏 3840×2160 真4K', '3299', 'xmTV4-49.jpg', '500', '3', '2018-01-15');
INSERT INTO `product_info` VALUES ('11', '小米电视4', '55英寸 原装三星屏 3840×2160 真4K', '3999', 'xmTV4-55.jpg', '500', '3', '2018-01-13');
INSERT INTO `product_info` VALUES ('15', '小米MIX2', '全陶瓷 黑色 8GB内存 128GB闪存', '4699', 'xmMIX2.jpg', '500', '1', '2018-04-01');
INSERT INTO `product_info` VALUES ('16', '小米Note3', '全网通 蓝色 6GB内存 64GB闪存', '2499', 'xmNote3.jpg', '500', '1', '2018-03-01');
INSERT INTO `product_info` VALUES ('17', '小米6', '玻璃金属 白色 6GB内存 128GB闪存', '2899', 'xm6.jpg', '500', '1', '2018-02-01');
INSERT INTO `product_info` VALUES ('18', '小米MAX2', '全金属 金色 4GB内存 64GB闪存', '1599', 'xmMAX2.jpg', '500', '1', '2018-01-02');
INSERT INTO `product_info` VALUES ('19', '小米5X', '全金属 金色 4GB内存 64GB闪存', '1499', 'xm5X.jpg', '5000', '1', null);

-- ----------------------------
-- Table structure for product_type
-- ----------------------------
DROP TABLE IF EXISTS `product_type`;
CREATE TABLE `product_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of product_type
-- ----------------------------
INSERT INTO `product_type` VALUES ('1', '手机');
INSERT INTO `product_type` VALUES ('2', '电脑');
INSERT INTO `product_type` VALUES ('3', '电视');

-- ----------------------------
-- Table structure for xmorder
-- ----------------------------
DROP TABLE IF EXISTS `xmorder`;
CREATE TABLE `xmorder` (
  `oid` char(32) NOT NULL,
  `uid` int DEFAULT NULL,
  `addressId` int DEFAULT NULL,
  `totalprice` double(10,2) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `status` varchar(6) DEFAULT NULL,
  `odate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`oid`),
  KEY `FK_Reference_5` (`uid`),
  KEY `FK_Reference_6` (`addressId`),
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`uid`) REFERENCES `yonghu` (`uid`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`addressId`) REFERENCES `address` (`addressId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of xmorder
-- ----------------------------
INSERT INTO `xmorder` VALUES ('098765432', '2', '3', '3124.00', null, '0', '2023-04-20 10:02:04');
INSERT INTO `xmorder` VALUES ('123456789', '4', '2', '5435.00', null, '0', '2023-04-20 10:02:26');
INSERT INTO `xmorder` VALUES ('132143123', '4', '1', '12331.00', null, '1', '2023-04-20 10:01:36');
INSERT INTO `xmorder` VALUES ('214325463767653', '7', '1', '1245.00', null, '0', '2023-04-20 10:02:39');
INSERT INTO `xmorder` VALUES ('3123214322', '4', '3', '23432.00', '尽快送到', '0', '2023-04-20 10:01:17');
INSERT INTO `xmorder` VALUES ('544123', '6', '1', '3123.00', null, '1', '2023-04-20 10:01:49');
INSERT INTO `xmorder` VALUES ('abcd111222333444777888999000wwww', '1', '1', '9996.00', '尽快送到', '0', '2023-04-20 17:12:44');
INSERT INTO `xmorder` VALUES ('assdfdsfsasafsf', '2', '2', '3424.00', '尽快送到', '1', '2023-04-20 10:00:36');

-- ----------------------------
-- Table structure for yonghu
-- ----------------------------
DROP TABLE IF EXISTS `yonghu`;
CREATE TABLE `yonghu` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `uname` varchar(50) DEFAULT NULL,
  `upass` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `ustatus` int DEFAULT NULL,
  `ulevel` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of yonghu
-- ----------------------------
INSERT INTO `yonghu` VALUES ('1', 'zar', '123456', '0', '1', '5');
INSERT INTO `yonghu` VALUES ('2', 'zhangsan', '123456', '1', '1', '2');
INSERT INTO `yonghu` VALUES ('3', 'mark', '111111', '1', '1', '2');
INSERT INTO `yonghu` VALUES ('4', 'jack', '11111', '1', '1', '1');
INSERT INTO `yonghu` VALUES ('5', 'lisa', '11111', '0', '2', '0');
INSERT INTO `yonghu` VALUES ('6', 'lisi', '11111', '0', '3', '5');
INSERT INTO `yonghu` VALUES ('7', 'zd', '11111', '1', '2', '5');
INSERT INTO `yonghu` VALUES ('8', '1', '1111', '0', '1', '14');
INSERT INTO `yonghu` VALUES ('10', 'qwe', '11111', '1', '4', '8');
INSERT INTO `yonghu` VALUES ('11', 'qe', '1111', '0', '2', '23');
