-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hauth
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.14-MariaDB

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
-- Table structure for table `sys_domain_info`
--

DROP TABLE IF EXISTS `sys_domain_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_domain_info` (
  `domain_id` varchar(30) NOT NULL,
  `domain_name` varchar(300) NOT NULL,
  `domain_status_id` char(1) NOT NULL,
  `domain_create_date` datetime NOT NULL,
  `domain_maintance_date` datetime DEFAULT NULL,
  `domain_maintance_user` varchar(30) DEFAULT NULL,
  `domain_owner` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`domain_id`),
  KEY `fk_sys_idx_05` (`domain_status_id`),
  CONSTRAINT `fk_sys_idx_05` FOREIGN KEY (`domain_status_id`) REFERENCES `sys_domain_status_attr` (`domain_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='域管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_domain_info`
--

LOCK TABLES `sys_domain_info` WRITE;
/*!40000 ALTER TABLE `sys_domain_info` DISABLE KEYS */;
INSERT INTO `sys_domain_info` VALUES ('domainTest1','测试域1','0','2017-06-18 14:37:54','2017-06-19 14:00:35','demo','demo'),('domainTest2','测试域2','0','2017-06-18 14:38:07','2017-06-18 14:38:07','demo','demo'),('mas','管理会计','0','2017-03-01 10:58:18','2017-04-11 22:08:03','ftpadmin','admin'),('vertex_root','系统顶级域空间','0','2016-12-26 16:43:19','2017-04-24 18:30:34','admin','admin');
/*!40000 ALTER TABLE `sys_domain_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_domain_share_info`
--

DROP TABLE IF EXISTS `sys_domain_share_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_domain_share_info` (
  `uuid` varchar(66) NOT NULL,
  `domain_id` varchar(30) NOT NULL,
  `target_domain_id` varchar(30) NOT NULL,
  `Authorization_level` char(1) NOT NULL,
  `create_user` varchar(30) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `modify_date` date DEFAULT NULL,
  `modify_user` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `fk_sys_domain_share_info_01_idx` (`domain_id`),
  CONSTRAINT `fk_sys_domain_share_info_01` FOREIGN KEY (`domain_id`) REFERENCES `sys_domain_info` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_domain_share_info`
--

LOCK TABLES `sys_domain_share_info` WRITE;
/*!40000 ALTER TABLE `sys_domain_share_info` DISABLE KEYS */;
INSERT INTO `sys_domain_share_info` VALUES ('1e00db7c-5cd0-11e7-9d30-a0c58951c8d5','domainTest1','vertex_root','2','admin','2017-06-29','2017-06-29','admin'),('2bc00949-237e-11e7-966c-a0c58951c8d5','mas','demo','2','demo','2017-04-17','2017-04-24','admin'),('3afca46c-54b6-11e7-99f7-a0c58951c8d5','domainTest1','domainTest2','1','demo','2017-06-19','2017-06-19','demo'),('40ffac77-1a72-11e7-9d82-a0c58951c8d5','mas','devops_product','2','demo','2017-04-06','2017-04-24','admin'),('63a8f2f4-5499-11e7-99f7-a0c58951c8d5','domainTest1','mas','1','demo','2017-06-19','2017-06-19','demo'),('662dc075-1f88-11e7-9677-a0c58951c8d5','vertex_root','324354325','2','admin','2017-04-12','2017-04-12','admin'),('a2ec0bdc-1dab-11e7-9d82-a0c58951c8d5','mas','vertex_root','2','ftpadmin','2017-04-10','2017-04-24','admin'),('aa5944db-28d8-11e7-9c7e-a0c58951c8d5','mas','product','1','demo','2017-04-24','2017-04-24','admin');
/*!40000 ALTER TABLE `sys_domain_share_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_domain_status_attr`
--

DROP TABLE IF EXISTS `sys_domain_status_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_domain_status_attr` (
  `domain_status_id` char(1) NOT NULL,
  `domain_status_name` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`domain_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_domain_status_attr`
--

LOCK TABLES `sys_domain_status_attr` WRITE;
/*!40000 ALTER TABLE `sys_domain_status_attr` DISABLE KEYS */;
INSERT INTO `sys_domain_status_attr` VALUES ('0','正常'),('1','锁定'),('2','失效');
/*!40000 ALTER TABLE `sys_domain_status_attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_handle_logs`
--

DROP TABLE IF EXISTS `sys_handle_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_handle_logs` (
  `uuid` varchar(60) NOT NULL,
  `user_id` varchar(30) DEFAULT NULL,
  `handle_time` datetime DEFAULT NULL,
  `client_ip` varchar(30) DEFAULT NULL,
  `status_code` varchar(10) DEFAULT NULL,
  `method` varchar(45) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `data` longtext,
  `domain_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_handle_logs`
--

LOCK TABLES `sys_handle_logs` WRITE;
/*!40000 ALTER TABLE `sys_handle_logs` DISABLE KEYS */;
INSERT INTO `sys_handle_logs` VALUES ('21e044a2-6716-11e7-9d91-a0c58951c8d5','demo','2017-07-12 23:24:01','0:0:0:0:0:0:0:1','200','GET','/v1/auth/main/menu','{\"TypeId\":\"0\",\"Id\":\"-1\"}','mas'),('22dfe8e1-6716-11e7-9d91-a0c58951c8d5','demo','2017-07-12 23:24:03','0:0:0:0:0:0:0:1','200','GET','/v1/auth/index/entry','{\"Id\":\"0100000000\"}','mas'),('22ed456a-6716-11e7-9d91-a0c58951c8d5','demo','2017-07-12 23:24:03','0:0:0:0:0:0:0:1','200','GET','/v1/auth/main/menu','{\"TypeId\":\"1\",\"Id\":\"0100000000\"}','mas'),('24c36426-6716-11e7-9d91-a0c58951c8d5','demo','2017-07-12 23:24:06','0:0:0:0:0:0:0:1','200','GET','/v1/auth/resource/page','{}','mas'),('24d2c5f8-6716-11e7-9d91-a0c58951c8d5','demo','2017-07-12 23:24:06','0:0:0:0:0:0:0:1','200','GET','/v1/auth/menu','{}','mas'),('26618b47-6716-11e7-9d91-a0c58951c8d5','demo','2017-07-12 23:24:08','0:0:0:0:0:0:0:1','200','GET','/v1/auth/menu/details','{\"res_id\":\"0500000000\"}','mas'),('2661e887-6716-11e7-9d91-a0c58951c8d5','demo','2017-07-12 23:24:08','0:0:0:0:0:0:0:1','200','GET','/v1/auth/menu/theme','{\"res_id\":\"0500000000\",\"theme_id\":\"1001\"}','mas'),('27b321e6-6716-11e7-9d91-a0c58951c8d5','demo','2017-07-12 23:24:11','0:0:0:0:0:0:0:1','200','POST','/v1/auth/menu/delete','{\"res_id\":\"0500000000\"}','mas'),('27b7e2a6-6716-11e7-9d91-a0c58951c8d5','demo','2017-07-12 23:24:11','0:0:0:0:0:0:0:1','200','GET','/v1/auth/menu','{}','mas'),('28d7307f-6716-11e7-9d91-a0c58951c8d5','demo','2017-07-12 23:24:13','0:0:0:0:0:0:0:1','200','GET','/v1/auth/main/menu','{\"TypeId\":\"0\",\"Id\":\"-1\"}','mas');
/*!40000 ALTER TABLE `sys_handle_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_index_page`
--

DROP TABLE IF EXISTS `sys_index_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_index_page` (
  `theme_id` varchar(30) NOT NULL,
  `res_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_index_page`
--

LOCK TABLES `sys_index_page` WRITE;
/*!40000 ALTER TABLE `sys_index_page` DISABLE KEYS */;
INSERT INTO `sys_index_page` VALUES ('1001','./views/hauth/theme/default/index.tpl'),('1002','./views/hauth/theme/blue/index.tpl'),('1003','./views/hauth/theme/apple/index.tpl'),('1004','./views/hauth/theme/cyan/index.tpl');
/*!40000 ALTER TABLE `sys_index_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_org_info`
--

DROP TABLE IF EXISTS `sys_org_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_org_info` (
  `org_unit_id` varchar(66) NOT NULL,
  `org_unit_desc` varchar(300) NOT NULL,
  `up_org_id` varchar(66) NOT NULL,
  `domain_id` varchar(30) NOT NULL,
  `create_date` date NOT NULL,
  `maintance_date` date NOT NULL,
  `create_user` varchar(30) NOT NULL,
  `maintance_user` varchar(30) NOT NULL,
  `code_number` varchar(66) NOT NULL,
  PRIMARY KEY (`org_unit_id`),
  KEY `pk_sys_org_info_03_idx` (`domain_id`),
  CONSTRAINT `fk_sys_org_info_01` FOREIGN KEY (`domain_id`) REFERENCES `sys_domain_info` (`domain_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_org_info`
--

LOCK TABLES `sys_org_info` WRITE;
/*!40000 ALTER TABLE `sys_org_info` DISABLE KEYS */;
INSERT INTO `sys_org_info` VALUES ('mas_join_234fda','攀枝花市分行','mas_join_5233454','mas','2017-03-14','2017-04-20','admin','admin','234fda'),('mas_join_34124','工商银行','root_vertex_system','mas','2017-03-01','2017-03-01','admin','admin','34124'),('mas_join_45246543','武汉市分行','mas_join_512345423','mas','2017-03-01','2017-06-10','admin','admin','45246543'),('mas_join_4542346','孝感市分行','mas_join_512345423','mas','2017-03-01','2017-04-21','admin','admin','4542346'),('mas_join_512345423','湖北省分行','mas_join_34124','mas','2017-03-01','2017-04-05','admin','demo','512345423'),('mas_join_5233454','四川省分行','mas_join_34124','mas','2017-03-14','2017-03-14','admin','admin','5233454'),('mas_join_aefd','欧洲分行','mas_join_34124','mas','2017-03-14','2017-03-14','admin','admin','aefd'),('mas_join_fdafdg','贵州省分行','mas_join_34124','mas','2017-03-14','2017-03-14','admin','admin','fdafdg'),('mas_join_fdaga','重庆市分行','mas_join_34124','mas','2017-03-14','2017-03-14','admin','admin','fdaga'),('mas_join_fdagqe','宁夏省分行','mas_join_34124','mas','2017-03-14','2017-03-14','admin','admin','fdagqe'),('mas_join_fdasfd','上海市分行','mas_join_34124','mas','2017-03-14','2017-03-14','admin','admin','fdasfd'),('mas_join_fdsagd','泸州市分行','mas_join_5233454','mas','2017-03-14','2017-03-14','admin','admin','fdsagd'),('mas_join_feqhda','海南省分行','mas_join_34124','mas','2017-03-14','2017-03-14','admin','admin','feqhda'),('mas_join_ffadg','安徽省分行','mas_join_34124','mas','2017-03-14','2017-03-14','admin','admin','ffadg'),('mas_join_fgasdbc','台湾省分行','mas_join_34124','mas','2017-03-14','2017-03-14','admin','admin','fgasdbc'),('mas_join_fgasdf','成都市分行','mas_join_5233454','mas','2017-03-14','2017-03-14','admin','admin','fgasdf'),('mas_join_fgdasdf','南充市分行','mas_join_5233454','mas','2017-03-14','2017-03-14','admin','admin','fgdasdf'),('mas_join_fhadf','香港特别行政区分行','mas_join_34124','mas','2017-03-14','2017-04-24','admin','admin','fhadf'),('mas_join_gasdh3','雅安市分行','mas_join_5233454','mas','2017-03-14','2017-03-14','admin','admin','gasdh3'),('mas_join_reqggfdas','江西省分行','mas_join_34124','mas','2017-03-14','2017-03-14','admin','admin','reqggfdas'),('mas_join_rqreg','北京市分行','mas_join_34124','mas','2017-03-14','2017-03-14','admin','admin','rqreg'),('vertex_root_join_vertex_root','系统管理组','root_vertex_system','vertex_root','2016-01-01','2017-04-20','sys','admin','vertex_root');
/*!40000 ALTER TABLE `sys_org_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_resource_info`
--

DROP TABLE IF EXISTS `sys_resource_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_resource_info` (
  `res_id` varchar(30) NOT NULL,
  `res_name` varchar(300) DEFAULT NULL,
  `res_attr` char(1) DEFAULT NULL,
  `res_up_id` varchar(30) DEFAULT NULL,
  `res_type` char(1) DEFAULT NULL,
  `sys_flag` char(1) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  KEY `fk_sys_idx_13` (`res_type`),
  KEY `fk_sys_idx_14` (`res_attr`),
  CONSTRAINT `fk_sys_idx_13` FOREIGN KEY (`res_type`) REFERENCES `sys_resource_type_attr` (`res_type`),
  CONSTRAINT `fk_sys_idx_14` FOREIGN KEY (`res_attr`) REFERENCES `sys_resource_info_attr` (`res_attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_resource_info`
--

LOCK TABLES `sys_resource_info` WRITE;
/*!40000 ALTER TABLE `sys_resource_info` DISABLE KEYS */;
INSERT INTO `sys_resource_info` VALUES ('0100000000','系统管理','0','-1','0','0'),('0101000000','系统审计','0','0100000000','4','0'),('0101010000','操作查询','1','0101000000','1','0'),('0101010100','查看操作日志权限','1','0101010000','2',NULL),('0101010200','下载操作日志按钮','1','0101010000','2',NULL),('0101010300','搜索日志信息按钮','1','0101010000','2',NULL),('0103000000','资源管理','0','0100000000','4','0'),('0103010000','菜单','1','0103000000','1','0'),('0103010100','查询资源信息','1','0103010000','2',NULL),('0103010200','新增资源信息按钮','1','0103010000','2',NULL),('0103010300','编辑资源信息按钮','1','0103010000','2',NULL),('0103010400','删除资源信息按钮','1','0103010000','2',NULL),('01030104001','删除资源信息按钮','1','0101010000','2',NULL),('0103010500','配置主题信息按钮','1','0103010000','2',NULL),('0103020000','组织','1','0103000000','1','0'),('0103020100','查询组织架构信息','1','0103020000','2',NULL),('0103020200','新增组织架构信息按钮','1','0103020000','2',NULL),('0103020300','更新组织架构信息按钮','1','0103020000','2',NULL),('0103020400','删除组织架构信息按钮','1','0103020000','2',NULL),('0103020500','导出组织架构信息按钮','1','0103020000','2',NULL),('0103030100','查询共享域信息','1','0104010200','2',NULL),('0103030200','新增共享域信息按钮','1','0104010200','2',NULL),('0103030300','删除共享域信息按钮','1','0104010200','2',NULL),('0103030400','更新共享域信息按钮','1','0104010200','2',NULL),('0104010000','域定义','1','0103000000','1','0'),('0104010100','查询域信息','1','0104010000','2',NULL),('0104010200','共享域管理','1','0104010000','2',NULL),('0104010300','编辑域信息按钮','1','0104010000','2',NULL),('0104010400','删除域信息按钮','1','0104010000','2',NULL),('0104010500','新增域信息按钮','1','0104010000','2',NULL),('0105000000','用户与安全管理','0','0100000000','4','0'),('0105010000','用户','1','0105000000','1','0'),('0105010100','查询用户信息','1','0105010000','2',NULL),('0105010200','新增用户信息按钮','1','0105010000','2',NULL),('0105010300','编辑用户信息按钮','1','0105010000','2',NULL),('0105010400','删除用户信息按钮','1','0105010000','2',NULL),('0105010500','修改用户密码按钮','1','0105010000','2',NULL),('0105010600','修改用户状态按钮','1','0105010000','2',NULL),('0105020000','角色','1','0105000000','1','0'),('0105020100','查询角色信息','1','0105020000','2',NULL),('0105020200','新增角色信息按钮','1','0105020000','2',NULL),('0105020300','更新角色信息按钮','1','0105020000','2',NULL),('0105020400','删除角色信息按钮','1','0105020000','2',NULL),('0105020500','角色资源管理','1','0105020000','2',NULL),('0105020510','查询角色资源信息','1','0105020500','2',NULL),('0105020520','修改角色资源信息','1','0105020500','2',NULL),('0105040000','授权','1','0105000000','1','0'),('0105040100','授予权限按钮','1','0105040000','2',NULL),('0105040200','移除权限','1','0105040000','2',NULL),('1100000000','系统帮助','0','-1','0',NULL),('1101000000','系统管理帮助','0','1100000000','4',NULL),('1101010000','系统维护帮助信息','1','1101000000','1',NULL),('1101020000','API文档','1','1101000000','1',NULL),('1102000000','管理会计帮助文档','0','1100000000','4',NULL);
/*!40000 ALTER TABLE `sys_resource_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_resource_info_attr`
--

DROP TABLE IF EXISTS `sys_resource_info_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_resource_info_attr` (
  `res_attr` char(1) NOT NULL,
  `res_attr_desc` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`res_attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_resource_info_attr`
--

LOCK TABLES `sys_resource_info_attr` WRITE;
/*!40000 ALTER TABLE `sys_resource_info_attr` DISABLE KEYS */;
INSERT INTO `sys_resource_info_attr` VALUES ('0','目录'),('1','叶子');
/*!40000 ALTER TABLE `sys_resource_info_attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_resource_type_attr`
--

DROP TABLE IF EXISTS `sys_resource_type_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_resource_type_attr` (
  `res_type` char(1) NOT NULL,
  `res_type_desc` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`res_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_resource_type_attr`
--

LOCK TABLES `sys_resource_type_attr` WRITE;
/*!40000 ALTER TABLE `sys_resource_type_attr` DISABLE KEYS */;
INSERT INTO `sys_resource_type_attr` VALUES ('0','首页菜单'),('1','子系统菜单'),('2','功能按钮'),('4','虚拟节点');
/*!40000 ALTER TABLE `sys_resource_type_attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_info`
--

DROP TABLE IF EXISTS `sys_role_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_info` (
  `role_id` varchar(66) NOT NULL,
  `role_name` varchar(300) NOT NULL,
  `role_owner` varchar(30) NOT NULL,
  `role_create_date` datetime NOT NULL,
  `role_status_id` char(1) NOT NULL,
  `domain_id` varchar(30) NOT NULL,
  `role_maintance_date` datetime NOT NULL,
  `role_maintance_user` varchar(30) NOT NULL,
  `code_number` varchar(66) NOT NULL,
  PRIMARY KEY (`role_id`),
  KEY `fk_sys_idx_11` (`role_status_id`),
  CONSTRAINT `fk_sys_idx_11` FOREIGN KEY (`role_status_id`) REFERENCES `sys_role_status_attr` (`role_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_info`
--

LOCK TABLES `sys_role_info` WRITE;
/*!40000 ALTER TABLE `sys_role_info` DISABLE KEYS */;
INSERT INTO `sys_role_info` VALUES ('mas__hzwy23__etladmin','ETL超级管理员','demo','2017-06-20 23:22:14','0','mas','2017-06-20 23:22:14','demo','etladmin'),('vertex_root_join_sysadmin','超级管理员','admin','2016-01-01 00:00:00','0','vertex_root','2016-12-16 00:00:00','admin','sysadmin');
/*!40000 ALTER TABLE `sys_role_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_resource_relat`
--

DROP TABLE IF EXISTS `sys_role_resource_relat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_resource_relat` (
  `uuid` varchar(160) NOT NULL DEFAULT 'uuid()',
  `role_id` varchar(66) DEFAULT NULL,
  `res_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `fk_sys_idx_06` (`res_id`),
  KEY `fk_sys_role_res_01_idx` (`role_id`),
  CONSTRAINT `fk_sys_idx_06` FOREIGN KEY (`res_id`) REFERENCES `sys_resource_info` (`res_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sys_role_res_01` FOREIGN KEY (`role_id`) REFERENCES `sys_role_info` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_resource_relat`
--

LOCK TABLES `sys_role_resource_relat` WRITE;
/*!40000 ALTER TABLE `sys_role_resource_relat` DISABLE KEYS */;
INSERT INTO `sys_role_resource_relat` VALUES ('00716df3-07ed-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105010600'),('0574d053-07e7-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103020300'),('0f931a5a-07f2-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105040100'),('1bdeaba6-07e9-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103010100'),('1bf28a08-07e7-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103020400'),('1c3118cc-07e2-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103030400'),('25167037-07f2-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105040200'),('33bb66bb-07e9-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103010200'),('3d23d85e-07e7-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103020500'),('43ad40d2-07f1-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105020510'),('48463b39-07e9-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103010300'),('5a7db1f7-07f1-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105020520'),('60700eba-1fed-11e7-9677-a0c58951c8d5','vertex_root_join_sysadmin','1101000000'),('607033cf-1fed-11e7-9677-a0c58951c8d5','vertex_root_join_sysadmin','1100000000'),('6070454b-1fed-11e7-9677-a0c58951c8d5','vertex_root_join_sysadmin','1101010000'),('6a935ea9-1fed-11e7-9677-a0c58951c8d5','vertex_root_join_sysadmin','1102000000'),('6bb7e04d-07e9-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103010400'),('6c7f6d2a-250a-11e7-9c7e-a0c58951c8d5','vertex_root_join_sysadmin','01030104001'),('7d73294c-07ec-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105010100'),('8024c16b-07d8-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0104010300'),('8ca4f732-07e5-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0101010200'),('9466d2dc-07d5-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0104010200'),('970569ee-07d8-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0104010400'),('974d1286-07ec-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105010200'),('a0e2a82e-20f8-11e7-966c-a0c58951c8d5','vertex_root_join_sysadmin','1101020000'),('a2658092-07ed-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105020100'),('a2a01355-07e5-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0101010300'),('ad3e53ed-07d8-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0104010500'),('b5801636-07ec-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105010300'),('b8df3b71-07e9-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103010500'),('bd267b0e-07ed-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105020200'),('becdf6e3-0eb9-11e7-9612-a0c58951c8d5','vertex_root_join_sysadmin','0101010100'),('c1177dbf-07e1-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103030100'),('c3baf059-07ee-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105020500'),('c988dc67-07ec-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105010400'),('d517d48d-07ed-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105020300'),('d8fd37ed-07e1-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103030200'),('daae0b92-07e6-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103020100'),('ea23a4e6-07ed-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105020400'),('ec5e6b47-07ec-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0105010500'),('ee768238-07e6-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103020200'),('f0766b0d-c597-11e6-9b11-d4bed967cdff','vertex_root_join_sysadmin','0100000000'),('f07680fd-c597-11e6-9b11-d4bed967cdff','vertex_root_join_sysadmin','0101000000'),('f076a4d5-c597-11e6-9b11-d4bed967cdff','vertex_root_join_sysadmin','0103000000'),('f076b2d1-c597-11e6-9b11-d4bed967cdff','vertex_root_join_sysadmin','0103010000'),('f076c09b-c597-11e6-9b11-d4bed967cdff','vertex_root_join_sysadmin','0103020000'),('f076e3ca-c597-11e6-9b11-d4bed967cdff','vertex_root_join_sysadmin','0104010000'),('f076efb4-c597-11e6-9b11-d4bed967cdff','vertex_root_join_sysadmin','0105000000'),('f076fb82-c597-11e6-9b11-d4bed967cdff','vertex_root_join_sysadmin','0105010000'),('f077074b-c597-11e6-9b11-d4bed967cdff','vertex_root_join_sysadmin','0105020000'),('f0771e6b-c597-11e6-9b11-d4bed967cdf1','vertex_root_join_sysadmin','0101010000'),('f0771e6b-c597-11e6-9b11-d4bed967cdff','vertex_root_join_sysadmin','0105040000'),('f2e86103-07d2-11e7-95d9-a0c58951c8d5','vertex_root_join_sysadmin','0104010100'),('fb9787a0-07e1-11e7-952f-a0c58951c8d5','vertex_root_join_sysadmin','0103030300'),('mas__hzwy23__etladmin__hzwy23__0100000000','mas__hzwy23__etladmin','0100000000'),('mas__hzwy23__etladmin__hzwy23__0101000000','mas__hzwy23__etladmin','0101000000'),('mas__hzwy23__etladmin__hzwy23__0101010000','mas__hzwy23__etladmin','0101010000'),('mas__hzwy23__etladmin__hzwy23__0101010100','mas__hzwy23__etladmin','0101010100'),('mas__hzwy23__etladmin__hzwy23__0101010200','mas__hzwy23__etladmin','0101010200'),('mas__hzwy23__etladmin__hzwy23__0101010300','mas__hzwy23__etladmin','0101010300'),('mas__hzwy23__etladmin__hzwy23__0103000000','mas__hzwy23__etladmin','0103000000'),('mas__hzwy23__etladmin__hzwy23__0103010000','mas__hzwy23__etladmin','0103010000'),('mas__hzwy23__etladmin__hzwy23__0103010100','mas__hzwy23__etladmin','0103010100'),('mas__hzwy23__etladmin__hzwy23__0103010200','mas__hzwy23__etladmin','0103010200'),('mas__hzwy23__etladmin__hzwy23__0103010300','mas__hzwy23__etladmin','0103010300'),('mas__hzwy23__etladmin__hzwy23__0103010400','mas__hzwy23__etladmin','0103010400'),('mas__hzwy23__etladmin__hzwy23__01030104001','mas__hzwy23__etladmin','01030104001'),('mas__hzwy23__etladmin__hzwy23__0103010500','mas__hzwy23__etladmin','0103010500'),('mas__hzwy23__etladmin__hzwy23__0103020000','mas__hzwy23__etladmin','0103020000'),('mas__hzwy23__etladmin__hzwy23__0103020100','mas__hzwy23__etladmin','0103020100'),('mas__hzwy23__etladmin__hzwy23__0103020200','mas__hzwy23__etladmin','0103020200'),('mas__hzwy23__etladmin__hzwy23__0103020300','mas__hzwy23__etladmin','0103020300'),('mas__hzwy23__etladmin__hzwy23__0103020400','mas__hzwy23__etladmin','0103020400'),('mas__hzwy23__etladmin__hzwy23__0103020500','mas__hzwy23__etladmin','0103020500'),('mas__hzwy23__etladmin__hzwy23__0103030100','mas__hzwy23__etladmin','0103030100'),('mas__hzwy23__etladmin__hzwy23__0103030200','mas__hzwy23__etladmin','0103030200'),('mas__hzwy23__etladmin__hzwy23__0103030300','mas__hzwy23__etladmin','0103030300'),('mas__hzwy23__etladmin__hzwy23__0103030400','mas__hzwy23__etladmin','0103030400'),('mas__hzwy23__etladmin__hzwy23__0104010000','mas__hzwy23__etladmin','0104010000'),('mas__hzwy23__etladmin__hzwy23__0104010100','mas__hzwy23__etladmin','0104010100'),('mas__hzwy23__etladmin__hzwy23__0104010200','mas__hzwy23__etladmin','0104010200'),('mas__hzwy23__etladmin__hzwy23__0104010300','mas__hzwy23__etladmin','0104010300'),('mas__hzwy23__etladmin__hzwy23__0104010400','mas__hzwy23__etladmin','0104010400'),('mas__hzwy23__etladmin__hzwy23__0104010500','mas__hzwy23__etladmin','0104010500'),('mas__hzwy23__etladmin__hzwy23__0105000000','mas__hzwy23__etladmin','0105000000'),('mas__hzwy23__etladmin__hzwy23__0105010000','mas__hzwy23__etladmin','0105010000'),('mas__hzwy23__etladmin__hzwy23__0105010100','mas__hzwy23__etladmin','0105010100'),('mas__hzwy23__etladmin__hzwy23__0105010200','mas__hzwy23__etladmin','0105010200'),('mas__hzwy23__etladmin__hzwy23__0105010300','mas__hzwy23__etladmin','0105010300'),('mas__hzwy23__etladmin__hzwy23__0105010400','mas__hzwy23__etladmin','0105010400'),('mas__hzwy23__etladmin__hzwy23__0105010500','mas__hzwy23__etladmin','0105010500'),('mas__hzwy23__etladmin__hzwy23__0105010600','mas__hzwy23__etladmin','0105010600'),('mas__hzwy23__etladmin__hzwy23__0105020000','mas__hzwy23__etladmin','0105020000'),('mas__hzwy23__etladmin__hzwy23__0105020100','mas__hzwy23__etladmin','0105020100'),('mas__hzwy23__etladmin__hzwy23__0105020200','mas__hzwy23__etladmin','0105020200'),('mas__hzwy23__etladmin__hzwy23__0105020300','mas__hzwy23__etladmin','0105020300'),('mas__hzwy23__etladmin__hzwy23__0105020400','mas__hzwy23__etladmin','0105020400'),('mas__hzwy23__etladmin__hzwy23__0105020500','mas__hzwy23__etladmin','0105020500'),('mas__hzwy23__etladmin__hzwy23__0105020510','mas__hzwy23__etladmin','0105020510'),('mas__hzwy23__etladmin__hzwy23__0105020520','mas__hzwy23__etladmin','0105020520'),('mas__hzwy23__etladmin__hzwy23__0105040000','mas__hzwy23__etladmin','0105040000'),('mas__hzwy23__etladmin__hzwy23__0105040100','mas__hzwy23__etladmin','0105040100'),('mas__hzwy23__etladmin__hzwy23__0105040200','mas__hzwy23__etladmin','0105040200'),('mas__hzwy23__etladmin__hzwy23__1100000000','mas__hzwy23__etladmin','1100000000'),('mas__hzwy23__etladmin__hzwy23__1101000000','mas__hzwy23__etladmin','1101000000'),('mas__hzwy23__etladmin__hzwy23__1101010000','mas__hzwy23__etladmin','1101010000'),('mas__hzwy23__etladmin__hzwy23__1101020000','mas__hzwy23__etladmin','1101020000'),('mas__hzwy23__etladmin__hzwy23__1102000000','mas__hzwy23__etladmin','1102000000');
/*!40000 ALTER TABLE `sys_role_resource_relat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_status_attr`
--

DROP TABLE IF EXISTS `sys_role_status_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_status_attr` (
  `role_status_id` char(1) NOT NULL,
  `role_status_desc` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`role_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_status_attr`
--

LOCK TABLES `sys_role_status_attr` WRITE;
/*!40000 ALTER TABLE `sys_role_status_attr` DISABLE KEYS */;
INSERT INTO `sys_role_status_attr` VALUES ('0','正常'),('1','锁定'),('2','失效');
/*!40000 ALTER TABLE `sys_role_status_attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_user_relation`
--

DROP TABLE IF EXISTS `sys_role_user_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_user_relation` (
  `uuid` varchar(60) NOT NULL,
  `role_id` varchar(66) DEFAULT NULL,
  `user_id` varchar(30) DEFAULT NULL,
  `maintance_date` date DEFAULT NULL,
  `maintance_user` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `fk_sys_idx_03` (`user_id`),
  KEY `fk_sys_role_user_01_idx` (`role_id`),
  CONSTRAINT `fk_sys_idx_03` FOREIGN KEY (`user_id`) REFERENCES `sys_user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sys_role_user_01` FOREIGN KEY (`role_id`) REFERENCES `sys_role_info` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_user_relation`
--

LOCK TABLES `sys_role_user_relation` WRITE;
/*!40000 ALTER TABLE `sys_role_user_relation` DISABLE KEYS */;
INSERT INTO `sys_role_user_relation` VALUES ('19890228hzwy23','vertex_root_join_sysadmin','admin','2000-01-01','hzwy23'),('caadmin__hzwy23__mas__hzwy23__etladmin','mas__hzwy23__etladmin','caadmin','2017-06-21','caadmin'),('demo__hzwy23__mas__hzwy23__etladmin','mas__hzwy23__etladmin','demo','2017-06-21','caadmin');
/*!40000 ALTER TABLE `sys_role_user_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_sec_user`
--

DROP TABLE IF EXISTS `sys_sec_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_sec_user` (
  `user_id` varchar(30) NOT NULL,
  `user_passwd` varchar(30) DEFAULT NULL,
  `status_id` char(1) DEFAULT NULL,
  `continue_error_cnt` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_sys_idx_02` (`status_id`),
  CONSTRAINT `fk_sys_idx_01` FOREIGN KEY (`user_id`) REFERENCES `sys_user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sys_idx_02` FOREIGN KEY (`status_id`) REFERENCES `sys_user_status_attr` (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_sec_user`
--

LOCK TABLES `sys_sec_user` WRITE;
/*!40000 ALTER TABLE `sys_sec_user` DISABLE KEYS */;
INSERT INTO `sys_sec_user` VALUES ('admin','rVbaiQ3XuCj8aCnhIL1KAA==','0',0),('caadmin','CguSVgQY2Df4LxG0UT/xwA==','0',0),('demo','CguSVgQY2Df4LxG0UT/xwA==','0',0);
/*!40000 ALTER TABLE `sys_sec_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_theme_info`
--

DROP TABLE IF EXISTS `sys_theme_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_theme_info` (
  `theme_id` varchar(30) NOT NULL,
  `theme_desc` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_theme_info`
--

LOCK TABLES `sys_theme_info` WRITE;
/*!40000 ALTER TABLE `sys_theme_info` DISABLE KEYS */;
INSERT INTO `sys_theme_info` VALUES ('1001','绿色主题'),('1002','深蓝主题'),('1003','粉色主题'),('1004','青色主题');
/*!40000 ALTER TABLE `sys_theme_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_theme_value`
--

DROP TABLE IF EXISTS `sys_theme_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_theme_value` (
  `uuid` varchar(60) NOT NULL,
  `theme_id` varchar(30) DEFAULT NULL,
  `res_id` varchar(30) DEFAULT NULL,
  `res_url` varchar(120) DEFAULT NULL,
  `res_type` varchar(5) DEFAULT NULL,
  `res_bg_color` varchar(30) DEFAULT NULL,
  `res_class` varchar(90) DEFAULT NULL,
  `group_id` char(1) DEFAULT NULL,
  `res_img` varchar(200) DEFAULT NULL,
  `sort_id` decimal(10,0) DEFAULT NULL,
  KEY `pk_sys_theme_value_01` (`uuid`),
  KEY `fk_sys_theme_value01_idx` (`res_id`),
  CONSTRAINT `fk_sys_theme_value01` FOREIGN KEY (`res_id`) REFERENCES `sys_resource_info` (`res_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_theme_value`
--

LOCK TABLES `sys_theme_value` WRITE;
/*!40000 ALTER TABLE `sys_theme_value` DISABLE KEYS */;
INSERT INTO `sys_theme_value` VALUES ('1001-0101010000','1001','0101010000','/v1/auth/HandleLogsPage','0','#336699','tile tile-large','3','/static/images/hauth/logs_shen.png',1),('1001-0103010000','1001','0103010000','/v1/auth/resource/page','0','#666699','tile','1','/static/images/hauth/menus.png',3),('1001-0104010000','1001','0104010000','/v1/auth/domain/page','0','#0099CC','tile tile-wide','1','/static/images/hauth/domain.png',1),('1001-0105010000','1001','0105010000','/v1/auth/user/page','0','#CC6600','tile tile-wide','2','/static/images/hauth/user_manager.png',1),('1001-0105020000','1001','0105020000','/v1/auth/role/page','0','#FFCC33','tile','2','/static/images/hauth/role_manager.png',2),('1001-0100000000','1001','0100000000','./views/hauth/theme/default/sysconfig.tpl','0','#FF6600','tile tile-wide','1','/static/images/hauth/system.png',1),('1001-0105040000','1001','0105040000','/v1/auth/batch/page','0','#339999','tile','2','/static/images/hauth/grant.png',4),('1001-0103020000','1001','0103020000','/v1/auth/resource/org/page','0','#FF6666','tile','1','/static/images/hauth/org.png',2),('948f67dc-024a-11e7-9b60-a0c58951c8d5','1001','1100000000','./views/help/default/syshelp.tpl','0','#0099CC','tile tile-wide','3','/static/images/hauth/help.png',1),('624b90c0-0278-11e7-9b60-a0c58951c8d5','1002','0101010000','/v1/auth/HandleLogsPage','0','#336699','tile tile-large','3','/static/images/hauth/logs_shen.png',1),('f2e81083-07d2-11e7-95d9-a0c58951c8d5','1001','0104010100','/v1/auth/domain/get','0','','','','',0),('946658e9-07d5-11e7-952f-a0c58951c8d5','1001','0104010200','/v1/auth/domain/share/page','0','','','','',0),('8024ac09-07d8-11e7-952f-a0c58951c8d5','1001','0104010300','/v1/auth/domain/update','0','','','','',0),('9705437b-07d8-11e7-952f-a0c58951c8d5','1001','0104010400','/v1/auth/domain/delete','0','','','','',0),('ad3e295c-07d8-11e7-952f-a0c58951c8d5','1001','0104010500','/v1/auth/domain/post','0','','','','',0),('c1174621-07e1-11e7-952f-a0c58951c8d5','1001','0103030100','/v1/auth/domain/share/get','0','','','','',0),('d8fccbcb-07e1-11e7-952f-a0c58951c8d5','1001','0103030200','/v1/auth/domain/share/post','0','','','','',0),('fb975107-07e1-11e7-952f-a0c58951c8d5','1001','0103030300','/v1/auth/domain/share/delete','0','','','','',0),('1c30f988-07e2-11e7-952f-a0c58951c8d5','1001','0103030400','/v1/auth/domain/share/put','0','','','','',0),('8ca386d8-07e5-11e7-952f-a0c58951c8d5','1001','0101010200','/v1/auth/handle/logs/download','0','','','','',0),('a29fba3f-07e5-11e7-952f-a0c58951c8d5','1001','0101010300','/v1/auth/handle/logs/search','0','','','','',0),('daadf91b-07e6-11e7-952f-a0c58951c8d5','1001','0103020100','/v1/auth/resource/org/get','0','','','','',0),('ee765e9a-07e6-11e7-952f-a0c58951c8d5','1001','0103020200','/v1/auth/resource/org/insert','0','','','','',0),('0574add7-07e7-11e7-952f-a0c58951c8d5','1001','0103020300','/v1/auth/resource/org/update','0','','','','',0),('1bf270aa-07e7-11e7-952f-a0c58951c8d5','1001','0103020400','/v1/auth/resource/org/delete','0','','','','',0),('3d237ba7-07e7-11e7-952f-a0c58951c8d5','1001','0103020500','/v1/auth/resource/org/download','0','','','','',0),('1bde8991-07e9-11e7-952f-a0c58951c8d5','1001','0103010100','/v1/auth/resource/get','0','','','','',0),('33b9cb0c-07e9-11e7-952f-a0c58951c8d5','1001','0103010200','/v1/auth/resource/post','0','','','','',0),('48460086-07e9-11e7-952f-a0c58951c8d5','1001','0103010300','/v1/auth/resource/update','0','','','','',0),('6bb7b2c8-07e9-11e7-952f-a0c58951c8d5','1001','0103010400','/v1/auth/resource/delete','0','','','','',0),('b8df0cd7-07e9-11e7-952f-a0c58951c8d5','1001','0103010500','/v1/auth/resource/config/theme','0','','','','',0),('7d73058c-07ec-11e7-952f-a0c58951c8d5','1001','0105010100','/v1/auth/user/get','0','','','','',0),('974ce1fd-07ec-11e7-952f-a0c58951c8d5','1001','0105010200','/v1/auth/user/post','0','','','','',0),('b58002f6-07ec-11e7-952f-a0c58951c8d5','1001','0105010300','/v1/auth/user/put','0','','','','',0),('c988bb89-07ec-11e7-952f-a0c58951c8d5','1001','0105010400','/v1/auth/user/delete','0','','','','',0),('ec5cb33a-07ec-11e7-952f-a0c58951c8d5','1001','0105010500','/v1/auth/user/modify/passwd','0','','','','',0),('00714873-07ed-11e7-952f-a0c58951c8d5','1001','0105010600','/v1/auth/user/modify/status','0','','','','',0),('a265597d-07ed-11e7-952f-a0c58951c8d5','1001','0105020100','/v1/auth/role/get','0','','','','',0),('bd264fd7-07ed-11e7-952f-a0c58951c8d5','1001','0105020200','/v1/auth/role/post','0','','','','',0),('d517aab8-07ed-11e7-952f-a0c58951c8d5','1001','0105020300','/v1/auth/role/update','0','','','','',0),('ea237b6a-07ed-11e7-952f-a0c58951c8d5','1001','0105020400','/v1/auth/role/delete','0','','','','',0),('c3bad47b-07ee-11e7-952f-a0c58951c8d5','1001','0105020500','/v1/auth/role/resource/details','0','','','','',0),('43ad2a9a-07f1-11e7-952f-a0c58951c8d5','1001','0105020510','/v1/auth/role/resource/get','0','','','','',0),('5a7d8dbf-07f1-11e7-952f-a0c58951c8d5','1001','0105020520','/v1/auth/role/resource/rights','0','','','','',0),('0f9303e2-07f2-11e7-952f-a0c58951c8d5','1001','0105040100','/v1/auth/user/roles/auth','0','','','','',0),('25165700-07f2-11e7-952f-a0c58951c8d5','1001','0105040200','/v1/auth/user/roles/revoke','0','','','','',0),('f87a9123-0991-11e7-952f-a0c58951c8d5','1001','1101010000','/v1/help/system/help','0','#339999','tile tile-wide','1','/static/images/hauth/sys_help.png',1),('991641c3-0d55-11e7-964b-a0c58951c8d5','1004','0101010000','/v1/auth/HandleLogsPage','0','#336699','tile tile-large','3','/static/images/hauth/logs_shen.png',1),('99164f5c-0d55-11e7-964b-a0c58951c8d5','1004','0103010000','/v1/auth/resource/page','0','#666699','tile','1','/static/images/hauth/menus.png',3),('9916502d-0d55-11e7-964b-a0c58951c8d5','1004','0104010000','/v1/auth/domain/page','0','#0099CC','tile tile-wide','1','/static/images/hauth/domain.png',1),('991650a9-0d55-11e7-964b-a0c58951c8d5','1004','0105010000','/v1/auth/user/page','0','#CC6600','tile tile-wide','2','/static/images/hauth/user_manager.png',1),('9916512d-0d55-11e7-964b-a0c58951c8d5','1004','0105020000','/v1/auth/role/page','0','#FFCC33','tile','2','/static/images/hauth/role_manager.png',2),('9916519c-0d55-11e7-964b-a0c58951c8d5','1004','0100000000','./views/hauth/theme/cyan/sysconfig.tpl','0','#FF6600','tile tile-wide','1','/static/images/hauth/system.png',1),('99165203-0d55-11e7-964b-a0c58951c8d5','1004','0105040000','/v1/auth/batch/page','0','#339999','tile','2','/static/images/hauth/grant.png',4),('9916525c-0d55-11e7-964b-a0c58951c8d5','1004','0103020000','/v1/auth/resource/org/page','0','#FF6666','tile','1','/static/images/hauth/org.png',2),('9917f6e5-0d55-11e7-964b-a0c58951c8d5','1004','1100000000','./views/help/default/syshelp.tpl','0','#0099CC','tile tile-wide','3','/static/images/hauth/help.png',1),('99180d65-0d55-11e7-964b-a0c58951c8d5','1004','0104010100','/v1/auth/domain/get','0','','','','',0),('99180da1-0d55-11e7-964b-a0c58951c8d5','1004','0104010200','/v1/auth/domain/share/page','0','','','','',0),('99180ddc-0d55-11e7-964b-a0c58951c8d5','1004','0104010300','/v1/auth/domain/update','0','','','','',0),('99180e14-0d55-11e7-964b-a0c58951c8d5','1004','0104010400','/v1/auth/domain/delete','0','','','','',0),('99180e4f-0d55-11e7-964b-a0c58951c8d5','1004','0104010500','/v1/auth/domain/post','0','','','','',0),('99180e87-0d55-11e7-964b-a0c58951c8d5','1004','0103030100','/v1/auth/domain/share/get','0','','','','',0),('99180ec3-0d55-11e7-964b-a0c58951c8d5','1004','0103030200','/v1/auth/domain/share/post','0','','','','',0),('99180efa-0d55-11e7-964b-a0c58951c8d5','1004','0103030300','/v1/auth/domain/share/delete','0','','','','',0),('99180f32-0d55-11e7-964b-a0c58951c8d5','1004','0103030400','/v1/auth/domain/share/put','0','','','','',0),('99180fa1-0d55-11e7-964b-a0c58951c8d5','1004','0101010200','/v1/auth/handle/logs/download','0','','','','',0),('99180fdc-0d55-11e7-964b-a0c58951c8d5','1004','0101010300','/v1/auth/handle/logs/search','0','','','','',0),('99181014-0d55-11e7-964b-a0c58951c8d5','1004','0103020100','/v1/auth/resource/org/get','0','','','','',0),('9918104b-0d55-11e7-964b-a0c58951c8d5','1004','0103020200','/v1/auth/resource/org/insert','0','','','','',0),('99181087-0d55-11e7-964b-a0c58951c8d5','1004','0103020300','/v1/auth/resource/org/update','0','','','','',0),('991810be-0d55-11e7-964b-a0c58951c8d5','1004','0103020400','/v1/auth/resource/org/delete','0','','','','',0),('991810fe-0d55-11e7-964b-a0c58951c8d5','1004','0103020500','/v1/auth/resource/org/download','0','','','','',0),('9918113a-0d55-11e7-964b-a0c58951c8d5','1004','0103010100','/v1/auth/resource/get','0','','','','',0),('99181176-0d55-11e7-964b-a0c58951c8d5','1004','0103010200','/v1/auth/resource/post','0','','','','',0),('991811ad-0d55-11e7-964b-a0c58951c8d5','1004','0103010300','/v1/auth/resource/update','0','','','','',0),('991811e1-0d55-11e7-964b-a0c58951c8d5','1004','0103010400','/v1/auth/resource/delete','0','','','','',0),('99181218-0d55-11e7-964b-a0c58951c8d5','1004','0103010500','/v1/auth/resource/config/theme','0','','','','',0),('9918124f-0d55-11e7-964b-a0c58951c8d5','1004','0105010100','/v1/auth/user/get','0','','','','',0),('9918128b-0d55-11e7-964b-a0c58951c8d5','1004','0105010200','/v1/auth/user/post','0','','','','',0),('991812c3-0d55-11e7-964b-a0c58951c8d5','1004','0105010300','/v1/auth/user/put','0','','','','',0),('991812fa-0d55-11e7-964b-a0c58951c8d5','1004','0105010400','/v1/auth/user/delete','0','','','','',0),('99181332-0d55-11e7-964b-a0c58951c8d5','1004','0105010500','/v1/auth/user/modify/passwd','0','','','','',0),('99181365-0d55-11e7-964b-a0c58951c8d5','1004','0105010600','/v1/auth/user/modify/status','0','','','','',0),('9918139c-0d55-11e7-964b-a0c58951c8d5','1004','0105020100','/v1/auth/role/get','0','','','','',0),('991813d4-0d55-11e7-964b-a0c58951c8d5','1004','0105020200','/v1/auth/role/post','0','','','','',0),('9918140b-0d55-11e7-964b-a0c58951c8d5','1004','0105020300','/v1/auth/role/update','0','','','','',0),('99181443-0d55-11e7-964b-a0c58951c8d5','1004','0105020400','/v1/auth/role/delete','0','','','','',0),('99181476-0d55-11e7-964b-a0c58951c8d5','1004','0105020500','/v1/auth/role/resource/details','0','','','','',0),('991814ad-0d55-11e7-964b-a0c58951c8d5','1004','0105020510','/v1/auth/role/resource/get','0','','','','',0),('991814f2-0d55-11e7-964b-a0c58951c8d5','1004','0105020520','/v1/auth/role/resource/rights','0','','','','',0),('9918152d-0d55-11e7-964b-a0c58951c8d5','1004','0105040100','/v1/auth/user/roles/auth','0','','','','',0),('99181569-0d55-11e7-964b-a0c58951c8d5','1004','0105040200','/v1/auth/user/roles/revoke','0','','','','',0),('991815e1-0d55-11e7-964b-a0c58951c8d5','1004','1101010000','/v1/help/system/help','0','#339999','tile tile-wide','1','/static/images/hauth/sys_help.png',1),('becde5db-0eb9-11e7-9612-a0c58951c8d5','1001','0101010100','/v1/auth/handle/logs','0','','','','',0),('8e2d2ae7-1c0a-11e7-9d82-a0c58951c8d5','1004','0101010100','/v1/auth/handle/logs','0','','tile tile-large','','',0),('a0e208f2-20f8-11e7-966c-a0c58951c8d5','1001','1101020000','/swagger-ui.html','1','#339999','tile tile-wide','2','/static/images/hauth/api.png',1),('b3f18e0b-20f8-11e7-966c-a0c58951c8d5','1004','1101020000','/swagger-ui.html','1','#339999','tile tile-wide','2','/static/images/hauth/api.png',1),('6c7f5772-250a-11e7-9c7e-a0c58951c8d5','1001','01030104001','/v1/auth/resource/org/page','','','','','',0),('9b081aec-2b27-11e7-9c7e-a0c58951c8d5','1002','0100000000','./views/hauth/theme/blue/sysconfig.tpl','0','#FF6600','tile tile-wide','1','/static/images/hauth/system.png',1),('a343cbfc-2b27-11e7-9c7e-a0c58951c8d5','1002','0101010100','/v1/auth/handle/logs','0','','tile','','',0),('a65d91b0-2b27-11e7-9c7e-a0c58951c8d5','1002','0101010200','/v1/auth/handle/logs/download','0','','tile','','',0),('a8854ec0-2b27-11e7-9c7e-a0c58951c8d5','1002','0101010300','/v1/auth/handle/logs/search','0','','tile','','',0),('aabbbd36-2b27-11e7-9c7e-a0c58951c8d5','1002','01030104001','/v1/auth/resource/org/page','0','','tile','','',0),('af0e054c-2b27-11e7-9c7e-a0c58951c8d5','1002','0103010000','/v1/auth/resource/page','0','#666699','tile','1','/static/images/hauth/menus.png',3),('b1314131-2b27-11e7-9c7e-a0c58951c8d5','1002','0103010100','/v1/auth/resource/get','0','','tile','','',0),('b3c7c6a6-2b27-11e7-9c7e-a0c58951c8d5','1002','0103010200','/v1/auth/resource/post','0','','tile','','',0),('b6372ff3-2b27-11e7-9c7e-a0c58951c8d5','1002','0103010300','/v1/auth/resource/update','0','','tile','','',0),('b8d3d1c1-2b27-11e7-9c7e-a0c58951c8d5','1002','0103010400','/v1/auth/resource/delete','0','','tile','','',0),('bb9fc76f-2b27-11e7-9c7e-a0c58951c8d5','1002','0103010500','/v1/auth/resource/config/theme','0','','tile','','',0),('bea9df22-2b27-11e7-9c7e-a0c58951c8d5','1002','0103020100','/v1/auth/resource/org/get','0','','tile','','',0),('c15e0f8b-2b27-11e7-9c7e-a0c58951c8d5','1002','0103020200','/v1/auth/resource/org/insert','0','','tile','','',0),('c37806f8-2b27-11e7-9c7e-a0c58951c8d5','1002','0103020300','/v1/auth/resource/org/update','0','','tile','','',0),('c59c3303-2b27-11e7-9c7e-a0c58951c8d5','1002','0103020400','/v1/auth/resource/org/delete','0','','tile','','',0),('c77c6ed0-2b27-11e7-9c7e-a0c58951c8d5','1002','0103020500','/v1/auth/resource/org/download','0','','tile','','',0),('cc8891d2-2b27-11e7-9c7e-a0c58951c8d5','1002','0103020000','/v1/auth/resource/org/page','0','#FF6666','tile','1','/static/images/hauth/org.png',2),('d1f01d28-2b27-11e7-9c7e-a0c58951c8d5','1002','0104010000','/v1/auth/domain/page','0','#0099CC','tile tile-wide','1','/static/images/hauth/domain.png',1),('d4bfa83c-2b27-11e7-9c7e-a0c58951c8d5','1002','0104010100','/v1/auth/domain/get','0','','tile','','',0),('d767f63e-2b27-11e7-9c7e-a0c58951c8d5','1002','0104010200','/v1/auth/domain/share/page','0','','tile','','',0),('da84a5e1-2b27-11e7-9c7e-a0c58951c8d5','1002','0103030100','/v1/auth/domain/share/get','0','','tile','','',0),('dc65642a-2b27-11e7-9c7e-a0c58951c8d5','1002','0103030200','/v1/auth/domain/share/post','0','','tile','','',0),('de8f9fcb-2b27-11e7-9c7e-a0c58951c8d5','1002','0103030300','/v1/auth/domain/share/delete','0','','tile','','',0),('e0a10dc4-2b27-11e7-9c7e-a0c58951c8d5','1002','0103030400','/v1/auth/domain/share/put','0','','tile','','',0),('e2e782c4-2b27-11e7-9c7e-a0c58951c8d5','1002','0104010300','/v1/auth/domain/update','0','','tile','','',0),('e4e17463-2b27-11e7-9c7e-a0c58951c8d5','1002','0104010400','/v1/auth/domain/delete','0','','tile','','',0),('e777d2c2-2b27-11e7-9c7e-a0c58951c8d5','1002','0104010500','/v1/auth/domain/post','0','','tile','','',0),('eb13f0e9-2b27-11e7-9c7e-a0c58951c8d5','1002','0105010100','/v1/auth/user/get','0','','tile','','',0),('ed148f2a-2b27-11e7-9c7e-a0c58951c8d5','1002','0105010200','/v1/auth/user/post','0','','tile','','',0),('ef613f0c-2b27-11e7-9c7e-a0c58951c8d5','1002','0105010300','/v1/auth/user/put','0','','tile','','',0),('f19af335-2b27-11e7-9c7e-a0c58951c8d5','1002','0105010400','/v1/auth/user/delete','0','','tile','','',0),('f3959708-2b27-11e7-9c7e-a0c58951c8d5','1002','0105010500','/v1/auth/user/modify/passwd','0','','tile','','',0),('f5a0999f-2b27-11e7-9c7e-a0c58951c8d5','1002','0105010600','/v1/auth/user/modify/status','0','','tile','','',0),('f94b4a93-2b27-11e7-9c7e-a0c58951c8d5','1002','0105020100','/v1/auth/role/get','0','','tile','','',0),('fbcd8b0b-2b27-11e7-9c7e-a0c58951c8d5','1002','0105020000','/v1/auth/role/page','0','#FFCC33','tile','2','/static/images/hauth/role_manager.png',2),('fdb44348-2b27-11e7-9c7e-a0c58951c8d5','1002','0105020200','/v1/auth/role/post','0','','tile','','',0),('ff9f6773-2b27-11e7-9c7e-a0c58951c8d5','1002','0105020300','/v1/auth/role/update','0','','tile','','',0),('0287ee48-2b28-11e7-9c7e-a0c58951c8d5','1002','0105020400','/v1/auth/role/delete','0','','tile','','',0),('052dc4ac-2b28-11e7-9c7e-a0c58951c8d5','1002','0105020500','/v1/auth/role/resource/details','0','','tile','','',0),('0875a5f3-2b28-11e7-9c7e-a0c58951c8d5','1002','0105020510','/v1/auth/role/resource/get','0','','tile','','',0),('0a964ef9-2b28-11e7-9c7e-a0c58951c8d5','1002','0105020520','/v1/auth/role/resource/rights','0','','tile','','',0),('0e4ca28b-2b28-11e7-9c7e-a0c58951c8d5','1002','0105040000','/v1/auth/batch/page','0','#339999','tile','2','/static/images/hauth/grant.png',4),('107e273d-2b28-11e7-9c7e-a0c58951c8d5','1002','0105040100','/v1/auth/user/roles/auth','0','','tile','','',0),('12cd5409-2b28-11e7-9c7e-a0c58951c8d5','1002','0105040200','/v1/auth/user/roles/revoke','0','','tile','','',0),('51a5bff2-2b28-11e7-9c7e-a0c58951c8d5','1002','0105010000','/v1/auth/user/page','0','#CC6600','tile tile-wide','2','/static/images/hauth/user_manager.png',1),('4fd8fdcf-2b42-11e7-9c7e-a0c58951c8d5','1002','1100000000','./views/help/default/syshelp.tpl','0','#0099CC','tile tile-wide','3','/static/images/hauth/help.png',1),('5dcfdfc0-2b42-11e7-9c7e-a0c58951c8d5','1002','1101010000','/v1/help/system/help','0','#339999','tile tile-wide','1','/static/images/hauth/sys_help.png',1),('60c6e788-2b42-11e7-9c7e-a0c58951c8d5','1002','1101020000','/swagger-ui.html','1','#339999','tile tile-wide','2','/static/images/hauth/api.png',1),('d4605f79-2b43-11e7-9c7e-a0c58951c8d5','1003','0100000000','./views/hauth/theme/apple/sysconfig.tpl','0','#FF6600','tile tile-wide','1','/static/images/hauth/system.png',1),('d7867a7a-2b43-11e7-9c7e-a0c58951c8d5','1003','0101010000','/v1/auth/HandleLogsPage','0','#336699','tile tile-large','3','/static/images/hauth/logs_shen.png',1),('dd972a84-2b43-11e7-9c7e-a0c58951c8d5','1003','0103010000','/v1/auth/resource/page','0','#666699','tile','1','/static/images/hauth/menus.png',3),('e007d284-2b43-11e7-9c7e-a0c58951c8d5','1003','0103020000','/v1/auth/resource/org/page','0','#FF6666','tile','1','/static/images/hauth/org.png',2),('e224205c-2b43-11e7-9c7e-a0c58951c8d5','1003','0104010000','/v1/auth/domain/page','0','#0099CC','tile tile-wide','1','/static/images/hauth/domain.png',1),('e4ac3710-2b43-11e7-9c7e-a0c58951c8d5','1003','0105010000','/v1/auth/user/page','0','#CC6600','tile tile-wide','2','/static/images/hauth/user_manager.png',1),('e716b0a1-2b43-11e7-9c7e-a0c58951c8d5','1003','0105020000','/v1/auth/role/page','0','#FFCC33','tile','2','/static/images/hauth/role_manager.png',2),('ea4b0eda-2b43-11e7-9c7e-a0c58951c8d5','1003','0105040000','/v1/auth/batch/page','0','#339999','tile','2','/static/images/hauth/grant.png',4),('3403b3b7-2b44-11e7-9c7e-a0c58951c8d5','1003','1100000000','./views/help/default/syshelp.tpl','0','#0099CC','tile tile-wide','3','/static/images/hauth/help.png',1),('37ceac85-2b44-11e7-9c7e-a0c58951c8d5','1003','1101010000','/v1/help/system/help','0','#339999','tile tile-wide','1','/static/images/hauth/sys_help.png',1),('3a0e741e-2b44-11e7-9c7e-a0c58951c8d5','1003','1101020000','/swagger-ui.html','1','#339999','tile tile-wide','2','/static/images/hauth/api.png',1);
/*!40000 ALTER TABLE `sys_theme_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_info`
--

DROP TABLE IF EXISTS `sys_user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_info` (
  `user_id` varchar(30) NOT NULL,
  `user_name` varchar(300) DEFAULT NULL,
  `user_create_date` datetime DEFAULT NULL,
  `user_owner` varchar(30) DEFAULT NULL,
  `user_email` varchar(30) DEFAULT NULL,
  `user_phone` decimal(15,0) DEFAULT NULL,
  `org_unit_id` varchar(66) DEFAULT NULL,
  `user_maintance_date` datetime DEFAULT NULL,
  `user_maintance_user` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_sys_user_org_idx` (`org_unit_id`),
  CONSTRAINT `fk_sys_user_org` FOREIGN KEY (`org_unit_id`) REFERENCES `sys_org_info` (`org_unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_info`
--

LOCK TABLES `sys_user_info` WRITE;
/*!40000 ALTER TABLE `sys_user_info` DISABLE KEYS */;
INSERT INTO `sys_user_info` VALUES ('admin','超级管理员','2016-01-01 00:00:00','sys','hzwy23@sina.com',15684582156,'vertex_root_join_vertex_root','2016-12-19 13:34:32','sys'),('caadmin','CA业务管理员','2017-03-18 14:32:22','admin','hzwy23@sina.com',15684582156,'mas_join_34124','2017-03-18 14:32:22','admin'),('demo','演示账号','2017-03-01 21:21:38','admin','hzwy23@sina.com',18986110551,'mas_join_4542346','2017-04-24 20:53:42','admin');
/*!40000 ALTER TABLE `sys_user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_status_attr`
--

DROP TABLE IF EXISTS `sys_user_status_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_status_attr` (
  `status_id` char(1) NOT NULL,
  `status_desc` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_status_attr`
--

LOCK TABLES `sys_user_status_attr` WRITE;
/*!40000 ALTER TABLE `sys_user_status_attr` DISABLE KEYS */;
INSERT INTO `sys_user_status_attr` VALUES ('0','正常'),('1','锁定');
/*!40000 ALTER TABLE `sys_user_status_attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_theme`
--

DROP TABLE IF EXISTS `sys_user_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_theme` (
  `user_id` varchar(30) NOT NULL,
  `theme_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `pk_sys_user_theme_01` FOREIGN KEY (`user_id`) REFERENCES `sys_user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_theme`
--

LOCK TABLES `sys_user_theme` WRITE;
/*!40000 ALTER TABLE `sys_user_theme` DISABLE KEYS */;
INSERT INTO `sys_user_theme` VALUES ('admin','1002'),('caadmin','1002'),('demo','1001');
/*!40000 ALTER TABLE `sys_user_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hauth'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-12 23:26:01
