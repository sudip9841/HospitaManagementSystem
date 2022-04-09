-- MariaDB dump 10.18  Distrib 10.4.17-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: hms
-- ------------------------------------------------------
-- Server version	10.4.17-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointment_appointmentbooking`
--

DROP TABLE IF EXISTS `appointment_appointmentbooking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment_appointmentbooking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appointmentDate` date NOT NULL,
  `appointmentTime` int(11) NOT NULL,
  `appointmentStatus` varchar(20) NOT NULL,
  `paymentStatus` varchar(20) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `nonRegisteredPatient_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appointment_appointmentbooking_doctor_id_a3ca89ea` (`doctor_id`),
  KEY `appointment_appointmentbooking_nonRegisteredPatient_id_7c78b306` (`nonRegisteredPatient_id`),
  KEY `appointment_appointmentbooking_patient_id_d2f67184` (`patient_id`),
  CONSTRAINT `appointment_appointm_doctor_id_a3ca89ea_fk_userAuth_` FOREIGN KEY (`doctor_id`) REFERENCES `userauth_doctordetails` (`id`),
  CONSTRAINT `appointment_appointm_nonRegisteredPatient_7c78b306_fk_userAuth_` FOREIGN KEY (`nonRegisteredPatient_id`) REFERENCES `userauth_nonregisteredpatientdetails` (`id`),
  CONSTRAINT `appointment_appointm_patient_id_d2f67184_fk_userAuth_` FOREIGN KEY (`patient_id`) REFERENCES `userauth_patientdetails` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_appointmentbooking`
--

LOCK TABLES `appointment_appointmentbooking` WRITE;
/*!40000 ALTER TABLE `appointment_appointmentbooking` DISABLE KEYS */;
INSERT INTO `appointment_appointmentbooking` VALUES (48,'2022-04-03',10,'booked','paid',1,NULL,1),(49,'2022-04-08',10,'booked','pending',1,NULL,1),(51,'2022-04-06',10,'booked','paid',1,15,NULL),(52,'2022-04-09',10,'booked','pending',1,NULL,1),(53,'2022-04-10',12,'booked','pending',1,NULL,1),(54,'2022-04-10',1,'booked','pending',1,NULL,1),(55,'2022-04-10',10,'booked','pending',1,NULL,1),(56,'2022-04-09',11,'booked','paid',1,15,NULL),(57,'2022-04-09',4,'booked','pending',1,NULL,4);
/*!40000 ALTER TABLE `appointment_appointmentbooking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'doctor'),(1,'patient'),(3,'staff');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,3,41),(2,3,42),(3,3,43),(4,3,44);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add personal details',7,'add_personaldetails'),(26,'Can change personal details',7,'change_personaldetails'),(27,'Can delete personal details',7,'delete_personaldetails'),(28,'Can view personal details',7,'view_personaldetails'),(29,'Can add patient details',8,'add_patientdetails'),(30,'Can change patient details',8,'change_patientdetails'),(31,'Can delete patient details',8,'delete_patientdetails'),(32,'Can view patient details',8,'view_patientdetails'),(33,'Can add doctor details',9,'add_doctordetails'),(34,'Can change doctor details',9,'change_doctordetails'),(35,'Can delete doctor details',9,'delete_doctordetails'),(36,'Can view doctor details',9,'view_doctordetails'),(37,'Can add staff details',10,'add_staffdetails'),(38,'Can change staff details',10,'change_staffdetails'),(39,'Can delete staff details',10,'delete_staffdetails'),(40,'Can view staff details',10,'view_staffdetails'),(41,'Can add non registered patient details',11,'add_nonregisteredpatientdetails'),(42,'Can change non registered patient details',11,'change_nonregisteredpatientdetails'),(43,'Can delete non registered patient details',11,'delete_nonregisteredpatientdetails'),(44,'Can view non registered patient details',11,'view_nonregisteredpatientdetails'),(45,'Can add appointment booking',12,'add_appointmentbooking'),(46,'Can change appointment booking',12,'change_appointmentbooking'),(47,'Can delete appointment booking',12,'delete_appointmentbooking'),(48,'Can view appointment booking',12,'view_appointmentbooking'),(49,'Can add test report',13,'add_testreport'),(50,'Can change test report',13,'change_testreport'),(51,'Can delete test report',13,'delete_testreport'),(52,'Can view test report',13,'view_testreport');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$216000$GEQH1h4X7zQJ$qvQcgfKW2TKsqNt5e1lsAu/uPqVBsmhc2gGVnNMMdHk=','2022-04-09 09:15:09.132099',1,'admin','','','',1,1,'2022-01-01 14:41:13.116325'),(2,'pbkdf2_sha256$216000$TPbMdQfTDp0g$iIUasT1KLHkOJzqS0ogucP2zb2iRLdrVBeK/zNDA6Wk=','2022-04-09 09:15:46.159680',0,'sudip17','','','sudiptamang000@gmail.com',0,1,'2022-01-15 16:53:26.000000'),(7,'pbkdf2_sha256$216000$3vOpNlYvfrqL$Hau0SBs03urfXmeutKvK7QhMezKPcrvXrh0DVbjjv+w=','2022-04-09 07:42:39.554265',0,'juni','','','junitmg5@gmail.com',0,1,'2022-02-05 12:49:29.000000'),(8,'pbkdf2_sha256$216000$RQf5OvQv5pBC$eCWEX2IGiwXYL/hK/7ZGw9EMwqSygjBzye0AdkNDBJQ=','2022-04-08 16:53:19.086478',0,'abhilasha','','','abhilasha1@gmail.com',0,1,'2022-02-05 12:51:38.000000'),(9,'pbkdf2_sha256$216000$JRM4q7sUuKbY$eqxLtLSUSoPRnfP9GQROUJP/jxP1bBJpqZVfS5PH7QI=',NULL,0,'achala','','','achala1@gmail.com',0,1,'2022-02-05 13:29:56.000000'),(10,'pbkdf2_sha256$216000$cuIYIAjit8lC$sdiswm1/5fl14MiEiey5XELtHuxZxvdVa7CPM6brVaU=',NULL,0,'banira','','','banira1@gmail.com',0,1,'2022-02-05 13:50:30.000000'),(11,'pbkdf2_sha256$216000$S9kklPZR7922$zLIhBLGS0D09wQhz1GewEMXNUvSwBGWPsbRpsJ4Sq7U=',NULL,0,'brajendra','','','brajendra123@gmail.com',0,1,'2022-02-05 13:55:36.000000'),(12,'pbkdf2_sha256$216000$eG2ourKiqIg0$HYbf7uNvCIzAQjs15HQ9C8/uL0UYl4Br/pcH+S/iGaA=',NULL,0,'ramesh','','','ramesh123@gmail.com',0,1,'2022-02-05 15:21:57.000000'),(13,'pbkdf2_sha256$216000$vXFLJGlMIs0U$o0YqDQEvgBqi2MP1XSLnRBJYdwdGWxXevDmjJWsLhVI=',NULL,0,'Rishi','','','rishi123@gmail.com',0,1,'2022-02-05 15:25:51.000000'),(14,'pbkdf2_sha256$216000$Fxu4ighL9APq$iUa/dlXQVxdMACBU/iwerYEw2Hc7VbVjWch4iMZBgiA=',NULL,0,'Shirapa','','','shirapa123@gmail.com',0,1,'2022-02-05 15:30:59.000000'),(15,'pbkdf2_sha256$216000$FrUiPuyiY2um$ACN6SKtu12GP6ROQvBUFGEiBxP7iDDEM7c9jOMc/PN4=',NULL,0,'Dina','','','dina1@gmail.com',0,1,'2022-02-05 15:37:30.000000'),(16,'pbkdf2_sha256$216000$MtnAMzYZBlqH$41rqRq7AFgvaphPHL7QK4O17qIl9UncBjzSWnkjJKpQ=',NULL,0,'Kiran','','','kiran1@gmail.com',0,1,'2022-02-05 15:42:43.000000'),(17,'pbkdf2_sha256$216000$D6kM8uCXKAO1$EVE1cJjDBCWhLSIk1I20EXAx6g0xWDnkcR1NeOnes9I=',NULL,0,'Neyaz','','','neyaz123@gmail.com',0,1,'2022-02-05 15:45:57.000000'),(18,'pbkdf2_sha256$216000$7XDEfAmNtI9e$C6p3fc+jEpAUGep7H0Se0pFPY6RVrAWclMrcvQpk6zg=',NULL,0,'madhu','','','madhu123@gmail.com',0,1,'2022-02-05 15:53:17.000000'),(19,'pbkdf2_sha256$216000$9IDg8OWTEcrN$6Dq9YyVv1r9lvTM9ELH6KZJLbdQmq3uGNbOLcaKssQY=',NULL,0,'Praniti','','','praniti123@gmail.com',0,1,'2022-02-05 15:56:35.000000'),(20,'pbkdf2_sha256$216000$VP1hi9JcXjQ3$MJIitP8htFkXR6KOXLrg5tV35OtUlo29gkljUfuD4mw=',NULL,0,'Rajendra','','','rajendra123@gmail.com',0,1,'2022-02-05 15:59:37.000000'),(21,'pbkdf2_sha256$216000$DsQJAhOcWQxC$0xhqY/iqDsIk2weU2wqRG/zUC4HI9pmZkt+V5CSksN8=',NULL,0,'Mohan','','','mohan123@gmail.com',0,1,'2022-02-05 16:02:45.000000'),(22,'pbkdf2_sha256$216000$bqmrk20bMnsM$iUzIm1cVCXA/m8vDXWmspCgtDSWjYoE/2IDgFDS3VGw=',NULL,0,'Robin','','','robin123@gmail.com',0,1,'2022-02-05 16:06:06.000000'),(27,'pbkdf2_sha256$216000$fpP5M0uFEwJ6$hDYjWGvInQ1eWcy/1sQp4OwTW00QCF8hLevQsisM64Y=',NULL,0,'ram','','','ram123@gmail.com',0,1,'2022-04-03 08:18:25.135987'),(28,'pbkdf2_sha256$216000$KBtqWgdWcFRx$PWfTrBg5j6cNU//fOPdbfXdnrbrTx24M9K8ND2FQ3/8=','2022-04-09 08:41:15.272886',0,'aaron','','','aaron123@gmail.com',0,1,'2022-04-09 08:41:05.993013');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (2,2,1),(4,7,3),(5,8,2),(6,9,2),(7,10,2),(8,11,2),(9,12,2),(10,13,2),(11,14,2),(12,15,2),(13,16,2),(14,17,2),(15,18,2),(16,19,2),(17,20,2),(18,21,2),(19,22,2),(23,27,1),(24,28,1);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (1,7,41),(2,7,42),(3,7,43),(4,7,44);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2022-01-22 16:22:04.068121','1','PersonalDetails object (1)',2,'[{\"changed\": {\"fields\": [\"Phone\", \"Address\"]}}]',7,1),(2,'2022-01-22 16:22:58.083058','1','patient',1,'[{\"added\": {}}]',3,1),(3,'2022-02-04 07:54:13.745647','2','doctor',1,'[{\"added\": {}}]',3,1),(4,'2022-02-04 07:54:18.329216','3','staff',1,'[{\"added\": {}}]',3,1),(5,'2022-02-04 08:04:23.050828','3','ram',3,'',4,1),(6,'2022-02-04 08:04:23.057825','4','sam',3,'',4,1),(7,'2022-02-04 08:19:01.567735','2','sudip17',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(8,'2022-02-04 08:21:44.332039','6','abhilasha',1,'[{\"added\": {}}]',4,1),(9,'2022-02-04 08:21:56.515766','6','abhilasha',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(10,'2022-02-04 08:32:19.341321','2','PersonalDetails object (2)',1,'[{\"added\": {}}]',7,1),(11,'2022-02-04 08:32:47.141085','6','abhilasha',2,'[{\"changed\": {\"fields\": [\"Email address\"]}}]',4,1),(12,'2022-02-05 09:39:17.003142','6','abhilasha',3,'',4,1),(13,'2022-02-05 09:39:29.869351','1','PersonalDetails object (1)',3,'',7,1),(14,'2022-02-05 12:49:29.862784','7','juni',1,'[{\"added\": {}}]',4,1),(15,'2022-02-05 12:49:41.953591','7','juni',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(16,'2022-02-05 12:50:33.821176','1','StaffDetails object (1)',1,'[{\"added\": {}}]',10,1),(17,'2022-02-05 12:51:39.147742','8','abhilasha',1,'[{\"added\": {}}]',4,1),(18,'2022-02-05 12:51:47.675555','8','abhilasha',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(19,'2022-02-05 12:54:19.473311','1','DoctorDetails object (1)',1,'[{\"added\": {}}]',9,1),(20,'2022-02-05 13:06:17.371127','5','ram',3,'',4,1),(21,'2022-02-05 13:06:35.574044','7','juni',2,'[{\"changed\": {\"fields\": [\"Email address\"]}}]',4,1),(22,'2022-02-05 13:07:08.814369','8','abhilasha',2,'[{\"changed\": {\"fields\": [\"Email address\"]}}]',4,1),(23,'2022-02-05 13:29:57.251630','9','achala',1,'[{\"added\": {}}]',4,1),(24,'2022-02-05 13:30:18.997716','9','achala',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(25,'2022-02-05 13:48:39.247536','2','DoctorDetails object (2)',1,'[{\"added\": {}}]',9,1),(26,'2022-02-05 13:50:31.248063','10','banira',1,'[{\"added\": {}}]',4,1),(27,'2022-02-05 13:50:55.085281','10','banira',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(28,'2022-02-05 13:53:02.076237','3','DoctorDetails object (3)',1,'[{\"added\": {}}]',9,1),(29,'2022-02-05 13:55:37.025690','11','brajendra',1,'[{\"added\": {}}]',4,1),(30,'2022-02-05 13:55:56.207271','11','brajendra',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(31,'2022-02-05 13:57:01.044593','4','DoctorDetails object (4)',1,'[{\"added\": {}}]',9,1),(32,'2022-02-05 15:21:57.740766','12','ramesh',1,'[{\"added\": {}}]',4,1),(33,'2022-02-05 15:22:16.111586','12','ramesh',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(34,'2022-02-05 15:24:12.037144','5','DoctorDetails object (5)',1,'[{\"added\": {}}]',9,1),(35,'2022-02-05 15:25:51.493063','13','Rishi',1,'[{\"added\": {}}]',4,1),(36,'2022-02-05 15:26:06.143251','13','Rishi',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(37,'2022-02-05 15:28:15.742426','6','DoctorDetails object (6)',1,'[{\"added\": {}}]',9,1),(38,'2022-02-05 15:30:59.341470','14','Shirapa',1,'[{\"added\": {}}]',4,1),(39,'2022-02-05 15:31:17.502828','14','Shirapa',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(40,'2022-02-05 15:32:36.944267','7','DoctorDetails object (7)',1,'[{\"added\": {}}]',9,1),(41,'2022-02-05 15:37:30.862260','15','Dina',1,'[{\"added\": {}}]',4,1),(42,'2022-02-05 15:37:54.494954','15','Dina',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(43,'2022-02-05 15:39:37.584178','8','DoctorDetails object (8)',1,'[{\"added\": {}}]',9,1),(44,'2022-02-05 15:42:43.464124','16','Kiran',1,'[{\"added\": {}}]',4,1),(45,'2022-02-05 15:43:02.145675','16','Kiran',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(46,'2022-02-05 15:44:44.939498','9','DoctorDetails object (9)',1,'[{\"added\": {}}]',9,1),(47,'2022-02-05 15:45:57.542475','17','Neyaz',1,'[{\"added\": {}}]',4,1),(48,'2022-02-05 15:46:14.506757','17','Neyaz',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(49,'2022-02-05 15:47:48.078763','10','DoctorDetails object (10)',1,'[{\"added\": {}}]',9,1),(50,'2022-02-05 15:53:17.563519','18','madhu',1,'[{\"added\": {}}]',4,1),(51,'2022-02-05 15:53:33.791801','18','madhu',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(52,'2022-02-05 15:55:21.125847','11','DoctorDetails object (11)',1,'[{\"added\": {}}]',9,1),(53,'2022-02-05 15:56:35.916612','19','Praniti',1,'[{\"added\": {}}]',4,1),(54,'2022-02-05 15:56:52.509809','19','Praniti',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(55,'2022-02-05 15:58:44.713981','12','DoctorDetails object (12)',1,'[{\"added\": {}}]',9,1),(56,'2022-02-05 15:59:37.482972','20','Rajendra',1,'[{\"added\": {}}]',4,1),(57,'2022-02-05 15:59:55.882136','20','Rajendra',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(58,'2022-02-05 16:01:33.114920','13','DoctorDetails object (13)',1,'[{\"added\": {}}]',9,1),(59,'2022-02-05 16:02:45.450219','21','Mohan',1,'[{\"added\": {}}]',4,1),(60,'2022-02-05 16:03:03.953155','21','Mohan',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(61,'2022-02-05 16:05:15.044098','14','DoctorDetails object (14)',1,'[{\"added\": {}}]',9,1),(62,'2022-02-05 16:06:06.382279','22','Robin',1,'[{\"added\": {}}]',4,1),(63,'2022-02-05 16:06:23.144780','22','Robin',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(64,'2022-02-05 16:08:33.315296','15','DoctorDetails object (15)',1,'[{\"added\": {}}]',9,1),(65,'2022-02-14 14:29:43.243895','1','NonRegisteredPatientDetails object (1)',1,'[{\"added\": {}}]',11,1),(66,'2022-02-14 14:30:08.916530','1','NonRegisteredPatientDetails object (1)',3,'',11,1),(67,'2022-02-14 14:30:21.069725','2','NonRegisteredPatientDetails object (2)',1,'[{\"added\": {}}]',11,1),(68,'2022-02-14 14:31:15.285552','2','NonRegisteredPatientDetails object (2)',3,'',11,1),(69,'2022-02-14 14:31:45.328911','23','sudip',1,'[{\"added\": {}}]',4,1),(70,'2022-02-14 14:32:07.774776','23','sudip',2,'[{\"changed\": {\"fields\": [\"Email address\"]}}]',4,1),(71,'2022-02-14 14:32:25.946234','23','sudip',3,'',4,1),(72,'2022-02-14 17:06:52.474021','24','sajani',1,'[{\"added\": {}}]',4,1),(73,'2022-02-14 17:07:08.876672','24','sajani',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Groups\"]}}]',4,1),(74,'2022-02-14 17:08:01.087351','2','PatientDetails object (2)',1,'[{\"added\": {}}]',8,1),(75,'2022-02-14 17:16:25.383142','3','NonRegisteredPatientDetails object (3)',1,'[{\"added\": {}}]',11,1),(76,'2022-02-14 17:17:49.073350','1','AppointmentBooking object (1)',1,'[{\"added\": {}}]',12,1),(77,'2022-02-15 13:02:55.883918','1','AppointmentBooking object (1)',3,'',12,1),(78,'2022-02-15 13:10:02.543268','4','NonRegisteredPatientDetails object (4)',1,'[{\"added\": {}}]',11,1),(79,'2022-02-15 13:16:37.295900','5','NonRegisteredPatientDetails object (5)',1,'[{\"added\": {}}]',11,1),(80,'2022-02-19 04:59:39.766682','3','staff',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(81,'2022-02-19 05:03:46.815219','3','staff',2,'[]',3,1),(82,'2022-02-19 05:07:00.972601','3','staff',2,'[]',3,1),(83,'2022-02-19 05:08:24.479335','7','juni',2,'[{\"changed\": {\"fields\": [\"User permissions\"]}}]',4,1),(84,'2022-02-19 18:49:15.899832','2','AppointmentBooking object (2)',3,'',12,1),(85,'2022-02-24 16:11:44.125593','8','AppointmentBooking object (8)',3,'',12,1),(86,'2022-02-24 16:11:44.131615','7','AppointmentBooking object (7)',3,'',12,1),(87,'2022-02-24 16:11:44.135618','6','AppointmentBooking object (6)',3,'',12,1),(88,'2022-02-24 16:11:44.138625','5','AppointmentBooking object (5)',3,'',12,1),(89,'2022-02-24 16:11:44.142622','4','AppointmentBooking object (4)',3,'',12,1),(90,'2022-02-25 05:20:38.268602','9','AppointmentBooking object (9)',3,'',12,1),(91,'2022-03-24 16:20:13.390525','26','AppointmentBooking object (26)',1,'[{\"added\": {}}]',12,1),(92,'2022-03-26 12:19:54.066361','28','AppointmentBooking object (28)',3,'',12,1),(93,'2022-03-26 13:37:25.664292','36','AppointmentBooking object (36)',3,'',12,1),(94,'2022-03-26 13:37:25.671144','35','AppointmentBooking object (35)',3,'',12,1),(95,'2022-03-26 13:37:25.674872','34','AppointmentBooking object (34)',3,'',12,1),(96,'2022-03-26 13:37:25.678877','33','AppointmentBooking object (33)',3,'',12,1),(97,'2022-03-26 13:37:25.682838','32','AppointmentBooking object (32)',3,'',12,1),(98,'2022-03-26 13:37:25.685838','31','AppointmentBooking object (31)',3,'',12,1),(99,'2022-03-26 13:37:25.689838','30','AppointmentBooking object (30)',3,'',12,1),(100,'2022-03-26 13:37:25.692839','29','AppointmentBooking object (29)',3,'',12,1),(101,'2022-03-28 10:02:36.351289','46','AppointmentBooking object (46)',3,'',12,1),(102,'2022-03-28 10:02:36.357288','45','AppointmentBooking object (45)',3,'',12,1),(103,'2022-03-28 10:02:36.362288','44','AppointmentBooking object (44)',3,'',12,1),(104,'2022-03-28 10:02:36.366286','43','AppointmentBooking object (43)',3,'',12,1),(105,'2022-03-28 10:02:36.370281','42','AppointmentBooking object (42)',3,'',12,1),(106,'2022-03-28 10:02:36.374284','41','AppointmentBooking object (41)',3,'',12,1),(107,'2022-03-28 10:02:36.378285','40','AppointmentBooking object (40)',3,'',12,1),(108,'2022-03-28 10:02:36.382287','39','AppointmentBooking object (39)',3,'',12,1),(109,'2022-03-28 10:02:36.386279','38','AppointmentBooking object (38)',3,'',12,1),(110,'2022-03-28 10:02:36.390290','37','AppointmentBooking object (37)',3,'',12,1),(111,'2022-03-28 10:02:36.393286','27','AppointmentBooking object (27)',3,'',12,1),(112,'2022-03-28 10:02:36.400292','26','AppointmentBooking object (26)',3,'',12,1),(113,'2022-03-28 10:02:36.404283','25','AppointmentBooking object (25)',3,'',12,1),(114,'2022-03-28 10:02:36.408288','24','AppointmentBooking object (24)',3,'',12,1),(115,'2022-03-28 10:02:36.412285','23','AppointmentBooking object (23)',3,'',12,1),(116,'2022-03-28 10:02:36.416287','22','AppointmentBooking object (22)',3,'',12,1),(117,'2022-03-28 10:02:36.421286','21','AppointmentBooking object (21)',3,'',12,1),(118,'2022-03-28 10:02:36.425294','20','AppointmentBooking object (20)',3,'',12,1),(119,'2022-03-28 10:02:36.429281','19','AppointmentBooking object (19)',3,'',12,1),(120,'2022-03-28 10:02:36.433284','18','AppointmentBooking object (18)',3,'',12,1),(121,'2022-03-28 10:02:36.437286','17','AppointmentBooking object (17)',3,'',12,1),(122,'2022-03-28 10:02:36.442291','16','AppointmentBooking object (16)',3,'',12,1),(123,'2022-03-28 10:02:36.446284','15','AppointmentBooking object (15)',3,'',12,1),(124,'2022-03-28 10:02:36.450287','14','AppointmentBooking object (14)',3,'',12,1),(125,'2022-03-28 10:02:36.454281','13','AppointmentBooking object (13)',3,'',12,1),(126,'2022-03-28 10:02:36.457287','12','AppointmentBooking object (12)',3,'',12,1),(127,'2022-03-28 10:02:36.461283','11','AppointmentBooking object (11)',3,'',12,1),(128,'2022-03-28 10:02:36.463735','10','AppointmentBooking object (10)',3,'',12,1),(129,'2022-04-03 07:43:07.856727','26','ram',3,'',4,1),(130,'2022-04-09 05:44:55.814104','1','TestReport object (1)',1,'[{\"added\": {}}]',13,1),(131,'2022-04-09 05:51:09.937547','2','TestReport object (2)',1,'[{\"added\": {}}]',13,1),(132,'2022-04-09 08:25:26.031401','3','TestReport object (3)',3,'',13,1),(133,'2022-04-09 08:27:40.358555','5','TestReport object (5)',3,'',13,1),(134,'2022-04-09 08:29:10.925357','4','TestReport object (4)',3,'',13,1),(135,'2022-04-09 08:29:10.929359','2','TestReport object (2)',3,'',13,1),(136,'2022-04-09 08:29:10.933359','1','TestReport object (1)',3,'',13,1),(137,'2022-04-09 08:34:57.704250','8','TestReport object (8)',3,'',13,1),(138,'2022-04-09 08:40:13.066086','12','TestReport object (12)',3,'',13,1),(139,'2022-04-09 08:40:13.072085','11','TestReport object (11)',3,'',13,1),(140,'2022-04-09 08:40:13.074794','10','TestReport object (10)',3,'',13,1),(141,'2022-04-09 08:40:13.082802','9','TestReport object (9)',3,'',13,1),(142,'2022-04-09 09:15:29.430262','25','hari',3,'',4,1),(143,'2022-04-09 09:15:29.435255','24','sajani',3,'',4,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(12,'appointment','appointmentbooking'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(9,'userAuth','doctordetails'),(11,'userAuth','nonregisteredpatientdetails'),(8,'userAuth','patientdetails'),(7,'userAuth','personaldetails'),(10,'userAuth','staffdetails'),(13,'userAuth','testreport');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-01-01 14:40:04.499049'),(2,'auth','0001_initial','2022-01-01 14:40:05.002633'),(3,'admin','0001_initial','2022-01-01 14:40:05.728967'),(4,'admin','0002_logentry_remove_auto_add','2022-01-01 14:40:05.891836'),(5,'admin','0003_logentry_add_action_flag_choices','2022-01-01 14:40:05.910816'),(6,'contenttypes','0002_remove_content_type_name','2022-01-01 14:40:06.050500'),(7,'auth','0002_alter_permission_name_max_length','2022-01-01 14:40:06.098497'),(8,'auth','0003_alter_user_email_max_length','2022-01-01 14:40:06.187492'),(9,'auth','0004_alter_user_username_opts','2022-01-01 14:40:06.214499'),(10,'auth','0005_alter_user_last_login_null','2022-01-01 14:40:06.304500'),(11,'auth','0006_require_contenttypes_0002','2022-01-01 14:40:06.311498'),(12,'auth','0007_alter_validators_add_error_messages','2022-01-01 14:40:06.331497'),(13,'auth','0008_alter_user_username_max_length','2022-01-01 14:40:06.372500'),(14,'auth','0009_alter_user_last_name_max_length','2022-01-01 14:40:06.409500'),(15,'auth','0010_alter_group_name_max_length','2022-01-01 14:40:06.452510'),(16,'auth','0011_update_proxy_permissions','2022-01-01 14:40:06.475539'),(17,'auth','0012_alter_user_first_name_max_length','2022-01-01 14:40:06.512533'),(18,'sessions','0001_initial','2022-01-01 14:40:06.584528'),(19,'userAuth','0001_initial','2022-01-16 07:39:00.120811'),(20,'userAuth','0002_auto_20220116_1402','2022-01-16 08:17:18.477243'),(21,'userAuth','0003_auto_20220205_1538','2022-02-05 09:53:21.997153'),(22,'userAuth','0004_auto_20220205_1607','2022-02-05 10:22:32.313082'),(23,'userAuth','0005_doctordetails_staffdetails','2022-02-05 12:33:48.635344'),(24,'userAuth','0006_auto_20220205_1912','2022-02-05 13:27:36.074127'),(25,'userAuth','0007_nonregisteredpatientdetails','2022-02-14 14:24:20.476164'),(26,'userAuth','0008_auto_20220214_2012','2022-02-14 14:27:25.308104'),(27,'userAuth','0009_auto_20220214_2014','2022-02-14 14:29:14.761002'),(28,'appointment','0001_initial','2022-02-14 17:05:16.619161'),(29,'appointment','0002_auto_20220215_1857','2022-02-15 13:12:20.527314'),(30,'appointment','0003_auto_20220220_0034','2022-02-19 18:50:03.291233'),(31,'userAuth','0010_testreport','2022-04-09 04:42:58.129948'),(32,'userAuth','0011_auto_20220409_1414','2022-04-09 08:29:51.073036');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0f9ex3fxs8f3eb4izok4rqculry23s3a','.eJxVjDsOwjAQBe_iGll4d-M4lPScwdr1BweQI8VJhbg7iZQC2pl57608r0vxa0uzH6O6KKdOv0w4PFPdRXxwvU86THWZR9F7og_b9G2K6XU92r-Dwq1sawBAsMYJDdlk7ISNBOlzBiIrGSlGRkqCfXDWbJgHRxaCEUdnhE59vt_aN5o:1nJSL7:7-y4hfe0x3qiC2rXxFg8Fd0ffVQgFfDryfWOH0IxVTo','2022-02-28 03:47:49.447523'),('0fuj8fntkq3zppqwsiv0nnx7kiczroiv','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nXQBE:q6Zd48DlJX7wQyaDTe7hcoTqPWDjZ4_X8upiL8Morqc','2022-04-07 16:19:20.885000'),('0o4mhjb1nxat3gpcilmwnb9q7ulc689n','.eJxVjMsOwiAQRf-FtSGlDAy4dO83NDMDSNXQpI-V8d-1SRe6veec-1IDbWsdtiXPw5jUWaE6_W5M8shtB-lO7TZpmdo6j6x3RR900dcp5eflcP8OKi31WwMbZLAI0onJxmUgdk4wCHgChyVzxI4sgC3JBo8cOLriqUeIRnr1_gDcqDd-:1nKxtS:QHOuFnd71Zb_NiVJ5aPrMYGmoZO0R3kHad9Qn_n4cNQ','2022-03-04 07:41:30.199230'),('1dpw8fh19bo1zphdh3cby5cyxqerfb4b','.eJxVjMsOwiAQRf-FtSGlDAy4dO83NDMDSNXQpI-V8d-1SRe6veec-1IDbWsdtiXPw5jUWaE6_W5M8shtB-lO7TZpmdo6j6x3RR900dcp5eflcP8OKi31WwMbZLAI0onJxmUgdk4wCHgChyVzxI4sgC3JBo8cOLriqUeIRnr1_gDcqDd-:1nLI8Y:cir0ZjsgiuJO7W43x_QXXur3tAjiTYulFmpTISx0jHc','2022-03-05 05:18:26.992666'),('1tjmxilz4bgnu09qwurh7dlhzys7dl6i','.eJxVjMsOwiAQRf-FtSEyvF269xsIA4xUDSSlXRn_3TbpQrf3nHPfLMR1qWEdZQ5TZhcG7PS7YUzP0naQH7HdO0-9LfOEfFf4QQe_9Vxe18P9O6hx1K02yhoidNKAluii9xnAC3BOWauktlm4pM-qkMmAm5OISKpioWASAtnnC7sVN1g:1nLOHN:wXiDCl6UJn-JqQJn8hawW0OmAVyU_puWcsbscKs2M8k','2022-03-05 11:51:57.569098'),('1u6q4xbtaso2s3yjett9kqhaxdb7dwxt','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1n90FL:sn2QV7YnxAirGdEmTau6BTUbgdxB4Ge9BEwwnpMzlGU','2022-01-30 07:46:39.662285'),('21pdlu7gyaaopo7xet2v3zt0sxd6yciy','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nK18W:LIxd0quXJNfkT-unmlMWpRCNytMkLvYk4Mvh1oFKoUg','2022-03-01 16:57:08.045534'),('3bgc1p5xsbf75wd46i21292dlpi7thrp','.eJxVjMsOwiAQRf-FtSGlDAy4dO83NDMDSNXQpI-V8d-1SRe6veec-1IDbWsdtiXPw5jUWaE6_W5M8shtB-lO7TZpmdo6j6x3RR900dcp5eflcP8OKi31WwMbZLAI0onJxmUgdk4wCHgChyVzxI4sgC3JBo8cOLriqUeIRnr1_gDcqDd-:1nMtXU:ppmJReZp1evGWz-OxppPsioZZXMAI2XjD3mpSnQPXEY','2022-03-09 15:26:48.355252'),('46ovhnbhyyk2exjzh23rwvszmnsbpcux','.eJxVjDsOwjAQBe_iGlmxY7w2JX3OYG2eNziAHCmfCnF3iJQC2jcz76USb2tJ2yJzGrO6KKtOv1vPeEjdQb5zvU0aU13nsde7og-66G7K8rwe7t9B4aV86xae4RrbGzvAGhJhgjdoAkx0FgMih5a8d5R99JLPBASmyE07gKN6fwDrbDg5:1n8ybo:dSzqSG5YPV2d3ThKRIcx2p8_lxprZWai76A0xkUJzJY','2022-01-30 06:01:44.412558'),('4hiykturnkojllmd9seijdy6xyhnp505','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nLU4m:BpaX2aP5CWaOi2cOR8d4kxzI8BQuncSDF6vRFLMJNgY','2022-03-05 18:03:20.327899'),('70or571ibew6218wirholob6ekaf0c1l','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nMtaI:oDPy4rhaNTBusOnS-H8kxmuZ47JrfVG6r55Pywc2dzY','2022-03-09 15:29:42.177268'),('94u850sl7jfbm7736u437cp1e5d44j06','.eJxVjMsOwiAQRf-FtSGlDAy4dO83NDMDSNXQpI-V8d-1SRe6veec-1IDbWsdtiXPw5jUWaE6_W5M8shtB-lO7TZpmdo6j6x3RR900dcp5eflcP8OKi31WwMbZLAI0onJxmUgdk4wCHgChyVzxI4sgC3JBo8cOLriqUeIRnr1_gDcqDd-:1nd5jz:EKdJsqpsAcafN-ludct9Zj8NbtMt-FHX3i99ufJsloE','2022-04-23 07:42:39.559262'),('9pimor0kjib0c0nq9330tlle04jsx4yx','.eJxVjDsOwjAQBe_iGlmxY7w2JX3OYG2eNziAHCmfCnF3iJQC2jcz76USb2tJ2yJzGrO6KKtOv1vPeEjdQb5zvU0aU13nsde7og-66G7K8rwe7t9B4aV86xae4RrbGzvAGhJhgjdoAkx0FgMih5a8d5R99JLPBASmyE07gKN6fwDrbDg5:1n8yfv:dhI67xc3GuK05qGrvtpJfDjyjWiwe6Q6o-sA9iWygM0','2022-01-30 06:05:59.243824'),('a25jg0bkc8xfdl16m9fx4rjj3d2dyz8a','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nFtPs:GLiO0Bu1ZQimzXxDW-cMPfElTU760sxMyCc2p1pHYgs','2022-02-18 07:54:00.841201'),('bcttg93ycyaa2u035g34v046zywfekr3','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nJcHx:DqfETgrIyE-fsulGzwjCYGxh0in8leKPzPjH7UuIkeM','2022-02-28 14:25:13.842315'),('c3fbdhjd042c1apli86w1vwg45a0otxn','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nGdZx:6D-thsquGeCclorUMps5DOmyoZJhfx-oRpn_WKDOEA4','2022-02-20 09:11:29.369533'),('c4386tnvbem0od2n0uqzz58c7shw40w9','.eJxVjMsOwiAQRf-FtSGlDAy4dO83NDMDSNXQpI-V8d-1SRe6veec-1IDbWsdtiXPw5jUWaE6_W5M8shtB-lO7TZpmdo6j6x3RR900dcp5eflcP8OKi31WwMbZLAI0onJxmUgdk4wCHgChyVzxI4sgC3JBo8cOLriqUeIRnr1_gDcqDd-:1nKvs9:gkjAm0IKl1-PIqUYkUFlAcy3KwJoXn7iPsFaTC50cKY','2022-03-04 05:32:01.285761'),('dtc7hbxbt79auhj6sq068027epqw54l3','.eJxVjMsOwiAQRf-FtSHyBpfu-w1kYAapGkhKuzL-uzbpQrf3nHNfLMK21rgNWuKM7MIkO_1uCfKD2g7wDu3Wee5tXebEd4UfdPCpIz2vh_t3UGHUb62FlqY4pQR4Lyxkp70TxtmQMp5LDgqxOIlaGyIJmLyQ0qsQLFH2kNj7A8OFN7U:1n9JS6:eqlfbzdRnurF7PenPYCgrY1ssb6Ho-Z9URZO3Xp0jUw','2022-01-31 04:17:06.604688'),('eegt2sng6hsb7zyasd175besxy8jm06x','.eJxVjDsOwjAQBe_iGll4d-M4lPScwdr1BweQI8VJhbg7iZQC2pl57608r0vxa0uzH6O6KKdOv0w4PFPdRXxwvU86THWZR9F7og_b9G2K6XU92r-Dwq1sawBAsMYJDdlk7ISNBOlzBiIrGSlGRkqCfXDWbJgHRxaCEUdnhE59vt_aN5o:1nTKyY:cbz97kq0c3yKdeTgP3wRcO6zj9mBZj3l3vC3MuL59z8','2022-03-27 09:57:22.462790'),('f00szkmywz93dpvudnyao54aes6aeftf','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nGHAC:pBveM6b-Qn7EtY5ojcXcz0tYVu63gk8kkH70REDZueQ','2022-02-19 09:15:24.564040'),('fyeriyc0lgdwscf4w3mr9owqydm41imz','.eJxVjMsOwiAQRf-FtSEyvF269xsIA4xUDSSlXRn_3TbpQrf3nHPfLMR1qWEdZQ5TZhcG7PS7YUzP0naQH7HdO0-9LfOEfFf4QQe_9Vxe18P9O6hx1K02yhoidNKAluii9xnAC3BOWauktlm4pM-qkMmAm5OISKpioWASAtnnC7sVN1g:1nE353:dy4S9On1q2XoXqp5m8sT8ZuqIFLUqxP27J28QJdbm7g','2022-02-13 05:48:53.173483'),('fyn9cvx0uxt1g6c3k6e4n6nbrs2dtq78','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nNT1n:q8HN9wFVagBl8BDwamKFYKQPk0TdCpun1C3yTxMXL88','2022-03-11 05:20:27.570577'),('ggbjsp1enbmox03sfoz7mfwiaz7e3v23','.eJxVjDsOwjAQBe_iGlnr79qU9JzB8nodHECOlE-FuDtESgHtm5n3Eilva0vbUuc0sjgL7cTpd6RcHrXvhO-53yZZpr7OI8ldkQdd5HXi-rwc7t9By0v71t5ow-h0cF5Zi0MGixiLChzBeAXgORJhDsYXq2lwAbBEAhUjAxKK9wfF9DaV:1nY6br:l3vMmXlwW-qPN4Kk3KWdX8l1p1SLt1Elw_jU0z87Vfk','2022-04-09 13:37:39.560592'),('h9pcuv7iekgn82ojnoka0ap953uhw1j8','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nBWfO:5wLne-7moeKWI-q_mZQdraMl6qYp4q0J2hT1epZzRtM','2022-02-06 06:47:58.537971'),('hdou6kfamly8v3c8vyvb7n4toro2xqj4','.eJxVjMsOwiAQRf-FtSGlDAy4dO83NDMDSNXQpI-V8d-1SRe6veec-1IDbWsdtiXPw5jUWaE6_W5M8shtB-lO7TZpmdo6j6x3RR900dcp5eflcP8OKi31WwMbZLAI0onJxmUgdk4wCHgChyVzxI4sgC3JBo8cOLriqUeIRnr1_gDcqDd-:1naKBJ:7fIT685ptKlqzuXKgsno9KkY6gLWff31yAgqbZgiOl8','2022-04-15 16:31:25.828147'),('hj6glv9h2x3znomp9a89uzfkqf4krzrx','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nG0w6:MPKNRTDtQkxeu1DfBJZZK-KgHLEdY6iJfdVn59ggrRI','2022-02-18 15:55:46.794660'),('iqs9nyqizws2lx0aa7dnjzxpm35bkq49','.eJxVjMsOwiAQRf-FtSEdHgVcuvcbyMAMUjU0Ke3K-O_apAvd3nPOfYmI21rj1nmJE4mzUOL0uyXMD247oDu22yzz3NZlSnJX5EG7vM7Ez8vh_h1U7PVbh2CcLSP7Ygw7Z3WxMPo8ZMioiFNArTNYBQkhOGWspsF4IO1DKgVJvD_Rkzeu:1n8nGu:fkRJUseK_s3Q0S-jdhGkjB9FnRetskbFOJ1_L2Ecob4','2022-01-29 17:55:24.478258'),('ixoltmqstkf36bctc31mbx1aw13a3eec','.eJxVjMsOwiAQRf-FtSEyvF269xsIA4xUDSSlXRn_3TbpQrf3nHPfLMR1qWEdZQ5TZhcG7PS7YUzP0naQH7HdO0-9LfOEfFf4QQe_9Vxe18P9O6hx1K02yhoidNKAluii9xnAC3BOWauktlm4pM-qkMmAm5OISKpioWASAtnnC7sVN1g:1naK3V:YsuAt6iKHIeER8Ey6AWP_nXjEWot8UkyiRutnFrtr8w','2022-04-15 16:23:21.094782'),('jz1xg3fgm2l2wseg41d9ovqbrmq5a93g','.eJxVjMsOwiAQRf-FtSEyvF269xsIA4xUDSSlXRn_3TbpQrf3nHPfLMR1qWEdZQ5TZhcG7PS7YUzP0naQH7HdO0-9LfOEfFf4QQe_9Vxe18P9O6hx1K02yhoidNKAluii9xnAC3BOWauktlm4pM-qkMmAm5OISKpioWASAtnnC7sVN1g:1nNYw2:koI0ark4BrHa8Dl4TFZQG-wBpej7GEGl-Mob5P2KbPo','2022-03-11 11:38:54.332251'),('ltxnroh1fd7ozrph6757hn3yb2tjkjg1','.eJxVjMsOwiAQRf-FtSEyvF269xsIA4xUDSSlXRn_3TbpQrf3nHPfLMR1qWEdZQ5TZhcG7PS7YUzP0naQH7HdO0-9LfOEfFf4QQe_9Vxe18P9O6hx1K02yhoidNKAluii9xnAC3BOWauktlm4pM-qkMmAm5OISKpioWASAtnnC7sVN1g:1nLIMs:xTgQmEzzxy2xOZFzlhY7zrU_JVtEoHwSUakT3ub8byk','2022-03-05 05:33:14.804955'),('m92ltuvxn1dxrabfa32lhwlkjn2th1ao','.eJxVjMsOwiAQRf-FtSEyvF269xsIA4xUDSSlXRn_3TbpQrf3nHPfLMR1qWEdZQ5TZhcG7PS7YUzP0naQH7HdO0-9LfOEfFf4QQe_9Vxe18P9O6hx1K02yhoidNKAluii9xnAC3BOWauktlm4pM-qkMmAm5OISKpioWASAtnnC7sVN1g:1nGdb4:EmjW4BC99K_-B5KWbYl9x4zq3XQHC91UON-WhxKwCmw','2022-02-20 09:12:38.428933'),('ma1l2svugo39ht8wscojn0dbb2xjhk8l','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nGdbZ:8cL4U3CO25nTh37Ov89UVKc7Vgvqnnn9LepziJUrAIc','2022-02-20 09:13:09.031634'),('mj9btxpnm4fmgs1rjqt27xtk0f2wg7e5','.eJxVjDsOwjAQBe_iGll4d-M4lPScwdr1BweQI8VJhbg7iZQC2pl57608r0vxa0uzH6O6KKdOv0w4PFPdRXxwvU86THWZR9F7og_b9G2K6XU92r-Dwq1sawBAsMYJDdlk7ISNBOlzBiIrGSlGRkqCfXDWbJgHRxaCEUdnhE59vt_aN5o:1nGdoT:VmAawtlxOYRcE2GwBkVII8ZPfXjXXBj8_YU-CTcZHlI','2022-02-20 09:26:29.276701'),('mygmp3l4s2jkho67urc07ubh50t5tx8n','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nNGi8:wh3hrmptRTqqD2VBO-FFSuBxQmm8NJCg-B7c1MeW5hs','2022-03-10 16:11:20.408222'),('n3q6fz5k40klvuq6d74hxkb2gy5hyfy4','.eJxVjEEOwiAUBe_C2hCgBYpL956BPP4HWzU0Ke3KeHdt0oVu38y8l4jY1jFuLS9xYnEWRpx-twR65LoDvqPeZklzXZcpyV2RB23yOnN-Xg7372BEG7_1kDzpoG2v4E1QRXHQnRl8LugdmWDAGQNpa5XjjgsYcERBoVj0rMT7A9d6OFA:1n8mKh:mnMB5e4Ipct5X9RLalVm871Egql5xiLuPbsAEbM3W6k','2022-01-29 16:55:15.024516'),('n7ww8ugfpz1q89ffrbcmloauc8czf4ho','.eJxVjMsOwiAQRf-FtSEyvF269xsIA4xUDSSlXRn_3TbpQrf3nHPfLMR1qWEdZQ5TZhcG7PS7YUzP0naQH7HdO0-9LfOEfFf4QQe_9Vxe18P9O6hx1K02yhoidNKAluii9xnAC3BOWauktlm4pM-qkMmAm5OISKpioWASAtnnC7sVN1g:1nGPCe:KjebRRWFg0B_X3Ao8ZiXfoBkJdJeWH3-Iin6XPkY1NI','2022-02-19 17:50:28.644582'),('ngmrirlfoe77s3pwfhb2zxrn2md0qjud','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nJxTc:FGFyRqcFbha63bK-HTNQgOzfvgGMF1kK_rI9hopg8ak','2022-03-01 13:02:40.724344'),('ni9o5giabf4bv8wpfwa7exh1cj7s5grz','.eJxVjMsOwiAQRf-FtSGlDAy4dO83NDMDSNXQpI-V8d-1SRe6veec-1IDbWsdtiXPw5jUWaE6_W5M8shtB-lO7TZpmdo6j6x3RR900dcp5eflcP8OKi31WwMbZLAI0onJxmUgdk4wCHgChyVzxI4sgC3JBo8cOLriqUeIRnr1_gDcqDd-:1nNFcM:6gy_hdAbwrr94uFD9YVn8Vzmf_izazufOQo9iSGfnBE','2022-03-10 15:01:18.042136'),('p5yxl93yqbp68xhgrajsjzn16dke81hk','.eJxVjMsOwiAQRf-FtSEyvF269xsIA4xUDSSlXRn_3TbpQrf3nHPfLMR1qWEdZQ5TZhcG7PS7YUzP0naQH7HdO0-9LfOEfFf4QQe_9Vxe18P9O6hx1K02yhoidNKAluii9xnAC3BOWauktlm4pM-qkMmAm5OISKpioWASAtnnC7sVN1g:1nd7C6:s3Sqj_VKJ-AvbxeLWQ8yaoU8XgQHGPsVZnkaMH23PIc','2022-04-23 09:15:46.164701'),('q5qj0umf1xmli25otedv3vzhitjyn16e','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nYmCb:WEk7bJUhX2VnOSUkPsI_oIX4Of4yMhC5QQt6ad9XZbQ','2022-04-11 10:02:21.184702'),('rhbnw0xilxazqt3jvz67xca2zo0dt9yo','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nYMaT:BwmfooezEe3WkEebxp2ZZvzttXV-ifvdgKQpPpeFZRU','2022-04-10 06:41:17.726026'),('sx3ehaj5d4dqsfygamt6vbetw9n6gzoj','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1n8gr2:8_0j0iDg6vqLzeQpqcsqYF8m5I1uQPY1EhDfNikGg7Y','2022-01-29 11:04:16.171211'),('tby3w5yn5aii61o8sft010o6uyl37pny','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1nGdib:kiRHduhYtGPRlIMn6P65YCNhMDc20W2oaVtxfg9hhOE','2022-02-20 09:20:25.777324'),('u99me90ph1nwaq8lic0z4tdxhn098h7l','.eJxVjMsOwiAQRf-FtSGlDAy4dO83NDMDSNXQpI-V8d-1SRe6veec-1IDbWsdtiXPw5jUWaE6_W5M8shtB-lO7TZpmdo6j6x3RR900dcp5eflcP8OKi31WwMbZLAI0onJxmUgdk4wCHgChyVzxI4sgC3JBo8cOLriqUeIRnr1_gDcqDd-:1nLRu6:kTIdxafIUjvWcjAaiPRTQ-EyY-yJ0Uux_nYpq2eM_O8','2022-03-05 15:44:10.315764'),('x7cwrvljlnlnod2ocdmvehzlij47h8cx','.eJxVjMsOwiAQRf-FtSGlDAy4dO83NDMDSNXQpI-V8d-1SRe6veec-1IDbWsdtiXPw5jUWaE6_W5M8shtB-lO7TZpmdo6j6x3RR900dcp5eflcP8OKi31WwMbZLAI0onJxmUgdk4wCHgChyVzxI4sgC3JBo8cOLriqUeIRnr1_gDcqDd-:1ncrlN:TWPBb2jZgLLRXDKgMjX9KL6M74eyoRE5aqlXJ7U15qo','2022-04-22 16:47:09.988684'),('xel30tcinceau1y7akhdel3b25wns208','.eJxVjMsOwiAQRf-FtSEyvF269xsIA4xUDSSlXRn_3TbpQrf3nHPfLMR1qWEdZQ5TZhcG7PS7YUzP0naQH7HdO0-9LfOEfFf4QQe_9Vxe18P9O6hx1K02yhoidNKAluii9xnAC3BOWauktlm4pM-qkMmAm5OISKpioWASAtnnC7sVN1g:1nTKxF:f9vFwCitTnaR-4jhC288LCSYT4Vr-q7VHq0O_IBiDeM','2022-03-27 09:56:01.357680'),('xtwjia1le8jw7kknyiglqe24nbcfglgv','.eJxVjMEOwiAQBf-FsyHALggevfcbCLAgVQNJaU_Gf9cmPej1zcx7MR-2tfpt5MXPxC5MstPvFkN65LYDuod26zz1ti5z5LvCDzr41Ck_r4f7d1DDqN8aCJUWQgoS56wcOI2QsdhoHDqSYHPRKoG1kTQBWnQg0BUtBUZjomTvD6qRNlw:1n8mrl:EtqR3oS-CvBCpbX_6g4ubg_jZbBFhzlJlvbV8xVW-JI','2022-01-29 17:29:25.831806'),('yuas3j5qznb97awrwg4xohfvlswzdfop','.eJxVjMsOwiAQRf-FtSEyvF269xsIA4xUDSSlXRn_3TbpQrf3nHPfLMR1qWEdZQ5TZhcG7PS7YUzP0naQH7HdO0-9LfOEfFf4QQe_9Vxe18P9O6hx1K02yhoidNKAluii9xnAC3BOWauktlm4pM-qkMmAm5OISKpioWASAtnnC7sVN1g:1nZr3W:ys5d05HkbgB7_QqPU070PUi94NHaen0QyWuiek7JJ3A','2022-04-14 09:25:26.337283');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userauth_doctordetails`
--

DROP TABLE IF EXISTS `userauth_doctordetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userauth_doctordetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullName` varchar(50) NOT NULL,
  `age` int(10) unsigned NOT NULL CHECK (`age` >= 0),
  `gender` varchar(10) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `address` varchar(50) NOT NULL,
  `department` varchar(50) NOT NULL,
  `experience` longtext NOT NULL,
  `education` longtext NOT NULL,
  `profile_pic` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `userAuth_doctordetails_user_id_488d6a3c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userauth_doctordetails`
--

LOCK TABLES `userauth_doctordetails` WRITE;
/*!40000 ALTER TABLE `userauth_doctordetails` DISABLE KEYS */;
INSERT INTO `userauth_doctordetails` VALUES (1,'Abhilasha Shah',35,'F',9841223456,'bansbari','neurosciences','Fellowship in Rheumatology and Clinical Immunology, Sir Gangaram Hospital, New Delhi , Kathmandu Nepal from September 2018 to August 2019','Bachelor in Medicine Bachelor in Surgery, Tianjin Medical University, Tianjin, China From September 2001 to July 2006','doctorprofilepic/5e412052bee7e_OV1stRT.jpg',8),(2,'Achala Vaidya',40,'F',9843123875,'durbarmarg','cardiovascular-medicine','Chief Consultant Gynaecologist, Norvic international Hospital, Thapathali','MBBS, King George Medical College, Lucknow; India 1983','doctorprofilepic/5abb5060ae92a.jpg',9),(3,'Banira Karki',30,'F',9841232343,'basundhara','oncolog','Norvic International Hospital – Consultant Breast Oncosurgeon (25th January, 2020 - Present)','Fellowship in Breast Oncosurgery, Tata Medical Center, Kolkata, India. (1st August, 2019 - 31st July, 2020)','doctorprofilepic/6177c411c38c8.jpg',10),(4,'Brajendra Srivastava',50,'M',9860334756,'dhapasi','pulmonology','Working as a Senior Consultant Pulmonologist (Chest Physician)','MD - Tuberculosis + Respiratory Medicine, 2000.','doctorprofilepic/5c88e82fa5292.jpg',11),(5,'Ramesh Chokhani',40,'M',9860337836,'boudha','obstetrics-and-gynecology','Associate Professor in Department of Medicine, Nepal Medical College (2004-2010)','MD in Respiratory Disease and Tuberculosis from Vallabhbhai Patel Chest Institute, University of Delhi, 1989','doctorprofilepic/5ab8bf1d9b89d.jpg',12),(6,'Rishi Bista',40,'M',9844212383,'budanilkantha','orthopaedics','Associate Professor of Orthopaedics at NAMS','MS (Orthopedics) from NAMS - 2012.','doctorprofilepic/614c6ef90a45a.jfif',13),(7,'Shirapa Bajracharya',30,'F',9841227856,'chakrapath','dermatology','Consultant Dermatologist, Norvic International Hospital Thapathali, Kathmandu July 2016 to present.','MBBS- Sindh Medical College, Karachi, Pakistan Attended from 2001-2006','doctorprofilepic/5b0e586a3a583.jpg',14),(8,'Dina Shrestha',30,'F',9841284748,'Baluwatar','diabetes-and-endocrinology','Consultant Endocrinologist ,Hospital for Advanced Medicine and Surgery (HAMS),Kathmandu','MD in Internal Medicine (Endocrinology), Dalian Medical University, Dalian, China.','doctorprofilepic/5ab8c02702b0b.jpg',15),(9,'Kiran Rai',40,'M',9860448374,'balaju','ear-nose-throat-ent','Head of Department ENT-HNS, Shree Birendra Army Hospital 2009 – till date','Doctor of Medicine, MD, Roster State Medical College Russia.','doctorprofilepic/5acdefaa7d110.jpg',16),(10,'Neyaz Kausar',35,'M',9845453412,'swyambhu','eye-care','Working as Opthalmologist at Nepal Eye Hospital, Since 2011','M.D., National Academy of Medical Sciences, Bir Hospital, Nepal, 2011','doctorprofilepic/5b320dcc40ade.jpg',17),(11,'Madhu Prasad Ghimire',70,'M',9845338876,'gangabu','gastroenterology','Chief, DDC , Norvic International  (2012-2017)','MBBS – Delhi University-1971','doctorprofilepic/5abb58b0178e4.jpg',18),(12,'Praniti Singh',33,'F',9841232323,'thapathali','nutrition-and-dietetic','Worked as a Dietitian at Ekta’s Diet Dazzle, New Delhi','M.Sc in  Foods and Nutrition from Amity University, Noida, India.','doctorprofilepic/5abb51ebb361e.jpg',19),(13,'Rajendra Kumar Agrawal',50,'M',9860223456,'samakhusi','nephrology','Chief Consultant Nephrologist, Bir Hospital, NAMS(2014-2017)','MD(Nephrology)- Institute of Post- Graduate Medicine and Research,Dhaka,Bangladesh(Feb1995-July 1998)','doctorprofilepic/5abb54ae6f9cb.jpg',20),(14,'Mohan Bista',27,'F',9860505857,'tokha','physiotherapy','Manmohan Cardio-thoracic and vascular transplant center (2011-2012)','Master in  Rehabilitation Science and Physiotherapy (Internal disorders)  Leuven, Belgium','doctorprofilepic/58b55900ed2ca-pratik-pokharel.jpg',21),(15,'Robin Joshi',45,'M',9845227867,'jorpati','urology','Working as Consultant Urologist in Norvic International Hospital.','MS and Fellow Registrar in Urology, Shaikh Zayed Hospital, Punjab University, Lahore, Pakistan (2003- 2006).','doctorprofilepic/5acdeee0737ef.jpg',22);
/*!40000 ALTER TABLE `userauth_doctordetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userauth_nonregisteredpatientdetails`
--

DROP TABLE IF EXISTS `userauth_nonregisteredpatientdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userauth_nonregisteredpatientdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullName` varchar(50) NOT NULL,
  `age` int(10) unsigned NOT NULL CHECK (`age` >= 0),
  `gender` varchar(10) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `address` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userauth_nonregisteredpatientdetails`
--

LOCK TABLES `userauth_nonregisteredpatientdetails` WRITE;
/*!40000 ALTER TABLE `userauth_nonregisteredpatientdetails` DISABLE KEYS */;
INSERT INTO `userauth_nonregisteredpatientdetails` VALUES (15,'hari thapa',33,'M',9841889898,'jorpati, narayantar'),(16,'ram shah',20,'M',9860110101,'dhapasi');
/*!40000 ALTER TABLE `userauth_nonregisteredpatientdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userauth_patientdetails`
--

DROP TABLE IF EXISTS `userauth_patientdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userauth_patientdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullName` varchar(50) NOT NULL,
  `age` int(10) unsigned NOT NULL CHECK (`age` >= 0),
  `gender` varchar(10) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `address` varchar(50) NOT NULL,
  `profile_pic` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `userAuth_patientdetails_user_id_fe500d73_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userauth_patientdetails`
--

LOCK TABLES `userauth_patientdetails` WRITE;
/*!40000 ALTER TABLE `userauth_patientdetails` DISABLE KEYS */;
INSERT INTO `userauth_patientdetails` VALUES (1,'Sudip Tamang',21,'M',9843103378,'jorpati','profilepic/8d1e657ccb53496ba48c5460f594d9d6_DOWFZ8y.jpg',2),(4,'aaron shrestha',6,'M',9841112121,'basundhara','profilepic/profile-pic.jpg',28);
/*!40000 ALTER TABLE `userauth_patientdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userauth_staffdetails`
--

DROP TABLE IF EXISTS `userauth_staffdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userauth_staffdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullName` varchar(50) NOT NULL,
  `age` int(10) unsigned NOT NULL CHECK (`age` >= 0),
  `gender` varchar(10) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `address` varchar(50) NOT NULL,
  `department` varchar(50) NOT NULL,
  `profile_pic` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `userAuth_staffdetails_user_id_d53226d3_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userauth_staffdetails`
--

LOCK TABLES `userauth_staffdetails` WRITE;
/*!40000 ALTER TABLE `userauth_staffdetails` DISABLE KEYS */;
INSERT INTO `userauth_staffdetails` VALUES (1,'Juni Tamang',30,'F',9841749586,'dashindhoka','cashier','staffprofilepic/image2.jpeg',7);
/*!40000 ALTER TABLE `userauth_staffdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userauth_testreport`
--

DROP TABLE IF EXISTS `userauth_testreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userauth_testreport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `testName` varchar(100) NOT NULL,
  `testDate` datetime(6) NOT NULL,
  `testPic` varchar(100) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userAuth_testreport_patient_id_29410503_fk_userAuth_` (`patient_id`),
  CONSTRAINT `userAuth_testreport_patient_id_29410503_fk_userAuth_` FOREIGN KEY (`patient_id`) REFERENCES `userauth_patientdetails` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userauth_testreport`
--

LOCK TABLES `userauth_testreport` WRITE;
/*!40000 ALTER TABLE `userauth_testreport` DISABLE KEYS */;
INSERT INTO `userauth_testreport` VALUES (6,'blood test','2022-04-09 08:30:38.545491','testReport/Test_Report_3_rKhm8F4.png',1),(7,'gulcose test','2022-04-09 08:32:57.555455','testReport/download_1_awKycnn.png',1),(13,'blood test','2022-04-09 08:47:14.225335','testReport/download_1_EjTPkKq.png',4),(14,'test','2022-04-09 09:02:18.377612','testReport/5493d4314d2e469569b98dcc2099afeb.jpg',1);
/*!40000 ALTER TABLE `userauth_testreport` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-09 15:39:58
