-- MySQL dump 10.13  Distrib 5.7.20, for Win64 (x86_64)
--
-- Host: localhost    Database: webshop_assigment_bo
-- ------------------------------------------------------
-- Server version	5.7.20-log

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
-- Current Database: `webshop_assigment_bo`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `webshop_assigment_bo` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `webshop_assigment_bo`;

--
-- Table structure for table `categorys`
--

DROP TABLE IF EXISTS `categorys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorys`
--

LOCK TABLES `categorys` WRITE;
/*!40000 ALTER TABLE `categorys` DISABLE KEYS */;
INSERT INTO `categorys` VALUES (1,'beer'),(2,'wine'),(3,'juice');
/*!40000 ALTER TABLE `categorys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufactors`
--

DROP TABLE IF EXISTS `manufactors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manufactors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufactors`
--

LOCK TABLES `manufactors` WRITE;
/*!40000 ALTER TABLE `manufactors` DISABLE KEYS */;
INSERT INTO `manufactors` VALUES (1,'Czech beer','We make beer'),(2,'French Wine','We make wine'),(3,'Fruit juice','We make fruit juices');
/*!40000 ALTER TABLE `manufactors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `amount` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `orders_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  KEY `orders_id` (`orders_id`),
  CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `orderdetails_ibfk_3` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (1,1,1,2,'2018-06-01 20:16:40',1),(2,1,2,2,'2018-06-01 20:16:40',1),(3,1,4,3,'2018-06-01 20:16:40',1),(4,1,7,2,'2018-06-01 20:16:40',1),(5,1,11,2,'2018-06-01 20:16:40',1),(6,1,5,1,'2018-06-01 20:16:53',2),(7,1,11,1,'2018-06-01 20:16:53',2),(8,1,1,2,'2018-06-01 20:17:03',3),(9,1,2,1,'2018-06-01 20:17:03',3),(10,1,3,1,'2018-06-01 20:17:03',3),(11,1,4,1,'2018-06-01 20:17:03',3),(12,1,8,4,'2018-06-01 20:17:03',3),(13,2,4,1,'2018-06-01 20:17:21',4),(14,2,5,3,'2018-06-01 20:17:21',4),(15,2,6,3,'2018-06-01 20:17:21',4),(16,2,9,1,'2018-06-01 20:17:21',4),(17,2,10,1,'2018-06-01 20:17:21',4),(18,2,11,1,'2018-06-01 20:17:21',4),(19,2,1,2,'2018-06-01 20:17:30',5),(20,2,7,2,'2018-06-01 20:17:30',5),(21,2,8,4,'2018-06-01 20:17:30',5),(22,3,3,9,'2018-06-01 20:17:52',6),(23,3,8,3,'2018-06-01 20:17:53',6),(24,3,11,2,'2018-06-01 20:17:53',6),(25,3,12,5,'2018-06-01 20:17:53',6),(26,3,2,1,'2018-06-01 20:18:05',7),(27,3,3,1,'2018-06-01 20:18:05',7),(28,3,4,2,'2018-06-01 20:18:05',7),(29,3,7,3,'2018-06-01 20:18:05',7),(30,3,8,2,'2018-06-01 20:18:05',7),(31,3,9,2,'2018-06-01 20:18:05',7);
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2018-06-01 20:16:40'),(2,1,'2018-06-01 20:16:53'),(3,1,'2018-06-01 20:17:03'),(4,2,'2018-06-01 20:17:21'),(5,2,'2018-06-01 20:17:30'),(6,3,'2018-06-01 20:17:52'),(7,3,'2018-06-01 20:18:05');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `manufactor_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `stock_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `manufactor_id` (`manufactor_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`manufactor_id`) REFERENCES `manufactors` (`id`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categorys` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Juice Box','8725b5bc-0c41-483d-a2bc-be929b0dfac2_07.jpg',3,3,144),(2,'Orange Jug','e10c5c14-d953-4462-a947-b5aebb028304_08.jpeg',3,3,196),(3,'Orange Fresh','45bd27ad-7cd0-4c3f-b5d1-b171b18156d9_09.jpg',3,3,309),(4,'Apple Drops','b7ee160a-cf01-4cb2-b2bc-b10238a1600a_11.jpg',3,3,163),(5,'Crystal Wine','7e316e88-d160-42fb-ad86-d4c2281d9d94_01.jpg',2,2,101),(6,'Red Ruby Wine','c42b2524-2bb8-409b-89aa-7f1986d21d17_03.jpg',2,2,137),(7,'A la Wine','524adc40-b535-4324-b9f4-23d53e5764d6_05.jpg',2,2,168),(8,'A la Wine','5ca5ef30-19a6-44df-b7d0-292d1ea452fb_06.jpg',2,2,192),(9,'Green Palace Beer','d6e78956-7d83-486c-9eb4-11df9ee56fd0_13.jpeg',1,1,102),(10,'Aztec Fresh','4a8b1db8-a62a-48c8-ab90-b844a496c3c9_14.jpeg',1,1,129),(11,'Jungle Fresh','5b60828d-849e-4ff3-90e7-e4c893cfebbc_20.jpeg',1,1,199),(12,'Beer Fresh','c23461e9-3775-4de0-aad3-b2cea985233d_18.jpg',1,1,117);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) DEFAULT NULL,
  `last_surname` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `password` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'root','root','root','2018-06-01 20:06:52','root',1),(2,'Ana','Anic','ana','2018-06-01 20:08:10','123',3),(3,'Pera','Peric','pera','2018-06-01 20:08:22','123',3);
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

-- Dump completed on 2018-06-01 22:19:11
