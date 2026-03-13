-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: localhost    Database: cl941024116
-- ------------------------------------------------------
-- Server version	5.7.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `cl941024116`
--

/*!40000 DROP DATABASE IF EXISTS `cl941024116`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cl941024116` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `cl941024116`;

--
-- Table structure for table `aboutus`
--

DROP TABLE IF EXISTS `aboutus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aboutus` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `subtitle` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '副标题',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `picture1` longtext COLLATE utf8mb4_unicode_ci COMMENT '图片1',
  `picture2` longtext COLLATE utf8mb4_unicode_ci COMMENT '图片2',
  `picture3` longtext COLLATE utf8mb4_unicode_ci COMMENT '图片3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='发展历程';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aboutus`
--

LOCK TABLES `aboutus` WRITE;
/*!40000 ALTER TABLE `aboutus` DISABLE KEYS */;
INSERT INTO `aboutus` VALUES (1,'2025-04-15 15:30:57','发展历程','DEVELOPMENT HISTORY','山川如画，水光潋滟。在这美丽的自然世界里，我们不禁沉醉于那迷人的风景。春天，花儿盛开，绿树成荫，仿佛置身于童话之中\n；夏天，阳光明媚，海风拂面，让人心旷神怡；秋天，枫叶满山，金色的稻田波光粼粼，令人流连忘返。','file/aboutusPicture1.jpg','file/aboutusPicture2.jpg','file/aboutusPicture3.jpg');
/*!40000 ALTER TABLE `aboutus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `address` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址',
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人',
  `phone` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `isdefault` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '否' COMMENT '是否默认地址',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='地址';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'2025-04-15 15:30:58','地址1','李一','19819881111','是',11),(2,'2025-04-15 15:30:58','地址2','王二','19819882222','是',12),(3,'2025-04-15 15:30:58','地址3','张三','19819883333','是',13),(4,'2025-04-15 15:30:58','地址4','刘四','19819884444','是',14),(5,'2025-04-15 15:30:58','地址5','陈五','19819885555','是',15),(6,'2025-04-15 15:30:58','地址6','杨六','19819886666','是',16),(7,'2025-04-15 15:30:58','地址7','赵七','19819887777','是',17),(8,'2025-04-15 15:30:58','地址8','黄八','19819888888','是',18),(9,'2025-04-15 15:30:58','地址9','周九','19819889999','是',19),(10,'2025-04-15 15:30:58','地址10','吴十','19819880000','是',20),(11,'2025-04-15 15:38:08','傻大个大撒大法师发广告','123','13512345123','是',1744731457193),(12,'2025-04-15 15:42:45','打撒噶事多','老人1','13512345123','是',71);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caipinxinxi`
--

DROP TABLE IF EXISTS `caipinxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caipinxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `caipinmingcheng` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜品名称',
  `caipintupian` longtext COLLATE utf8mb4_unicode_ci COMMENT '菜品图片',
  `yingyangchengfen` longtext COLLATE utf8mb4_unicode_ci COMMENT '营养成分',
  `zhizuofangfa` longtext COLLATE utf8mb4_unicode_ci COMMENT '制作方法',
  `kouwei` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '口味',
  `caipinxiangqing` longtext COLLATE utf8mb4_unicode_ci COMMENT '菜品详情',
  `onelimittimes` int(11) DEFAULT '-1' COMMENT '单限',
  `alllimittimes` int(11) DEFAULT '-1' COMMENT '库存',
  `price` double DEFAULT '0' COMMENT '价格',
  `storeup_number` int(11) DEFAULT '0' COMMENT '收藏数',
  `clicktime` datetime DEFAULT NULL COMMENT '最近点击时间',
  `discuss_number` int(11) DEFAULT '0' COMMENT '评论数',
  `gonghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工号',
  PRIMARY KEY (`id`),
  KEY `caipinxinxi_price` (`id`,`price`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜品信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caipinxinxi`
--

LOCK TABLES `caipinxinxi` WRITE;
/*!40000 ALTER TABLE `caipinxinxi` DISABLE KEYS */;
INSERT INTO `caipinxinxi` VALUES (1,'2025-04-15 15:30:58','菜品名称1','file/caipinxinxiCaipintupian1.jpg,file/caipinxinxiCaipintupian2.jpg,file/caipinxinxiCaipintupian3.jpg','营养成分1','制作方法1','口味1','菜品详情1',1,97,99.9,1,'2025-04-15 23:30:58',1,'工号1'),(2,'2025-04-15 15:30:58','菜品名称2','file/caipinxinxiCaipintupian2.jpg,file/caipinxinxiCaipintupian3.jpg,file/caipinxinxiCaipintupian4.jpg','营养成分2','制作方法2','口味2','菜品详情2',2,97,99.9,2,'2025-04-15 23:30:58',2,'工号2'),(3,'2025-04-15 15:30:58','菜品名称3','file/caipinxinxiCaipintupian3.jpg,file/caipinxinxiCaipintupian4.jpg,file/caipinxinxiCaipintupian5.jpg','营养成分3','制作方法3','口味3','菜品详情3',3,99,99.9,3,'2025-04-15 23:30:58',3,'工号3'),(4,'2025-04-15 15:30:58','菜品名称4','file/caipinxinxiCaipintupian4.jpg,file/caipinxinxiCaipintupian5.jpg,file/caipinxinxiCaipintupian6.jpg','营养成分4','制作方法4','口味4','菜品详情4',4,99,99.9,4,'2025-04-15 23:30:58',4,'工号4'),(5,'2025-04-15 15:30:58','菜品名称5','file/caipinxinxiCaipintupian5.jpg,file/caipinxinxiCaipintupian6.jpg,file/caipinxinxiCaipintupian7.jpg','营养成分5','制作方法5','口味5','菜品详情5',5,99,99.9,5,'2025-04-15 23:30:58',5,'工号5'),(6,'2025-04-15 15:30:58','菜品名称6','file/caipinxinxiCaipintupian6.jpg,file/caipinxinxiCaipintupian7.jpg,file/caipinxinxiCaipintupian8.jpg','营养成分6','制作方法6','口味6','菜品详情6',6,99,99.9,6,'2025-04-15 23:30:58',6,'工号6'),(7,'2025-04-15 15:30:58','菜品名称7','file/caipinxinxiCaipintupian7.jpg,file/caipinxinxiCaipintupian8.jpg,file/caipinxinxiCaipintupian9.jpg','营养成分7','制作方法7','口味7','菜品详情7',7,99,99.9,7,'2025-04-15 23:30:58',7,'工号7'),(8,'2025-04-15 15:30:58','菜品名称8','file/caipinxinxiCaipintupian8.jpg,file/caipinxinxiCaipintupian9.jpg,file/caipinxinxiCaipintupian10.jpg','营养成分8','制作方法8','口味8','菜品详情8',8,99,99.9,8,'2025-04-15 23:30:58',8,'工号8'),(9,'2025-04-15 15:30:58','菜品名称9','file/caipinxinxiCaipintupian9.jpg,file/caipinxinxiCaipintupian10.jpg,file/caipinxinxiCaipintupian11.jpg','营养成分9','制作方法9','口味9','菜品详情9',9,99,99.9,9,'2025-04-15 23:30:58',9,'工号9'),(10,'2025-04-15 15:30:58','菜品名称10','file/caipinxinxiCaipintupian10.jpg,file/caipinxinxiCaipintupian11.jpg,file/caipinxinxiCaipintupian12.jpg','营养成分10','制作方法10','口味10','菜品详情10',10,99,99.9,10,'2025-04-15 23:30:58',10,'工号10'),(11,'2025-04-15 15:38:55','凉豆腐','file/1744731521022.jpg','打撒噶事多','打撒噶事多打撒噶事多','咸','<p>打撒噶事多打撒噶事多打撒噶事多打撒噶事多打撒噶事多打撒噶事多打撒噶事多打撒噶事多打撒噶事多打撒噶事多</p>',15,49,100,2,NULL,1,'12');
/*!40000 ALTER TABLE `caipinxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `tablename` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT 'caipinxinxi' COMMENT '商品表名',
  `goodid` bigint(20) NOT NULL COMMENT '商品id',
  `goodname` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `picture` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `buynumber` int(11) DEFAULT NULL COMMENT '购买数量',
  `price` double DEFAULT NULL COMMENT '单价',
  `discountprice` double DEFAULT NULL COMMENT '折扣价',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `goodid` (`goodid`,`price`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`goodid`, `price`) REFERENCES `caipinxinxi` (`id`, `price`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购物车';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chushi`
--

DROP TABLE IF EXISTS `chushi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chushi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gonghao` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工号',
  `mima` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `chushixingming` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '厨师姓名',
  `xingbie` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `touxiang` longtext COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `nianling` int(11) DEFAULT NULL COMMENT '年龄',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gonghao` (`gonghao`)
) ENGINE=InnoDB AUTO_INCREMENT=1744731468902 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='厨师';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chushi`
--

LOCK TABLES `chushi` WRITE;
/*!40000 ALTER TABLE `chushi` DISABLE KEYS */;
INSERT INTO `chushi` VALUES (121,'2025-04-15 15:30:58','工号1','123456','厨师姓名1','男','file/chushiTouxiang1.jpg',1),(122,'2025-04-15 15:30:58','工号2','123456','厨师姓名2','男','file/chushiTouxiang2.jpg',2),(123,'2025-04-15 15:30:58','工号3','123456','厨师姓名3','男','file/chushiTouxiang3.jpg',3),(124,'2025-04-15 15:30:58','工号4','123456','厨师姓名4','男','file/chushiTouxiang4.jpg',4),(125,'2025-04-15 15:30:58','工号5','123456','厨师姓名5','男','file/chushiTouxiang5.jpg',5),(126,'2025-04-15 15:30:58','工号6','123456','厨师姓名6','男','file/chushiTouxiang6.jpg',6),(127,'2025-04-15 15:30:58','工号7','123456','厨师姓名7','男','file/chushiTouxiang7.jpg',7),(128,'2025-04-15 15:30:58','工号8','123456','厨师姓名8','男','file/chushiTouxiang8.jpg',8),(129,'2025-04-15 15:30:58','工号9','123456','厨师姓名9','男','file/chushiTouxiang9.jpg',9),(130,'2025-04-15 15:30:58','工号10','123456','厨师姓名10','男','file/chushiTouxiang10.jpg',10),(1744731468901,'2025-04-15 15:37:48','12','12','王强','男','file/1744731467356.jpeg',35);
/*!40000 ALTER TABLE `chushi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `value` longtext COLLATE utf8mb4_unicode_ci COMMENT '值',
  `url` longtext COLLATE utf8mb4_unicode_ci COMMENT '链接',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='轮播图';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'2025-04-15 15:30:58','swiper1','file/swiperPicture1.jpg',NULL),(2,'2025-04-15 15:30:58','swiper2','file/swiperPicture2.jpg',NULL),(3,'2025-04-15 15:30:58','swiper3','file/swiperPicture3.jpg',NULL);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discusscaipinxinxi`
--

DROP TABLE IF EXISTS `discusscaipinxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discusscaipinxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint(20) NOT NULL COMMENT '关联表id',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `avatarurl` longtext COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `nickname` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `score` double DEFAULT NULL COMMENT '评分',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `reply` longtext COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜品信息评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discusscaipinxinxi`
--

LOCK TABLES `discusscaipinxinxi` WRITE;
/*!40000 ALTER TABLE `discusscaipinxinxi` DISABLE KEYS */;
INSERT INTO `discusscaipinxinxi` VALUES (1,'2025-04-15 15:41:02',11,1744731457193,'file/1744731452087.png','123',5,'<p>大师傅撒大师傅撒</p>',NULL);
/*!40000 ALTER TABLE `discusscaipinxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fankuiyujianyi`
--

DROP TABLE IF EXISTS `fankuiyujianyi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fankuiyujianyi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fankuibiaoti` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '反馈标题',
  `fankuileixing` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '反馈类型',
  `fankuineirong` longtext COLLATE utf8mb4_unicode_ci COMMENT '反馈内容',
  `laorenzhanghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '老人账号',
  `laorenxingming` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '老人姓名',
  `fankuishijian` datetime DEFAULT NULL COMMENT '反馈时间',
  `shhf` longtext COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='反馈与建议';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fankuiyujianyi`
--

LOCK TABLES `fankuiyujianyi` WRITE;
/*!40000 ALTER TABLE `fankuiyujianyi` DISABLE KEYS */;
INSERT INTO `fankuiyujianyi` VALUES (1,'2025-04-15 15:30:58','反馈标题1','反馈','反馈内容1','老人账号1','老人姓名1','2025-04-15 23:30:58',''),(2,'2025-04-15 15:30:58','反馈标题2','反馈','反馈内容2','老人账号2','老人姓名2','2025-04-15 23:30:58',''),(3,'2025-04-15 15:30:58','反馈标题3','反馈','反馈内容3','老人账号3','老人姓名3','2025-04-15 23:30:58',''),(4,'2025-04-15 15:30:58','反馈标题4','反馈','反馈内容4','老人账号4','老人姓名4','2025-04-15 23:30:58',''),(5,'2025-04-15 15:30:58','反馈标题5','反馈','反馈内容5','老人账号5','老人姓名5','2025-04-15 23:30:58',''),(6,'2025-04-15 15:30:58','反馈标题6','反馈','反馈内容6','老人账号6','老人姓名6','2025-04-15 23:30:58',''),(7,'2025-04-15 15:30:58','反馈标题7','反馈','反馈内容7','老人账号7','老人姓名7','2025-04-15 23:30:58',''),(8,'2025-04-15 15:30:58','反馈标题8','反馈','反馈内容8','老人账号8','老人姓名8','2025-04-15 23:30:58',''),(9,'2025-04-15 15:30:58','反馈标题9','反馈','反馈内容9','老人账号9','老人姓名9','2025-04-15 23:30:58',''),(10,'2025-04-15 15:30:58','反馈标题10','反馈','反馈内容10','老人账号10','老人姓名10','2025-04-15 23:30:58',''),(11,'2025-04-15 15:41:41','的撒发撒','反馈','的撒发撒发生的','123','王刚','2025-04-15 23:41:33','已处理');
/*!40000 ALTER TABLE `fankuiyujianyi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jiankangjiance`
--

DROP TABLE IF EXISTS `jiankangjiance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jiankangjiance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `laorenzhanghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '老人账号',
  `laorenxingming` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '老人姓名',
  `touxiang` longtext COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `xueya` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '血压',
  `xuetang` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '血糖',
  `xinlv` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '心率',
  `pifuzhuangkuang` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '皮肤状况',
  `jingshenzhuangtai` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '精神状态',
  `jichujibing` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '基础疾病',
  `yinshixianzhi` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '饮食限制',
  `dengjishijian` datetime DEFAULT NULL COMMENT '登记时间',
  `pingguneirong` longtext COLLATE utf8mb4_unicode_ci COMMENT '评估内容',
  `jiankangbaogao` longtext COLLATE utf8mb4_unicode_ci COMMENT '健康报告',
  `jiankangjianyi` longtext COLLATE utf8mb4_unicode_ci COMMENT '健康建议',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='健康监测';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jiankangjiance`
--

LOCK TABLES `jiankangjiance` WRITE;
/*!40000 ALTER TABLE `jiankangjiance` DISABLE KEYS */;
INSERT INTO `jiankangjiance` VALUES (1,'2025-04-15 15:30:58','老人账号1','老人姓名1','file/jiankangjianceTouxiang1.jpg,file/jiankangjianceTouxiang2.jpg,file/jiankangjianceTouxiang3.jpg','血压1','血糖1','心率1','皮肤状况1','精神状态1','基础疾病1','饮食限制1','2025-04-15 23:30:58','评估内容1','健康报告1','健康建议1'),(2,'2025-04-15 15:30:58','老人账号2','老人姓名2','file/jiankangjianceTouxiang2.jpg,file/jiankangjianceTouxiang3.jpg,file/jiankangjianceTouxiang4.jpg','血压2','血糖2','心率2','皮肤状况2','精神状态2','基础疾病2','饮食限制2','2025-04-15 23:30:58','评估内容2','健康报告2','健康建议2'),(3,'2025-04-15 15:30:58','老人账号3','老人姓名3','file/jiankangjianceTouxiang3.jpg,file/jiankangjianceTouxiang4.jpg,file/jiankangjianceTouxiang5.jpg','血压3','血糖3','心率3','皮肤状况3','精神状态3','基础疾病3','饮食限制3','2025-04-15 23:30:58','评估内容3','健康报告3','健康建议3'),(4,'2025-04-15 15:30:58','老人账号4','老人姓名4','file/jiankangjianceTouxiang4.jpg,file/jiankangjianceTouxiang5.jpg,file/jiankangjianceTouxiang6.jpg','血压4','血糖4','心率4','皮肤状况4','精神状态4','基础疾病4','饮食限制4','2025-04-15 23:30:58','评估内容4','健康报告4','健康建议4'),(5,'2025-04-15 15:30:58','老人账号5','老人姓名5','file/jiankangjianceTouxiang5.jpg,file/jiankangjianceTouxiang6.jpg,file/jiankangjianceTouxiang7.jpg','血压5','血糖5','心率5','皮肤状况5','精神状态5','基础疾病5','饮食限制5','2025-04-15 23:30:58','评估内容5','健康报告5','健康建议5'),(6,'2025-04-15 15:30:58','老人账号6','老人姓名6','file/jiankangjianceTouxiang6.jpg,file/jiankangjianceTouxiang7.jpg,file/jiankangjianceTouxiang8.jpg','血压6','血糖6','心率6','皮肤状况6','精神状态6','基础疾病6','饮食限制6','2025-04-15 23:30:58','评估内容6','健康报告6','健康建议6'),(7,'2025-04-15 15:30:58','老人账号7','老人姓名7','file/jiankangjianceTouxiang7.jpg,file/jiankangjianceTouxiang8.jpg,file/jiankangjianceTouxiang9.jpg','血压7','血糖7','心率7','皮肤状况7','精神状态7','基础疾病7','饮食限制7','2025-04-15 23:30:58','评估内容7','健康报告7','健康建议7'),(8,'2025-04-15 15:30:58','老人账号8','老人姓名8','file/jiankangjianceTouxiang8.jpg,file/jiankangjianceTouxiang9.jpg,file/jiankangjianceTouxiang10.jpg','血压8','血糖8','心率8','皮肤状况8','精神状态8','基础疾病8','饮食限制8','2025-04-15 23:30:58','评估内容8','健康报告8','健康建议8'),(9,'2025-04-15 15:30:58','老人账号9','老人姓名9','file/jiankangjianceTouxiang9.jpg,file/jiankangjianceTouxiang10.jpg,file/jiankangjianceTouxiang11.jpg','血压9','血糖9','心率9','皮肤状况9','精神状态9','基础疾病9','饮食限制9','2025-04-15 23:30:58','评估内容9','健康报告9','健康建议9'),(10,'2025-04-15 15:30:58','老人账号10','老人姓名10','file/jiankangjianceTouxiang10.jpg,file/jiankangjianceTouxiang11.jpg,file/jiankangjianceTouxiang12.jpg','血压10','血糖10','心率10','皮肤状况10','精神状态10','基础疾病10','饮食限制10','2025-04-15 23:30:58','评估内容10','健康报告10','健康建议10'),(11,'2025-04-15 15:39:40','123','王刚','file/1744731452087.png','100','100','100','良好','良好','哮喘','的撒发','2025-04-15 23:39:08','的撒韩国拌饭萨迪克阿莎','打卡官方卡实打实咖啡机啊上党课静安寺','的撒甲方GV撒静待花开撒附件撒凯撒');
/*!40000 ALTER TABLE `jiankangjiance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laoren`
--

DROP TABLE IF EXISTS `laoren`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `laoren` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `laorenzhanghao` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '老人账号',
  `mima` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `laorenxingming` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '老人姓名',
  `xingbie` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `touxiang` longtext COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `nianling` int(11) DEFAULT NULL COMMENT '年龄',
  `yinshijinji` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '饮食禁忌',
  `pianhaokouwei` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '偏好口味',
  `money` double DEFAULT '0' COMMENT '余额',
  PRIMARY KEY (`id`),
  UNIQUE KEY `laorenzhanghao` (`laorenzhanghao`)
) ENGINE=InnoDB AUTO_INCREMENT=1744731457194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='老人';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laoren`
--

LOCK TABLES `laoren` WRITE;
/*!40000 ALTER TABLE `laoren` DISABLE KEYS */;
INSERT INTO `laoren` VALUES (71,'2025-04-15 15:30:58','老人账号1','123456','老人姓名1','男','file/laorenTouxiang1.jpg',1,'饮食禁忌1','偏好口味1',0.2),(72,'2025-04-15 15:30:58','老人账号2','123456','老人姓名2','男','file/laorenTouxiang2.jpg',2,'饮食禁忌2','偏好口味2',200),(73,'2025-04-15 15:30:58','老人账号3','123456','老人姓名3','男','file/laorenTouxiang3.jpg',3,'饮食禁忌3','偏好口味3',200),(74,'2025-04-15 15:30:58','老人账号4','123456','老人姓名4','男','file/laorenTouxiang4.jpg',4,'饮食禁忌4','偏好口味4',200),(75,'2025-04-15 15:30:58','老人账号5','123456','老人姓名5','男','file/laorenTouxiang5.jpg',5,'饮食禁忌5','偏好口味5',200),(76,'2025-04-15 15:30:58','老人账号6','123456','老人姓名6','男','file/laorenTouxiang6.jpg',6,'饮食禁忌6','偏好口味6',200),(77,'2025-04-15 15:30:58','老人账号7','123456','老人姓名7','男','file/laorenTouxiang7.jpg',7,'饮食禁忌7','偏好口味7',200),(78,'2025-04-15 15:30:58','老人账号8','123456','老人姓名8','男','file/laorenTouxiang8.jpg',8,'饮食禁忌8','偏好口味8',200),(79,'2025-04-15 15:30:58','老人账号9','123456','老人姓名9','男','file/laorenTouxiang9.jpg',9,'饮食禁忌9','偏好口味9',200),(80,'2025-04-15 15:30:58','老人账号10','123456','老人姓名10','男','file/laorenTouxiang10.jpg',10,'饮食禁忌10','偏好口味10',200),(1744731457193,'2025-04-15 15:37:37','123','123','王刚','男','file/1744731452087.png',35,'阿斯达发','的撒发干撒',999700.2);
/*!40000 ALTER TABLE `laoren` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `menujson` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'2025-04-15 15:30:58','[{\"backMenu\":[{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"库存统计\",\"查看评论\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"库存统计\",\"查看评论\",\"首页总数\",\"首页统计\"],\"classname\":\"caipinxinxi\",\"menu\":\"菜品信息\",\"menuJump\":\"列表\",\"tableName\":\"caipinxinxi\"}],\"fontClass\":\"icon-common24\",\"menu\":\"菜品信息管理\",\"unicode\":\"&#xee07;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-full\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"users\",\"menu\":\"管理员\",\"menuJump\":\"列表\",\"tableName\":\"users\"}],\"fontClass\":\"icon-user2\",\"menu\":\"管理员管理\",\"unicode\":\"&#xef98;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-goods\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"classname\":\"jiankangjiance\",\"menu\":\"健康监测\",\"menuJump\":\"列表\",\"tableName\":\"jiankangjiance\"}],\"fontClass\":\"icon-common37\",\"menu\":\"健康监测管理\",\"unicode\":\"&#xeea4;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-paint\",\"buttons\":[\"查看\",\"修改\"],\"classname\":\"config\",\"menu\":\"轮播图\",\"menuJump\":\"列表\",\"tableName\":\"config\"}],\"fontClass\":\"icon-common42\",\"menu\":\"轮播图管理\",\"unicode\":\"&#xef24;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\",\"修改\"],\"classname\":\"systemintro\",\"menu\":\"网站介绍\",\"menuJump\":\"列表\",\"tableName\":\"systemintro\"}],\"fontClass\":\"icon-common20\",\"menu\":\"网站介绍管理\",\"unicode\":\"&#xee02;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\"],\"appFrontIcon\":\"cuIcon-skin\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\"],\"classname\":\"chushi\",\"menu\":\"厨师\",\"menuJump\":\"列表\",\"tableName\":\"chushi\"}],\"fontClass\":\"icon-user4\",\"menu\":\"餐厅工作人员管理\",\"unicode\":\"&#xef9a;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-skin\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"news\",\"menu\":\"健康资讯\",\"menuJump\":\"列表\",\"tableName\":\"news\"}],\"fontClass\":\"icon-common28\",\"menu\":\"新闻资讯管理\",\"unicode\":\"&#xee2d;\"},{\"child\":[{\"allButtons\":[\"菜单管理\"],\"appFrontIcon\":\"cuIcon-present\",\"buttons\":[\"菜单管理\"],\"classname\":\"menu\",\"menu\":\"菜单\",\"menuJump\":\"列表\",\"tableName\":\"menu\"}],\"fontClass\":\"icon-common9\",\"menu\":\"菜单管理\",\"unicode\":\"&#xedc9;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"监测\"],\"appFrontIcon\":\"cuIcon-medal\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"监测\"],\"classname\":\"laoren\",\"menu\":\"老人\",\"menuJump\":\"列表\",\"tableName\":\"laoren\"}],\"fontClass\":\"icon-user4\",\"menu\":\"顾客管理\",\"unicode\":\"&#xef9a;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\"],\"appFrontIcon\":\"cuIcon-vip\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"审核\"],\"classname\":\"fankuiyujianyi\",\"menu\":\"反馈与建议\",\"menuJump\":\"列表\",\"tableName\":\"fankuiyujianyi\"}],\"fontClass\":\"icon-common50\",\"menu\":\"反馈与建议管理\",\"unicode\":\"&#xef96;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-camera\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"classname\":\"aboutus\",\"menu\":\"发展历程\",\"menuJump\":\"列表\",\"tableName\":\"aboutus\"}],\"fontClass\":\"icon-common38\",\"menu\":\"发展历程管理\",\"unicode\":\"&#xeeb2;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\"],\"menu\":\"商品订单\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\"],\"menu\":\"未支付订单\",\"menuJump\":\"未支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\",\"发货\",\"物流\",\"核销\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\",\"发货\"],\"menu\":\"已支付订单\",\"menuJump\":\"已支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\",\"物流\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\"],\"menu\":\"已完成订单\",\"menuJump\":\"已完成\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\"],\"menu\":\"已取消订单\",\"menuJump\":\"已取消\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\",\"物流\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\"],\"menu\":\"已退款订单\",\"menuJump\":\"已退款\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\",\"确认收货\",\"物流\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\"],\"menu\":\"已发货订单\",\"menuJump\":\"已发货\",\"tableName\":\"orders\"}],\"fontClass\":\"icon-common15\",\"menu\":\"订单管理\",\"unicode\":\"&#xedfc;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-clothes\",\"buttons\":[\"查看\"],\"classname\":\"caipinxinxi\",\"fontClass\":\"icon-common3\",\"menu\":\"菜品信息\",\"menuJump\":\"列表\",\"tableName\":\"caipinxinxi\",\"unicode\":\"&#xeda5;\"}],\"fontClass\":\"icon-common3\",\"menu\":\"菜品信息管理\",\"unicode\":\"&#xeda5;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-cardboard\",\"buttons\":[\"查看\"],\"classname\":\"news\",\"fontClass\":\"icon-common15\",\"menu\":\"健康资讯\",\"menuJump\":\"列表\",\"tableName\":\"news\",\"unicode\":\"&#xedfc;\"}],\"fontClass\":\"icon-common15\",\"menu\":\"新闻资讯管理\",\"unicode\":\"&#xedfc;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-vipcard\",\"buttons\":[\"查看\"],\"classname\":\"cart\",\"menu\":\"购物车\",\"menuJump\":\"列表\",\"tableName\":\"cart\"}],\"menu\":\"购物车管理\"}],\"hasBackLogin\":\"是\",\"hasBackRegister\":\"否\",\"hasFrontLogin\":\"否\",\"hasFrontRegister\":\"否\",\"pathName\":\"users\",\"roleName\":\"管理员\",\"tableName\":\"users\"},{\"backMenu\":[{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-vip\",\"buttons\":[\"查看\"],\"classname\":\"storeup\",\"menu\":\"我的收藏\",\"menuJump\":\"1\",\"tableName\":\"storeup\"}],\"fontClass\":\"icon-common4\",\"menu\":\"我的收藏管理\",\"unicode\":\"&#xedab;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-goods\",\"buttons\":[\"查看\"],\"classname\":\"jiankangjiance\",\"menu\":\"健康监测\",\"menuJump\":\"列表\",\"tableName\":\"jiankangjiance\"}],\"fontClass\":\"icon-common37\",\"menu\":\"健康监测管理\",\"unicode\":\"&#xeea4;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-full\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"address\",\"menu\":\"地址\",\"menuJump\":\"列表\",\"tableName\":\"address\"}],\"fontClass\":\"icon-common26\",\"menu\":\"地址管理\",\"unicode\":\"&#xee2b;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\"],\"appFrontIcon\":\"cuIcon-vip\",\"buttons\":[\"查看\",\"新增\"],\"classname\":\"fankuiyujianyi\",\"menu\":\"反馈与建议\",\"menuJump\":\"列表\",\"tableName\":\"fankuiyujianyi\"}],\"fontClass\":\"icon-common50\",\"menu\":\"反馈与建议管理\",\"unicode\":\"&#xef96;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\"],\"menu\":\"商品订单\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\"],\"menu\":\"未支付订单\",\"menuJump\":\"未支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\",\"发货\",\"物流\",\"核销\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\"],\"menu\":\"已支付订单\",\"menuJump\":\"已支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\",\"物流\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\"],\"menu\":\"已完成订单\",\"menuJump\":\"已完成\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\"],\"menu\":\"已取消订单\",\"menuJump\":\"已取消\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\",\"物流\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\"],\"menu\":\"已退款订单\",\"menuJump\":\"已退款\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"财务收入统计\",\"导出\",\"首页总数\",\"首页统计\",\"确认收货\",\"物流\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\",\"确认收货\"],\"menu\":\"已发货订单\",\"menuJump\":\"已发货\",\"tableName\":\"orders\"}],\"fontClass\":\"icon-common15\",\"menu\":\"订单管理\",\"unicode\":\"&#xedfc;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-clothes\",\"buttons\":[\"查看\"],\"classname\":\"caipinxinxi\",\"fontClass\":\"icon-common3\",\"menu\":\"菜品信息\",\"menuJump\":\"列表\",\"tableName\":\"caipinxinxi\",\"unicode\":\"&#xeda5;\"}],\"fontClass\":\"icon-common3\",\"menu\":\"菜品信息管理\",\"unicode\":\"&#xeda5;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-cardboard\",\"buttons\":[\"查看\"],\"classname\":\"news\",\"fontClass\":\"icon-common15\",\"menu\":\"健康资讯\",\"menuJump\":\"列表\",\"tableName\":\"news\",\"unicode\":\"&#xedfc;\"}],\"fontClass\":\"icon-common15\",\"menu\":\"新闻资讯管理\",\"unicode\":\"&#xedfc;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-vipcard\",\"buttons\":[\"查看\"],\"classname\":\"cart\",\"menu\":\"购物车\",\"menuJump\":\"列表\",\"tableName\":\"cart\"}],\"menu\":\"购物车管理\"}],\"hasBackLogin\":\"否\",\"hasBackRegister\":\"否\",\"hasFrontLogin\":\"是\",\"hasFrontRegister\":\"是\",\"pathName\":\"laoren\",\"roleName\":\"老人\",\"tableName\":\"laoren\"},{\"backMenu\":[{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"库存统计\",\"查看评论\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"库存统计\",\"查看评论\",\"首页总数\",\"首页统计\"],\"classname\":\"caipinxinxi\",\"menu\":\"菜品信息\",\"menuJump\":\"列表\",\"tableName\":\"caipinxinxi\"}],\"fontClass\":\"icon-common24\",\"menu\":\"菜品信息管理\",\"unicode\":\"&#xee07;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-clothes\",\"buttons\":[\"查看\"],\"classname\":\"caipinxinxi\",\"fontClass\":\"icon-common3\",\"menu\":\"菜品信息\",\"menuJump\":\"列表\",\"tableName\":\"caipinxinxi\",\"unicode\":\"&#xeda5;\"}],\"fontClass\":\"icon-common3\",\"menu\":\"菜品信息管理\",\"unicode\":\"&#xeda5;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-cardboard\",\"buttons\":[\"查看\"],\"classname\":\"news\",\"fontClass\":\"icon-common15\",\"menu\":\"健康资讯\",\"menuJump\":\"列表\",\"tableName\":\"news\",\"unicode\":\"&#xedfc;\"}],\"fontClass\":\"icon-common15\",\"menu\":\"新闻资讯管理\",\"unicode\":\"&#xedfc;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-vipcard\",\"buttons\":[\"查看\"],\"classname\":\"cart\",\"menu\":\"购物车\",\"menuJump\":\"列表\",\"tableName\":\"cart\"}],\"menu\":\"购物车管理\"}],\"hasBackLogin\":\"是\",\"hasBackRegister\":\"是\",\"hasFrontLogin\":\"否\",\"hasFrontRegister\":\"否\",\"pathName\":\"chushi\",\"roleName\":\"厨师\",\"tableName\":\"chushi\"}]');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `introduction` longtext COLLATE utf8mb4_unicode_ci COMMENT '简介',
  `picture` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='健康资讯';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'2025-04-15 15:30:57','余生，愿你活出自己的精彩','曾几何时，为了让自己显得合群，选择去做自己不喜欢的事;为了讨好喜欢的人，一次次地委屈自己;甚至，为了陌生人的一个眼神，就陷入了深深的自我怀疑。','file/newsPicture1.jpg','可是，这样小心翼翼的你，一定很累吧。你以为照顾了所有人的想法，就能得到他们的喜欢;你以为逼着自己合群，就能真的合群。直到后来才发现，在日复一日对自己的为难中，你逐渐弄丢了真实的自己.\n殊不知，人生在世，最不值得的事情，就是在别人的眼光中，迷失自己。其实，正如世界上没有十全十美的人，你也同样无法做到让每个人满意。\n世上没有不快乐的人，只有不肯让自己快乐的心。有一句话说:\n如果一段关系让你变得卑微，你可以选择抽身离去;如果一个人总是让你悲伤哭泣，你要学会放手。\n始终相信，每个人最初的样子，都是最美好的。真正喜欢你的人，会喜欢你原来的样子:真正爱你的从来不需要你的委曲求全。\n后半生，请把身上的枷锁，全部解除。去做喜欢的事，去听自己内心的声音。你会发现，这世上没有什么事情比活出自己更加幸福。\n要相信，真实的自己亦是一道风景线。你若盛开，清风自来。愿你此生尽兴，不负韶华，'),(2,'2025-04-15 15:30:57','岁月无常，好好珍惜','常听到这样的话，如果一切可以重新开始，我一定改掉任性，学会坚持，如果有下辈子，我一定好好珍惜，不会再弄丢原本属于自己的幸福。','file/newsPicture2.jpg','然而，世上有很多事情没有再来一次的机会，一旦错失就意味着无法弥补，正如人与人之间，有的只是一世的缘分，一旦转身，就意味着再无可能。\n这一生只活一次，有些人也只爱一回。\n所以，在拥有时就好好把握，对于来世，可以适当憧憬，但不要一昧去幻想，活着，唯有珍惜身边做好眼前事，才能让明天少一些遗憾。人，\n既然有幸来到这个世上，那就要努力把这辈子活好。岁月其实远没有想象中的那么漫长，若是能爱就好好爱，别让说好相伴一生的人，中途散走;若是当下能相知相守，就别去等待虚无缥缈的未来。\n就像一位网友留言说的:我从来不去期待下辈子，我要的只有今生，世事无常，来世是怎样的光景，谁都无法预知。对我来说，在有限的时光里，善待爱自己及自己爱的人，用心珍惜相聚的每一时刻，努力过好当下就足够了。\n时光匆匆，韶华似水，每个人都只有这短暂的一生。\n有些事，如果喜欢就坚定努力的去做，有些人，如果爱就真诚用心地去爱，别幻想着重来，别总是寄希望于下辈子。\n下辈子，彼此也许再也不会遇见，就算遇见了，谁还会记得谁，今生相互承诺的两个人，来生也许相见不相识。\n想起之前看过的一句话:人生没有假如，我们没有来世，下辈子，你我也许只是大千世界里互不相识的两个陌生人。\n的确，生命只有一次，今生有幸相遇的人，下辈子不一定能遇见，就算能遇见，谁能把谁陪伴，谁又是谁的谁?\n余生不长，趁着岁月未老，好好珍惜这辈子的缘分吧，别等到失去了才悔不该当初。'),(3,'2025-04-15 15:30:57','与其背着烦恼活，不如带着美好过','一直觉得，感情里，无疾而终并不可怕，可怕的是结束后，你还抱着回忆不肯放;岁月中，失去并不可怕，可怕的是失去后，你还揪着曾经不肯忘。\n有些事，明知道不应该继续，却始终没有转身的勇气;有些人，明知道已经成为过去，却还是舍不得放手;有时候，明知道纠缠于往事旧人只会徒增伤悲，却仍然执着的去回忆，去留恋。','file/newsPicture3.jpg','人生短短几十年，为什么要蹉跎浪费在无可挽回的失去上，为什么不酒脱一点，看开一点，活得轻松快乐一点。\n这世间，没有谁的人生是十全十美的，总要面对一些离别，总要经历一些失去，如果总对身边的一切执念太深，只会越活越累。\n时间不停向前，人也不可避免的要向前看。面对一些不如意、不顺心的事，该放的就放，该忘的就忘，别总把自己困在失败的悲伤中。\n生而为人，放不是无能，而是一种洒脱，忘更不是懦弱，而是一种智慧。\n在来去匆匆，聚散不定的现实里，放下不属于自己的感情，才能有新的开始，忘记心中的烦恼，才能收获愉快的心情。\n所以，有些离开的人，该放就放下吧，一直念念不忘，伤害的是自己，有些烦心事，该忘就忘了吧一直耿耿于怀，痛苦的是自己。\n-辈子本就不长，何必让自己活得那么累，过去的情就让它过去，别再留恋，想不通的事就算了，别再纠结。\n人生的旅途，总有些事让人烦，总有些情让人伤。只有学会忘记过往的不如意，忘记一些不必要的烦恼，以轻盈的身心重新出发，才不会被旧人旧事所累。\n记得，每个人心灵的空间都是有限的，当装多了纠结与伤感，就装不下自在与欢快了。要想日子过得简单轻松一点，就要懂得放下执念，忘掉痛苦，清除伤。'),(4,'2025-04-15 15:30:57','理想很丰满，现实很骨感','游戏里的你帅气无比，乘风御剑，通关杀敌无所不能，你满足于那其中的成就感，你满足于通关的畅快淋漓。','file/newsPicture4.jpg','年轻人，可那毕竟不是现实，理想很丰满，现实很骨感这不是玩笑，你不走出来，怎么会知\n你真的想等到某天喜欢上一个姑娘时，才去纠结咖啡钱电影钱你要如何与爸妈张口，才去苦恼为她买礼物你要怎样省吃俭用节衣缩食?\n你没有挥金如土的.魄力，没有殷实的家境，没有既定的光芒锦绣的前程，二十出头的年纪，你不努力，你想拿什么报答那个在你身边用最好的青春陪伴你的姑娘?你又拿什么报答含辛茹苦养育你这么多年的父母?\n生活不是游戏，不会给你那么多反复再来的机会，青春年少风华正茂，年轻人，你不努力，你想指望什么?\n年轻人，走出来奋斗吧!累也好苦也罢。如果你现在对自己各种放纵，你指望以后你用什么条件来放松?\n年轻人，你要努力赚钱，为了自己，也为了你爸妈。为了他们在以后逛商场的时候，可以给自己买东西像给你买东西一样毫不犹豫。为了他们可以在同老友谈起你时可以一脸安详，而不是想着，这个月，儿子交了房租还有钱吃饭么。我们这个年龄的人，已经像吸血鬼一样巴着父母活了二十多年了，还真的要继续吸着他们的血活下去么?\n年轻人，停止期望凡事简单容易。如果总是挑简单的事情做，那你永远成不了大器，生活总会在始料不及时考验你，所以你必须挑战困难，保持坚强，世上任何值得拥有的东西都需要付诸努力，勤奋与自律，倘若自甘平庸，那你就会变得庸碌无为。\n年轻人，与我们一起，挑战一下自己，拥抱一下梦想。你想要的生活，跳起来，一定够得到!'),(5,'2025-04-15 15:30:57','理想是一种精神上的追求','如果前方是一片黑暗，理想是否会黯淡?黑暗终究不能限制理想的步伐，只是需要时间。','file/newsPicture5.jpg','是否会撕裂黑暗的结界?给理想一点时间，是否会完成理想的目标?太多时候，黑给黑暗一缕曙光，暗限制了理想的脚步，时间成了撕裂黑暗的曙光。社会的压抑，未知的迷茫，甚至是事实的打击，都成了所谓的黑暗。\n理想应该是一种精神上的追求，一种我们内心深处的渴望。也许理想的种类太多，不一样的人也有不一样的理想。但唯一的共同点就是我们在追求，追求自己精神上亦或是心中的目标。但总是不尽人意，一来存在太多不确定因素，二来时间还不够。理想并不是一而就的空话。\n想过放弃，因为理想与现实的差距。但又不想放弃，因为理想是精神上的追求心中的渴望。纠结了太多，却是否想过在纠结的时候，已经选择了错过。被刻意选择的错过是什么?是路过。我们在不经意间路过了多少理想，只是因为纠结。如果坚定自己的理想，用时间去行动，是否会少几次刻意的错过:-次，与一位朋友谈到如何乐观，然后追求理想。朋友想了一会儿，给我的回答是正能量与时间。他说，想要乐观就要不断给自己正能量。事物有阴阳两面，如果阳代表乐观，那在我们看待一件事时要看阳面千万别看阴面。这样自己不会消极，某种程度上来说就是一种正能量。想要追求理想，务必要花费时间。正如没有风平浪静的大海，想要追求理想，要时间。给理想一点时间，让自己去追求，不顾切的追求。\n点点滴滴的小事构成了我们的生活，点点滴滴的努力给理想铺平了路。每一次小成功都为理想迈进了一步。每一次失败，都告诉我们一些教训，反方向来说为下一次成功提供了经验。不要觉得失败是可怕的，长远来看，正是失败才有了成功。\n时间在流逝。如果安于现状，就会乐不思。理想需要时间不代表我们可以挥霍，我们能做的是珍惜时间，去为理想拼搏。\n间接意义上讲，理想的时间是我们的努力。\n如果正在路上，一直任性向前走，忘记时间不回头。'),(6,'2025-04-15 15:30:57','人生如梦，梦想是帆','人生如梦，梦想是帆，每个人都有一个只属于自己的梦，但我们同属一个国家，所以每个人的梦又与国家的兴衰荣辱紧密相连。先哲顾炎武曾说:天下兴亡，匹夫有责。只有国家好，大家才能好。','file/newsPicture6.jpg','我依然清楚的记得:\n当甲午战争战败，日寇无礼踏破中国的门户;当八国联军侵入北京，无情掠夺中国的财产:当七七事变发生，中国的老人、妇孺被残忍杀害的时候，我在想那时中国的梦是怎样的!\n我虽不曾亲眼看到，但那却是铁一般的事实。因为从老人们那深邃的眼神中可以感到无尽的愤懑;从他们干瘪的脸颊可以看到深情的泪水，从他们嘹亮的军歌中可以想到那奋勇杀敌时的豪迈;从他们激昂话语中听到那誓要捍卫家园振兴中华的誓言。作为新一代青年的我们难道不应该树立远大的理想，付之以踏实的行动，去继承先辈们的使命。去实现中华民族的伟大崛起和复兴吗?\n有梦才能使中国繁荣!\n在改革开放以来中国取得了一系列的可以载入中国史册的成就。香港、澳门的回归，经济特区的建立，使中国成为发展国家中的经济大国，科技先进国和军事强国。当中国成功举办奥运的时候，当神九飞天的时候，当蛟龙入海的时候，当航母下水的时候，当莫言荣获诺贝尔文学奖的时候。我相信每个人都感觉到了无比的自豪。但是现在的中国与其他发达国家还有很大差距。作为新一代的我们，难道不应该志存高远吗?\n我想有的人会说，我们的力量是有限的。的确个人的力量很渺小，但是中国梦就是因一个个微不足道的个人的梦一直汇集、汇集，然后凝聚成的一个巨大的梦。冯至在《十四行诗》中写道，我们准备着，深深领受，那些意想不到的奇迹，在漫长的岁月里，忽然有彗星的出现，狂风乍起。\n梦想是美丽的，它是美的期望;梦想是阳光的，它使人由浮躁走向踏实;梦想是充满力量的，它可以激发人身体里无限的潜能。我们期盼的是国泰民安、经济发展、政治清明、文化繁荣、社会和谐、生态良\n好、公平正义。这才是中国人伟大的梦'),(7,'2025-04-15 15:30:57','若月亮没来-王宇宙Leto，乔浚丞','《若月亮没来(若是月亮还没来)》是王宇宙Leto，乔浚丞演唱的歌曲，于2024年1月22日上线发行。','file/newsPicture7.jpg','风吹过山 船靠了岸  风光呀 一点点看  我走向北 你去往南\n故事呀 一篇篇翻  好烦 又加班到很晚  你搭上空荡的 地铁已是末班\n好烦 很爱却要分开  恋爱谈不明白  好烦 接近理想好难 却又还很不甘\n如何拥抱平淡  如果 最难得到圆满  不如选择坦然 若是月亮还没来\n路灯也可照窗台  照着白色的山茶花微微开  若是晨风还没来\n晚风也可吹入怀  吹着那一地树影温柔摇摆  你总以为你不够好\n不够苗条和美貌  可是完美谁能达到  做你自己就很好\n烦恼烦恼拥有太少  没有房车没有钞票  可爱你的人永远会 \n把你当做心尖珍宝  我也懂大多数的时候  你只想逃离这世界\n我也懂太多的情绪在  一个人失眠的深夜 你可以是悲伤或者埋怨\n但请不要放弃明天  这一直灰暗的世界  我想看见你的笑脸\n若是月亮还没来  路灯也可照窗台  照着白色的山茶花微微开\n若是晨风还没来  晚风也可吹入怀  吹着那一地树影温柔摇摆\n若是月亮还没来  路灯也可照窗台  照着白色的山茶花微微开\n若是晨风还没来  晚风也可吹入怀  吹着那一地树影温柔摇摆\n李哲今年1月份创作了《若月亮没来》这首歌。随着歌曲的热度不断上升，约他写歌的人越来越多，他的工作变得更加繁忙。\n近年来，李哲凭借对音乐的热爱和不懈的努力，创作了几百首音乐作品，其中不乏广为人知的佳作，例如王栎鑫的《一个人》、何赛飞与叶炫清在央视演唱的《木兰诗》等歌曲，都是由李哲作曲。\n如今，李哲的音乐才华和努力得到了业界的广泛认可，他的音乐作品多次登上各大音乐平台的热歌榜，成为备受瞩目的新生代音乐人。现在，走在街头、坐在车里，经常会听到自己的作品。看到自己的音乐作品受到如此广泛的喜爱和认可，我感到非常有成就感。李哲笑着说，他会努力创作更多优秀音乐作品，为家乡争光。'),(8,'2025-04-15 15:30:57','-米阳光传递一份温暖','黑暗中跌倒，坚强里苦笑。只是因为青春还在，所以梦想一直在路上。当年华未曾老去，青春没有散场，留给幽暗的岁月，还有几分值得珍藏?孤独无助时、伤心难过时总爱恣意挥霍愤怒。伤了、痛了原本以为就都结束了;可是心里还不甘愿放弃，就只为一个理由，有梦想的人永不孤单。','file/newsPicture8.jpg','放进去了的青春，走不出来的悲伤却总是给年少时的我们留下太多无法割舍的情怀。记录岁月的足迹，聆听时光的故事。然轻吟浅唱出，青春嘉年华。\n故事里总会有，那些太多感慨于时间的无情，太多对往事的追忆，太多的太多，而今刻在了心里也停泻在了流年里。一段无法抹去的回忆，也只不过是一场烟火燃放的瞬间，却也一辈子在脑海里兜兜转转。很是怀念那些相遇的日子，邂逅了幸福也留在了时间轨迹里。时而想起，那些曾肩并肩奋斗的日子，那些写满感动与快乐的岁月。\n如今，我们似乎渐行渐远，彼此奋斗着青春的轮回。渐渐的，我们都长大了，时间改变了我们时刻分享彼此快乐与不快乐的习惯，青春的渐逝，岁月的更迭让我们变得都不再联系，身边的朋友也越来越少;那些欢笑，那些幸福的流年也随着我们的陌生而变得更加奢侈。也许多年以后，我们都有了自己的朋友，有了自己关心的人。那时，我们再细数那些癫狂在你生命里一辈子的记忆故事，蓦然发现一切都停留在了回忆里。'),(9,'2025-04-15 15:30:57','自己的路自己走，自己的心自己懂','岛上书店》中有句话:每个人的生命里，都有最艰难的那一年，将人生变得美好而辽阔。\n你有没有经历过那么一年，在走过的岁月中跋涉得异常艰难困苦，却仍无法灭前行的勇气。哪怕所有人都极力劝阻，也要不甘心地试一试;哪怕前方已没有道路，却还在坚定前行;哪怕再看不到任何希望，也要竭尽全力地为自己争取一个机会。','file/newsPicture9.jpg','你开始不动声色的扮演着一个大人，经历着生活日复一日的打。\n每天醒在天还没亮的五六点，挤过早高峰的地下铁，面对成山的工作，加班到深夜倒下就睡更成为了日常，还要应付各色的人际关系，逐渐开始接受努力也不一定有回报的道理。\n这段日子也许很长，但你没有放弃对生活的信心，始终相信人生总会变得一帆风顺，更坚信每件事的最后都会有一个好的结局，如果不是，说明还没到最后。\n于是你树立新的目标，让这一年的奔波更有方向。\n虽然永远无法预料明天是晴是雨，也无法预知你在乎的人是否还在身边，你一直以来的坚持究竟能换来什么。\n但你能决定的是，今天有没有备好雨伞，有没有好好爱人以及是否为自己追求的理想拼尽全力。\n永远不要只看见前方路途遥远而忘了从前的自己坚持了多久才走到了这里，\n今天拼尽全力虽然艰辛万分，在未来都将成为落在你身上的礼物。'),(10,'2025-04-15 15:30:57','愿你有明天可奔赴，有过往可回头','此去经年，用一张离家的车票，换一段有故事可说的人生。\n大概就是那时候怀揣着梦想，背上了行囊，一腔热血决定远行的你。独自拎着一只行李箱，背着双肩包在深夜抵达一个陌生的城市，站在人潮涌动的车站出口，望着宽敞公路上车水马龙的喧嚣，城市里亮如白昼的繁华。','file/newsPicture10.jpg','这世界上的人们都活的匆匆忙忙，每个人看起来都很焦虑，每个人都有自己的苦楚，却往往找不到人可以诉说。也许你的倾诉，对别人来说是一种打扰，而且别人没经历过你的经历，所以无法体会你的心情。我们总是在心情不好的时候拿着手机，翻翻通讯录，然后再默默放下手机，压住心中那股想要找人说说话的想法。\n等到低落的情绪慢慢有些好转，才开始明白，人这一生，无论是什么样的路，都是自己的选择，冲动也好，深思熟虑也罢，自己选的路，不管多难，都要自己走下去。心中的感受，不管是复杂还是简单，都只能自己来懂，别人帮不了你，也安慰不了你，顶多给你一些无济于事的劝告，最后还得靠自己想开。你选的幸福，你自己享受;你选的眼泪，你自己来流，生活就是如此，自己的路，自己走;自己的心，自己懂。');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `orderid` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单编号',
  `tablename` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT 'caipinxinxi' COMMENT '商品表名',
  `goodid` bigint(20) NOT NULL COMMENT '商品id',
  `goodname` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `picture` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `buynumber` int(11) DEFAULT NULL COMMENT '购买数量',
  `price` double DEFAULT NULL COMMENT '单价',
  `discountprice` double DEFAULT NULL COMMENT '折扣价',
  `total` double DEFAULT NULL COMMENT '总价',
  `discounttotal` double DEFAULT NULL COMMENT '折扣总价格',
  `type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付类型',
  `status` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单状态',
  `address` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `tel` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `consignee` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人',
  `remark` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `logistics` longtext COLLATE utf8mb4_unicode_ci COMMENT '物流',
  `role` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户角色',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `sfsh` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否审核',
  `shhf` longtext COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `orderid` (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2025-04-15 15:39:55','20250415233952758080','caipinxinxi',11,'凉豆腐','file/1744731521022.jpg',1,100,100,100,100,'1','已完成','傻大个大撒大法师发广告','13512345123','123','',NULL,'laoren',1744731457193,NULL,NULL),(2,'2025-04-15 15:40:14','20250415234011674749','caipinxinxi',1,'菜品名称1','file/caipinxinxiCaipintupian1.jpg',1,99.9,99.9,99.9,99.9,'1','已完成','傻大个大撒大法师发广告','13512345123','123','',NULL,'laoren',1744731457193,NULL,NULL),(3,'2025-04-15 15:40:14','20250415234011699810','caipinxinxi',2,'菜品名称2','file/caipinxinxiCaipintupian2.jpg',1,99.9,99.9,99.9,99.9,'1','已完成','傻大个大撒大法师发广告','13512345123','123','',NULL,'laoren',1744731457193,NULL,NULL),(4,'2025-04-15 15:40:43','20250415234040708707','caipinxinxi',11,'凉豆腐','file/1744731521022.jpg',1,100,100,100,100,'1','已退款','傻大个大撒大法师发广告','13512345123','123','',NULL,'laoren',1744731457193,'是','是'),(5,'2025-04-15 15:43:17','20250415234315154772','caipinxinxi',1,'菜品名称1','file/caipinxinxiCaipintupian1.jpg',1,99.9,99.9,99.9,99.9,'1','已支付','打撒噶事多','13512345123','老人1','',NULL,'laoren',71,NULL,NULL),(6,'2025-04-15 15:43:17','20250415234315175487','caipinxinxi',2,'菜品名称2','file/caipinxinxiCaipintupian2.jpg',1,99.9,99.9,99.9,99.9,'1','已支付','打撒噶事多','13512345123','老人1','',NULL,'laoren',71,NULL,NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storeup`
--

DROP TABLE IF EXISTS `storeup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storeup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint(20) DEFAULT NULL COMMENT 'refid',
  `tablename` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表名',
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `picture` longtext COLLATE utf8mb4_unicode_ci COMMENT '图片',
  `type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '类型(1:收藏,21:赞,22:踩,31:竞拍参与,41:关注)',
  `inteltype` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '推荐类型',
  `remark` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='我的收藏';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storeup`
--

LOCK TABLES `storeup` WRITE;
/*!40000 ALTER TABLE `storeup` DISABLE KEYS */;
INSERT INTO `storeup` VALUES (1,'2025-04-15 15:39:51',11,'caipinxinxi','凉豆腐','file/1744731521022.jpg','1',NULL,NULL,1744731457193),(2,'2025-04-15 15:42:52',11,'caipinxinxi','凉豆腐','file/1744731521022.jpg','1',NULL,NULL,71);
/*!40000 ALTER TABLE `storeup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemintro`
--

DROP TABLE IF EXISTS `systemintro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemintro` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `subtitle` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '副标题',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `picture1` longtext COLLATE utf8mb4_unicode_ci COMMENT '图片1',
  `picture2` longtext COLLATE utf8mb4_unicode_ci COMMENT '图片2',
  `picture3` longtext COLLATE utf8mb4_unicode_ci COMMENT '图片3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='网站介绍';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemintro`
--

LOCK TABLES `systemintro` WRITE;
/*!40000 ALTER TABLE `systemintro` DISABLE KEYS */;
INSERT INTO `systemintro` VALUES (1,'2025-04-15 15:30:58','网站介绍','WEBSITE INTRODUCTION','山川湖海，风雨雷电，花鸟虫鱼，这些都是大自然的奇妙造物，也是我们生命中最美好的遇见。在万籁俱寂的雪夜里，深邃>的星空映入眼帘，让我感受到生命的无限广阔与深沉；在烈日炎炎的夏日里，那炽热的阳光照射在身上，让我感受到生命的多彩与活力。','file/systemintroPicture1.jpg','file/systemintroPicture2.jpg','file/systemintroPicture3.jpg');
/*!40000 ALTER TABLE `systemintro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `tablename` varchar(100) DEFAULT NULL COMMENT '表名',
  `role` varchar(100) DEFAULT NULL COMMENT '角色',
  `token` varchar(200) NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='token表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,1744731457193,'123','laoren','老人','fa4r8xii039mbzmbtl9u3jrzjc5ktcec','2025-04-15 15:37:52','2025-04-15 16:37:52'),(2,1744731468901,'12','chushi','厨师','cqjv5zy416g5vlmiuxs7eh0wrzk3zu2c','2025-04-15 15:38:31','2025-04-15 16:38:32'),(3,1,'admin','users','管理员','tc6heeu8ee5w79csbfns3nrdu38zyr7q','2025-04-15 15:39:02','2025-04-15 16:39:03'),(4,71,'老人账号1','laoren','老人','jpp3zvjmp3jrt9feaag1zi87kwdcmpi8','2025-04-15 15:42:33','2025-04-15 16:42:34');
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `role` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '管理员' COMMENT '角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2025-04-15 15:30:58','admin','admin','管理员');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-16  9:50:31
