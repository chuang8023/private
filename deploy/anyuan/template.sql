-- MySQL dump 10.13  Distrib 5.6.33, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: proj_dlfxgkyhpc
-- ------------------------------------------------------
-- Server version	5.6.33-0ubuntu0.14.04.1

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
-- Table structure for table `ent_sys_file`
--

DROP TABLE IF EXISTS `ent_sys_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_sys_file` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `uid` varchar(30) DEFAULT NULL,
  `host` varchar(15) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `type` varchar(64) NOT NULL,
  `size` int(11) NOT NULL,
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `access` int(11) NOT NULL,
  `apps` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`fid`,`version`),
  KEY `folder_id` (`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_sys_file`
--

LOCK TABLES `ent_sys_file` WRITE;
/*!40000 ALTER TABLE `ent_sys_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_sys_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_sys_file_archive`
--

DROP TABLE IF EXISTS `ent_sys_file_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_sys_file_archive` (
  `fid` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `uid` varchar(30) DEFAULT NULL,
  `host` varchar(15) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `type` varchar(64) NOT NULL,
  `size` int(11) NOT NULL,
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `access` int(11) DEFAULT NULL,
  `apps` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`fid`,`version`),
  KEY `folder_id` (`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_sys_file_archive`
--

LOCK TABLES `ent_sys_file_archive` WRITE;
/*!40000 ALTER TABLE `ent_sys_file_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_sys_file_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_sys_file_delete`
--

DROP TABLE IF EXISTS `ent_sys_file_delete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_sys_file_delete` (
  `fid` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `uid` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `host` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `folder_id` int(11) NOT NULL,
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` int(11) NOT NULL,
  `size` int(11) NOT NULL,
  `apps` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `access` tinyint(4) NOT NULL,
  PRIMARY KEY (`fid`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_sys_file_delete`
--

LOCK TABLES `ent_sys_file_delete` WRITE;
/*!40000 ALTER TABLE `ent_sys_file_delete` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_sys_file_delete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_sys_file_foldername`
--

DROP TABLE IF EXISTS `ent_sys_file_foldername`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_sys_file_foldername` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `point` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `point` (`point`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_sys_file_foldername`
--

LOCK TABLES `ent_sys_file_foldername` WRITE;
/*!40000 ALTER TABLE `ent_sys_file_foldername` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_sys_file_foldername` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_analysis_permission_module`
--

DROP TABLE IF EXISTS `ent_template_analysis_permission_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_analysis_permission_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated_at` datetime NOT NULL,
  `app_type` varchar(16) NOT NULL,
  `app_id` varchar(64) NOT NULL,
  `access` text,
  PRIMARY KEY (`id`),
  KEY `app_type_id` (`app_type`,`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_analysis_permission_module`
--

LOCK TABLES `ent_template_analysis_permission_module` WRITE;
/*!40000 ALTER TABLE `ent_template_analysis_permission_module` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_analysis_permission_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_analysis`
--

DROP TABLE IF EXISTS `ent_template_app_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_analysis` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `app_type` varchar(255) NOT NULL COMMENT '应用类型',
  `app_id` varchar(255) NOT NULL COMMENT '应用id',
  `owner` varchar(40) NOT NULL COMMENT '拥有者',
  `title` varchar(40) NOT NULL COMMENT '标题',
  `is_default` tinyint(1) NOT NULL,
  `config` text NOT NULL COMMENT '配置',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `access` text NOT NULL COMMENT '删除(0:启用|1:删除)',
  PRIMARY KEY (`id`),
  KEY `app_type_id` (`app_type`,`app_id`),
  KEY `app_type_owner` (`app_type`,`app_id`,`owner`,`is_default`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_analysis`
--

LOCK TABLES `ent_template_app_analysis` WRITE;
/*!40000 ALTER TABLE `ent_template_app_analysis` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_analysis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_child_permission`
--

DROP TABLE IF EXISTS `ent_template_app_child_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_child_permission` (
  `app_id` int(11) NOT NULL COMMENT '应用id',
  `type` tinyint(1) NOT NULL DEFAULT '3' COMMENT '权限类型：1组织架构，2应用系统角色组，3继承上一级',
  `groups` text,
  UNIQUE KEY `app_id` (`app_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='子应用权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_child_permission`
--

LOCK TABLES `ent_template_app_child_permission` WRITE;
/*!40000 ALTER TABLE `ent_template_app_child_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_child_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_data_statistics`
--

DROP TABLE IF EXISTS `ent_template_app_data_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_data_statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(40) NOT NULL,
  `app_type` enum('workflow','dataflow') NOT NULL DEFAULT 'dataflow',
  `app_record` int(11) NOT NULL DEFAULT '-1',
  `owner` varchar(30) NOT NULL,
  `frequency` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app` (`app_id`,`app_type`,`app_record`,`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_data_statistics`
--

LOCK TABLES `ent_template_app_data_statistics` WRITE;
/*!40000 ALTER TABLE `ent_template_app_data_statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_data_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_group`
--

DROP TABLE IF EXISTS `ent_template_app_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) NOT NULL,
  `group_name` varchar(255) NOT NULL,
  `blacklist` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_group`
--

LOCK TABLES `ent_template_app_group` WRITE;
/*!40000 ALTER TABLE `ent_template_app_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_icon`
--

DROP TABLE IF EXISTS `ent_template_app_icon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_icon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_icon`
--

LOCK TABLES `ent_template_app_icon` WRITE;
/*!40000 ALTER TABLE `ent_template_app_icon` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_icon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_manage`
--

DROP TABLE IF EXISTS `ent_template_app_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_manage` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(60) NOT NULL COMMENT '应用名称',
  `link` varchar(255) DEFAULT NULL COMMENT '应用链接',
  `parent` int(11) NOT NULL COMMENT '应用父节点',
  `order` int(11) DEFAULT NULL COMMENT '排序',
  `description` text COMMENT '应用描述',
  `image` text COMMENT '应用图片',
  `icon_name` varchar(50) DEFAULT NULL COMMENT '一级应用图标名称',
  `level` int(11) DEFAULT NULL COMMENT '应用等级',
  `icon_type` varchar(40) DEFAULT NULL COMMENT '应用图标类型',
  `app_type` varchar(40) DEFAULT NULL COMMENT '应用类型',
  `handler` varchar(30) NOT NULL COMMENT '应用创建者',
  `app_id` varchar(255) DEFAULT NULL COMMENT '应用对应的具体配置ID',
  `app_show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '移动端显示',
  `created_at` datetime DEFAULT NULL COMMENT '应用创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '应用修改时间',
  `use_count` int(11) NOT NULL DEFAULT '0' COMMENT '应用使用次数',
  `from_store` varchar(255) NOT NULL DEFAULT '' COMMENT '应用市场ID',
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_manage`
--

LOCK TABLES `ent_template_app_manage` WRITE;
/*!40000 ALTER TABLE `ent_template_app_manage` DISABLE KEYS */;
INSERT INTO `ent_template_app_manage` VALUES (1,'流程',NULL,0,NULL,NULL,NULL,NULL,1,NULL,NULL,'',NULL,1,'2018-09-13 19:42:50','2018-09-13 19:42:50',0,''),(2,'Info',NULL,0,NULL,NULL,NULL,NULL,1,NULL,NULL,'',NULL,1,'2018-09-13 19:42:50','2018-09-13 19:42:50',0,'');
/*!40000 ALTER TABLE `ent_template_app_manage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_modified`
--

DROP TABLE IF EXISTS `ent_template_app_modified`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_modified` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `app_id` varchar(225) NOT NULL,
  `user_id` varchar(30) NOT NULL,
  `modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_app_user_id` (`app_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论最终查看时间表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_modified`
--

LOCK TABLES `ent_template_app_modified` WRITE;
/*!40000 ALTER TABLE `ent_template_app_modified` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_modified` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_racl`
--

DROP TABLE IF EXISTS `ent_template_app_racl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_racl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `app_id` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_racl`
--

LOCK TABLES `ent_template_app_racl` WRITE;
/*!40000 ALTER TABLE `ent_template_app_racl` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_racl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_uiengine_button`
--

DROP TABLE IF EXISTS `ent_template_app_uiengine_button`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_uiengine_button` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(40) NOT NULL COMMENT '应用ID',
  `module` enum('information','workflow') NOT NULL DEFAULT 'information' COMMENT '应用模块',
  `type` enum('default','link','app') NOT NULL DEFAULT 'default' COMMENT '按钮类型',
  `button_name` varchar(40) NOT NULL COMMENT '按钮名称',
  `handler` text COMMENT '执行人',
  `config` text COMMENT '按钮配置信息',
  `version` int(11) DEFAULT '0' COMMENT '应用版本号',
  `group` text NOT NULL COMMENT '执行人用户组',
  PRIMARY KEY (`id`),
  KEY `app_module_version` (`app_id`,`module`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_uiengine_button`
--

LOCK TABLES `ent_template_app_uiengine_button` WRITE;
/*!40000 ALTER TABLE `ent_template_app_uiengine_button` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_uiengine_button` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_uiengine_config`
--

DROP TABLE IF EXISTS `ent_template_app_uiengine_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_uiengine_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` enum('information','workflow') NOT NULL DEFAULT 'information' COMMENT '应用模块',
  `app_id` varchar(40) NOT NULL COMMENT '应用ID',
  `extra` varchar(255) DEFAULT NULL COMMENT '主表ID',
  `table_id` varchar(255) NOT NULL COMMENT '表ID',
  `user_id` varchar(255) NOT NULL COMMENT '用户ID',
  `type` varchar(40) NOT NULL COMMENT '类型：EXTENSION_CONFIG(扩展配置) SYSTEM_LABEL_SORT(管理员配置的标签排序顺序) slave_fields(从表表格) slave_conditions(从表条件) subapp_fields(子应用表格) subapp_conditions(子应用条件) documents(打印导出模板) magnifier(放大镜配置)\n',
  `config` text NOT NULL COMMENT '配置信息',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '应用版本号',
  PRIMARY KEY (`id`),
  KEY `app_config` (`module`,`app_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_uiengine_config`
--

LOCK TABLES `ent_template_app_uiengine_config` WRITE;
/*!40000 ALTER TABLE `ent_template_app_uiengine_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_uiengine_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_uiengine_label`
--

DROP TABLE IF EXISTS `ent_template_app_uiengine_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_uiengine_label` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '标签名称',
  `app_id` varchar(40) NOT NULL COMMENT '应用ID',
  `module` enum('information','workflow') NOT NULL DEFAULT 'information' COMMENT '应用模块',
  `user_id` varchar(255) DEFAULT NULL COMMENT '用户ID',
  `type` int(2) NOT NULL DEFAULT '1' COMMENT '类型：1(information:所有,workflow:代办) 2(information:我添加的,workflow:经办) 3(information:管理员配置标签,workflow:过往) 4(information:用户自定义标签,workflow:监控) 5(information:我共享的,workflow:所有) 6(information:共享给我的,workflow:管理员配置标签) 7(information:移交给我的,workflow:我参与的) 8(information:我关注的,workflow:我发起的) 9(information:提醒,workflow:最近处理的) 10(workflow:我抄送的) 11(workflow:抄送给我的) 12(workflow:提醒) 13(workflow:用户配置标签)\n',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '应用版本号',
  `custom` int(11) NOT NULL COMMENT '管理员是否自定义过',
  `default_watch_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新默认关注配置时间',
  `from` varchar(40) NOT NULL DEFAULT '' COMMENT '来源于',
  PRIMARY KEY (`id`),
  KEY `app_label_config` (`module`,`app_id`,`type`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_uiengine_label`
--

LOCK TABLES `ent_template_app_uiengine_label` WRITE;
/*!40000 ALTER TABLE `ent_template_app_uiengine_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_uiengine_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_uiengine_label_config`
--

DROP TABLE IF EXISTS `ent_template_app_uiengine_label_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_uiengine_label_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label_id` int(11) NOT NULL COMMENT '标签ID',
  `type` varchar(40) NOT NULL COMMENT '类型：access(权限配置) accessGroup(权限用户角色组) watch(关注) watchGroup(关注用户角色组) field(表格配置) button(按钮配置) operate(操作列配置) condition(条件配置) Magnifier(放大镜列配置)\n',
  `config` text COMMENT '配置信息',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '应用版本号',
  PRIMARY KEY (`id`),
  KEY `labelId_type` (`label_id`,`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_uiengine_label_config`
--

LOCK TABLES `ent_template_app_uiengine_label_config` WRITE;
/*!40000 ALTER TABLE `ent_template_app_uiengine_label_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_uiengine_label_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_uiengine_label_user_config`
--

DROP TABLE IF EXISTS `ent_template_app_uiengine_label_user_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_uiengine_label_user_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '用户ID的自增id',
  `app_id` int(10) NOT NULL COMMENT '应用ID的自增id',
  `label_id` int(10) unsigned NOT NULL COMMENT '标签ID的自增id',
  `default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是默认',
  `config` text NOT NULL COMMENT '标签配置信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_label` (`user_id`,`label_id`) USING BTREE,
  KEY `default` (`default`) USING BTREE,
  KEY `app_id` (`app_id`) USING BTREE,
  KEY `label_id` (`label_id`) USING BTREE,
  CONSTRAINT `template_Ent_app_manage_Id` FOREIGN KEY (`app_id`) REFERENCES `ent_template_app_manage` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `template_Ent_app_uiengine_label_Id` FOREIGN KEY (`label_id`) REFERENCES `ent_template_app_uiengine_label` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `template_Sys_user_base_Id` FOREIGN KEY (`user_id`) REFERENCES `sys_user_base` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_uiengine_label_user_config`
--

LOCK TABLES `ent_template_app_uiengine_label_user_config` WRITE;
/*!40000 ALTER TABLE `ent_template_app_uiengine_label_user_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_uiengine_label_user_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_uiengine_label_user_share`
--

DROP TABLE IF EXISTS `ent_template_app_uiengine_label_user_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_uiengine_label_user_share` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(40) NOT NULL DEFAULT '' COMMENT '应用id',
  `label_id` varchar(40) NOT NULL DEFAULT '' COMMENT '标签id',
  `creator` varchar(45) NOT NULL DEFAULT '' COMMENT '分享者id',
  `receiver` varchar(45) NOT NULL DEFAULT '' COMMENT '被分享者id',
  `share_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '共享时间',
  PRIMARY KEY (`id`),
  KEY `appId_user_id` (`app_id`,`creator`,`receiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_uiengine_label_user_share`
--

LOCK TABLES `ent_template_app_uiengine_label_user_share` WRITE;
/*!40000 ALTER TABLE `ent_template_app_uiengine_label_user_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_uiengine_label_user_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_uiengine_table`
--

DROP TABLE IF EXISTS `ent_template_app_uiengine_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_uiengine_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(40) NOT NULL COMMENT '应用ID',
  `module` enum('information','workflow') NOT NULL DEFAULT 'information' COMMENT '应用模块',
  `type` enum('master','slave','subapp') NOT NULL DEFAULT 'master' COMMENT '主表从表子应用类型',
  `table_id` varchar(255) NOT NULL COMMENT '表ID',
  `extra` varchar(255) NOT NULL COMMENT '主表ID',
  `index` tinyint(1) NOT NULL DEFAULT '0' COMMENT '表单排序',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '应用版本号',
  `type_info` varchar(255) NOT NULL DEFAULT '' COMMENT '子应用的应用信息',
  `selection` tinyint(1) NOT NULL DEFAULT '0' COMMENT '批量选择推荐功能',
  `magnifier` tinyint(1) NOT NULL DEFAULT '0' COMMENT '放大镜推荐功能',
  PRIMARY KEY (`id`),
  KEY `app_table_config` (`module`,`app_id`,`type`,`table_id`,`extra`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_uiengine_table`
--

LOCK TABLES `ent_template_app_uiengine_table` WRITE;
/*!40000 ALTER TABLE `ent_template_app_uiengine_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_uiengine_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_uiengine_view`
--

DROP TABLE IF EXISTS `ent_template_app_uiengine_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_uiengine_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` enum('information','workflow') NOT NULL DEFAULT 'information' COMMENT '应用模块	',
  `app_id` varchar(40) NOT NULL COMMENT '应用ID',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '应用版本号',
  `mode` varchar(255) NOT NULL DEFAULT 'calendar' COMMENT '视图模式',
  `use` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用',
  `config` text NOT NULL COMMENT '配置信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_view` (`module`,`app_id`,`version`,`mode`),
  KEY `app_views` (`module`,`app_id`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_uiengine_view`
--

LOCK TABLES `ent_template_app_uiengine_view` WRITE;
/*!40000 ALTER TABLE `ent_template_app_uiengine_view` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_uiengine_view` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_app_update`
--

DROP TABLE IF EXISTS `ent_template_app_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_app_update` (
  `user_id` varchar(100) NOT NULL,
  `app_id` varchar(150) NOT NULL,
  `app_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:workflow, 2:dataflow',
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `user_app` (`user_id`,`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_app_update`
--

LOCK TABLES `ent_template_app_update` WRITE;
/*!40000 ALTER TABLE `ent_template_app_update` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_app_update` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_appoint`
--

DROP TABLE IF EXISTS `ent_template_appoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_appoint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  `role_type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `role_name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `roleId_userId` (`role_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_appoint`
--

LOCK TABLES `ent_template_appoint` WRITE;
/*!40000 ALTER TABLE `ent_template_appoint` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_appoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_auto_recommend`
--

DROP TABLE IF EXISTS `ent_template_auto_recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_auto_recommend` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `record_id` int(11) NOT NULL COMMENT '记录ID',
  `table_id` varchar(50) NOT NULL COMMENT '操作表ID',
  `method` varchar(255) NOT NULL COMMENT '应用类别/AppId',
  `type` tinyint(1) NOT NULL COMMENT '类别:1-放大镜;2-批量选择',
  `user_id` varchar(255) NOT NULL COMMENT '操作者ID',
  `count` int(11) NOT NULL COMMENT '操作次数',
  `update_time` int(10) NOT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`),
  KEY `auto_recommend` (`table_id`,`method`,`type`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_auto_recommend`
--

LOCK TABLES `ent_template_auto_recommend` WRITE;
/*!40000 ALTER TABLE `ent_template_auto_recommend` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_auto_recommend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_banner`
--

DROP TABLE IF EXISTS `ent_template_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_banner` (
  `id` varchar(45) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `background` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_banner`
--

LOCK TABLES `ent_template_banner` WRITE;
/*!40000 ALTER TABLE `ent_template_banner` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_category_for_user`
--

DROP TABLE IF EXISTS `ent_template_category_for_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_category_for_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `user_id` varchar(40) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_category_for_user`
--

LOCK TABLES `ent_template_category_for_user` WRITE;
/*!40000 ALTER TABLE `ent_template_category_for_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_category_for_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_chat_conversation`
--

DROP TABLE IF EXISTS `ent_template_chat_conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_chat_conversation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `conversation_id` varchar(255) NOT NULL COMMENT '讨论组ID',
  `conversation_name` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT '讨论组名称',
  `conversation_type` varchar(255) NOT NULL COMMENT '讨论组类型',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `conversation_id` (`conversation_id`),
  KEY `c_name_type` (`conversation_name`(191),`conversation_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_chat_conversation`
--

LOCK TABLES `ent_template_chat_conversation` WRITE;
/*!40000 ALTER TABLE `ent_template_chat_conversation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_chat_conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_chat_conversation_member`
--

DROP TABLE IF EXISTS `ent_template_chat_conversation_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_chat_conversation_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `conversation_id` varchar(255) NOT NULL COMMENT '讨论组ID',
  `user_id` varchar(30) NOT NULL COMMENT '用户ID',
  `join_time` datetime NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`),
  KEY `conversation_user_id` (`conversation_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_chat_conversation_member`
--

LOCK TABLES `ent_template_chat_conversation_member` WRITE;
/*!40000 ALTER TABLE `ent_template_chat_conversation_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_chat_conversation_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_chat_group`
--

DROP TABLE IF EXISTS `ent_template_chat_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_chat_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `creator` varchar(30) NOT NULL COMMENT '创建的用户',
  `org_id` int(11) NOT NULL COMMENT '组织部门ID',
  `group_id` varchar(255) DEFAULT NULL COMMENT '分组ID',
  `group_name` varchar(255) DEFAULT NULL COMMENT '分组名称',
  `group_info` text COMMENT '分组信息',
  `group_level` varchar(30) DEFAULT NULL COMMENT '分组级别',
  `group_file` text COMMENT '分组文件',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `org_id` (`org_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_chat_group`
--

LOCK TABLES `ent_template_chat_group` WRITE;
/*!40000 ALTER TABLE `ent_template_chat_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_chat_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_chat_group_member`
--

DROP TABLE IF EXISTS `ent_template_chat_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_chat_group_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `group_id` varchar(255) DEFAULT NULL COMMENT '分组ID',
  `user_id` varchar(30) NOT NULL COMMENT '用户ID',
  `disabled` enum('false','true') NOT NULL DEFAULT 'false' COMMENT '禁用状态(true:禁用|false:启用)',
  `join_time` datetime NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `disabled` (`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_chat_group_member`
--

LOCK TABLES `ent_template_chat_group_member` WRITE;
/*!40000 ALTER TABLE `ent_template_chat_group_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_chat_group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_comments_contact`
--

DROP TABLE IF EXISTS `ent_template_comments_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_comments_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `modifier` varchar(45) NOT NULL DEFAULT '0' COMMENT '发起者',
  `receiver` varchar(45) NOT NULL DEFAULT '0' COMMENT '接收者',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '统计数',
  `receiver_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '接收者是否被禁用(0:否|1:是)',
  `last_modified` datetime NOT NULL COMMENT '最后一次被修改的时间',
  PRIMARY KEY (`id`),
  KEY `modifier_receiver` (`modifier`,`receiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_comments_contact`
--

LOCK TABLES `ent_template_comments_contact` WRITE;
/*!40000 ALTER TABLE `ent_template_comments_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_comments_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_comments_msg`
--

DROP TABLE IF EXISTS `ent_template_comments_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_comments_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `app_id` varchar(255) NOT NULL COMMENT '应用ID',
  `modifier` varchar(50) NOT NULL COMMENT '发起者',
  `msg` text CHARACTER SET utf8mb4 COMMENT '评论内容',
  `last_modified` datetime DEFAULT NULL COMMENT '最后一次被修改的时间',
  `msg_type` varchar(255) NOT NULL COMMENT '评论内容类型',
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`),
  KEY `msg_type` (`msg_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_comments_msg`
--

LOCK TABLES `ent_template_comments_msg` WRITE;
/*!40000 ALTER TABLE `ent_template_comments_msg` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_comments_msg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_common_applist`
--

DROP TABLE IF EXISTS `ent_template_common_applist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_common_applist` (
  `user_id` varchar(50) NOT NULL,
  `common_list` varchar(255) DEFAULT NULL,
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_common_applist`
--

LOCK TABLES `ent_template_common_applist` WRITE;
/*!40000 ALTER TABLE `ent_template_common_applist` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_common_applist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_config`
--

DROP TABLE IF EXISTS `ent_template_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_config`
--

LOCK TABLES `ent_template_config` WRITE;
/*!40000 ALTER TABLE `ent_template_config` DISABLE KEYS */;
INSERT INTO `ent_template_config` VALUES (1,'APK_RELATION','{\"table_name\":null,\"type\":null,\"apk_tableid\":null,\"apk_vision\":null,\"apk_url\":null,\"apk_descirption\":null,\"apk_filename\":null}'),(2,'LANYA','{\"active\":\"true\"}');
/*!40000 ALTER TABLE `ent_template_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_coterie_comment`
--

DROP TABLE IF EXISTS `ent_template_coterie_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_coterie_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `post_id` int(11) NOT NULL COMMENT 'postID',
  `user_id` varchar(30) NOT NULL COMMENT '用户ID',
  `reply_user` varchar(30) DEFAULT NULL COMMENT '回复用户',
  `content` text CHARACTER SET utf8mb4 COMMENT '评论内容',
  `commented_id` int(11) DEFAULT '0' COMMENT '评论ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_coterie_comment`
--

LOCK TABLES `ent_template_coterie_comment` WRITE;
/*!40000 ALTER TABLE `ent_template_coterie_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_coterie_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_coterie_notice`
--

DROP TABLE IF EXISTS `ent_template_coterie_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_coterie_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `operate` varchar(30) NOT NULL COMMENT '操作(COMMENT:评论|PRAISE:点赞)',
  `post_id` int(11) NOT NULL COMMENT 'postID',
  `app_id` int(11) DEFAULT NULL COMMENT '应用ID',
  `content` text COMMENT '评论内容',
  `send_user` varchar(30) NOT NULL COMMENT '发送的用户',
  `to_user` varchar(30) NOT NULL COMMENT '接收的用户',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态(0:未读|1:已读)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  KEY `app_id` (`app_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_coterie_notice`
--

LOCK TABLES `ent_template_coterie_notice` WRITE;
/*!40000 ALTER TABLE `ent_template_coterie_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_coterie_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_coterie_posts`
--

DROP TABLE IF EXISTS `ent_template_coterie_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_coterie_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL,
  `content` text CHARACTER SET utf8mb4,
  `pic` text,
  `link_url` text,
  `link_title` text,
  `link_img` text,
  `location` text,
  `post_type` tinyint(1) NOT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '0 成功; 1 文字成功,图片失败; 2 文字失败,图片成功; 3 全部失败',
  `create_time` datetime NOT NULL,
  `old_content` text,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_coterie_posts`
--

LOCK TABLES `ent_template_coterie_posts` WRITE;
/*!40000 ALTER TABLE `ent_template_coterie_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_coterie_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_coterie_praise`
--

DROP TABLE IF EXISTS `ent_template_coterie_praise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_coterie_praise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `user_id` varchar(30) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_coterie_praise`
--

LOCK TABLES `ent_template_coterie_praise` WRITE;
/*!40000 ALTER TABLE `ent_template_coterie_praise` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_coterie_praise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_coterie_refreshtime`
--

DROP TABLE IF EXISTS `ent_template_coterie_refreshtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_coterie_refreshtime` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL,
  `last_refresh_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_coterie_refreshtime`
--

LOCK TABLES `ent_template_coterie_refreshtime` WRITE;
/*!40000 ALTER TABLE `ent_template_coterie_refreshtime` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_coterie_refreshtime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_dashboard`
--

DROP TABLE IF EXISTS `ent_template_dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_dashboard` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `title` varchar(20) NOT NULL COMMENT '仪表盘名称',
  `type` varchar(20) NOT NULL COMMENT '仪表盘类型',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态(0:未删除|1:已删除)',
  `owner` varchar(30) NOT NULL COMMENT '拥有者',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否显示(0:显示|1:隐藏)',
  `config` text COMMENT '仪表盘配置',
  `create_time` datetime DEFAULT '2018-09-13 19:43:50' COMMENT '创建时间',
  `last_modified` datetime DEFAULT '2018-09-13 19:43:50' COMMENT '最后一次修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_dashboard`
--

LOCK TABLES `ent_template_dashboard` WRITE;
/*!40000 ALTER TABLE `ent_template_dashboard` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_dashboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_dashboard_for_category`
--

DROP TABLE IF EXISTS `ent_template_dashboard_for_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_dashboard_for_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `category_id` varchar(40) NOT NULL COMMENT '分类id',
  `dashboard_id` varchar(40) NOT NULL COMMENT '仪表盘id',
  `user_id` varchar(40) NOT NULL COMMENT '用户id',
  `type` varchar(20) NOT NULL COMMENT '类型(single:单一分析表|combine:组合分析表)',
  `weight` int(11) NOT NULL COMMENT '仪表盘位置',
  `range` varchar(30) NOT NULL COMMENT '仪表盘大小',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  KEY `dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_dashboard_for_category`
--

LOCK TABLES `ent_template_dashboard_for_category` WRITE;
/*!40000 ALTER TABLE `ent_template_dashboard_for_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_dashboard_for_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_dashboard_order`
--

DROP TABLE IF EXISTS `ent_template_dashboard_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_dashboard_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` varchar(40) NOT NULL COMMENT '用户id',
  `position` text NOT NULL COMMENT '位置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_dashboard_order`
--

LOCK TABLES `ent_template_dashboard_order` WRITE;
/*!40000 ALTER TABLE `ent_template_dashboard_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_dashboard_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_dashboard_show`
--

DROP TABLE IF EXISTS `ent_template_dashboard_show`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_dashboard_show` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` varchar(40) NOT NULL COMMENT '用户id',
  `rule_id` int(11) NOT NULL COMMENT '规则id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_dashboard_show`
--

LOCK TABLES `ent_template_dashboard_show` WRITE;
/*!40000 ALTER TABLE `ent_template_dashboard_show` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_dashboard_show` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_category`
--

DROP TABLE IF EXISTS `ent_template_datacenter_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `title` varchar(50) NOT NULL COMMENT '分类名称',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级分类id',
  `index` int(11) NOT NULL DEFAULT '0' COMMENT '同级分类的排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_category`
--

LOCK TABLES `ent_template_datacenter_category` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_data_datasource`
--

DROP TABLE IF EXISTS `ent_template_datacenter_data_datasource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_data_datasource` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `table_id` varchar(50) NOT NULL COMMENT '数据表id',
  `field_id` varchar(50) NOT NULL COMMENT '数据字段id',
  `record_id` int(11) NOT NULL COMMENT '记录id',
  `datasource_table_id` varchar(50) NOT NULL COMMENT '数据来源表id',
  `datasource_field_id` varchar(50) NOT NULL COMMENT '数据来源字段id',
  `datasource_record_id` int(11) NOT NULL COMMENT '数据来源记录id',
  `datasource_path` text COMMENT '记录数据传递路径, 用于更新(基本废弃)',
  `index` tinyint(4) DEFAULT '0' COMMENT '选项位置(比如多选第一个选项值为0)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tid_rid_fid_index` (`table_id`,`record_id`,`field_id`,`index`),
  KEY `dtid_drid_dfid` (`datasource_table_id`,`datasource_record_id`,`datasource_field_id`),
  KEY `tid_rid_dtid` (`table_id`,`record_id`,`datasource_table_id`),
  KEY `dtid_drid_tid` (`datasource_table_id`,`datasource_record_id`,`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_data_datasource`
--

LOCK TABLES `ent_template_datacenter_data_datasource` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_data_datasource` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_data_datasource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_data_identifier`
--

DROP TABLE IF EXISTS `ent_template_datacenter_data_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_data_identifier` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `table_id` varchar(50) NOT NULL COMMENT '表id',
  `identifier` text NOT NULL COMMENT '编号规则',
  `field_id` varchar(50) NOT NULL COMMENT '字段id',
  `count` int(11) NOT NULL COMMENT '自增数字',
  `lastTime` text,
  PRIMARY KEY (`id`),
  KEY `table_field` (`table_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='编号字段数据记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_data_identifier`
--

LOCK TABLES `ent_template_datacenter_data_identifier` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_data_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_data_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_field`
--

DROP TABLE IF EXISTS `ent_template_datacenter_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_field` (
  `id` varchar(50) NOT NULL COMMENT '字段存储id',
  `title` varchar(50) NOT NULL COMMENT '字段名称',
  `type` varchar(20) NOT NULL COMMENT '字段类型(string|number|radio|org|zone|datetime等)',
  `belongs` varchar(50) NOT NULL COMMENT '表id, 表示该字段属于哪个表',
  `index` int(11) NOT NULL DEFAULT '0' COMMENT '字段排序',
  `creator` varchar(50) NOT NULL COMMENT '创建者',
  `modifier` varchar(50) NOT NULL COMMENT '修改者',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `last_modified` datetime NOT NULL COMMENT '最后修改时间',
  `basic` tinyint(1) NOT NULL DEFAULT '0' COMMENT '基本信息(废弃)',
  `required` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否必填',
  `report` tinyint(1) NOT NULL DEFAULT '0' COMMENT '报表(废弃)',
  UNIQUE KEY `id` (`id`,`belongs`),
  UNIQUE KEY `title` (`title`,`belongs`),
  KEY `belongs` (`belongs`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_field`
--

LOCK TABLES `ent_template_datacenter_field` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_field_datasource`
--

DROP TABLE IF EXISTS `ent_template_datacenter_field_datasource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_field_datasource` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `table_id` varchar(50) NOT NULL COMMENT '表id',
  `field_id` varchar(50) NOT NULL COMMENT '字段id',
  `index` tinyint(4) NOT NULL DEFAULT '0' COMMENT '已废弃',
  `datasource_table_id` varchar(50) NOT NULL COMMENT '数据来源表id',
  `datasource_field_id` varchar(50) NOT NULL COMMENT '数据来源字段id',
  `condition` text COMMENT '过滤条件',
  `access` tinyint(1) DEFAULT '0' COMMENT '是否检查权限(1:检查)',
  PRIMARY KEY (`id`),
  KEY `tid_fid` (`table_id`,`field_id`),
  KEY `tid_dtid` (`table_id`,`datasource_table_id`),
  KEY `dtid` (`datasource_table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_field_datasource`
--

LOCK TABLES `ent_template_datacenter_field_datasource` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_field_datasource` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_field_datasource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_field_metadata`
--

DROP TABLE IF EXISTS `ent_template_datacenter_field_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_field_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `table_id` varchar(50) NOT NULL COMMENT '表id',
  `field_id` varchar(50) NOT NULL COMMENT '字段id',
  `type` varchar(20) NOT NULL COMMENT '属性名称',
  `value` text COMMENT '属性实际值',
  PRIMARY KEY (`id`),
  KEY `field` (`table_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_field_metadata`
--

LOCK TABLES `ent_template_datacenter_field_metadata` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_field_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_field_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_monitoring`
--

DROP TABLE IF EXISTS `ent_template_datacenter_monitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_monitoring` (
  `id` int(11) NOT NULL COMMENT '自增id',
  `monitor` text COMMENT '监控者',
  `monitored` text COMMENT '被监控者',
  `monitor_group` text COMMENT '监控者(角色组)',
  `monitored_group` text COMMENT '被监控者(角色组)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_monitoring`
--

LOCK TABLES `ent_template_datacenter_monitoring` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_monitoring` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_monitoring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_monitoring_history`
--

DROP TABLE IF EXISTS `ent_template_datacenter_monitoring_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_monitoring_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` varchar(255) NOT NULL COMMENT '用户id',
  `recordId` int(11) NOT NULL COMMENT '记录id',
  `operator` varchar(65) NOT NULL COMMENT '操作者',
  `data` text NOT NULL COMMENT '监控规则',
  `operation` varchar(20) NOT NULL COMMENT '操作(创建|编辑)',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `search` text COMMENT '变动记录',
  `verified_at` varchar(30) NOT NULL,
  `status` tinyint(1) DEFAULT '4',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_monitoring_history`
--

LOCK TABLES `ent_template_datacenter_monitoring_history` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_monitoring_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_monitoring_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_monitoring_table`
--

DROP TABLE IF EXISTS `ent_template_datacenter_monitoring_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_monitoring_table` (
  `monitor_id` int(11) NOT NULL COMMENT '监控记录id',
  `table_id` varchar(40) NOT NULL COMMENT '表id',
  `table_right` varchar(10) DEFAULT NULL COMMENT '表级权限(0:不能读|1:能改|1:能删)',
  `fields_right` text COMMENT '字段级权限(空表示全部字段)',
  `conditions` text COMMENT '监控规则条件',
  KEY `monitor_id` (`monitor_id`),
  KEY `table_id` (`table_id`),
  KEY `tid` (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_monitoring_table`
--

LOCK TABLES `ent_template_datacenter_monitoring_table` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_monitoring_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_monitoring_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_relation`
--

DROP TABLE IF EXISTS `ent_template_datacenter_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `table_id` varchar(50) NOT NULL COMMENT '主表表id',
  `relation_table_id` varchar(50) NOT NULL COMMENT '从表表id',
  `table_record` int(11) NOT NULL COMMENT '主表记录id',
  `relation_table_record` int(11) NOT NULL COMMENT '从表记录id',
  `disable` tinyint(1) DEFAULT '0' COMMENT '是否删除(1:已删除)',
  PRIMARY KEY (`id`),
  KEY `tid_rtid_rrid` (`table_id`,`relation_table_id`,`relation_table_record`),
  KEY `rtid_rrid` (`relation_table_id`,`relation_table_record`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_relation`
--

LOCK TABLES `ent_template_datacenter_relation` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_share`
--

DROP TABLE IF EXISTS `ent_template_datacenter_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_share` (
  `table_id` varchar(40) NOT NULL COMMENT '表id',
  `record_id` int(11) NOT NULL COMMENT '记录id',
  `right` varchar(4) DEFAULT NULL COMMENT '权限(0:读|1:写)',
  `fields` text COMMENT '共享的字段(空表示全部)',
  `sharers` text NOT NULL COMMENT '共享给谁',
  `blacklist` text COMMENT '对应分享给谁的黑名单',
  `creator` varchar(40) NOT NULL COMMENT '共享记录创建者',
  `share_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '共享时间',
  UNIQUE KEY `table_id` (`table_id`,`record_id`,`creator`,`sharers`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_share`
--

LOCK TABLES `ent_template_datacenter_share` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_slave_table`
--

DROP TABLE IF EXISTS `ent_template_datacenter_slave_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_slave_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `table_id` varchar(50) NOT NULL COMMENT '从表表id',
  `belongs_to` varchar(50) NOT NULL COMMENT '主表表id',
  `index` int(11) DEFAULT '0' COMMENT '从表排序顺序(废弃)',
  `status` tinyint(1) NOT NULL COMMENT '从表是否显示(废弃)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `table` (`table_id`,`belongs_to`),
  KEY `belongs_to` (`belongs_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_slave_table`
--

LOCK TABLES `ent_template_datacenter_slave_table` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_slave_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_slave_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_table`
--

DROP TABLE IF EXISTS `ent_template_datacenter_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_table` (
  `id` varchar(50) NOT NULL COMMENT '数据表存储id',
  `title` varchar(50) NOT NULL COMMENT '表名',
  `type` enum('REPORT','MESSAGE') NOT NULL DEFAULT 'MESSAGE' COMMENT '表类型(MESSAGE:信息表)',
  `default_view` enum('LINE','TABLE') NOT NULL DEFAULT 'LINE' COMMENT '默认视图(LINE:行级视图)',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '数据表的分类(数据中心左侧分类节点id)',
  `creator` varchar(50) NOT NULL COMMENT '创建者',
  `modifier` varchar(50) NOT NULL COMMENT '最后修改人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `last_modified` datetime NOT NULL COMMENT '最后修改时间',
  `fields_relation` text COMMENT '字段关联配置',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_table`
--

LOCK TABLES `ent_template_datacenter_table` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_datacenter_table_metadata`
--

DROP TABLE IF EXISTS `ent_template_datacenter_table_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_datacenter_table_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `table_id` varchar(50) NOT NULL COMMENT '表id',
  `type` varchar(20) NOT NULL COMMENT '属性名称',
  `value` text COMMENT '属性实际值',
  PRIMARY KEY (`id`),
  KEY `tid` (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_datacenter_table_metadata`
--

LOCK TABLES `ent_template_datacenter_table_metadata` WRITE;
/*!40000 ALTER TABLE `ent_template_datacenter_table_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_datacenter_table_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_field_update`
--

DROP TABLE IF EXISTS `ent_template_field_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_field_update` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `table_id` varchar(100) NOT NULL COMMENT '表ID',
  `field_id` varchar(100) NOT NULL COMMENT '字段ID',
  `status` tinyint(1) NOT NULL COMMENT '状态:0-未执行;1-执行中;2-已完成',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `table_field` (`table_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_field_update`
--

LOCK TABLES `ent_template_field_update` WRITE;
/*!40000 ALTER TABLE `ent_template_field_update` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_field_update` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_file`
--

DROP TABLE IF EXISTS `ent_template_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_file` (
  `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `version` int(11) NOT NULL COMMENT '版本号',
  `name` varchar(128) NOT NULL COMMENT '文件名',
  `uid` varchar(30) DEFAULT NULL COMMENT '用户id',
  `host` varchar(15) NOT NULL COMMENT '文件路径',
  `folder_id` int(11) NOT NULL COMMENT '文件夹id',
  `type` varchar(128) NOT NULL COMMENT '文件类型(base:上传到本地,无需其他配置|aliyun:上传到OSS,必须配置fileio_key)',
  `size` int(11) NOT NULL COMMENT '文件大小',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `access` int(11) NOT NULL COMMENT '删除(0:启用|1:删除)',
  `apps` varchar(60) DEFAULT NULL COMMENT '应用程序',
  PRIMARY KEY (`fid`,`version`),
  KEY `folder_id` (`folder_id`),
  KEY `IDX_APPS_UPDATETIME` (`apps`,`updatetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_file`
--

LOCK TABLES `ent_template_file` WRITE;
/*!40000 ALTER TABLE `ent_template_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_file_archive`
--

DROP TABLE IF EXISTS `ent_template_file_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_file_archive` (
  `fid` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `uid` varchar(30) DEFAULT NULL,
  `host` varchar(15) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `type` varchar(128) NOT NULL,
  `size` int(11) NOT NULL,
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `access` int(11) DEFAULT NULL,
  `apps` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`fid`,`version`),
  KEY `folder_id` (`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_file_archive`
--

LOCK TABLES `ent_template_file_archive` WRITE;
/*!40000 ALTER TABLE `ent_template_file_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_file_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_file_collect`
--

DROP TABLE IF EXISTS `ent_template_file_collect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_file_collect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(30) DEFAULT NULL,
  `fid` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `version` int(11) NOT NULL,
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `uid` varchar(30) DEFAULT NULL,
  `folder_id` int(11) NOT NULL,
  `type` varchar(128) NOT NULL,
  `size` int(11) NOT NULL,
  `access` int(11) DEFAULT NULL,
  `apps` varchar(60) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`version`),
  KEY `folder_id` (`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_file_collect`
--

LOCK TABLES `ent_template_file_collect` WRITE;
/*!40000 ALTER TABLE `ent_template_file_collect` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_file_collect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_file_delete`
--

DROP TABLE IF EXISTS `ent_template_file_delete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_file_delete` (
  `fid` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `uid` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `host` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `folder_id` int(11) NOT NULL,
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` varchar(128) CHARACTER SET utf8 NOT NULL,
  `size` int(11) NOT NULL,
  `apps` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `access` tinyint(4) NOT NULL,
  PRIMARY KEY (`fid`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_file_delete`
--

LOCK TABLES `ent_template_file_delete` WRITE;
/*!40000 ALTER TABLE `ent_template_file_delete` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_file_delete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_file_foldername`
--

DROP TABLE IF EXISTS `ent_template_file_foldername`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_file_foldername` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(60) NOT NULL COMMENT '文件夹名称',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `point` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `point` (`point`),
  KEY `path` (`path`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_file_foldername`
--

LOCK TABLES `ent_template_file_foldername` WRITE;
/*!40000 ALTER TABLE `ent_template_file_foldername` DISABLE KEYS */;
INSERT INTO `ent_template_file_foldername` VALUES (1,'文档管理',0,'store/',0),(2,'我的收藏',0,'store/collect/',1);
/*!40000 ALTER TABLE `ent_template_file_foldername` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_file_statistics`
--

DROP TABLE IF EXISTS `ent_template_file_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_file_statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `fid` int(11) NOT NULL COMMENT '文件id',
  `name` varchar(128) NOT NULL COMMENT '文件名',
  `version` smallint(6) NOT NULL DEFAULT '1' COMMENT '版本号',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '文件上传时间',
  `uid` varchar(30) NOT NULL COMMENT '用户id',
  `type` varchar(15) DEFAULT NULL COMMENT '文件操作类型(UPLOAD:上传|VIEW:预览|DOWNLOAD:下载)',
  `ip` int(11) NOT NULL DEFAULT '0' COMMENT 'ip地址',
  `description` varchar(50) NOT NULL COMMENT '文件描述',
  PRIMARY KEY (`id`),
  KEY `fid` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_file_statistics`
--

LOCK TABLES `ent_template_file_statistics` WRITE;
/*!40000 ALTER TABLE `ent_template_file_statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_file_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_file_storebrowse`
--

DROP TABLE IF EXISTS `ent_template_file_storebrowse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_file_storebrowse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` varchar(255) NOT NULL COMMENT '用户id',
  `browsedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '浏览日期',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_file_storebrowse`
--

LOCK TABLES `ent_template_file_storebrowse` WRITE;
/*!40000 ALTER TABLE `ent_template_file_storebrowse` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_file_storebrowse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_form`
--

DROP TABLE IF EXISTS `ent_template_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application` enum('information','workflow') NOT NULL DEFAULT 'information' COMMENT '应用模块',
  `app_id` varchar(40) NOT NULL COMMENT '应用ID',
  `table_id` varchar(40) NOT NULL COMMENT '表ID',
  `html` longtext NOT NULL COMMENT 'form1.0配置',
  `form` longtext COMMENT 'form1.0配置',
  `used_cell` text COMMENT 'form1.0配置',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '应用版本号',
  `cells` longtext NOT NULL COMMENT 'form2.0配置',
  `type` tinyint(1) DEFAULT NULL COMMENT 'form版本',
  `last_modified` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `application_app_id` (`application`,`app_id`,`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_form`
--

LOCK TABLES `ent_template_form` WRITE;
/*!40000 ALTER TABLE `ent_template_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_holiday_arrangement`
--

DROP TABLE IF EXISTS `ent_template_holiday_arrangement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_holiday_arrangement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` char(30) NOT NULL COMMENT '休班日期',
  `state` tinyint(1) NOT NULL COMMENT '状态',
  `auto` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=1097 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_holiday_arrangement`
--

LOCK TABLES `ent_template_holiday_arrangement` WRITE;
/*!40000 ALTER TABLE `ent_template_holiday_arrangement` DISABLE KEYS */;
INSERT INTO `ent_template_holiday_arrangement` VALUES (1,'2016-01-01',0,0),(2,'2016-01-02',0,0),(3,'2016-01-03',0,0),(4,'2016-02-06',1,0),(5,'2016-02-07',0,0),(6,'2016-02-08',0,0),(7,'2016-02-09',0,0),(8,'2016-02-14',1,0),(9,'2016-02-10',0,0),(10,'2016-02-11',0,0),(11,'2016-02-12',0,0),(12,'2016-02-13',0,0),(13,'2016-04-02',0,0),(14,'2016-04-03',0,0),(15,'2016-04-04',0,0),(16,'2016-04-30',0,0),(17,'2016-05-01',0,0),(18,'2016-05-02',0,0),(19,'2016-06-09',0,0),(20,'2016-06-10',0,0),(21,'2016-06-11',0,0),(22,'2016-06-12',1,0),(23,'2016-09-15',0,0),(24,'2016-09-16',0,0),(25,'2016-09-17',0,0),(26,'2016-09-18',1,0),(27,'2016-10-01',0,0),(28,'2016-10-02',0,0),(29,'2016-10-03',0,0),(30,'2016-10-04',0,0),(31,'2016-10-05',0,0),(32,'2016-10-06',0,0),(33,'2016-10-07',0,0),(34,'2016-10-08',1,0),(35,'2016-10-09',1,0),(36,'2015-01-01',0,0),(37,'2015-01-02',0,0),(38,'2015-01-03',0,0),(39,'2015-01-04',1,0),(40,'2015-02-15',1,0),(41,'2015-02-18',0,0),(42,'2015-02-19',0,0),(43,'2015-02-20',0,0),(44,'2015-02-21',0,0),(45,'2015-02-22',0,0),(46,'2015-02-23',0,0),(47,'2015-02-24',0,0),(48,'2015-02-28',1,0),(49,'2015-04-04',0,0),(50,'2015-04-05',0,0),(51,'2015-04-06',0,0),(52,'2015-05-01',0,0),(53,'2015-05-02',0,0),(54,'2015-05-03',0,0),(55,'2015-06-20',0,0),(56,'2015-06-21',0,0),(57,'2015-06-22',0,0),(58,'2015-09-03',0,0),(59,'2015-09-04',0,0),(60,'2015-09-05',0,0),(61,'2015-09-06',1,0),(62,'2015-09-26',0,0),(63,'2015-09-27',0,0),(64,'2015-10-01',0,0),(65,'2015-10-02',0,0),(66,'2015-10-03',0,0),(67,'2015-10-04',0,0),(68,'2015-10-05',0,0),(69,'2015-10-06',0,0),(70,'2015-10-07',0,0),(71,'2015-10-10',1,0),(72,'2015-01-05',1,0),(73,'2015-01-06',1,0),(74,'2015-01-07',1,0),(75,'2015-01-08',1,0),(76,'2015-01-09',1,0),(77,'2015-01-12',1,0),(78,'2015-01-13',1,0),(79,'2015-01-14',1,0),(80,'2015-01-15',1,0),(81,'2015-01-16',1,0),(82,'2015-01-19',1,0),(83,'2015-01-20',1,0),(84,'2015-01-21',1,0),(85,'2015-01-22',1,0),(86,'2015-01-23',1,0),(87,'2015-01-26',1,0),(88,'2015-01-27',1,0),(89,'2015-01-28',1,0),(90,'2015-01-29',1,0),(91,'2015-01-30',1,0),(92,'2015-02-02',1,0),(93,'2015-02-03',1,0),(94,'2015-02-04',1,0),(95,'2015-02-05',1,0),(96,'2015-02-06',1,0),(97,'2015-02-09',1,0),(98,'2015-02-10',1,0),(99,'2015-02-11',1,0),(100,'2015-02-12',1,0),(101,'2015-02-13',1,0),(102,'2015-02-16',1,0),(103,'2015-02-17',1,0),(104,'2015-02-25',1,0),(105,'2015-02-26',1,0),(106,'2015-02-27',1,0),(107,'2015-03-02',1,0),(108,'2015-03-03',1,0),(109,'2015-03-04',1,0),(110,'2015-03-05',1,0),(111,'2015-03-06',1,0),(112,'2015-03-09',1,0),(113,'2015-03-10',1,0),(114,'2015-03-11',1,0),(115,'2015-03-12',1,0),(116,'2015-03-13',1,0),(117,'2015-03-16',1,0),(118,'2015-03-17',1,0),(119,'2015-03-18',1,0),(120,'2015-03-19',1,0),(121,'2015-03-20',1,0),(122,'2015-03-23',1,0),(123,'2015-03-24',1,0),(124,'2015-03-25',1,0),(125,'2015-03-26',1,0),(126,'2015-03-27',1,0),(127,'2015-03-30',1,0),(128,'2015-03-31',1,0),(129,'2015-04-01',1,0),(130,'2015-04-02',1,0),(131,'2015-04-03',1,0),(132,'2015-04-07',1,0),(133,'2015-04-08',1,0),(134,'2015-04-09',1,0),(135,'2015-04-10',1,0),(136,'2015-04-13',1,0),(137,'2015-04-14',1,0),(138,'2015-04-15',1,0),(139,'2015-04-16',1,0),(140,'2015-04-17',1,0),(141,'2015-04-20',1,0),(142,'2015-04-21',1,0),(143,'2015-04-22',1,0),(144,'2015-04-23',1,0),(145,'2015-04-24',1,0),(146,'2015-04-27',1,0),(147,'2015-04-28',1,0),(148,'2015-04-29',1,0),(149,'2015-04-30',1,0),(150,'2015-05-04',1,0),(151,'2015-05-05',1,0),(152,'2015-05-06',1,0),(153,'2015-05-07',1,0),(154,'2015-05-08',1,0),(155,'2015-05-11',1,0),(156,'2015-05-12',1,0),(157,'2015-05-13',1,0),(158,'2015-05-14',1,0),(159,'2015-05-15',1,0),(160,'2015-05-18',1,0),(161,'2015-05-19',1,0),(162,'2015-05-20',1,0),(163,'2015-05-21',1,0),(164,'2015-05-22',1,0),(165,'2015-05-25',1,0),(166,'2015-05-26',1,0),(167,'2015-05-27',1,0),(168,'2015-05-28',1,0),(169,'2015-05-29',1,0),(170,'2015-06-01',1,0),(171,'2015-06-02',1,0),(172,'2015-06-03',1,0),(173,'2015-06-04',1,0),(174,'2015-06-05',1,0),(175,'2015-06-08',1,0),(176,'2015-06-09',1,0),(177,'2015-06-10',1,0),(178,'2015-06-11',1,0),(179,'2015-06-12',1,0),(180,'2015-06-15',1,0),(181,'2015-06-16',1,0),(182,'2015-06-17',1,0),(183,'2015-06-18',1,0),(184,'2015-06-19',1,0),(185,'2015-06-23',1,0),(186,'2015-06-24',1,0),(187,'2015-06-25',1,0),(188,'2015-06-26',1,0),(189,'2015-06-29',1,0),(190,'2015-06-30',1,0),(191,'2015-07-01',1,0),(192,'2015-07-02',1,0),(193,'2015-07-03',1,0),(194,'2015-07-06',1,0),(195,'2015-07-07',1,0),(196,'2015-07-08',1,0),(197,'2015-07-09',1,0),(198,'2015-07-10',1,0),(199,'2015-07-13',1,0),(200,'2015-07-14',1,0),(201,'2015-07-15',1,0),(202,'2015-07-16',1,0),(203,'2015-07-17',1,0),(204,'2015-07-20',1,0),(205,'2015-07-21',1,0),(206,'2015-07-22',1,0),(207,'2015-07-23',1,0),(208,'2015-07-24',1,0),(209,'2015-07-27',1,0),(210,'2015-07-28',1,0),(211,'2015-07-29',1,0),(212,'2015-07-30',1,0),(213,'2015-07-31',1,0),(214,'2015-08-03',1,0),(215,'2015-08-04',1,0),(216,'2015-08-05',1,0),(217,'2015-08-06',1,0),(218,'2015-08-07',1,0),(219,'2015-08-10',1,0),(220,'2015-08-11',1,0),(221,'2015-08-12',1,0),(222,'2015-08-13',1,0),(223,'2015-08-14',1,0),(224,'2015-08-17',1,0),(225,'2015-08-18',1,0),(226,'2015-08-19',1,0),(227,'2015-08-20',1,0),(228,'2015-08-21',1,0),(229,'2015-08-24',1,0),(230,'2015-08-25',1,0),(231,'2015-08-26',1,0),(232,'2015-08-27',1,0),(233,'2015-08-28',1,0),(234,'2015-08-31',1,0),(235,'2015-09-01',1,0),(236,'2015-09-02',1,0),(237,'2015-09-07',1,0),(238,'2015-09-08',1,0),(239,'2015-09-09',1,0),(240,'2015-09-10',1,0),(241,'2015-09-11',1,0),(242,'2015-09-14',1,0),(243,'2015-09-15',1,0),(244,'2015-09-16',1,0),(245,'2015-09-17',1,0),(246,'2015-09-18',1,0),(247,'2015-09-21',1,0),(248,'2015-09-22',1,0),(249,'2015-09-23',1,0),(250,'2015-09-24',1,0),(251,'2015-09-25',1,0),(252,'2015-09-28',1,0),(253,'2015-09-29',1,0),(254,'2015-09-30',1,0),(255,'2015-10-08',1,0),(256,'2015-10-09',1,0),(257,'2015-10-12',1,0),(258,'2015-10-13',1,0),(259,'2015-10-14',1,0),(260,'2015-10-15',1,0),(261,'2015-10-16',1,0),(262,'2015-10-19',1,0),(263,'2015-10-20',1,0),(264,'2015-10-21',1,0),(265,'2015-10-22',1,0),(266,'2015-10-23',1,0),(267,'2015-10-26',1,0),(268,'2015-10-27',1,0),(269,'2015-10-28',1,0),(270,'2015-10-29',1,0),(271,'2015-10-30',1,0),(272,'2015-11-02',1,0),(273,'2015-11-03',1,0),(274,'2015-11-04',1,0),(275,'2015-11-05',1,0),(276,'2015-11-06',1,0),(277,'2015-11-09',1,0),(278,'2015-11-10',1,0),(279,'2015-11-11',1,0),(280,'2015-11-12',1,0),(281,'2015-11-13',1,0),(282,'2015-11-16',1,0),(283,'2015-11-17',1,0),(284,'2015-11-18',1,0),(285,'2015-11-19',1,0),(286,'2015-11-20',1,0),(287,'2015-11-23',1,0),(288,'2015-11-24',1,0),(289,'2015-11-25',1,0),(290,'2015-11-26',1,0),(291,'2015-11-27',1,0),(292,'2015-11-30',1,0),(293,'2015-12-01',1,0),(294,'2015-12-02',1,0),(295,'2015-12-03',1,0),(296,'2015-12-04',1,0),(297,'2015-12-07',1,0),(298,'2015-12-08',1,0),(299,'2015-12-09',1,0),(300,'2015-12-10',1,0),(301,'2015-12-11',1,0),(302,'2015-12-14',1,0),(303,'2015-12-15',1,0),(304,'2015-12-16',1,0),(305,'2015-12-17',1,0),(306,'2015-12-18',1,0),(307,'2015-12-21',1,0),(308,'2015-12-22',1,0),(309,'2015-12-23',1,0),(310,'2015-12-24',1,0),(311,'2015-12-25',1,0),(312,'2015-12-28',1,0),(313,'2015-12-29',1,0),(314,'2015-12-30',1,0),(315,'2015-12-31',1,0),(316,'2016-01-04',1,0),(317,'2016-01-05',1,0),(318,'2016-01-06',1,0),(319,'2016-01-07',1,0),(320,'2016-01-08',1,0),(321,'2016-01-11',1,0),(322,'2016-01-12',1,0),(323,'2016-01-13',1,0),(324,'2016-01-14',1,0),(325,'2016-01-15',1,0),(326,'2016-01-18',1,0),(327,'2016-01-19',1,0),(328,'2016-01-20',1,0),(329,'2016-01-21',1,0),(330,'2016-01-22',1,0),(331,'2016-01-25',1,0),(332,'2016-01-26',1,0),(333,'2016-01-27',1,0),(334,'2016-01-28',1,0),(335,'2016-01-29',1,0),(336,'2016-02-01',1,0),(337,'2016-02-02',1,0),(338,'2016-02-03',1,0),(339,'2016-02-04',1,0),(340,'2016-02-05',1,0),(341,'2016-02-15',1,0),(342,'2016-02-16',1,0),(343,'2016-02-17',1,0),(344,'2016-02-18',1,0),(345,'2016-02-19',1,0),(346,'2016-02-22',1,0),(347,'2016-02-23',1,0),(348,'2016-02-24',1,0),(349,'2016-02-25',1,0),(350,'2016-02-26',1,0),(351,'2016-02-29',1,0),(352,'2016-03-01',1,0),(353,'2016-03-02',1,0),(354,'2016-03-03',1,0),(355,'2016-03-04',1,0),(356,'2016-03-07',1,0),(357,'2016-03-08',1,0),(358,'2016-03-09',1,0),(359,'2016-03-10',1,0),(360,'2016-03-11',1,0),(361,'2016-03-14',1,0),(362,'2016-03-15',1,0),(363,'2016-03-16',1,0),(364,'2016-03-17',1,0),(365,'2016-03-18',1,0),(366,'2016-03-21',1,0),(367,'2016-03-22',1,0),(368,'2016-03-23',1,0),(369,'2016-03-24',1,0),(370,'2016-03-25',1,0),(371,'2016-03-28',1,0),(372,'2016-03-29',1,0),(373,'2016-03-30',1,0),(374,'2016-03-31',1,0),(375,'2016-04-01',1,0),(376,'2016-04-05',1,0),(377,'2016-04-06',1,0),(378,'2016-04-07',1,0),(379,'2016-04-08',1,0),(380,'2016-04-11',1,0),(381,'2016-04-12',1,0),(382,'2016-04-13',1,0),(383,'2016-04-14',1,0),(384,'2016-04-15',1,0),(385,'2016-04-18',1,0),(386,'2016-04-19',1,0),(387,'2016-04-20',1,0),(388,'2016-04-21',1,0),(389,'2016-04-22',1,0),(390,'2016-04-25',1,0),(391,'2016-04-26',1,0),(392,'2016-04-27',1,0),(393,'2016-04-28',1,0),(394,'2016-04-29',1,0),(395,'2016-05-03',1,0),(396,'2016-05-04',1,0),(397,'2016-05-05',1,0),(398,'2016-05-06',1,0),(399,'2016-05-09',1,0),(400,'2016-05-10',1,0),(401,'2016-05-11',1,0),(402,'2016-05-12',1,0),(403,'2016-05-13',1,0),(404,'2016-05-16',1,0),(405,'2016-05-17',1,0),(406,'2016-05-18',1,0),(407,'2016-05-19',1,0),(408,'2016-05-20',1,0),(409,'2016-05-23',1,0),(410,'2016-05-24',1,0),(411,'2016-05-25',1,0),(412,'2016-05-26',1,0),(413,'2016-05-27',1,0),(414,'2016-05-30',1,0),(415,'2016-05-31',1,0),(416,'2016-06-01',1,0),(417,'2016-06-02',1,0),(418,'2016-06-03',1,0),(419,'2016-06-06',1,0),(420,'2016-06-07',1,0),(421,'2016-06-08',1,0),(422,'2016-06-13',1,0),(423,'2016-06-14',1,0),(424,'2016-06-15',1,0),(425,'2016-06-16',1,0),(426,'2016-06-17',1,0),(427,'2016-06-20',1,0),(428,'2016-06-21',1,0),(429,'2016-06-22',1,0),(430,'2016-06-23',1,0),(431,'2016-06-24',1,0),(432,'2016-06-27',1,0),(433,'2016-06-28',1,0),(434,'2016-06-29',1,0),(435,'2016-06-30',1,0),(436,'2016-07-01',1,0),(437,'2016-07-04',1,0),(438,'2016-07-05',1,0),(439,'2016-07-06',1,0),(440,'2016-07-07',1,0),(441,'2016-07-08',1,0),(442,'2016-07-11',1,0),(443,'2016-07-12',1,0),(444,'2016-07-13',1,0),(445,'2016-07-14',1,0),(446,'2016-07-15',1,0),(447,'2016-07-18',1,0),(448,'2016-07-19',1,0),(449,'2016-07-20',1,0),(450,'2016-07-21',1,0),(451,'2016-07-22',1,0),(452,'2016-07-25',1,0),(453,'2016-07-26',1,0),(454,'2016-07-27',1,0),(455,'2016-07-28',1,0),(456,'2016-07-29',1,0),(457,'2016-08-01',1,0),(458,'2016-08-02',1,0),(459,'2016-08-03',1,0),(460,'2016-08-04',1,0),(461,'2016-08-05',1,0),(462,'2016-08-08',1,0),(463,'2016-08-09',1,0),(464,'2016-08-10',1,0),(465,'2016-08-11',1,0),(466,'2016-08-12',1,0),(467,'2016-08-15',1,0),(468,'2016-08-16',1,0),(469,'2016-08-17',1,0),(470,'2016-08-18',1,0),(471,'2016-08-19',1,0),(472,'2016-08-22',1,0),(473,'2016-08-23',1,0),(474,'2016-08-24',1,0),(475,'2016-08-25',1,0),(476,'2016-08-26',1,0),(477,'2016-08-29',1,0),(478,'2016-08-30',1,0),(479,'2016-08-31',1,0),(480,'2016-09-01',1,0),(481,'2016-09-02',1,0),(482,'2016-09-05',1,0),(483,'2016-09-06',1,0),(484,'2016-09-07',1,0),(485,'2016-09-08',1,0),(486,'2016-09-09',1,0),(487,'2016-09-12',1,0),(488,'2016-09-13',1,0),(489,'2016-09-14',1,0),(490,'2016-09-19',1,0),(491,'2016-09-20',1,0),(492,'2016-09-21',1,0),(493,'2016-09-22',1,0),(494,'2016-09-23',1,0),(495,'2016-09-26',1,0),(496,'2016-09-27',1,0),(497,'2016-09-28',1,0),(498,'2016-09-29',1,0),(499,'2016-09-30',1,0),(500,'2016-10-10',1,0),(501,'2016-10-11',1,0),(502,'2016-10-12',1,0),(503,'2016-10-13',1,0),(504,'2016-10-14',1,0),(505,'2016-10-17',1,0),(506,'2016-10-18',1,0),(507,'2016-10-19',1,0),(508,'2016-10-20',1,0),(509,'2016-10-21',1,0),(510,'2016-10-24',1,0),(511,'2016-10-25',1,0),(512,'2016-10-26',1,0),(513,'2016-10-27',1,0),(514,'2016-10-28',1,0),(515,'2016-10-31',1,0),(516,'2016-11-01',1,0),(517,'2016-11-02',1,0),(518,'2016-11-03',1,0),(519,'2016-11-04',1,0),(520,'2016-11-07',1,0),(521,'2016-11-08',1,0),(522,'2016-11-09',1,0),(523,'2016-11-10',1,0),(524,'2016-11-11',1,0),(525,'2016-11-14',1,0),(526,'2016-11-15',1,0),(527,'2016-11-16',1,0),(528,'2016-11-17',1,0),(529,'2016-11-18',1,0),(530,'2016-11-21',1,0),(531,'2016-11-22',1,0),(532,'2016-11-23',1,0),(533,'2016-11-24',1,0),(534,'2016-11-25',1,0),(535,'2016-11-28',1,0),(536,'2016-11-29',1,0),(537,'2016-11-30',1,0),(538,'2016-12-01',1,0),(539,'2016-12-02',1,0),(540,'2016-12-05',1,0),(541,'2016-12-06',1,0),(542,'2016-12-07',1,0),(543,'2016-12-08',1,0),(544,'2016-12-09',1,0),(545,'2016-12-12',1,0),(546,'2016-12-13',1,0),(547,'2016-12-14',1,0),(548,'2016-12-15',1,0),(549,'2016-12-16',1,0),(550,'2016-12-19',1,0),(551,'2016-12-20',1,0),(552,'2016-12-21',1,0),(553,'2016-12-22',1,0),(554,'2016-12-23',1,0),(555,'2016-12-26',1,0),(556,'2016-12-27',1,0),(557,'2016-12-28',1,0),(558,'2016-12-29',1,0),(559,'2016-12-30',1,0),(560,'2015-01-10',0,0),(561,'2015-01-11',0,0),(562,'2015-01-17',0,0),(563,'2015-01-18',0,0),(564,'2015-01-24',0,0),(565,'2015-01-25',0,0),(566,'2015-01-31',0,0),(567,'2015-02-01',0,0),(568,'2015-02-07',0,0),(569,'2015-02-08',0,0),(570,'2015-02-14',0,0),(571,'2015-03-01',0,0),(572,'2015-03-07',0,0),(573,'2015-03-08',0,0),(574,'2015-03-14',0,0),(575,'2015-03-15',0,0),(576,'2015-03-21',0,0),(577,'2015-03-22',0,0),(578,'2015-03-28',0,0),(579,'2015-03-29',0,0),(580,'2015-04-11',0,0),(581,'2015-04-12',0,0),(582,'2015-04-18',0,0),(583,'2015-04-19',0,0),(584,'2015-04-25',0,0),(585,'2015-04-26',0,0),(586,'2015-05-09',0,0),(587,'2015-05-10',0,0),(588,'2015-05-16',0,0),(589,'2015-05-17',0,0),(590,'2015-05-23',0,0),(591,'2015-05-24',0,0),(592,'2015-05-30',0,0),(593,'2015-05-31',0,0),(594,'2015-06-06',0,0),(595,'2015-06-07',0,0),(596,'2015-06-13',0,0),(597,'2015-06-14',0,0),(598,'2015-06-27',0,0),(599,'2015-06-28',0,0),(600,'2015-07-04',0,0),(601,'2015-07-05',0,0),(602,'2015-07-11',0,0),(603,'2015-07-12',0,0),(604,'2015-07-18',0,0),(605,'2015-07-19',0,0),(606,'2015-07-25',0,0),(607,'2015-07-26',0,0),(608,'2015-08-01',0,0),(609,'2015-08-02',0,0),(610,'2015-08-08',0,0),(611,'2015-08-09',0,0),(612,'2015-08-15',0,0),(613,'2015-08-16',0,0),(614,'2015-08-22',0,0),(615,'2015-08-23',0,0),(616,'2015-08-29',0,0),(617,'2015-08-30',0,0),(618,'2015-09-12',0,0),(619,'2015-09-13',0,0),(620,'2015-09-19',0,0),(621,'2015-09-20',0,0),(622,'2015-10-11',0,0),(623,'2015-10-17',0,0),(624,'2015-10-18',0,0),(625,'2015-10-24',0,0),(626,'2015-10-25',0,0),(627,'2015-10-31',0,0),(628,'2015-11-01',0,0),(629,'2015-11-07',0,0),(630,'2015-11-08',0,0),(631,'2015-11-14',0,0),(632,'2015-11-15',0,0),(633,'2015-11-21',0,0),(634,'2015-11-22',0,0),(635,'2015-11-28',0,0),(636,'2015-11-29',0,0),(637,'2015-12-05',0,0),(638,'2015-12-06',0,0),(639,'2015-12-12',0,0),(640,'2015-12-13',0,0),(641,'2015-12-19',0,0),(642,'2015-12-20',0,0),(643,'2015-12-26',0,0),(644,'2015-12-27',0,0),(645,'2016-01-09',0,0),(646,'2016-01-10',0,0),(647,'2016-01-16',0,0),(648,'2016-01-17',0,0),(649,'2016-01-23',0,0),(650,'2016-01-24',0,0),(651,'2016-01-30',0,0),(652,'2016-01-31',0,0),(653,'2016-02-20',0,0),(654,'2016-02-21',0,0),(655,'2016-02-27',0,0),(656,'2016-02-28',0,0),(657,'2016-03-05',0,0),(658,'2016-03-06',0,0),(659,'2016-03-12',0,0),(660,'2016-03-13',0,0),(661,'2016-03-19',0,0),(662,'2016-03-20',0,0),(663,'2016-03-26',0,0),(664,'2016-03-27',0,0),(665,'2016-04-09',0,0),(666,'2016-04-10',0,0),(667,'2016-04-16',0,0),(668,'2016-04-17',0,0),(669,'2016-04-23',0,0),(670,'2016-04-24',0,0),(671,'2016-05-07',0,0),(672,'2016-05-08',0,0),(673,'2016-05-14',0,0),(674,'2016-05-15',0,0),(675,'2016-05-21',0,0),(676,'2016-05-22',0,0),(677,'2016-05-28',0,0),(678,'2016-05-29',0,0),(679,'2016-06-04',0,0),(680,'2016-06-05',0,0),(681,'2016-06-18',0,0),(682,'2016-06-19',0,0),(683,'2016-06-25',0,0),(684,'2016-06-26',0,0),(685,'2016-07-02',0,0),(686,'2016-07-03',0,0),(687,'2016-07-09',0,0),(688,'2016-07-10',0,0),(689,'2016-07-16',0,0),(690,'2016-07-17',0,0),(691,'2016-07-23',0,0),(692,'2016-07-24',0,0),(693,'2016-07-30',0,0),(694,'2016-07-31',0,0),(695,'2016-08-06',0,0),(696,'2016-08-07',0,0),(697,'2016-08-13',0,0),(698,'2016-08-14',0,0),(699,'2016-08-20',0,0),(700,'2016-08-21',0,0),(701,'2016-08-27',0,0),(702,'2016-08-28',0,0),(703,'2016-09-03',0,0),(704,'2016-09-04',0,0),(705,'2016-09-10',0,0),(706,'2016-09-11',0,0),(707,'2016-09-24',0,0),(708,'2016-09-25',0,0),(709,'2016-10-15',0,0),(710,'2016-10-16',0,0),(711,'2016-10-22',0,0),(712,'2016-10-23',0,0),(713,'2016-10-29',0,0),(714,'2016-10-30',0,0),(715,'2016-11-05',0,0),(716,'2016-11-06',0,0),(717,'2016-11-12',0,0),(718,'2016-11-13',0,0),(719,'2016-11-19',0,0),(720,'2016-11-20',0,0),(721,'2016-11-26',0,0),(722,'2016-11-27',0,0),(723,'2016-12-03',0,0),(724,'2016-12-04',0,0),(725,'2016-12-10',0,0),(726,'2016-12-11',0,0),(727,'2016-12-17',0,0),(728,'2016-12-18',0,0),(729,'2016-12-24',0,0),(730,'2016-12-25',0,0),(731,'2016-12-31',0,0),(732,'2017-01-01',0,0),(733,'2017-01-02',0,0),(734,'2017-01-22',1,0),(735,'2017-01-27',0,0),(736,'2017-01-28',0,0),(737,'2017-01-29',0,0),(738,'2017-01-30',0,0),(739,'2017-01-31',0,0),(740,'2017-02-01',0,0),(741,'2017-02-02',0,0),(742,'2017-02-04',1,0),(743,'2017-04-01',1,0),(744,'2017-04-02',0,0),(745,'2017-04-03',0,0),(746,'2017-04-04',0,0),(747,'2017-04-29',0,0),(748,'2017-04-30',0,0),(749,'2017-05-01',0,0),(750,'2017-05-27',1,0),(751,'2017-05-28',0,0),(752,'2017-05-29',0,0),(753,'2017-05-30',0,0),(754,'2017-09-30',1,0),(755,'2017-10-01',0,0),(756,'2017-10-02',0,0),(757,'2017-10-03',0,0),(758,'2017-10-04',0,0),(759,'2017-10-05',0,0),(760,'2017-10-06',0,0),(761,'2017-10-07',0,0),(762,'2017-10-08',0,0),(763,'2017-01-03',1,0),(764,'2017-01-04',1,0),(765,'2017-01-05',1,0),(766,'2017-01-06',1,0),(767,'2017-01-09',1,0),(768,'2017-01-10',1,0),(769,'2017-01-11',1,0),(770,'2017-01-12',1,0),(771,'2017-01-13',1,0),(772,'2017-01-16',1,0),(773,'2017-01-17',1,0),(774,'2017-01-18',1,0),(775,'2017-01-19',1,0),(776,'2017-01-20',1,0),(777,'2017-01-23',1,0),(778,'2017-01-24',1,0),(779,'2017-01-25',1,0),(780,'2017-01-26',1,0),(781,'2017-02-03',1,0),(782,'2017-02-06',1,0),(783,'2017-02-07',1,0),(784,'2017-02-08',1,0),(785,'2017-02-09',1,0),(786,'2017-02-10',1,0),(787,'2017-02-13',1,0),(788,'2017-02-14',1,0),(789,'2017-02-15',1,0),(790,'2017-02-16',1,0),(791,'2017-02-17',1,0),(792,'2017-02-20',1,0),(793,'2017-02-21',1,0),(794,'2017-02-22',1,0),(795,'2017-02-23',1,0),(796,'2017-02-24',1,0),(797,'2017-02-27',1,0),(798,'2017-02-28',1,0),(799,'2017-03-01',1,0),(800,'2017-03-02',1,0),(801,'2017-03-03',1,0),(802,'2017-03-06',1,0),(803,'2017-03-07',1,0),(804,'2017-03-08',1,0),(805,'2017-03-09',1,0),(806,'2017-03-10',1,0),(807,'2017-03-13',1,0),(808,'2017-03-14',1,0),(809,'2017-03-15',1,0),(810,'2017-03-16',1,0),(811,'2017-03-17',1,0),(812,'2017-03-20',1,0),(813,'2017-03-21',1,0),(814,'2017-03-22',1,0),(815,'2017-03-23',1,0),(816,'2017-03-24',1,0),(817,'2017-03-27',1,0),(818,'2017-03-28',1,0),(819,'2017-03-29',1,0),(820,'2017-03-30',1,0),(821,'2017-03-31',1,0),(822,'2017-04-05',1,0),(823,'2017-04-06',1,0),(824,'2017-04-07',1,0),(825,'2017-04-10',1,0),(826,'2017-04-11',1,0),(827,'2017-04-12',1,0),(828,'2017-04-13',1,0),(829,'2017-04-14',1,0),(830,'2017-04-17',1,0),(831,'2017-04-18',1,0),(832,'2017-04-19',1,0),(833,'2017-04-20',1,0),(834,'2017-04-21',1,0),(835,'2017-04-24',1,0),(836,'2017-04-25',1,0),(837,'2017-04-26',1,0),(838,'2017-04-27',1,0),(839,'2017-04-28',1,0),(840,'2017-05-02',1,0),(841,'2017-05-03',1,0),(842,'2017-05-04',1,0),(843,'2017-05-05',1,0),(844,'2017-05-08',1,0),(845,'2017-05-09',1,0),(846,'2017-05-10',1,0),(847,'2017-05-11',1,0),(848,'2017-05-12',1,0),(849,'2017-05-15',1,0),(850,'2017-05-16',1,0),(851,'2017-05-17',1,0),(852,'2017-05-18',1,0),(853,'2017-05-19',1,0),(854,'2017-05-22',1,0),(855,'2017-05-23',1,0),(856,'2017-05-24',1,0),(857,'2017-05-25',1,0),(858,'2017-05-26',1,0),(859,'2017-05-31',1,0),(860,'2017-06-01',1,0),(861,'2017-06-02',1,0),(862,'2017-06-05',1,0),(863,'2017-06-06',1,0),(864,'2017-06-07',1,0),(865,'2017-06-08',1,0),(866,'2017-06-09',1,0),(867,'2017-06-12',1,0),(868,'2017-06-13',1,0),(869,'2017-06-14',1,0),(870,'2017-06-15',1,0),(871,'2017-06-16',1,0),(872,'2017-06-19',1,0),(873,'2017-06-20',1,0),(874,'2017-06-21',1,0),(875,'2017-06-22',1,0),(876,'2017-06-23',1,0),(877,'2017-06-26',1,0),(878,'2017-06-27',1,0),(879,'2017-06-28',1,0),(880,'2017-06-29',1,0),(881,'2017-06-30',1,0),(882,'2017-07-03',1,0),(883,'2017-07-04',1,0),(884,'2017-07-05',1,0),(885,'2017-07-06',1,0),(886,'2017-07-07',1,0),(887,'2017-07-10',1,0),(888,'2017-07-11',1,0),(889,'2017-07-12',1,0),(890,'2017-07-13',1,0),(891,'2017-07-14',1,0),(892,'2017-07-17',1,0),(893,'2017-07-18',1,0),(894,'2017-07-19',1,0),(895,'2017-07-20',1,0),(896,'2017-07-21',1,0),(897,'2017-07-24',1,0),(898,'2017-07-25',1,0),(899,'2017-07-26',1,0),(900,'2017-07-27',1,0),(901,'2017-07-28',1,0),(902,'2017-07-31',1,0),(903,'2017-08-01',1,0),(904,'2017-08-02',1,0),(905,'2017-08-03',1,0),(906,'2017-08-04',1,0),(907,'2017-08-07',1,0),(908,'2017-08-08',1,0),(909,'2017-08-09',1,0),(910,'2017-08-10',1,0),(911,'2017-08-11',1,0),(912,'2017-08-14',1,0),(913,'2017-08-15',1,0),(914,'2017-08-16',1,0),(915,'2017-08-17',1,0),(916,'2017-08-18',1,0),(917,'2017-08-21',1,0),(918,'2017-08-22',1,0),(919,'2017-08-23',1,0),(920,'2017-08-24',1,0),(921,'2017-08-25',1,0),(922,'2017-08-28',1,0),(923,'2017-08-29',1,0),(924,'2017-08-30',1,0),(925,'2017-08-31',1,0),(926,'2017-09-01',1,0),(927,'2017-09-04',1,0),(928,'2017-09-05',1,0),(929,'2017-09-06',1,0),(930,'2017-09-07',1,0),(931,'2017-09-08',1,0),(932,'2017-09-11',1,0),(933,'2017-09-12',1,0),(934,'2017-09-13',1,0),(935,'2017-09-14',1,0),(936,'2017-09-15',1,0),(937,'2017-09-18',1,0),(938,'2017-09-19',1,0),(939,'2017-09-20',1,0),(940,'2017-09-21',1,0),(941,'2017-09-22',1,0),(942,'2017-09-25',1,0),(943,'2017-09-26',1,0),(944,'2017-09-27',1,0),(945,'2017-09-28',1,0),(946,'2017-09-29',1,0),(947,'2017-10-09',1,0),(948,'2017-10-10',1,0),(949,'2017-10-11',1,0),(950,'2017-10-12',1,0),(951,'2017-10-13',1,0),(952,'2017-10-16',1,0),(953,'2017-10-17',1,0),(954,'2017-10-18',1,0),(955,'2017-10-19',1,0),(956,'2017-10-20',1,0),(957,'2017-10-23',1,0),(958,'2017-10-24',1,0),(959,'2017-10-25',1,0),(960,'2017-10-26',1,0),(961,'2017-10-27',1,0),(962,'2017-10-30',1,0),(963,'2017-10-31',1,0),(964,'2017-11-01',1,0),(965,'2017-11-02',1,0),(966,'2017-11-03',1,0),(967,'2017-11-06',1,0),(968,'2017-11-07',1,0),(969,'2017-11-08',1,0),(970,'2017-11-09',1,0),(971,'2017-11-10',1,0),(972,'2017-11-13',1,0),(973,'2017-11-14',1,0),(974,'2017-11-15',1,0),(975,'2017-11-16',1,0),(976,'2017-11-17',1,0),(977,'2017-11-20',1,0),(978,'2017-11-21',1,0),(979,'2017-11-22',1,0),(980,'2017-11-23',1,0),(981,'2017-11-24',1,0),(982,'2017-11-27',1,0),(983,'2017-11-28',1,0),(984,'2017-11-29',1,0),(985,'2017-11-30',1,0),(986,'2017-12-01',1,0),(987,'2017-12-04',1,0),(988,'2017-12-05',1,0),(989,'2017-12-06',1,0),(990,'2017-12-07',1,0),(991,'2017-12-08',1,0),(992,'2017-12-11',1,0),(993,'2017-12-12',1,0),(994,'2017-12-13',1,0),(995,'2017-12-14',1,0),(996,'2017-12-15',1,0),(997,'2017-12-18',1,0),(998,'2017-12-19',1,0),(999,'2017-12-20',1,0),(1000,'2017-12-21',1,0),(1001,'2017-12-22',1,0),(1002,'2017-12-25',1,0),(1003,'2017-12-26',1,0),(1004,'2017-12-27',1,0),(1005,'2017-12-28',1,0),(1006,'2017-12-29',1,0),(1007,'2017-01-07',0,0),(1008,'2017-01-08',0,0),(1009,'2017-01-14',0,0),(1010,'2017-01-15',0,0),(1011,'2017-01-21',0,0),(1012,'2017-02-05',0,0),(1013,'2017-02-11',0,0),(1014,'2017-02-12',0,0),(1015,'2017-02-18',0,0),(1016,'2017-02-19',0,0),(1017,'2017-02-25',0,0),(1018,'2017-02-26',0,0),(1019,'2017-03-04',0,0),(1020,'2017-03-05',0,0),(1021,'2017-03-11',0,0),(1022,'2017-03-12',0,0),(1023,'2017-03-18',0,0),(1024,'2017-03-19',0,0),(1025,'2017-03-25',0,0),(1026,'2017-03-26',0,0),(1027,'2017-04-08',0,0),(1028,'2017-04-09',0,0),(1029,'2017-04-15',0,0),(1030,'2017-04-16',0,0),(1031,'2017-04-22',0,0),(1032,'2017-04-23',0,0),(1033,'2017-05-06',0,0),(1034,'2017-05-07',0,0),(1035,'2017-05-13',0,0),(1036,'2017-05-14',0,0),(1037,'2017-05-20',0,0),(1038,'2017-05-21',0,0),(1039,'2017-06-03',0,0),(1040,'2017-06-04',0,0),(1041,'2017-06-10',0,0),(1042,'2017-06-11',0,0),(1043,'2017-06-17',0,0),(1044,'2017-06-18',0,0),(1045,'2017-06-24',0,0),(1046,'2017-06-25',0,0),(1047,'2017-07-01',0,0),(1048,'2017-07-02',0,0),(1049,'2017-07-08',0,0),(1050,'2017-07-09',0,0),(1051,'2017-07-15',0,0),(1052,'2017-07-16',0,0),(1053,'2017-07-22',0,0),(1054,'2017-07-23',0,0),(1055,'2017-07-29',0,0),(1056,'2017-07-30',0,0),(1057,'2017-08-05',0,0),(1058,'2017-08-06',0,0),(1059,'2017-08-12',0,0),(1060,'2017-08-13',0,0),(1061,'2017-08-19',0,0),(1062,'2017-08-20',0,0),(1063,'2017-08-26',0,0),(1064,'2017-08-27',0,0),(1065,'2017-09-02',0,0),(1066,'2017-09-03',0,0),(1067,'2017-09-09',0,0),(1068,'2017-09-10',0,0),(1069,'2017-09-16',0,0),(1070,'2017-09-17',0,0),(1071,'2017-09-23',0,0),(1072,'2017-09-24',0,0),(1073,'2017-10-14',0,0),(1074,'2017-10-15',0,0),(1075,'2017-10-21',0,0),(1076,'2017-10-22',0,0),(1077,'2017-10-28',0,0),(1078,'2017-10-29',0,0),(1079,'2017-11-04',0,0),(1080,'2017-11-05',0,0),(1081,'2017-11-11',0,0),(1082,'2017-11-12',0,0),(1083,'2017-11-18',0,0),(1084,'2017-11-19',0,0),(1085,'2017-11-25',0,0),(1086,'2017-11-26',0,0),(1087,'2017-12-02',0,0),(1088,'2017-12-03',0,0),(1089,'2017-12-09',0,0),(1090,'2017-12-10',0,0),(1091,'2017-12-16',0,0),(1092,'2017-12-17',0,0),(1093,'2017-12-23',0,0),(1094,'2017-12-24',0,0),(1095,'2017-12-30',0,0),(1096,'2017-12-31',0,0);
/*!40000 ALTER TABLE `ent_template_holiday_arrangement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_inform`
--

DROP TABLE IF EXISTS `ent_template_inform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_inform` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` varchar(255) NOT NULL,
  `to_user_id` varchar(255) NOT NULL,
  `seestate` varchar(1) NOT NULL DEFAULT '否',
  `seetime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_inform`
--

LOCK TABLES `ent_template_inform` WRITE;
/*!40000 ALTER TABLE `ent_template_inform` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_inform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_inform_message`
--

DROP TABLE IF EXISTS `ent_template_inform_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_inform_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `to_user_id` text NOT NULL,
  `title` text NOT NULL,
  `content` text NOT NULL,
  `sendcount` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_inform_message`
--

LOCK TABLES `ent_template_inform_message` WRITE;
/*!40000 ALTER TABLE `ent_template_inform_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_inform_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_information_app`
--

DROP TABLE IF EXISTS `ent_template_information_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_information_app` (
  `id` varchar(40) NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `lastmodify` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_information_app`
--

LOCK TABLES `ent_template_information_app` WRITE;
/*!40000 ALTER TABLE `ent_template_information_app` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_information_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_information_category`
--

DROP TABLE IF EXISTS `ent_template_information_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_information_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_information_category`
--

LOCK TABLES `ent_template_information_category` WRITE;
/*!40000 ALTER TABLE `ent_template_information_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_information_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_information_config`
--

DROP TABLE IF EXISTS `ent_template_information_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_information_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(40) NOT NULL,
  `table_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `config` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_information_config`
--

LOCK TABLES `ent_template_information_config` WRITE;
/*!40000 ALTER TABLE `ent_template_information_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_information_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_information_intimacy`
--

DROP TABLE IF EXISTS `ent_template_information_intimacy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_information_intimacy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL,
  `friend_id` varchar(30) NOT NULL,
  `intimacy` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_friend_id` (`user_id`,`friend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_information_intimacy`
--

LOCK TABLES `ent_template_information_intimacy` WRITE;
/*!40000 ALTER TABLE `ent_template_information_intimacy` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_information_intimacy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_information_remind`
--

DROP TABLE IF EXISTS `ent_template_information_remind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_information_remind` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `table_id` varchar(255) NOT NULL,
  `record_id` int(11) NOT NULL,
  `action` tinyint(4) NOT NULL,
  `relation` varchar(255) DEFAULT NULL,
  `create_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid_tid_rid` (`user_id`,`table_id`,`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_information_remind`
--

LOCK TABLES `ent_template_information_remind` WRITE;
/*!40000 ALTER TABLE `ent_template_information_remind` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_information_remind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_information_remindcount`
--

DROP TABLE IF EXISTS `ent_template_information_remindcount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_information_remindcount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(40) NOT NULL DEFAULT '0',
  `table_id` varchar(50) NOT NULL DEFAULT '0',
  `user_id` varchar(45) NOT NULL DEFAULT '0',
  `counts` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `appId_user_id` (`app_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_information_remindcount`
--

LOCK TABLES `ent_template_information_remindcount` WRITE;
/*!40000 ALTER TABLE `ent_template_information_remindcount` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_information_remindcount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_information_share`
--

DROP TABLE IF EXISTS `ent_template_information_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_information_share` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(40) NOT NULL,
  `table_id` varchar(255) NOT NULL,
  `slave_table_id` varchar(255) DEFAULT NULL,
  `record_id` int(11) NOT NULL,
  `slave_record_id` varchar(255) DEFAULT '0',
  `creator` varchar(30) NOT NULL,
  `receiver` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_table_record` (`app_id`,`table_id`,`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_information_share`
--

LOCK TABLES `ent_template_information_share` WRITE;
/*!40000 ALTER TABLE `ent_template_information_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_information_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_information_watch`
--

DROP TABLE IF EXISTS `ent_template_information_watch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_information_watch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(40) NOT NULL,
  `table_id` varchar(255) NOT NULL DEFAULT '',
  `remark` int(11) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `isNew` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_information_watch`
--

LOCK TABLES `ent_template_information_watch` WRITE;
/*!40000 ALTER TABLE `ent_template_information_watch` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_information_watch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_log_recyclebin`
--

DROP TABLE IF EXISTS `ent_template_log_recyclebin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_log_recyclebin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_id` varchar(50) NOT NULL DEFAULT '0',
  `user_id` varchar(45) NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_log_recyclebin`
--

LOCK TABLES `ent_template_log_recyclebin` WRITE;
/*!40000 ALTER TABLE `ent_template_log_recyclebin` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_log_recyclebin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_menu_counts`
--

DROP TABLE IF EXISTS `ent_template_menu_counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_menu_counts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `menu_id` int(11) DEFAULT NULL,
  `url` varchar(150) DEFAULT NULL COMMENT '菜单链接地址',
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单使用次数统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_menu_counts`
--

LOCK TABLES `ent_template_menu_counts` WRITE;
/*!40000 ALTER TABLE `ent_template_menu_counts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_menu_counts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_message_content`
--

DROP TABLE IF EXISTS `ent_template_message_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_message_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `content` text NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_message_content`
--

LOCK TABLES `ent_template_message_content` WRITE;
/*!40000 ALTER TABLE `ent_template_message_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_message_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_message_notice`
--

DROP TABLE IF EXISTS `ent_template_message_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_message_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `app_config` varchar(255) NOT NULL,
  `send_user` varchar(255) NOT NULL COMMENT '发送用户',
  `to_user` varchar(255) NOT NULL COMMENT '接收用户',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态(0:未读|1:已读)',
  `app` varchar(15) NOT NULL COMMENT '消息通知应用',
  `app_key` varchar(100) NOT NULL COMMENT '消息通知应用key',
  `content_id` int(11) DEFAULT NULL COMMENT '关联内容id',
  `notice_type` varchar(100) DEFAULT NULL COMMENT '通知类型',
  `isShow` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '显示(true:显示|false:不显示)',
  PRIMARY KEY (`id`),
  KEY `to_user` (`to_user`),
  KEY `content_id` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_message_notice`
--

LOCK TABLES `ent_template_message_notice` WRITE;
/*!40000 ALTER TABLE `ent_template_message_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_message_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_message_switch`
--

DROP TABLE IF EXISTS `ent_template_message_switch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_message_switch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL,
  `rule_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_message_switch`
--

LOCK TABLES `ent_template_message_switch` WRITE;
/*!40000 ALTER TABLE `ent_template_message_switch` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_message_switch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_message_switchrules`
--

DROP TABLE IF EXISTS `ent_template_message_switchrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_message_switchrules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workflow_definition_id` longtext,
  `todo` varchar(50) NOT NULL DEFAULT 'app',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_message_switchrules`
--

LOCK TABLES `ent_template_message_switchrules` WRITE;
/*!40000 ALTER TABLE `ent_template_message_switchrules` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_message_switchrules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_mobile_messagesend`
--

DROP TABLE IF EXISTS `ent_template_mobile_messagesend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_mobile_messagesend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(15) NOT NULL,
  `app_key` varchar(100) NOT NULL,
  `app_id` int(11) NOT NULL,
  `send_user` varchar(30) NOT NULL COMMENT '信息创建者',
  `to_user` text NOT NULL COMMENT '信息接收方',
  `params` text NOT NULL COMMENT '信息',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_mobile_messagesend`
--

LOCK TABLES `ent_template_mobile_messagesend` WRITE;
/*!40000 ALTER TABLE `ent_template_mobile_messagesend` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_mobile_messagesend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_navigation`
--

DROP TABLE IF EXISTS `ent_template_navigation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_navigation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `permission` text,
  `icon_url` varchar(255) DEFAULT NULL,
  `width` varchar(255) DEFAULT NULL,
  `height` varchar(255) DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  `color` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_navigation`
--

LOCK TABLES `ent_template_navigation` WRITE;
/*!40000 ALTER TABLE `ent_template_navigation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_navigation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_navigation_item`
--

DROP TABLE IF EXISTS `ent_template_navigation_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_navigation_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `navigation_id` int(11) DEFAULT NULL,
  `icon_url` varchar(255) DEFAULT NULL,
  `gray_url` varchar(255) DEFAULT NULL,
  `submenu` text,
  `permission` text,
  `block_group` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_navigation_item`
--

LOCK TABLES `ent_template_navigation_item` WRITE;
/*!40000 ALTER TABLE `ent_template_navigation_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_navigation_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_org`
--

DROP TABLE IF EXISTS `ent_template_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_org` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `type` enum('department','role') NOT NULL COMMENT '类型 department:部门 role:岗位',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '层级',
  `parent` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父节点',
  `order` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(30) NOT NULL COMMENT '节点名称',
  `pinyin` varchar(255) NOT NULL DEFAULT '' COMMENT '节点名称-拼音,为了拼音搜索',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '节点描述信息',
  `assign` text COMMENT '节点权限,即节点可被谁查看',
  PRIMARY KEY (`id`),
  KEY `name` (`name`) USING BTREE,
  KEY `pinyin` (`pinyin`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_org`
--

LOCK TABLES `ent_template_org` WRITE;
/*!40000 ALTER TABLE `ent_template_org` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_org` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_org_history`
--

DROP TABLE IF EXISTS `ent_template_org_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_org_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `operate` varchar(50) DEFAULT NULL COMMENT '组织架构历史记录类型',
  `modifier` varchar(40) DEFAULT NULL COMMENT '修改人user_id',
  `time` datetime DEFAULT NULL COMMENT '修改时间',
  `target_org_id` int(11) DEFAULT NULL COMMENT '编辑的节点id',
  `target_org_name` varchar(30) NOT NULL COMMENT '编辑的节点名称',
  `unique_id` varchar(255) DEFAULT NULL COMMENT '直接上级所在的父级节点',
  `info` text COMMENT '编辑节点|用户信息',
  `appoint` text COMMENT '直接上级所在的父级节点',
  `disabled` enum('false','true') NOT NULL DEFAULT 'false' COMMENT '设置',
  `truster` varchar(255) DEFAULT NULL COMMENT '设置用户托管人',
  `sort` text COMMENT '节点排序记录',
  `leader` text COMMENT '用户|节点编辑直接上级记录',
  `search` text COMMENT '根据关键信息集合出来的内容,以备搜索',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_org_history`
--

LOCK TABLES `ent_template_org_history` WRITE;
/*!40000 ALTER TABLE `ent_template_org_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_org_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_org_leader`
--

DROP TABLE IF EXISTS `ent_template_org_leader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_org_leader` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型 1:节点  2:用户',
  `value` varchar(30) NOT NULL COMMENT '节点id  | 用户user_id',
  `user_id` varchar(30) NOT NULL COMMENT '直接上级的用户id',
  `parent` int(10) unsigned NOT NULL COMMENT '直接上级所在的父级节点',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_orgId_or_type_userId` (`type`,`value`) USING BTREE,
  KEY `user_id_type` (`user_id`,`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_org_leader`
--

LOCK TABLES `ent_template_org_leader` WRITE;
/*!40000 ALTER TABLE `ent_template_org_leader` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_org_leader` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_org_node_config`
--

DROP TABLE IF EXISTS `ent_template_org_node_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_org_node_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(100) NOT NULL COMMENT '用户ID',
  `node_id` int(10) unsigned NOT NULL COMMENT '节点ID',
  `config` text NOT NULL COMMENT '配置详情',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_node` (`user_id`,`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_org_node_config`
--

LOCK TABLES `ent_template_org_node_config` WRITE;
/*!40000 ALTER TABLE `ent_template_org_node_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_org_node_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_org_order`
--

DROP TABLE IF EXISTS `ent_template_org_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_org_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(30) NOT NULL COMMENT '用户id',
  `parent_id` smallint(6) NOT NULL COMMENT '所在节点',
  `order` smallint(6) NOT NULL COMMENT '用户在此节点下的排序',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `order` (`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tinyint';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_org_order`
--

LOCK TABLES `ent_template_org_order` WRITE;
/*!40000 ALTER TABLE `ent_template_org_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_org_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_org_tree`
--

DROP TABLE IF EXISTS `ent_template_org_tree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_org_tree` (
  `ancestor` int(11) unsigned NOT NULL COMMENT '节点直属上级',
  `descendant` int(11) unsigned NOT NULL COMMENT '节点直属下级',
  PRIMARY KEY (`ancestor`,`descendant`),
  KEY `descendant` (`descendant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_org_tree`
--

LOCK TABLES `ent_template_org_tree` WRITE;
/*!40000 ALTER TABLE `ent_template_org_tree` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_org_tree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_qrcode`
--

DROP TABLE IF EXISTS `ent_template_qrcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_qrcode` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `appId` varchar(40) NOT NULL,
  `config` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_qrcode`
--

LOCK TABLES `ent_template_qrcode` WRITE;
/*!40000 ALTER TABLE `ent_template_qrcode` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_qrcode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_racl_list`
--

DROP TABLE IF EXISTS `ent_template_racl_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_racl_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(50) NOT NULL,
  `key` varchar(50) NOT NULL,
  `rid` int(11) NOT NULL,
  `privilege` varchar(50) NOT NULL,
  `blacklist` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_racl_list`
--

LOCK TABLES `ent_template_racl_list` WRITE;
/*!40000 ALTER TABLE `ent_template_racl_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_racl_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_racl_rule`
--

DROP TABLE IF EXISTS `ent_template_racl_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_racl_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(45) DEFAULT NULL,
  `role_type` varchar(45) DEFAULT NULL,
  `app` varchar(45) DEFAULT NULL,
  `resource_id` varchar(45) DEFAULT NULL,
  `privilege` varchar(45) DEFAULT NULL,
  `rule_type` varchar(45) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_racl_rule`
--

LOCK TABLES `ent_template_racl_rule` WRITE;
/*!40000 ALTER TABLE `ent_template_racl_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_racl_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_relationdc`
--

DROP TABLE IF EXISTS `ent_template_relationdc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_relationdc` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `app` varchar(40) NOT NULL,
  `app_id` varchar(40) NOT NULL,
  `table_id` varchar(40) NOT NULL,
  `record_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_condition` (`app`,`app_id`,`table_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_relationdc`
--

LOCK TABLES `ent_template_relationdc` WRITE;
/*!40000 ALTER TABLE `ent_template_relationdc` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_relationdc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_role_authorization`
--

DROP TABLE IF EXISTS `ent_template_role_authorization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_role_authorization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) NOT NULL,
  `department_id` varchar(10) DEFAULT '1',
  `roles` text,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_role_authorization`
--

LOCK TABLES `ent_template_role_authorization` WRITE;
/*!40000 ALTER TABLE `ent_template_role_authorization` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_role_authorization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_rulesengin_category`
--

DROP TABLE IF EXISTS `ent_template_rulesengin_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_rulesengin_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(50) NOT NULL COMMENT '节点名称',
  `parent_id` int(11) NOT NULL COMMENT '节点的父级节点',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='规则设置分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_rulesengin_category`
--

LOCK TABLES `ent_template_rulesengin_category` WRITE;
/*!40000 ALTER TABLE `ent_template_rulesengin_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_rulesengin_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_rulesengin_list`
--

DROP TABLE IF EXISTS `ent_template_rulesengin_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_rulesengin_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(50) NOT NULL COMMENT '规则名称',
  `method` enum('timer','plugin') NOT NULL DEFAULT 'timer' COMMENT '规则类型 timer:定时触发 plugin:钩子触发',
  `start` varchar(50) NOT NULL COMMENT '触发器类型:dataflow:数据流 workflow:工作流 info:数据流中的某张表',
  `result` varchar(50) NOT NULL COMMENT '接收器类型:datanotice:数据提醒 workflow:工作流 info:数据流中的某张表 webhook:外部数据传输机制',
  `startrules` text NOT NULL COMMENT '触发器规则',
  `resultrules` text NOT NULL COMMENT '接收器规则',
  `description` varchar(255) DEFAULT '' COMMENT '规则描述',
  `created_at` datetime NOT NULL COMMENT '规则创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '规则状态:1:启用  0:停用',
  `parent_id` int(11) NOT NULL DEFAULT '-1' COMMENT '规则所属节点',
  `app_parent_id` int(11) DEFAULT '0' COMMENT '规则所属的应用中心模块,根据触发器应用所在模块为主',
  PRIMARY KEY (`id`),
  KEY `app_parent_id` (`app_parent_id`),
  KEY `status_method` (`status`,`method`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_rulesengin_list`
--

LOCK TABLES `ent_template_rulesengin_list` WRITE;
/*!40000 ALTER TABLE `ent_template_rulesengin_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_rulesengin_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_rulesengin_log`
--

DROP TABLE IF EXISTS `ent_template_rulesengin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_rulesengin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `ruleid` int(11) NOT NULL COMMENT '规则id',
  `title` varchar(255) NOT NULL COMMENT '此规则触发的内容简述',
  `data` text NOT NULL COMMENT '最终影响到的数据',
  `description` text NOT NULL COMMENT '规则描述',
  `created_at` datetime DEFAULT NULL COMMENT '规则创建时间',
  `status` tinyint(1) NOT NULL COMMENT '执行状态 1:成功 0:失败',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_rulesengin_log`
--

LOCK TABLES `ent_template_rulesengin_log` WRITE;
/*!40000 ALTER TABLE `ent_template_rulesengin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_rulesengin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_rulesengin_valid`
--

DROP TABLE IF EXISTS `ent_template_rulesengin_valid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_rulesengin_valid` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `ruleid` int(11) NOT NULL COMMENT '规则id',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用此规则:1:启用  0:停用',
  `validconfig` text NOT NULL COMMENT '触发条件配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_rulesengin_valid`
--

LOCK TABLES `ent_template_rulesengin_valid` WRITE;
/*!40000 ALTER TABLE `ent_template_rulesengin_valid` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_rulesengin_valid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_safety_monitorlist`
--

DROP TABLE IF EXISTS `ent_template_safety_monitorlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_safety_monitorlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联本表规则id',
  `relate_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联规则id',
  `type` varchar(30) NOT NULL COMMENT '规则类型',
  `type_name` varchar(30) NOT NULL COMMENT '规则类型 为搜索',
  `status` tinyint(1) DEFAULT '0' COMMENT '1 通过; -1|0 未通过; 2 撤销审核　3 待审批 4 默认生效',
  `create_at` varchar(30) NOT NULL COMMENT '创建者',
  `create_at_name` varchar(100) NOT NULL COMMENT '创建者(admin) 为搜索',
  `verified_at` varchar(30) NOT NULL COMMENT '审核人',
  `description` text NOT NULL COMMENT '摘要　描述　为搜索',
  `config` text NOT NULL COMMENT '原始配置',
  `monitor` text NOT NULL COMMENT '监控者',
  `be_monitor` text NOT NULL COMMENT '被监控者',
  `monitor_app` text NOT NULL COMMENT '监控应用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `trust_id` varchar(45) DEFAULT NULL COMMENT '托管人',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `status` (`status`),
  KEY `search` (`type_name`,`create_at_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_safety_monitorlist`
--

LOCK TABLES `ent_template_safety_monitorlist` WRITE;
/*!40000 ALTER TABLE `ent_template_safety_monitorlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_safety_monitorlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_sms`
--

DROP TABLE IF EXISTS `ent_template_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_sms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xingming` text NOT NULL,
  `mobie` text NOT NULL,
  `content` varchar(255) NOT NULL,
  `create_time` int(11) DEFAULT NULL,
  `rspcode` int(11) DEFAULT NULL,
  `rspdesc` varchar(255) DEFAULT NULL,
  `msgid` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_sms`
--

LOCK TABLES `ent_template_sms` WRITE;
/*!40000 ALTER TABLE `ent_template_sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_trust`
--

DROP TABLE IF EXISTS `ent_template_trust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_trust` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(25) NOT NULL,
  `app` varchar(25) NOT NULL,
  `truster` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_trust`
--

LOCK TABLES `ent_template_trust` WRITE;
/*!40000 ALTER TABLE `ent_template_trust` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_trust` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_unique_login`
--

DROP TABLE IF EXISTS `ent_template_unique_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_unique_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_modified` datetime NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `login_ip` varchar(255) NOT NULL,
  `login_place` varchar(255) NOT NULL,
  `opera_time` datetime NOT NULL,
  `opera_context` varchar(255) NOT NULL,
  `opera_browser` varchar(255) NOT NULL,
  `opera_system` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_unique_login`
--

LOCK TABLES `ent_template_unique_login` WRITE;
/*!40000 ALTER TABLE `ent_template_unique_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_unique_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_user`
--

DROP TABLE IF EXISTS `ent_template_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` varchar(30) NOT NULL COMMENT '用户id',
  `login_user_id` varchar(30) NOT NULL COMMENT '登录用户id',
  `real_name` varchar(30) NOT NULL COMMENT '真实姓名',
  `pinyin` varchar(255) NOT NULL DEFAULT '' COMMENT '姓名拼音',
  `avatar` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类型(0:企业用户|4:安全管理员|5:审计管理员|6:企业管理员|7:系统管理员)',
  `sex` int(1) NOT NULL DEFAULT '0',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `phone` char(11) DEFAULT NULL COMMENT '手机',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后一次登录时间',
  `is_ad_welcome` tinyint(1) DEFAULT NULL COMMENT '欢迎界面(0:不显示|1:显示)',
  `disabled` enum('false','true') DEFAULT 'false' COMMENT '禁用(true:禁用|false:启用)',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `last_modified` datetime NOT NULL COMMENT '最后一次被修改时间',
  `verify_two` tinyint(1) DEFAULT '0' COMMENT '两步验证(1:开启｜0:未开启)',
  `reset_pwd` tinyint(1) DEFAULT '0' COMMENT '重置密码(1:重置|0:未重置)',
  `theme` varchar(255) DEFAULT NULL COMMENT '界面主题',
  `birth_type` tinyint(1) DEFAULT '0' COMMENT '生日类型(0:公历|1:农历)',
  `entry_time` date DEFAULT NULL COMMENT '进入时间',
  `qq` varchar(32) DEFAULT '' COMMENT '用户QQ',
  `id_number` varchar(32) DEFAULT '' COMMENT '用户身份证号码',
  `ext_number` varchar(32) DEFAULT '' COMMENT '分机号',
  `main_job` varchar(128) DEFAULT '' COMMENT '主职',
  `duty` varchar(255) DEFAULT '' COMMENT '分工描述',
  `address` varchar(255) DEFAULT '' COMMENT '联系地址',
  `sign` varchar(255) NOT NULL DEFAULT '' COMMENT '个性签名',
  `isSecurity` enum('true','false') DEFAULT 'false' COMMENT '保密(true:保密|false:不保密)',
  `pw_grade` tinyint(1) DEFAULT NULL COMMENT '密码等级(NULL:极低|1:中等|3:较高)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`) USING BTREE,
  UNIQUE KEY `login_user_id` (`login_user_id`) USING BTREE,
  KEY `disabled` (`disabled`),
  KEY `real_name` (`real_name`) USING BTREE,
  KEY `pinyin` (`pinyin`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_user`
--

LOCK TABLES `ent_template_user` WRITE;
/*!40000 ALTER TABLE `ent_template_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_user_contacts`
--

DROP TABLE IF EXISTS `ent_template_user_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_user_contacts` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` varchar(30) NOT NULL COMMENT '用户id',
  `role_id` varchar(45) NOT NULL COMMENT '角色id',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '统计数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `last_modified` datetime DEFAULT NULL COMMENT '最后一次被修改时间',
  `type` varchar(255) DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_user_contacts`
--

LOCK TABLES `ent_template_user_contacts` WRITE;
/*!40000 ALTER TABLE `ent_template_user_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_user_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_user_group`
--

DROP TABLE IF EXISTS `ent_template_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `create_user` varchar(30) NOT NULL COMMENT '创建的用户',
  `group` longtext NOT NULL COMMENT '分组列表',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `disabled` enum('FALSE','TRUE') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'FALSE' COMMENT '禁用(true:禁用|false:未禁用)',
  PRIMARY KEY (`id`),
  KEY `disabled` (`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_user_group`
--

LOCK TABLES `ent_template_user_group` WRITE;
/*!40000 ALTER TABLE `ent_template_user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_user_trust`
--

DROP TABLE IF EXISTS `ent_template_user_trust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_user_trust` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL,
  `truster` varchar(30) NOT NULL,
  `disable` enum('false','true') NOT NULL DEFAULT 'false',
  `trusterorg` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_user_trust`
--

LOCK TABLES `ent_template_user_trust` WRITE;
/*!40000 ALTER TABLE `ent_template_user_trust` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_user_trust` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_user_trustconfig`
--

DROP TABLE IF EXISTS `ent_template_user_trustconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_user_trustconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL,
  `disabled` enum('false','true') NOT NULL DEFAULT 'false',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_user_trustconfig`
--

LOCK TABLES `ent_template_user_trustconfig` WRITE;
/*!40000 ALTER TABLE `ent_template_user_trustconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_user_trustconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_widget`
--

DROP TABLE IF EXISTS `ent_template_widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_widget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `type` enum('table','chart') NOT NULL,
  `icon` text NOT NULL,
  `color` varchar(20) NOT NULL,
  `size` int(2) NOT NULL,
  `app_id` varchar(50) NOT NULL,
  `create_time` datetime NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业管理员保存模块表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_widget`
--

LOCK TABLES `ent_template_widget` WRITE;
/*!40000 ALTER TABLE `ent_template_widget` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_widget_config`
--

DROP TABLE IF EXISTS `ent_template_widget_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_widget_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `widget_id` int(11) NOT NULL,
  `type` enum('ENTERPRISE','USER') NOT NULL,
  `sort` int(10) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `widget_type` enum('ENTERPRISE','SYSTEM') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业管理员模块配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_widget_config`
--

LOCK TABLES `ent_template_widget_config` WRITE;
/*!40000 ALTER TABLE `ent_template_widget_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_widget_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_widget_module_helper`
--

DROP TABLE IF EXISTS `ent_template_widget_module_helper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_widget_module_helper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logo` varchar(200) NOT NULL,
  `title` varchar(200) NOT NULL,
  `url` varchar(200) NOT NULL,
  `content` text,
  `sort` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_widget_module_helper`
--

LOCK TABLES `ent_template_widget_module_helper` WRITE;
/*!40000 ALTER TABLE `ent_template_widget_module_helper` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_widget_module_helper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_category`
--

DROP TABLE IF EXISTS `ent_template_workflow_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `workflow_id` varchar(40) DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_category`
--

LOCK TABLES `ent_template_workflow_category` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_category` DISABLE KEYS */;
INSERT INTO `ent_template_workflow_category` VALUES (1,'未分类',NULL,0);
/*!40000 ALTER TABLE `ent_template_workflow_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_definition`
--

DROP TABLE IF EXISTS `ent_template_workflow_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_definition` (
  `id` varchar(255) NOT NULL COMMENT '流程定义名称英文',
  `title` varchar(255) DEFAULT NULL COMMENT '流程定义名称',
  `created_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_definition`
--

LOCK TABLES `ent_template_workflow_definition` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_definition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_definition_node`
--

DROP TABLE IF EXISTS `ent_template_workflow_definition_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_definition_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `version_id` int(11) DEFAULT NULL COMMENT '版本id',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `key` varchar(100) DEFAULT NULL COMMENT '配置节点id',
  `type` varchar(255) DEFAULT NULL COMMENT '节点类型(system|general)',
  `assigned_to` text COMMENT '废弃',
  `assigned_method` varchar(40) DEFAULT NULL COMMENT '分配类型',
  `datacenter_method` text COMMENT '数据显示方式',
  `executor_method` varchar(40) NOT NULL DEFAULT 'all' COMMENT '执行人方式',
  `push_method` text COMMENT '数据推送配置',
  `dynamic_assigned_to` mediumtext COMMENT '动态执行人',
  `regression` text COMMENT '关联节点',
  `deadline` text COMMENT '超时配置',
  `datafields` text COMMENT '可写字段',
  `executor` longtext COMMENT '执行人配置',
  PRIMARY KEY (`id`),
  UNIQUE KEY `version_id` (`version_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_definition_node`
--

LOCK TABLES `ent_template_workflow_definition_node` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_definition_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_definition_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_definition_node_design`
--

DROP TABLE IF EXISTS `ent_template_workflow_definition_node_design`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_definition_node_design` (
  `node_id` int(11) NOT NULL COMMENT '节点id',
  `position` varchar(255) DEFAULT NULL COMMENT '节点位置',
  `size` varchar(255) DEFAULT NULL COMMENT '节点大小',
  `midpoint` varchar(255) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_definition_node_design`
--

LOCK TABLES `ent_template_workflow_definition_node_design` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_definition_node_design` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_definition_node_design` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_definition_node_relationship`
--

DROP TABLE IF EXISTS `ent_template_workflow_definition_node_relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_definition_node_relationship` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `node_id` int(11) NOT NULL COMMENT '节点id',
  `parent_node_id` int(11) NOT NULL COMMENT '父节点id',
  `type` varchar(255) DEFAULT NULL COMMENT '分支类型',
  `condition_logic` varchar(255) DEFAULT NULL COMMENT '分支条件逻辑',
  `path` text COMMENT '节点间路径',
  `conditionGroup` text COMMENT '分支条件组',
  PRIMARY KEY (`id`),
  KEY `node_id` (`node_id`),
  KEY `parent_node_id` (`parent_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_definition_node_relationship`
--

LOCK TABLES `ent_template_workflow_definition_node_relationship` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_definition_node_relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_definition_node_relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_definition_version`
--

DROP TABLE IF EXISTS `ent_template_workflow_definition_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_definition_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `definition_id` varchar(255) DEFAULT NULL COMMENT '流程id',
  `code` varchar(255) DEFAULT NULL COMMENT 'version代号',
  `description` varchar(255) DEFAULT NULL COMMENT 'version描述',
  `config` text COMMENT '配置信息',
  `published` tinyint(4) NOT NULL DEFAULT '0' COMMENT '发布状态(0:未发布|1:已发布)',
  `is_default` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认版本(0:否|1:是)',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `created_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `published_at` datetime DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程定义版本';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_definition_version`
--

LOCK TABLES `ent_template_workflow_definition_version` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_definition_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_definition_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `old_instance_id` int(11) DEFAULT NULL COMMENT '旧实例id',
  `version_id` int(11) DEFAULT NULL COMMENT '流程版本',
  `definition_id` varchar(255) DEFAULT NULL COMMENT '流程id',
  `status` varchar(45) DEFAULT NULL COMMENT '流程状态(start:进行中|interrupt:中断|finish:完成)',
  `message` varchar(255) DEFAULT NULL COMMENT '流程中断原因',
  `created_at` datetime DEFAULT NULL COMMENT '实例开始时间',
  `created_by` varchar(45) DEFAULT NULL COMMENT '实例创建人',
  `updated_at` datetime DEFAULT NULL COMMENT '实例更新时间',
  PRIMARY KEY (`id`),
  KEY `definition_id` (`definition_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance`
--

LOCK TABLES `ent_template_workflow_instance` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_cc`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_cc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_cc` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态(0:未读|1:已读)',
  `send_user` varchar(45) NOT NULL COMMENT '接收者',
  `sc_id` int(11) NOT NULL COMMENT '抄送的数据记录id',
  PRIMARY KEY (`id`),
  KEY `sc_id` (`sc_id`,`send_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_cc`
--

LOCK TABLES `ent_template_workflow_instance_cc` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_cc` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_cc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_deleted`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_deleted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_deleted` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `instance_id` int(11) NOT NULL COMMENT '流程id',
  `instances` text NOT NULL COMMENT '流程实例信息',
  `instance_relation` text COMMENT '流程id',
  `nodes` text NOT NULL COMMENT '流程节点信息',
  `histories` text NOT NULL COMMENT '流程历史信息',
  `monitor_relation` text COMMENT '流程监控信息',
  `handler` varchar(45) NOT NULL COMMENT '处理人',
  `deleted_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_deleted`
--

LOCK TABLES `ent_template_workflow_instance_deleted` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_deleted` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_deleted` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_history`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `instance_id` int(11) DEFAULT NULL COMMENT '实例id',
  `status` varchar(45) DEFAULT NULL COMMENT '实例状态',
  `message` varchar(255) DEFAULT NULL COMMENT '流程中断原因',
  `origin_node` text COMMENT '操作前节点',
  `after_node` text COMMENT '操作后节点',
  `handler` varchar(45) DEFAULT NULL COMMENT '执行人',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_history`
--

LOCK TABLES `ent_template_workflow_instance_history` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_node`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `instance_id` int(11) DEFAULT NULL COMMENT '实例id',
  `definition_node_key` varchar(45) DEFAULT NULL COMMENT '定义的节点key',
  `assigned_to` text COMMENT '执行人',
  `assigned_methods` enum('manual','automatic') DEFAULT 'automatic' COMMENT '节点执行人方式(manual:手动|automatic:自动)',
  `deadline` text COMMENT '超时设置',
  `message` varchar(255) DEFAULT NULL COMMENT '实例节点消息',
  `handler` varchar(45) DEFAULT NULL COMMENT '执行人',
  `status` enum('running','draft') DEFAULT 'running' COMMENT '状态(running:正常|draft:存草稿)',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `finished_at` datetime DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`),
  KEY `instance_id` (`instance_id`,`definition_node_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_node`
--

LOCK TABLES `ent_template_workflow_instance_node` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_node_chaoshi`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_node_chaoshi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_node_chaoshi` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `instance_id` int(11) unsigned DEFAULT NULL COMMENT '实例id',
  `instance_node_id` int(11) NOT NULL COMMENT '实例节点id',
  `handler` varchar(45) DEFAULT NULL COMMENT '执行人',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `finished_at` datetime DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`),
  KEY `instance_id` (`instance_id`),
  KEY `handler` (`handler`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_node_chaoshi`
--

LOCK TABLES `ent_template_workflow_instance_node_chaoshi` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_chaoshi` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_chaoshi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_node_chaoshi_admin`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_node_chaoshi_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_node_chaoshi_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `monitor` text NOT NULL COMMENT '查看者',
  `monitored` text NOT NULL COMMENT '被监控者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_node_chaoshi_admin`
--

LOCK TABLES `ent_template_workflow_instance_node_chaoshi_admin` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_chaoshi_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_chaoshi_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_node_consign`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_node_consign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_node_consign` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `instance_node_id` int(11) NOT NULL COMMENT '实例节点id',
  `status` enum('created','handed','cancel','refuse','end') NOT NULL DEFAULT 'handed' COMMENT '委托状态(created:添加|handed被委托|cancel取消|refuse拒绝|end完成)',
  `comissioned_to` text NOT NULL COMMENT '委托人',
  `consign_to` varchar(30) NOT NULL COMMENT '被委托人',
  `created_by` varchar(30) NOT NULL COMMENT '操作者',
  `created_at` datetime NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `instance_node_id` (`instance_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_node_consign`
--

LOCK TABLES `ent_template_workflow_instance_node_consign` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_consign` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_consign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_node_handler`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_node_handler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_node_handler` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `instance_node_id` int(11) DEFAULT NULL COMMENT '实例节点id',
  `handler` varchar(45) DEFAULT NULL COMMENT '执行人',
  PRIMARY KEY (`id`),
  KEY `handler` (`handler`),
  KEY `IDX_INSTANCE_NODE_ID_HANDLER` (`instance_node_id`,`handler`),
  KEY `node_id` (`instance_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_node_handler`
--

LOCK TABLES `ent_template_workflow_instance_node_handler` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_handler` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_handler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_node_handler_relation`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_node_handler_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_node_handler_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `instance_node_id` int(11) DEFAULT NULL COMMENT '实例节点id',
  `next_node_key` varchar(45) DEFAULT NULL COMMENT '下级节点key',
  `handler` varchar(45) DEFAULT NULL COMMENT '执行人',
  PRIMARY KEY (`id`),
  KEY `instance_node_id` (`instance_node_id`),
  KEY `handler` (`handler`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_node_handler_relation`
--

LOCK TABLES `ent_template_workflow_instance_node_handler_relation` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_handler_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_handler_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_node_submit_relation`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_node_submit_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_node_submit_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `instance_id` int(11) NOT NULL COMMENT '实例id',
  `node_id` int(11) NOT NULL COMMENT '节点id',
  `node_key` varchar(45) NOT NULL COMMENT '定义节点id',
  `submit_by_node_id` int(11) NOT NULL COMMENT '来源实例节点id',
  `submit_by_node_key` varchar(45) NOT NULL COMMENT '来源定义节点id',
  `created_at` datetime NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `instance_id` (`instance_id`),
  KEY `node_id` (`node_id`),
  KEY `node_key` (`node_key`),
  KEY `submit_by_node_id` (`submit_by_node_id`),
  KEY `submit_by_node_key` (`submit_by_node_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_node_submit_relation`
--

LOCK TABLES `ent_template_workflow_instance_node_submit_relation` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_submit_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_submit_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_node_xianshi`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_node_xianshi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_node_xianshi` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `node_id` int(11) unsigned DEFAULT NULL COMMENT '节点id',
  `trigger_time` int(11) unsigned DEFAULT NULL COMMENT '触发时间',
  `timeout` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否超时(0:不超时|1:超时)',
  `action` enum('end','remind','continue') NOT NULL DEFAULT 'continue' COMMENT '超时后行为(end:结束|remind:提醒|continue:继续)',
  `status` tinyint(1) DEFAULT '0' COMMENT '是否推送(1:推送|0:未推送)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_node_xianshi`
--

LOCK TABLES `ent_template_workflow_instance_node_xianshi` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_xianshi` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_node_xianshi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_process`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `topic` varchar(45) NOT NULL DEFAULT '0' COMMENT '当前主题',
  `definition_id` varchar(255) NOT NULL DEFAULT '0' COMMENT '流程定义id',
  `instance_id` int(11) NOT NULL DEFAULT '0' COMMENT '流程实例id',
  `handler` varchar(45) NOT NULL DEFAULT '0' COMMENT '当前处理的用户',
  `created_by` varchar(45) NOT NULL DEFAULT '0' COMMENT '流程创建用户',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `instance_id` (`instance_id`),
  KEY `definition_id` (`definition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_process`
--

LOCK TABLES `ent_template_workflow_instance_process` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_process` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_relation`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `definition_id` varchar(255) DEFAULT NULL COMMENT '流程id',
  `instance_id` int(11) DEFAULT NULL COMMENT '实例id',
  `instance_node_id` int(11) DEFAULT NULL COMMENT '节点id',
  `handler` varchar(45) DEFAULT NULL COMMENT '执行人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `node_handler` (`instance_node_id`,`handler`),
  KEY `handler` (`handler`),
  KEY `definition_id` (`definition_id`,`handler`),
  KEY `instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_relation`
--

LOCK TABLES `ent_template_workflow_instance_relation` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_send_copy`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_send_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_send_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `instance_id` int(11) NOT NULL COMMENT '实例id',
  `history_data` text NOT NULL,
  `handler` varchar(45) NOT NULL COMMENT '处理人',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `instance_id` (`instance_id`,`handler`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_send_copy`
--

LOCK TABLES `ent_template_workflow_instance_send_copy` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_send_copy` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_send_copy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_instance_urge`
--

DROP TABLE IF EXISTS `ent_template_workflow_instance_urge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_instance_urge` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `instance_id` int(11) NOT NULL COMMENT '实例id',
  `sender` varchar(50) NOT NULL COMMENT '催办者',
  `msg` varchar(500) NOT NULL COMMENT '催办消息',
  `send_time` varchar(50) NOT NULL COMMENT '催办时间',
  `node_key` varchar(50) NOT NULL COMMENT '定义节点id',
  PRIMARY KEY (`id`),
  KEY `urge` (`instance_id`,`node_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_instance_urge`
--

LOCK TABLES `ent_template_workflow_instance_urge` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_instance_urge` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_instance_urge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_monitor_fields`
--

DROP TABLE IF EXISTS `ent_template_workflow_monitor_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_monitor_fields` (
  `rule_id` int(11) unsigned NOT NULL COMMENT '监控规则id',
  `table_id` varchar(100) NOT NULL COMMENT '表id',
  `fields` text COMMENT '不可读的字段id，格式 name,title,age...',
  UNIQUE KEY `rule and table` (`rule_id`,`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_monitor_fields`
--

LOCK TABLES `ent_template_workflow_monitor_fields` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_monitor_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_monitor_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_monitor_history`
--

DROP TABLE IF EXISTS `ent_template_workflow_monitor_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_monitor_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `operator` varchar(65) NOT NULL,
  `data` text NOT NULL,
  `operation` varchar(20) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `search` text,
  `verified_at` varchar(30) NOT NULL COMMENT '审核人',
  `status` tinyint(1) DEFAULT '4' COMMENT '1 通过; -1 未通过; 4 默认生效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_monitor_history`
--

LOCK TABLES `ent_template_workflow_monitor_history` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_monitor_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_monitor_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workflow_monitoring`
--

DROP TABLE IF EXISTS `ent_template_workflow_monitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workflow_monitoring` (
  `id` int(11) NOT NULL,
  `workflow_id` varchar(255) NOT NULL,
  `rule` text,
  `delete_auth` tinyint(1) NOT NULL DEFAULT '1',
  `conditions` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workflow_monitoring`
--

LOCK TABLES `ent_template_workflow_monitoring` WRITE;
/*!40000 ALTER TABLE `ent_template_workflow_monitoring` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workflow_monitoring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ent_template_workhours_setting`
--

DROP TABLE IF EXISTS `ent_template_workhours_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_template_workhours_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_user` varchar(30) NOT NULL COMMENT '创建者',
  `moring_start` varchar(100) NOT NULL COMMENT '上午工作开始时间',
  `moring_end` varchar(100) NOT NULL COMMENT '上午工作结束时间',
  `afternoon_start` varchar(100) NOT NULL COMMENT '下午工作开始时间',
  `afternoon_end` varchar(100) NOT NULL COMMENT '下午工作结束时间',
  `date_start` varchar(100) NOT NULL COMMENT '运用日期开始',
  `date_end` varchar(100) NOT NULL COMMENT '运用日期结束',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `workday` varchar(30) NOT NULL DEFAULT '{"workday":["1","5"]}',
  PRIMARY KEY (`id`),
  KEY `morning_afternoon` (`moring_start`,`moring_end`,`afternoon_start`,`afternoon_end`),
  KEY `date_start_end` (`date_start`,`date_end`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ent_template_workhours_setting`
--

LOCK TABLES `ent_template_workhours_setting` WRITE;
/*!40000 ALTER TABLE `ent_template_workhours_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `ent_template_workhours_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_apk`
--

DROP TABLE IF EXISTS `sys_apk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_apk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ent_id` varchar(255) NOT NULL DEFAULT '',
  `owner` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `version` varchar(16) NOT NULL,
  `description` text NOT NULL,
  `file` varchar(128) NOT NULL,
  `force_update` tinyint(4) DEFAULT '0' COMMENT '是否强制更新:1-是,0-否',
  `version_name` varchar(32) DEFAULT '' COMMENT '版本号名称：6.7.8',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_apk`
--

LOCK TABLES `sys_apk` WRITE;
/*!40000 ALTER TABLE `sys_apk` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_apk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_app`
--

DROP TABLE IF EXISTS `sys_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_app` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `from_enterprise_id` varchar(30) NOT NULL COMMENT '发布应用的企业',
  `app_type` tinyint(1) NOT NULL COMMENT '应用类型 1-系统应用模板 2-单应用模板',
  `from_app_id` varchar(40) DEFAULT NULL COMMENT '发布应用ID',
  `app_id` varchar(200) NOT NULL COMMENT '应用ID',
  `app_version` varchar(30) NOT NULL COMMENT '应用版本',
  `description` text NOT NULL COMMENT '应用描述',
  `app_name` varchar(100) NOT NULL COMMENT '应用名称',
  `icon` varchar(80) NOT NULL COMMENT '应用图标地址',
  `color` varchar(30) NOT NULL COMMENT '颜色',
  `industry` varchar(40) NOT NULL COMMENT '所属行业',
  `category` varchar(40) NOT NULL COMMENT '所属分类',
  `install_count` int(11) NOT NULL DEFAULT '0' COMMENT '安装次数',
  `created_by` varchar(45) NOT NULL COMMENT '发布者',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  `release_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否发布 0-发布 1-撤销',
  `audit` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核０-未审核 １-通过 2-不通过',
  `finished` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发布完成0-没有完成 1-已完成',
  `app_images` text NOT NULL COMMENT '应用截图地址',
  PRIMARY KEY (`id`),
  KEY `app_type` (`app_type`),
  KEY `app_id` (`app_id`),
  KEY `audit` (`audit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_app`
--

LOCK TABLES `sys_app` WRITE;
/*!40000 ALTER TABLE `sys_app` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_app_config`
--

DROP TABLE IF EXISTS `sys_app_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_app_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ent_id` varchar(128) NOT NULL DEFAULT '' COMMENT '企业id',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '配置项名称',
  `client_type` varchar(8) NOT NULL DEFAULT '' COMMENT '客户端类型：android，ios',
  `config_type` varchar(16) NOT NULL DEFAULT '' COMMENT '配置项类型：image|text|switch',
  `config_key` varchar(64) NOT NULL DEFAULT '' COMMENT '配置项key',
  `config_value` varchar(1024) NOT NULL DEFAULT '' COMMENT '配置项值',
  `description` varchar(128) NOT NULL DEFAULT '' COMMENT '配置描述',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='app配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_app_config`
--

LOCK TABLES `sys_app_config` WRITE;
/*!40000 ALTER TABLE `sys_app_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_app_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_app_install`
--

DROP TABLE IF EXISTS `sys_app_install`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_app_install` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `appId` varchar(200) NOT NULL COMMENT '发布后的应用ID',
  `enterprise_id` varchar(60) NOT NULL COMMENT '安装企业ID',
  `sysId` int(11) NOT NULL DEFAULT '0' COMMENT '系统ID',
  `user_id` varchar(45) NOT NULL COMMENT '安装用户ID',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态０-未安装 １-安装中 2-已安装',
  `finished` tinyint(1) DEFAULT '0' COMMENT '安装完整性0-未完成 1-完成',
  PRIMARY KEY (`id`),
  UNIQUE KEY `appId` (`appId`,`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_app_install`
--

LOCK TABLES `sys_app_install` WRITE;
/*!40000 ALTER TABLE `sys_app_install` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_app_install` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_banner`
--

DROP TABLE IF EXISTS `sys_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_banner` (
  `enterprise_id` varchar(45) DEFAULT NULL,
  `img` varchar(225) DEFAULT NULL,
  `background` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_banner`
--

LOCK TABLES `sys_banner` WRITE;
/*!40000 ALTER TABLE `sys_banner` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_bill`
--

DROP TABLE IF EXISTS `sys_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project` enum('initial_build_cost','space_cost','share_cost') NOT NULL,
  `type` enum('in','out') NOT NULL DEFAULT 'in',
  `status` enum('not_pay','success_pay') NOT NULL DEFAULT 'not_pay',
  `pay_mode` varchar(100) DEFAULT NULL,
  `price` float(11,2) DEFAULT NULL,
  `description` text,
  `handler` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_bill`
--

LOCK TABLES `sys_bill` WRITE;
/*!40000 ALTER TABLE `sys_bill` DISABLE KEYS */;
INSERT INTO `sys_bill` VALUES (1,'space_cost','in','success_pay','alipay',50000.00,NULL,'root','2018-09-13 19:40:57');
/*!40000 ALTER TABLE `sys_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'allow_create_enterprise','0'),(2,'visual_default_icon','0');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config_category`
--

DROP TABLE IF EXISTS `sys_config_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_config_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(40) NOT NULL,
  `parent_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config_category`
--

LOCK TABLES `sys_config_category` WRITE;
/*!40000 ALTER TABLE `sys_config_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_config_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_danger_password`
--

DROP TABLE IF EXISTS `sys_danger_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_danger_password` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `password` (`password`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_danger_password`
--

LOCK TABLES `sys_danger_password` WRITE;
/*!40000 ALTER TABLE `sys_danger_password` DISABLE KEYS */;
INSERT INTO `sys_danger_password` VALUES (1,'aykj83752661');
/*!40000 ALTER TABLE `sys_danger_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_detect_log`
--

DROP TABLE IF EXISTS `sys_detect_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_detect_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enterprise_id` varchar(100) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` text,
  `type` int(5) DEFAULT NULL,
  `item` varchar(100) DEFAULT NULL,
  `resolved` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_detect_log`
--

LOCK TABLES `sys_detect_log` WRITE;
/*!40000 ALTER TABLE `sys_detect_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_detect_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_enterprise_auth`
--

DROP TABLE IF EXISTS `sys_enterprise_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_enterprise_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enterprise_id` varchar(30) NOT NULL,
  `project` enum('initial_build_cost','space_cost') NOT NULL,
  `due_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_enterprise_auth`
--

LOCK TABLES `sys_enterprise_auth` WRITE;
/*!40000 ALTER TABLE `sys_enterprise_auth` DISABLE KEYS */;
INSERT INTO `sys_enterprise_auth` VALUES (1,'template','space_cost','2019-09-13 19:40:57');
/*!40000 ALTER TABLE `sys_enterprise_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_enterprise_banner`
--

DROP TABLE IF EXISTS `sys_enterprise_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_enterprise_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `enterprise_id` varchar(255) NOT NULL COMMENT '企业id',
  `img` varchar(255) NOT NULL COMMENT 'banner图片',
  `modified` varchar(40) NOT NULL COMMENT '修改人',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_enterprise_banner`
--

LOCK TABLES `sys_enterprise_banner` WRITE;
/*!40000 ALTER TABLE `sys_enterprise_banner` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_enterprise_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_enterprise_base`
--

DROP TABLE IF EXISTS `sys_enterprise_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_enterprise_base` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(50) NOT NULL COMMENT '企业名称',
  `enterprise_id` varchar(30) NOT NULL COMMENT '企业id',
  `parent` int(11) unsigned NOT NULL COMMENT '母公司',
  `founder_id` varchar(30) NOT NULL COMMENT '创始人',
  `status` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '是否停用 1:启用 0:停用',
  `del_time` datetime DEFAULT NULL COMMENT '企业删除时间',
  `enterprise_tag` varchar(15) NOT NULL COMMENT '企业标签 public_cloud:公有云 51safety:无忧  mixed_cloud:混合云',
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_id` (`enterprise_id`) USING BTREE,
  KEY `enterprise_status_del` (`enterprise_id`,`status`,`del_time`),
  KEY `enterprise_tag` (`enterprise_id`,`enterprise_tag`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_enterprise_base`
--

LOCK TABLES `sys_enterprise_base` WRITE;
/*!40000 ALTER TABLE `sys_enterprise_base` DISABLE KEYS */;
INSERT INTO `sys_enterprise_base` VALUES (1,'template','template',0,'undefined',2,NULL,'');
/*!40000 ALTER TABLE `sys_enterprise_base` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_enterprise_customer`
--

DROP TABLE IF EXISTS `sys_enterprise_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_enterprise_customer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `enterprise_id` varchar(30) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `token` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_enterprise_customer`
--

LOCK TABLES `sys_enterprise_customer` WRITE;
/*!40000 ALTER TABLE `sys_enterprise_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_enterprise_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_enterprise_extra`
--

DROP TABLE IF EXISTS `sys_enterprise_extra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_enterprise_extra` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `e_id` int(11) NOT NULL COMMENT '关联的企业基本表企业id',
  `e_type` varchar(100) NOT NULL COMMENT '公司类型',
  `business_model` varchar(255) NOT NULL COMMENT '经营模式',
  `scale` varchar(10) NOT NULL COMMENT '企业规模',
  `country` varchar(30) DEFAULT NULL COMMENT '所属国家',
  `province` varchar(30) NOT NULL COMMENT '省份',
  `city` varchar(30) NOT NULL COMMENT '城市',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `note` varchar(255) DEFAULT NULL COMMENT '邮编',
  `zip` varchar(20) DEFAULT NULL COMMENT '?',
  `tel` varchar(20) NOT NULL COMMENT '固定电话',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机',
  `fax` varchar(20) DEFAULT NULL COMMENT '传真',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `qq` varchar(20) DEFAULT NULL COMMENT 'qq',
  `msn` varchar(100) DEFAULT NULL COMMENT 'msn',
  `contact` varchar(30) NOT NULL COMMENT '联系人',
  `main_business` varchar(100) DEFAULT NULL COMMENT '主营业务',
  `industry` varchar(100) NOT NULL COMMENT '职务',
  `interest` varchar(100) DEFAULT NULL COMMENT '不知啊,没查到',
  `about` varchar(255) NOT NULL COMMENT '企业简介',
  `title` varchar(100) DEFAULT NULL COMMENT '企业名称',
  `person_num` varchar(100) DEFAULT NULL COMMENT '个税号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `fix_telephone` bigint(15) NOT NULL COMMENT '联系电话',
  `position` varchar(100) NOT NULL COMMENT '位置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_enterprise_extra`
--

LOCK TABLES `sys_enterprise_extra` WRITE;
/*!40000 ALTER TABLE `sys_enterprise_extra` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_enterprise_extra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_enterprise_theme`
--

DROP TABLE IF EXISTS `sys_enterprise_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_enterprise_theme` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ent_id` varchar(128) NOT NULL DEFAULT '' COMMENT '企业id',
  `theme` varchar(128) NOT NULL DEFAULT '' COMMENT '主题名称',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业默认主题';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_enterprise_theme`
--

LOCK TABLES `sys_enterprise_theme` WRITE;
/*!40000 ALTER TABLE `sys_enterprise_theme` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_enterprise_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_enterprise_user`
--

DROP TABLE IF EXISTS `sys_enterprise_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_enterprise_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` varchar(30) NOT NULL COMMENT '用户id',
  `enterprise_id` varchar(30) NOT NULL COMMENT '企业id',
  `disabled` enum('false','true') NOT NULL DEFAULT 'false' COMMENT '禁用状态(true:禁用|false:启用)',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类型(0:企业用户|4:安全管理员|5:审计管理员|6:企业管理员|7:系统管理员)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_enterprise` (`user_id`,`enterprise_id`),
  KEY `enterprise_user_disabled_type` (`enterprise_id`,`user_id`,`disabled`,`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_enterprise_user`
--

LOCK TABLES `sys_enterprise_user` WRITE;
/*!40000 ALTER TABLE `sys_enterprise_user` DISABLE KEYS */;
INSERT INTO `sys_enterprise_user` VALUES (1,'root','','false',7);
/*!40000 ALTER TABLE `sys_enterprise_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_holiday_arrangement`
--

DROP TABLE IF EXISTS `sys_holiday_arrangement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_holiday_arrangement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` char(30) NOT NULL COMMENT '休班日期',
  `state` tinyint(1) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_holiday_arrangement`
--

LOCK TABLES `sys_holiday_arrangement` WRITE;
/*!40000 ALTER TABLE `sys_holiday_arrangement` DISABLE KEYS */;
INSERT INTO `sys_holiday_arrangement` VALUES (1,'2016-01-01',0),(2,'2016-01-02',0),(3,'2016-01-03',0),(4,'2016-02-06',1),(5,'2016-02-07',0),(6,'2016-02-08',0),(7,'2016-02-09',0),(8,'2016-02-14',1),(9,'2016-02-10',0),(10,'2016-02-11',0),(11,'2016-02-12',0),(12,'2016-02-13',0),(13,'2016-04-02',0),(14,'2016-04-03',0),(15,'2016-04-04',0),(16,'2016-04-30',0),(17,'2016-05-01',0),(18,'2016-05-02',0),(19,'2016-06-09',0),(20,'2016-06-10',0),(21,'2016-06-11',0),(22,'2016-06-12',1),(23,'2016-09-15',0),(24,'2016-09-16',0),(25,'2016-09-17',0),(26,'2016-09-18',1),(27,'2016-10-01',0),(28,'2016-10-02',0),(29,'2016-10-03',0),(30,'2016-10-04',0),(31,'2016-10-05',0),(32,'2016-10-06',0),(33,'2016-10-07',0),(34,'2016-10-08',1),(35,'2016-10-09',1),(36,'2015-01-01',0),(37,'2015-01-02',0),(38,'2015-01-03',0),(39,'2015-01-04',1),(40,'2015-02-15',1),(41,'2015-02-18',0),(42,'2015-02-19',0),(43,'2015-02-20',0),(44,'2015-02-21',0),(45,'2015-02-22',0),(46,'2015-02-23',0),(47,'2015-02-24',0),(48,'2015-02-28',1),(49,'2015-04-04',0),(50,'2015-04-05',0),(51,'2015-04-06',0),(52,'2015-05-01',0),(53,'2015-05-02',0),(54,'2015-05-03',0),(55,'2015-06-20',0),(56,'2015-06-21',0),(57,'2015-06-22',0),(58,'2015-09-03',0),(59,'2015-09-04',0),(60,'2015-09-05',0),(61,'2015-09-06',1),(62,'2015-09-26',0),(63,'2015-09-27',0),(64,'2015-10-01',0),(65,'2015-10-02',0),(66,'2015-10-03',0),(67,'2015-10-04',0),(68,'2015-10-05',0),(69,'2015-10-06',0),(70,'2015-10-07',0),(71,'2015-10-10',1),(72,'2017-01-01',0),(73,'2017-01-02',0),(74,'2017-01-22',1),(75,'2017-01-27',0),(76,'2017-01-28',0),(77,'2017-01-29',0),(78,'2017-01-30',0),(79,'2017-01-31',0),(80,'2017-02-01',0),(81,'2017-02-02',0),(82,'2017-02-04',1),(83,'2017-04-01',1),(84,'2017-04-02',0),(85,'2017-04-03',0),(86,'2017-04-04',0),(87,'2017-04-29',0),(88,'2017-04-30',0),(89,'2017-05-01',0),(90,'2017-05-27',1),(91,'2017-05-28',0),(92,'2017-05-29',0),(93,'2017-05-30',0),(94,'2017-09-30',1),(95,'2017-10-01',0),(96,'2017-10-02',0),(97,'2017-10-03',0),(98,'2017-10-04',0),(99,'2017-10-05',0),(100,'2017-10-06',0),(101,'2017-10-07',0),(102,'2017-10-08',0);
/*!40000 ALTER TABLE `sys_holiday_arrangement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_ipa`
--

DROP TABLE IF EXISTS `sys_ipa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_ipa` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ent_id` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `version` varchar(16) NOT NULL,
  `description` text NOT NULL,
  `ipa` varchar(255) NOT NULL,
  `img` varchar(255) NOT NULL,
  `force_update` tinyint(4) DEFAULT '0' COMMENT '是否强制更新:1-是,0-否',
  `version_name` varchar(32) DEFAULT '' COMMENT '版本号名称：6.7.8',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_ipa`
--

LOCK TABLES `sys_ipa` WRITE;
/*!40000 ALTER TABLE `sys_ipa` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_ipa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_log`
--

DROP TABLE IF EXISTS `sys_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `meg` varchar(255) NOT NULL,
  `eid` varchar(50) DEFAULT '',
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_log`
--

LOCK TABLES `sys_log` WRITE;
/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_login_log`
--

DROP TABLE IF EXISTS `sys_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_login_log` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `enterprise_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `login_ip` varchar(50) DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  `logout_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`) USING BTREE,
  KEY `login_time` (`login_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_login_log`
--

LOCK TABLES `sys_login_log` WRITE;
/*!40000 ALTER TABLE `sys_login_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_message`
--

DROP TABLE IF EXISTS `sys_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `start` datetime NOT NULL,
  `finish` datetime NOT NULL,
  `introduce` varchar(255) DEFAULT NULL,
  `details` text,
  `content` text NOT NULL,
  `is_published` tinyint(4) NOT NULL DEFAULT '0',
  `is_old` tinyint(4) NOT NULL DEFAULT '0',
  `publish_time` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `is_published` (`is_published`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_message`
--

LOCK TABLES `sys_message` WRITE;
/*!40000 ALTER TABLE `sys_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_messagelog`
--

DROP TABLE IF EXISTS `sys_messagelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_messagelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `record_id` int(11) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_messagelog`
--

LOCK TABLES `sys_messagelog` WRITE;
/*!40000 ALTER TABLE `sys_messagelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_messagelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_migrations`
--

DROP TABLE IF EXISTS `sys_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_migrations` (
  `version` bigint(10) unsigned NOT NULL,
  `stable` tinyint(1) NOT NULL DEFAULT '0',
  `test` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_migrations`
--

LOCK TABLES `sys_migrations` WRITE;
/*!40000 ALTER TABLE `sys_migrations` DISABLE KEYS */;
INSERT INTO `sys_migrations` VALUES (20000530010000,1,1),(20120822094445,1,1),(20120822110225,1,1),(20150101000000,1,1),(20150101091925,1,1),(20150504155148,1,1),(20150508133811,1,1),(20150526093026,1,1),(20150615135256,1,1),(20150619120614,1,1),(20150623173515,1,1),(20150626091559,1,1),(20150626102646,1,1),(20150626112743,1,1),(20150626115601,1,1),(20150626152512,1,1),(20150701094704,1,1),(20150702161946,1,1),(20150706093103,1,1),(20150706093655,1,1),(20150706110936,1,1),(20150708112640,1,1),(20150708122640,1,1),(20150708142640,1,1),(20150709162604,1,1),(20150709170230,1,1),(20150710105501,1,1),(20150715152403,1,1),(20150716143532,1,1),(20150716150644,1,1),(20150720101724,1,1),(20150720140450,1,1),(20150720154108,1,1),(20150720170411,1,1),(20150723102028,1,1),(20150812145716,1,1),(20150812151142,1,1),(20150814105501,1,1),(20150814111356,1,1),(20150818111217,1,1),(20150824111251,1,1),(20150824145856,1,1),(20150828102514,1,1),(20150831123845,1,1),(20150901101911,1,1),(20150901181101,1,1),(20150902084244,1,1),(20150902084255,1,1),(20150902084303,1,1),(20150902102107,1,1),(20150902104620,1,1),(20150902135046,1,1),(20150902161653,1,1),(20150906141728,1,1),(20150909154009,1,1),(20150910108888,1,1),(20150914135142,1,1),(20150915153054,1,1),(20150916091339,1,1),(20150916165123,1,1),(20150917140414,1,1),(20150922101743,1,1),(20150923140658,1,1),(20150925085717,1,1),(20150928135916,1,1),(20150928163524,1,1),(20150929170033,1,1),(20151008086845,1,1),(20151009153314,1,1),(20151013102153,1,1),(20151020140457,1,1),(20151021090713,1,1),(20151021140715,1,1),(20151021144107,1,1),(20151021171144,1,1),(20151022152718,1,1),(20151022153704,1,1),(20151023111614,1,1),(20151026142115,1,1),(20151029094751,1,1),(20151103101743,1,1),(20151103181101,1,1),(20151104140027,1,1),(20151104140506,1,1),(20151106102511,1,1),(20151106141406,1,1),(20151106145613,1,1),(20151107113006,1,1),(20151108164734,1,1),(20151113162651,1,1),(20151118103222,1,1),(20151119100349,1,1),(20151120162217,1,1),(20151123085415,1,1),(20151124091925,1,1),(20151124114253,1,1),(20151124140146,1,1),(20151130113323,1,1),(20151130122714,1,1),(20151130143532,1,1),(20151130153642,1,1),(20151201142252,1,1),(20151203112227,1,1),(20151203171504,1,1),(20151204125103,1,1),(20151208091727,1,1),(20151208092136,1,1),(20151209161711,1,1),(20151211162117,1,1),(20151215100832,1,1),(20151215215155,1,1),(20151216175839,1,1),(20151218111556,1,1),(20151221112556,1,1),(20151221113613,1,1),(20151229093846,1,1),(20151229112222,1,1),(20151229140014,1,1),(20151230111203,1,1),(20151230134018,1,1),(20160105133845,1,1),(20160108140346,1,1),(20160111131857,1,1),(20160112095029,1,1),(20160115144924,1,1),(20160119102255,1,1),(20160121091553,1,1),(20160121202319,1,1),(20160125091622,1,1),(20160125170528,1,1),(20160127155858,1,1),(20160129888888,1,1),(20160129888889,1,1),(20160215173235,1,1),(20160216103329,1,1),(20160217162713,1,1),(20160222094910,1,1),(20160223101209,1,1),(20160224165356,1,1),(20160225162120,1,1),(20160229112323,1,1),(20160301152149,1,1),(20160301155900,1,1),(20160302164406,1,1),(20160302201129,1,1),(20160307165609,1,1),(20160309112719,1,1),(20160309160735,1,1),(20160310152432,1,1),(20160310999999,1,1),(20160315110207,1,1),(20160315111023,1,1),(20160315135737,1,1),(20160315142229,1,1),(20160316115253,1,1),(20160316155858,1,1),(20160317091149,1,1),(20160323171436,1,1),(20160324163047,1,1),(20160328162200,1,1),(20160329143833,1,1),(20160330135430,1,1),(20160330135629,1,1),(20160331093641,1,1),(20160401101743,1,1),(20160407105634,1,1),(20160414155312,1,1),(20160415095322,1,1),(20160415112625,1,1),(20160421134230,1,1),(20160427090652,1,1),(20160504140326,1,1),(20160509140927,1,1),(20160510123456,1,1),(20160511123456,1,1),(20160516115708,1,1),(20160517124225,1,1),(20160520130704,1,1),(20160520130705,1,1),(20160530020000,1,1),(20160530111111,1,1),(20160530111112,1,1),(20160530999999,1,1),(20160531180734,1,1),(20160603100000,1,1),(20160603134541,1,1),(20160606152825,1,1),(20160606888888,1,1),(20160607100451,1,1),(20160607143654,1,1),(20160612132508,1,1),(20160617140809,1,1),(20160621105017,1,1),(20160621145923,1,1),(20160622142416,1,1),(20160623150411,1,1),(20160627150910,1,1),(20160701093633,1,1),(20160703101743,1,1),(20160706114753,1,1),(20160711163620,1,1),(20160711163711,1,1),(20160713145145,1,1),(20160721666666,1,1),(20160722123456,1,1),(20160726143227,1,1),(20160726143228,1,1),(20160803102058,1,1),(20160804150744,1,1),(20160810100333,1,1),(20160810100334,1,1),(20160819000000,1,1),(20160822132519,1,1),(20160822134544,1,1),(20160823132334,1,1),(20160824165340,1,1),(20160825131147,1,1),(20160829143228,1,1),(20160905000000,1,1),(20160905000001,1,1),(20160906100023,1,1),(20160907143228,1,1),(20160912163408,1,1),(20160918114314,1,1),(20160918143050,1,1),(20160919000000,1,1),(20160919141627,1,1),(20160921000000,1,1),(20160923150644,1,1),(20160924121759,1,1),(20160927000000,1,1),(20160927000001,1,1),(20160929092055,1,1),(20161010091922,1,1),(20161010110634,1,1),(20161013101430,1,1),(20161017090601,1,1),(20161019000000,1,1),(20161019095647,1,1),(20161024160325,1,1),(20161025143559,1,1),(20161026000000,1,1),(20161026134025,1,1),(20161101201109,1,1),(20161104162331,1,1),(20161108140957,1,1),(20161109000000,1,1),(20161116140957,1,1),(20161118000000,1,1),(20161123160434,1,1),(20161130160434,1,1),(20161205110502,1,1),(20161206210527,1,1),(20161207000000,1,1),(20161207000001,1,1),(20161207000002,1,1),(20161207145425,1,1),(20161207152054,1,1),(20161208141923,1,1),(20161209141423,1,1),(20161213114609,1,1),(20161216084411,1,1),(20161220171033,1,1),(20161228000000,1,1),(20161228133948,1,1),(20161228134013,1,1),(20161229000000,1,1),(20161229000001,1,1),(20161229171033,1,1),(20170106171034,1,1),(20170116085632,1,1),(20170117094453,1,1),(20170120094453,1,1),(20170120163355,1,1),(20170204150200,1,1),(20170204152247,1,1),(20170208145835,1,1),(20170210152357,1,1),(20170213140212,1,1),(20170220165314,1,1),(20170221091700,1,1),(20170222140138,1,1),(20170223142911,1,1),(20170228100233,1,1),(20170301093042,1,1),(20170306104327,1,1),(20170313104427,1,1),(20170313111506,1,1),(20170314092727,1,1),(20170315092241,1,1),(20170322114651,1,1),(20170327164209,1,1),(20170328103941,1,1),(20170328103942,1,1),(20170328144636,1,1),(20170401191658,1,1),(20170406173111,1,1),(20170410102720,1,1),(20170411164841,1,1),(20170417101403,1,1),(20170419092654,1,1),(20170426000000,1,1),(20170503000000,1,1),(20170504000000,1,1),(20170504000001,1,1),(20170510151003,1,1),(20170519133211,1,1),(20170612151003,1,1),(20170614151255,1,1),(20170615173510,1,1),(20170620145829,1,1),(20170621135719,1,1),(20170626153128,1,1),(20170704173510,1,1),(20170705143129,1,1),(20170712091902,1,1),(20170713164053,1,1),(20170717143129,1,1),(20170718094519,1,1),(20170719142337,1,1),(20170728113352,1,1),(20170802113405,1,1),(20170804154055,1,1),(20170808111854,1,1),(20170808194051,1,1),(20170809094110,1,1),(20170809095133,1,1),(20170809173510,1,1),(20170814095601,1,1),(20170828140405,1,1),(20170828163637,1,1),(20170828163638,1,1),(20170831161202,1,1),(20170902220344,1,1),(20170908140405,1,1),(20170912151652,1,1),(20170913140705,1,1),(20170915160629,1,1),(20170922141508,1,1),(20170926131705,1,1),(20170927153241,1,1),(20171011150056,1,1),(20171011154314,1,1),(20171012093253,1,1),(20171025094453,1,1),(20171027141135,1,1),(20171030100108,1,1),(20171031151241,1,1),(20171102113111,1,1),(20171106095615,1,1),(20171113110347,1,1),(20171113171651,1,1),(20171114091947,1,1),(20171115134944,1,1),(20171116141926,1,1),(20171120110700,1,1),(20171205143557,1,1),(20171218143539,1,1),(20171228162803,1,1),(20180108095500,1,1),(20180109103300,1,1),(20180110143226,1,1),(20180115143227,1,1),(20180115153738,1,1),(20180116095524,1,1),(20180116163111,1,1),(20180117164100,1,1),(20180122102700,1,1),(20180123163827,1,1),(20180125155210,1,1),(20180202145640,1,1),(20180227166314,1,1),(20180228145641,1,1),(20180228164040,1,1),(20180301163827,1,1),(20180302134443,1,1),(20180307133826,1,1),(20180312104314,1,1),(20180313085100,1,1),(20180320095529,1,1),(20180402142405,1,1),(20180408151345,1,1),(20180419132018,1,1),(20180420103121,1,1),(20180428111611,1,1),(20180502153800,1,1),(20180504092830,1,1),(20180507105143,1,1),(20180508103651,1,1),(20180508132815,1,1),(20180514154611,1,1),(20180522164133,1,1),(20180529144849,1,1),(20180529144915,1,1),(20180601103121,1,1),(20180606132813,1,1),(20180615091244,1,1),(20150508114036,1,1),(20150512092119,1,1),(20150519102411,1,1),(20150519164844,1,1),(20150520095231,1,1),(20150526083429,1,1),(20150603094601,1,1),(20150604155830,1,1),(20150609165337,1,1),(20150817091450,1,1),(20150817092450,1,1),(20150910170820,1,1),(20150914140057,1,1),(20151128999999,1,1),(20151207093033,1,1),(20151207094409,1,1),(20160216999999,1,1),(20160301155913,1,1),(20170613160116,1,1),(20170720005306,1,1),(20180719101622,1,1);
/*!40000 ALTER TABLE `sys_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_mobile_user_action_analysis`
--

DROP TABLE IF EXISTS `sys_mobile_user_action_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_mobile_user_action_analysis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL,
  `enterprise_id` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type_time` (`type`,`create_time`),
  KEY `entId_type_time` (`enterprise_id`,`type`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_mobile_user_action_analysis`
--

LOCK TABLES `sys_mobile_user_action_analysis` WRITE;
/*!40000 ALTER TABLE `sys_mobile_user_action_analysis` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_mobile_user_action_analysis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notice` (
  `id` bigint(20) NOT NULL,
  `from_user_id` varchar(30) NOT NULL,
  `to_user_id` varchar(30) NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` varchar(255) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `disabled` tinyint(4) DEFAULT NULL,
  `readed` tinyint(4) DEFAULT NULL,
  `send_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice_file`
--

DROP TABLE IF EXISTS `sys_notice_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notice_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) NOT NULL,
  `user_Id` varchar(50) NOT NULL,
  `url` varchar(255) NOT NULL,
  `unread_num` int(11) NOT NULL DEFAULT '0',
  `sum_num` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice_file`
--

LOCK TABLES `sys_notice_file` WRITE;
/*!40000 ALTER TABLE `sys_notice_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_notice_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice_record`
--

DROP TABLE IF EXISTS `sys_notice_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notice_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notice_id` int(11) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `file_id` int(11) NOT NULL,
  `readed` tinyint(4) NOT NULL DEFAULT '0',
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice_record`
--

LOCK TABLES `sys_notice_record` WRITE;
/*!40000 ALTER TABLE `sys_notice_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_notice_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_online_peak`
--

DROP TABLE IF EXISTS `sys_online_peak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_online_peak` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `enterprise_id` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL,
  `peak` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`) USING BTREE,
  KEY `date` (`date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_online_peak`
--

LOCK TABLES `sys_online_peak` WRITE;
/*!40000 ALTER TABLE `sys_online_peak` DISABLE KEYS */;
INSERT INTO `sys_online_peak` VALUES (1,'all','2018-09-13 00:00:00',0);
/*!40000 ALTER TABLE `sys_online_peak` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_order`
--

DROP TABLE IF EXISTS `sys_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `price` float(11,2) NOT NULL,
  `order_id` char(10) NOT NULL,
  `config` text NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_order`
--

LOCK TABLES `sys_order` WRITE;
/*!40000 ALTER TABLE `sys_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_org_change_record`
--

DROP TABLE IF EXISTS `sys_org_change_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_org_change_record` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `enterprise_id` varchar(30) NOT NULL,
  `record` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_org_change_record`
--

LOCK TABLES `sys_org_change_record` WRITE;
/*!40000 ALTER TABLE `sys_org_change_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_org_change_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_password_security_rule`
--

DROP TABLE IF EXISTS `sys_password_security_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_password_security_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ent_id` varchar(30) NOT NULL DEFAULT '' COMMENT '企业id',
  `level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '安全等级',
  `remind_at` varchar(64) NOT NULL DEFAULT '' COMMENT '提醒时间（array）',
  `period` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '密码修改周期（天）',
  `target` text NOT NULL COMMENT '适用的用户（组织架构）',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1-启用，0-停用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_ent_id` (`ent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='密码安全规则';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_password_security_rule`
--

LOCK TABLES `sys_password_security_rule` WRITE;
/*!40000 ALTER TABLE `sys_password_security_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_password_security_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_search_log`
--

DROP TABLE IF EXISTS `sys_search_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_search_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` varchar(30) NOT NULL COMMENT '用户id',
  `enterprise_id` varchar(30) NOT NULL DEFAULT '' COMMENT '企业id',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示(0:隐藏|1:显示)',
  `category` enum('all','staff','bizdata','fileio','notice','diagram','app') NOT NULL DEFAULT 'all' COMMENT '分类(''all'',''staff'',''bizdata'',''fileio'',''notice'',''diagram'',''app'')',
  `ip` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ip地址',
  `hit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '全局搜索到的记录数',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录时间',
  `ua` varchar(255) NOT NULL DEFAULT '' COMMENT '当前用户浏览器信息',
  `keyword` varchar(128) NOT NULL COMMENT '关键字',
  PRIMARY KEY (`id`),
  KEY `user` (`user_id`,`enterprise_id`) USING BTREE,
  KEY `keyword` (`keyword`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_search_log`
--

LOCK TABLES `sys_search_log` WRITE;
/*!40000 ALTER TABLE `sys_search_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_search_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_sql_analysis`
--

DROP TABLE IF EXISTS `sys_sql_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_sql_analysis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `safe` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `performance` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `type` char(4) NOT NULL,
  `method` char(8) NOT NULL,
  `speed` double(10,4) unsigned NOT NULL,
  `sqlSize` int(10) unsigned NOT NULL,
  `sqlAndParamSzie` int(10) unsigned NOT NULL,
  `affected` int(10) unsigned NOT NULL,
  `enterprise` varchar(64) NOT NULL,
  `user` varchar(64) NOT NULL,
  `sqlKey` char(32) NOT NULL,
  `sqlAndParamKey` char(32) NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` int(10) unsigned NOT NULL,
  `url` text NOT NULL,
  `sql` longtext CHARACTER SET utf8mb4 NOT NULL,
  `param` longtext CHARACTER SET utf8mb4 NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_sql_analysis`
--

LOCK TABLES `sys_sql_analysis` WRITE;
/*!40000 ALTER TABLE `sys_sql_analysis` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_sql_analysis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_trial`
--

DROP TABLE IF EXISTS `sys_trial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_trial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  `userid` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `sort` int(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_trial`
--

LOCK TABLES `sys_trial` WRITE;
/*!40000 ALTER TABLE `sys_trial` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_trial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_access`
--

DROP TABLE IF EXISTS `sys_user_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) NOT NULL COMMENT '用户Id',
  `enterprise_id` varchar(45) NOT NULL COMMENT '企业Id',
  `access_key` varchar(100) NOT NULL COMMENT '授权key',
  `expired` int(10) NOT NULL COMMENT '过期时间',
  `reason` varchar(255) NOT NULL DEFAULT '' COMMENT '申请理由',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1、审核中 2、已通过 3、未通过',
  `apply_time` int(11) NOT NULL DEFAULT '0' COMMENT '申请时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_key_index` (`access_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户api授权表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_access`
--

LOCK TABLES `sys_user_access` WRITE;
/*!40000 ALTER TABLE `sys_user_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_accrual`
--

DROP TABLE IF EXISTS `sys_user_accrual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_accrual` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_id` int(11) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `owned_ent` varchar(45) DEFAULT NULL,
  `issuing_status` enum('invoicing','invoiced') NOT NULL DEFAULT 'invoicing',
  `issuing_time` datetime DEFAULT NULL,
  `invitation_ent` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_accrual`
--

LOCK TABLES `sys_user_accrual` WRITE;
/*!40000 ALTER TABLE `sys_user_accrual` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user_accrual` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_base`
--

DROP TABLE IF EXISTS `sys_user_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_base` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` varchar(30) NOT NULL COMMENT '用户id',
  `password` char(32) NOT NULL COMMENT '用户密码',
  `real_name` varchar(30) NOT NULL COMMENT '真实姓名',
  `pinyin` varchar(255) NOT NULL DEFAULT '' COMMENT '真实姓名拼音',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别(0:男|1:女)',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `phone` char(11) DEFAULT NULL COMMENT '手机号码',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后一次登录时间',
  `last_login_enterprise` varchar(30) NOT NULL COMMENT '最后一次登录的企业',
  `last_login_enterprise_mobile` varchar(30) NOT NULL COMMENT '移动端最后一次登录的企业',
  `is_ad_welcome` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否显示欢迎界面(0:不显示|1:显示)',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `login_user_id` varchar(30) NOT NULL COMMENT '登录用户id',
  `last_modified` datetime NOT NULL COMMENT '最后一次修改时间',
  `verify_two` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否开启两步验证(0:未开启|1:已开启)',
  `reset_pwd` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '重置密码(0:未重置|1:已重置)',
  `theme` varchar(255) DEFAULT NULL COMMENT '界面主题',
  `reg_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户注册来源(1:管理员添加|2:手机注册|3:邮箱注册)',
  `birth_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '生日类型(0:公历|1:农历)',
  `pw_grade` tinyint(1) DEFAULT NULL COMMENT '密码等级(NULL:极低|1:中等|3:较高)',
  `lead_new_user` varchar(8) NOT NULL DEFAULT '' COMMENT '新用户引导',
  `lead_header` varchar(8) NOT NULL DEFAULT '' COMMENT '头部引导',
  `lead_portal` varchar(8) NOT NULL DEFAULT '' COMMENT '门户引导',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`) USING BTREE,
  UNIQUE KEY `login_user_id` (`login_user_id`) USING BTREE,
  KEY `real_name` (`real_name`) USING BTREE,
  KEY `pinyin` (`pinyin`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_base`
--

LOCK TABLES `sys_user_base` WRITE;
/*!40000 ALTER TABLE `sys_user_base` DISABLE KEYS */;
INSERT INTO `sys_user_base` VALUES (1,'root','be06dc310dc50b4b5ef25e1719e7353f','安元','anyuan',NULL,0,NULL,NULL,'2015-05-20 13:20:27',NULL,'','',0,NULL,'root','0000-00-00 00:00:00',0,0,'blue',1,0,NULL,'','','');
/*!40000 ALTER TABLE `sys_user_base` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_chat_token`
--

DROP TABLE IF EXISTS `sys_user_chat_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_chat_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `token` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `date` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_chat_token`
--

LOCK TABLES `sys_user_chat_token` WRITE;
/*!40000 ALTER TABLE `sys_user_chat_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user_chat_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_ios_token`
--

DROP TABLE IF EXISTS `sys_user_ios_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_ios_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_ios_token`
--

LOCK TABLES `sys_user_ios_token` WRITE;
/*!40000 ALTER TABLE `sys_user_ios_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user_ios_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_password_history`
--

DROP TABLE IF EXISTS `sys_user_password_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_password_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL DEFAULT '' COMMENT '用户id',
  `ent_id` varchar(30) NOT NULL DEFAULT '' COMMENT '企业id',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户密码修改历史';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_password_history`
--

LOCK TABLES `sys_user_password_history` WRITE;
/*!40000 ALTER TABLE `sys_user_password_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user_password_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_widget`
--

DROP TABLE IF EXISTS `sys_widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_widget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `url` text NOT NULL,
  `icon` text NOT NULL,
  `color` varchar(20) NOT NULL,
  `size` int(2) NOT NULL,
  `create_time` datetime NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统管理员保存模块表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_widget`
--

LOCK TABLES `sys_widget` WRITE;
/*!40000 ALTER TABLE `sys_widget` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_widget_permission`
--

DROP TABLE IF EXISTS `sys_widget_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_widget_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `widget_id` int(11) NOT NULL,
  `ent_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统管理员模块权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_widget_permission`
--

LOCK TABLES `sys_widget_permission` WRITE;
/*!40000 ALTER TABLE `sys_widget_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_widget_permission` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-13 19:50:45
