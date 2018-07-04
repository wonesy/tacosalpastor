-- MySQL dump 10.13  Distrib 5.7.21, for osx10.13 (x86_64)
--
-- Host: localhost    Database: alpastor
-- ------------------------------------------------------
-- Server version	5.7.21

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
-- Table structure for table `accounts_resettoken`
--

DROP TABLE IF EXISTS `accounts_resettoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_resettoken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(128) NOT NULL,
  `expiration` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `accounts_resettoken_user_id_c75fe424_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_resettoken`
--

LOCK TABLES `accounts_resettoken` WRITE;
/*!40000 ALTER TABLE `accounts_resettoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_resettoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user`
--

DROP TABLE IF EXISTS `accounts_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(254) NOT NULL,
  `title` int(11) NOT NULL,
  `first_name` varchar(127) NOT NULL,
  `last_name` varchar(127) NOT NULL,
  `external_email` varchar(254) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_registered` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=271 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user`
--

LOCK TABLES `accounts_user` WRITE;
/*!40000 ALTER TABLE `accounts_user` DISABLE KEYS */;
INSERT INTO `accounts_user` VALUES (1,'pbkdf2_sha256$100000$z9SMFAMnE5rc$cisEIIp42jeCGnR2IQgK6NO5BAYf1qqmMzJEHtMUhUs=',NULL,0,'john.professor@epita.fr',0,'John','Professor','','2018-06-09 12:45:37.887000',1,1,1),(2,'pbkdf2_sha256$100000$a1HyxVXL4hzE$KRGmFe1OzqtaWsS77+dphyZFyorwF3fG8550OSBQGuQ=',NULL,0,'me_student0@epita.fr',0,'Willy0','Williamson','','2018-06-09 12:51:02.964000',1,0,1),(3,'pbkdf2_sha256$100000$LIOf01sZZGQA$fW57qeA/vukvlIFw+/25zeNoVFRrshsPyJGnuGYlqE0=',NULL,0,'me_student1@epita.fr',0,'Willy1','Williamson','','2018-06-09 12:51:03.032000',1,0,1),(4,'pbkdf2_sha256$100000$Cpn4AzAcGFGb$TAwWI0HEG776VqNbgGm39CLQqoTlls7hs2G8gwwZiKA=',NULL,0,'me_student2@epita.fr',0,'Willy2','Williamson','','2018-06-09 12:51:03.106000',1,0,1),(5,'pbkdf2_sha256$100000$z8CV1UaPWQu4$29yVGplHfvjNDlr79XnEj/WegVfkeVJtsaLLzHWdCJs=',NULL,0,'me_student3@epita.fr',0,'Willy3','Williamson','','2018-06-09 12:51:03.182000',1,0,1),(6,'pbkdf2_sha256$100000$boVkGZJHdhoO$PJndp+7kTl8dBZN8/P6qdE/HDgGSQUe00+oaUNqp/PA=',NULL,0,'me_student4@epita.fr',0,'Willy4','Williamson','','2018-06-09 12:51:03.247000',1,0,1),(7,'pbkdf2_sha256$100000$UUvfUZnzoTqo$c/F5OlIkobB4gauJ51F0ykiLsut6jBwkHaTmaHzQhA4=',NULL,0,'me_student5@epita.fr',0,'Willy5','Williamson','','2018-06-09 12:51:03.326000',1,0,1),(8,'pbkdf2_sha256$100000$qY8r0pidtEIi$hKs0hqqgYfxuTnRUB78AeeiFc0HGUnBzadkwt2Ljt20=',NULL,0,'me_student6@epita.fr',0,'Willy6','Williamson','','2018-06-09 12:51:03.389000',1,0,1),(9,'pbkdf2_sha256$100000$v7GzpzC0k4W5$UwCxLVdP6HNDiBqRZF7tzJYd19MhZWtTPhVHWF9Q3vM=',NULL,0,'me_student7@epita.fr',0,'Willy7','Williamson','','2018-06-09 12:51:03.454000',1,0,1),(10,'pbkdf2_sha256$100000$Wh5npMJDqpqB$7WZnVnLbH0wwtUlDiDLkmL5kvWV7I7kf7VdRCT5IxII=',NULL,0,'me_student8@epita.fr',0,'Willy8','Williamson','','2018-06-09 12:51:03.516000',1,0,1),(11,'pbkdf2_sha256$100000$FICdRIzv5STm$w8LHvNs7F4H5ju6kHJnN5rz7GbFDbL6Iv5L1XxgiRM8=',NULL,0,'me_student9@epita.fr',0,'Willy9','Williamson','','2018-06-09 12:51:03.595000',1,0,1),(12,'pbkdf2_sha256$100000$gV49rFjqMn4R$rYOjH+uzU4PHjVYRZs0Gx0NSUVquIdvaBd8hW/SYdnM=',NULL,0,'me_student10@epita.fr',0,'Willy10','Williamson','','2018-06-09 12:51:03.660000',1,0,1),(13,'pbkdf2_sha256$100000$gbljX2GoBXiD$lEkChipGoQQ/x1+mo0Oe6MJ3ZOfMfQaLUtEzf0uSjc0=',NULL,0,'me_student11@epita.fr',0,'Willy11','Williamson','','2018-06-09 12:51:03.724000',1,0,1),(14,'pbkdf2_sha256$100000$TJyS6wKVYaMx$X6S7HFw9WoOXIvkgTacReSdSmLX0AtBDvfu0ndY1Uws=',NULL,0,'me_student12@epita.fr',0,'Willy12','Williamson','','2018-06-09 12:51:03.788000',1,0,1),(15,'pbkdf2_sha256$100000$jcSqsCntIPn0$oAoPtsqcL4VIZev18l84AZSYvCiKm1v1MvrDWJ5XIDk=',NULL,0,'me_student13@epita.fr',0,'Willy13','Williamson','','2018-06-09 12:51:03.852000',1,0,1),(16,'pbkdf2_sha256$100000$n6e1Ff7hQ877$D/sm1WnqdygmCvy/Nd03mv8A6rUS6LbOnpnM6Q57hV0=',NULL,0,'me_student14@epita.fr',0,'Willy14','Williamson','','2018-06-09 12:51:03.916000',1,0,1),(17,'pbkdf2_sha256$100000$Jx4fifUxzReC$t2htq0yn2y4Y3WNJRoj5CjUFdccJfIE2DluzWA3mqlg=',NULL,0,'me_student15@epita.fr',0,'Willy15','Williamson','','2018-06-09 12:51:03.980000',1,0,1),(18,'pbkdf2_sha256$100000$cegoQDTDyTLF$G8NymmK0z2sSI5cUmLORnARc3Wj0IC0i2iOLyE7XJQg=',NULL,0,'me_student16@epita.fr',0,'Willy16','Williamson','','2018-06-09 12:51:04.044000',1,0,1),(19,'pbkdf2_sha256$100000$4UbmXAdWYABg$QRTR+UeRYord1/bSnDt1rFt396eF0xXVmTZD49oKS6s=',NULL,0,'me_student17@epita.fr',0,'Willy17','Williamson','','2018-06-09 12:51:04.110000',1,0,1),(20,'pbkdf2_sha256$100000$rkVEgL8GilgK$yPFciIW1n8AVbwsxScbwu7XWQAGzzpfrqIft5NH3jDg=',NULL,0,'me_student18@epita.fr',0,'Willy18','Williamson','','2018-06-09 12:51:04.174000',1,0,1),(21,'pbkdf2_sha256$100000$N6PrZAzm8eZy$K0KhJQo7Zg5L23iA0qZd2NXIecllNG3FJzA6NT/b9sg=',NULL,0,'me_student19@epita.fr',0,'Willy19','Williamson','','2018-06-09 12:51:04.236000',1,0,1),(22,'pbkdf2_sha256$100000$x5Ls7hA7UJDa$fU034Sn+5wNLBLfbSwVX9A0y/jNEKSlda+LtdhK9tTI=',NULL,0,'me_student20@epita.fr',0,'Willy20','Williamson','','2018-06-09 12:51:04.299000',1,0,1),(23,'pbkdf2_sha256$100000$ILQDfgb9Nwsx$QPda633MouQxJAPro2f+mlmVcGzA36BGr+443P5zcNs=',NULL,0,'me_student21@epita.fr',0,'Willy21','Williamson','','2018-06-09 12:51:04.364000',1,0,1),(24,'pbkdf2_sha256$100000$PGmAY94zgKGD$SFBNuyBhnqTWDYzIZqd4cp/0ohC9EtWSYu6WNekljGQ=',NULL,0,'me_student22@epita.fr',0,'Willy22','Williamson','','2018-06-09 12:51:04.428000',1,0,1),(25,'pbkdf2_sha256$100000$wwzbcSUB9z9F$J7HmKs464XWOtthTqJ8Oki1bN4c0XtQ2fAtkKSHUMuY=',NULL,0,'me_student23@epita.fr',0,'Willy23','Williamson','','2018-06-09 12:51:04.492000',1,0,1),(26,'pbkdf2_sha256$100000$GUEaSKgA5YyT$ZWDoZxfsdvF6NhmJFttGNQTX5Bhew47nepaL4gdVyjw=',NULL,0,'me_student24@epita.fr',0,'Willy24','Williamson','','2018-06-09 12:51:04.578000',1,0,1),(27,'pbkdf2_sha256$100000$bnzmdkhrynY4$ZdfRCbgHdgtEyIVKem6f+88HvYXwPUYIwydSE7PXVVU=',NULL,0,'me_student25@epita.fr',0,'Willy25','Williamson','','2018-06-09 12:51:04.640000',1,0,1),(28,'pbkdf2_sha256$100000$k4m2QtT3NToJ$CtW1u+hIOGCHGm5/sPAFQileB4Vur1MgekCdK18EkTg=',NULL,0,'me_student26@epita.fr',0,'Willy26','Williamson','','2018-06-09 12:51:04.704000',1,0,1),(29,'pbkdf2_sha256$100000$LYwJTdhTmgjx$oFMbjRQHGMljje+D+sgMRW9DtutU+yfWbm4zNlSwsHA=',NULL,0,'me_student27@epita.fr',0,'Willy27','Williamson','','2018-06-09 12:51:04.813000',1,0,1),(30,'pbkdf2_sha256$100000$c2dBPpHcTv9Q$co/nItPF7ErFQebf5SKrcXdOLk8gMclH6Xqwz2Tje+g=',NULL,0,'me_student28@epita.fr',0,'Willy28','Williamson','','2018-06-09 12:51:04.877000',1,0,1),(31,'pbkdf2_sha256$100000$pCojsPzCqgs2$gML79tYOfOboPPq/eG0tX3aAso2WtvOu2Tqp1laVawc=',NULL,0,'me_student29@epita.fr',0,'Willy29','Williamson','','2018-06-09 12:51:04.941000',1,0,1),(32,'pbkdf2_sha256$100000$XJrWtD9WNLru$x9T5wmtCjEtrXSjI8xjeDcHl0ueAtz67zKdMeoWBbN8=',NULL,0,'me_student30@epita.fr',0,'Willy30','Williamson','','2018-06-09 12:51:05.015000',1,0,1),(33,'pbkdf2_sha256$100000$DLQoK9evXbNI$HEmVofTloC1we6T+cEwvtqkm9BEaoNeeqQA70Weda1k=',NULL,0,'me_student31@epita.fr',0,'Willy31','Williamson','','2018-06-09 12:51:05.080000',1,0,1),(34,'pbkdf2_sha256$100000$epdw4sc4RMf3$sD3kGEcvZVh7Lrmzmw+MXyJ3ztKOMVCd00yFxAk6Rrc=',NULL,0,'me_student32@epita.fr',0,'Willy32','Williamson','','2018-06-09 12:51:05.144000',1,0,1),(35,'pbkdf2_sha256$100000$DzLNFPL5EEwo$xAvxlOeUD8T17MAJEnbmvP3GLk17kO8eKj1E2lNWWjk=',NULL,0,'me_student33@epita.fr',0,'Willy33','Williamson','','2018-06-09 12:51:05.209000',1,0,1),(36,'pbkdf2_sha256$100000$ogYNRA57llw4$z0smc+9AL24E/2Od/3YBi6EbRvJVVCmuBO3niRYqdYs=',NULL,0,'me_student34@epita.fr',0,'Willy34','Williamson','','2018-06-09 12:51:05.273000',1,0,1),(37,'pbkdf2_sha256$100000$KdxHfjV8SEle$u0dvpV7N+dKtfjAgU5lLuDHO06DIJHx35so5aa/EeF0=',NULL,0,'me_student35@epita.fr',0,'Willy35','Williamson','','2018-06-09 12:51:05.337000',1,0,1),(38,'pbkdf2_sha256$100000$mFaeNyVJeVFX$Y6Dp6GXM41eM2LpYKkx6wMxKf6KBgya7TYf6aEuJpsM=',NULL,0,'me_student36@epita.fr',0,'Willy36','Williamson','','2018-06-09 12:51:05.401000',1,0,1),(39,'pbkdf2_sha256$100000$IffJZZC2J300$vV5JcQ4T6f9KAGIJk/T5fmty0Lcm71P5Fel7SE1Jm10=',NULL,0,'me_student37@epita.fr',0,'Willy37','Williamson','','2018-06-09 12:51:05.465000',1,0,1),(40,'pbkdf2_sha256$100000$z77jwOxVvJ1N$9aKad+iwEoyEjwod7NbnDVW9pgKLVqmt/beF6pVKDTg=',NULL,0,'me_student38@epita.fr',0,'Willy38','Williamson','','2018-06-09 12:51:05.538000',1,0,1),(41,'pbkdf2_sha256$100000$C1Xtms8Q9tkR$zaECKR3z0nJfQu5nPJ0OB39ZX3L4ufFd2+b7YjNyUEE=',NULL,0,'me_student39@epita.fr',0,'Willy39','Williamson','','2018-06-09 12:51:05.600000',1,0,1),(42,'pbkdf2_sha256$100000$lZZbqSWtZtZR$rQ9/59+Zp+ua5kjBcL7FK3fZvb1UyIZN3FH5Kh2UrRs=',NULL,0,'me_student40@epita.fr',0,'Willy40','Williamson','','2018-06-09 12:51:05.665000',1,0,1),(43,'pbkdf2_sha256$100000$aMjq18h3U2pB$9cnZ2FK2jknKIe3FgOMlXEkF3HszKudXkHyAJzS+LHo=',NULL,0,'me_student41@epita.fr',0,'Willy41','Williamson','','2018-06-09 12:51:05.730000',1,0,1),(44,'pbkdf2_sha256$100000$DY9TBYNDBbO4$4qN+DxuoflYjdUn4ZHnZ8Zsf5R60aZVHxZUdewkDAc4=',NULL,0,'me_student42@epita.fr',0,'Willy42','Williamson','','2018-06-09 12:51:05.826000',1,0,1),(45,'pbkdf2_sha256$100000$vtiWL3WZJuqP$T/eEXJVnEJTvefGr/+MsqAoaJ1a5wtPEsvuXCtpUa34=',NULL,0,'me_student43@epita.fr',0,'Willy43','Williamson','','2018-06-09 12:51:05.915000',1,0,1),(46,'pbkdf2_sha256$100000$96Fi8IH4W5T0$0MiA/eMX2XDWFdfez95wNXR+tN9fm4EcS9oB+WkQwCQ=',NULL,0,'me_student44@epita.fr',0,'Willy44','Williamson','','2018-06-09 12:51:06.017000',1,0,1),(47,'pbkdf2_sha256$100000$J4WSEQT8YaQz$/Keo1erALNjog3+soryjQ75t8bSb/slHviFQ2hqjEaM=',NULL,0,'me_student45@epita.fr',0,'Willy45','Williamson','','2018-06-09 12:51:06.081000',1,0,1),(48,'pbkdf2_sha256$100000$GqzGnKfM5t5a$/aTaUAf60FgxdPKAyLBLACygSXc5fY8PcY2HPSNTyCY=',NULL,0,'me_student46@epita.fr',0,'Willy46','Williamson','','2018-06-09 12:51:06.173000',1,0,1),(49,'pbkdf2_sha256$100000$K2WV0T43s32M$Pmk0lwyMTfCghmw0x538GcpDm7rztaM6W+ED4eDqEak=',NULL,0,'me_student47@epita.fr',0,'Willy47','Williamson','','2018-06-09 12:51:06.236000',1,0,1),(50,'pbkdf2_sha256$100000$aGt1jCzqBPF2$HZI/eFNrdn5hcDJw080NByUP0907xubsH83roDbaExc=',NULL,0,'me_student48@epita.fr',0,'Willy48','Williamson','','2018-06-09 12:51:06.302000',1,0,1),(51,'pbkdf2_sha256$100000$dmtl9smmO0qk$uAY1Xk/c53Pw19H6l7BWzD5V64R5J4U1U1p5J5YPcNs=',NULL,0,'me_student49@epita.fr',0,'Willy49','Williamson','','2018-06-09 12:51:06.363000',1,0,1),(52,'pbkdf2_sha256$100000$qOLnJoKG8Blg$tELUBxLrULtpnAZxOTd1eOJOqjGQ0wRzH2dwvDGuHIU=',NULL,0,'me_student50@epita.fr',0,'Willy50','Williamson','','2018-06-09 12:51:06.427000',1,0,1),(53,'pbkdf2_sha256$100000$tVL2mUp4YDT0$hlhluZiEeVN8sWYhJASN3mHgc8YMbdRub6Xun8tZnn0=',NULL,0,'me_student51@epita.fr',0,'Willy51','Williamson','','2018-06-09 12:51:06.491000',1,0,1),(54,'pbkdf2_sha256$100000$kfpHwfKTXEQ5$nHkECFhISj1gneQ3FCGc4+k7XjvVNqZOXLqasyg5+Bc=',NULL,0,'me_student52@epita.fr',0,'Willy52','Williamson','','2018-06-09 12:51:06.555000',1,0,1),(55,'pbkdf2_sha256$100000$yUSoEu9EIPcL$c/BEa5sR4zZGW//WUJXiBxRDLHktoD7C7W9lMPpRJUM=',NULL,0,'me_student53@epita.fr',0,'Willy53','Williamson','','2018-06-09 12:51:06.619000',1,0,1),(56,'pbkdf2_sha256$100000$s2X8cZ6wktg1$MI+Rsjms53CpeKtEc6UCp9KqNqBfOCRZA75oJmVM2G8=',NULL,0,'me_student54@epita.fr',0,'Willy54','Williamson','','2018-06-09 12:51:06.684000',1,0,1),(57,'pbkdf2_sha256$100000$WIvZrGB2LXhb$ZLEIXoxSZJsxyE/Idlt6OQTEt0Kqu043DoQ3uTPhNmk=',NULL,0,'me_student55@epita.fr',0,'Willy55','Williamson','','2018-06-09 12:51:06.748000',1,0,1),(58,'pbkdf2_sha256$100000$LCVrFv5Bl3EM$UJPyvgybO4DE/9ssSddQbjy/Ds9h5iZE5aJ6bEsx2W0=',NULL,0,'me_student56@epita.fr',0,'Willy56','Williamson','','2018-06-09 12:51:06.812000',1,0,1),(59,'pbkdf2_sha256$100000$6rra0pP1MLUa$i6MyORFn9ytDCesTBtIM1tOrZcu5hlemlhDUzAFHD6w=',NULL,0,'me_student57@epita.fr',0,'Willy57','Williamson','','2018-06-09 12:51:06.876000',1,0,1),(60,'pbkdf2_sha256$100000$18UIrlF5Kbhq$9+gpXtr0tgNdroUxySTh2KJsI90IFHXR1sSOUMrP2ac=',NULL,0,'me_student58@epita.fr',0,'Willy58','Williamson','','2018-06-09 12:51:06.940000',1,0,1),(61,'pbkdf2_sha256$100000$SIe5q4YjX6Gv$1UIzlcj3fc9EKw+n0XCZUjDo4enuZgUQPbM4uRO7Lzg=',NULL,0,'me_student59@epita.fr',0,'Willy59','Williamson','','2018-06-09 12:51:07.004000',1,0,1),(62,'pbkdf2_sha256$100000$mewNY1baEDj5$g6gdUscGsdt14Ytqu0RvlJJiqhwwj8g8Pys3Ot6lNFk=',NULL,0,'me_student60@epita.fr',0,'Willy60','Williamson','','2018-06-09 12:51:07.072000',1,0,1),(63,'pbkdf2_sha256$100000$CLkYFvp0c2V6$dltkVcobql/aW3AHjHME2AItt0YdbSGkCA+cSJbljtk=',NULL,0,'me_student61@epita.fr',0,'Willy61','Williamson','','2018-06-09 12:51:07.136000',1,0,1),(64,'pbkdf2_sha256$100000$JgCbk3TvXLRB$8i5hm1qczF3y+yUH84klDwHEintTzWyhK38ivHDo67k=',NULL,0,'me_student62@epita.fr',0,'Willy62','Williamson','','2018-06-09 12:51:07.203000',1,0,1),(65,'pbkdf2_sha256$100000$36tqkfj7LwUx$jGlco+1uOr2ELLFKbmfECVbOiYxXqiU2CzEPYg9xVbc=',NULL,0,'me_student63@epita.fr',0,'Willy63','Williamson','','2018-06-09 12:51:07.292000',1,0,1),(66,'pbkdf2_sha256$100000$zLeFJ3dl0Wbf$D8i+FOTp549IYvjfSPYlBmGSmlkL4ru34hdxCTvImcU=',NULL,0,'me_student64@epita.fr',0,'Willy64','Williamson','','2018-06-09 12:51:07.356000',1,0,1),(67,'pbkdf2_sha256$100000$9oApt0xlJMMN$92XVJFHGsB2HFvA2L13sdNnQlKg88LEeLbiK0H2MMcE=',NULL,0,'me_student65@epita.fr',0,'Willy65','Williamson','','2018-06-09 12:51:07.427000',1,0,1),(68,'pbkdf2_sha256$100000$SutI9tZsqK5K$F+jVxZJif/DXHN9w7nIY2ompb8MILmjNgxmaLOn8BwE=',NULL,0,'me_student66@epita.fr',0,'Willy66','Williamson','','2018-06-09 12:51:07.492000',1,0,1),(69,'pbkdf2_sha256$100000$wyTIfTnfMlyX$HqMlm+bETn7etK0srl7upFuI5dJlivSTaQQ6+SuaP/k=',NULL,0,'me_student67@epita.fr',0,'Willy67','Williamson','','2018-06-09 12:51:07.557000',1,0,1),(70,'pbkdf2_sha256$100000$WhNdoScKntle$RoBt0twNpgX2CheGUEI8t5baJjULyRBDvHFfhxIZJy0=',NULL,0,'me_student68@epita.fr',0,'Willy68','Williamson','','2018-06-09 12:51:07.621000',1,0,1),(71,'pbkdf2_sha256$100000$NQOx6uAFlCgC$RGSQMLJwQqO/g8VWEGggPlshiPBjKzRPgFIhSDehdAE=',NULL,0,'me_student69@epita.fr',0,'Willy69','Williamson','','2018-06-09 12:51:07.707000',1,0,1),(72,'pbkdf2_sha256$100000$QPZoVT8ywB1S$50Ygch8Sg7JfJ4ZI1ERysZIvg7OsrcvdBySDw7S+QUE=',NULL,0,'me_student70@epita.fr',0,'Willy70','Williamson','','2018-06-09 12:51:07.789000',1,0,1),(73,'pbkdf2_sha256$100000$VnmBOP6ReGll$PXdNR1nPcShwKvp1TgYSjiSRvXnuyd+5YTmvS0GURO8=',NULL,0,'me_student71@epita.fr',0,'Willy71','Williamson','','2018-06-09 12:51:07.852000',1,0,1),(74,'pbkdf2_sha256$100000$AKp34uC3wSfa$tQr/S5RIxy3xeH6qNocw2dSipLfeafB1rGc/s1qv+/M=',NULL,0,'me_student72@epita.fr',0,'Willy72','Williamson','','2018-06-09 12:51:07.947000',1,0,1),(75,'pbkdf2_sha256$100000$DbXMKzdZ6qzE$70X76NO2nRxMC1r6WcDZIu5sGR0roQctagARstS26ng=',NULL,0,'me_student73@epita.fr',0,'Willy73','Williamson','','2018-06-09 12:51:08.011000',1,0,1),(76,'pbkdf2_sha256$100000$llpMqDcDaBC9$fRy73t+jH1N1XmLailtndsvf8am9GR1WnPmLdUwh2Yo=',NULL,0,'me_student74@epita.fr',0,'Willy74','Williamson','','2018-06-09 12:51:08.105000',1,0,1),(77,'pbkdf2_sha256$100000$14LKX6B9VDsZ$/QXpAyEM7xZVIKwvOM32WvLLq06nPacWdcrLE8/DsgU=',NULL,0,'me_student75@epita.fr',0,'Willy75','Williamson','','2018-06-09 12:51:08.170000',1,0,1),(78,'pbkdf2_sha256$100000$kflCFHsrOXY9$VCmuBF6yzSA1xpUJrlO3VQBHLoKMmgnsqsWUjngkaHo=',NULL,0,'me_student76@epita.fr',0,'Willy76','Williamson','','2018-06-09 12:51:08.232000',1,0,1),(79,'pbkdf2_sha256$100000$v73lqkapvtU6$uOLrkMGeVYnxIc2DTTCM/3aLFuTLs3Ivp9o6uIPvFuw=',NULL,0,'me_student77@epita.fr',0,'Willy77','Williamson','','2018-06-09 12:51:08.322000',1,0,1),(80,'pbkdf2_sha256$100000$86QEcUnu96x0$0ZSDuegbJeUwEZUtcFoNhpRjWg9mG8Vc/eV4UJG/+D4=',NULL,0,'me_student78@epita.fr',0,'Willy78','Williamson','','2018-06-09 12:51:08.400000',1,0,1),(81,'pbkdf2_sha256$100000$uQUZUmcFbvlG$csSlBGK2jOsD0nR7+Ok2+qPDYlkAuS138SLOn30pnY0=',NULL,0,'me_student79@epita.fr',0,'Willy79','Williamson','','2018-06-09 12:51:08.464000',1,0,1),(82,'pbkdf2_sha256$100000$kAF7eA6vOSTA$kjwdnlGXh+yEM7C/SrtRTpX4/A+PPgl04qP7q0dvyeQ=',NULL,0,'me_student80@epita.fr',0,'Willy80','Williamson','','2018-06-09 12:51:08.532000',1,0,1),(83,'pbkdf2_sha256$100000$Um6YZhdSTMxt$ffn15Gn8S1p7vk/IS+Eh7P2OAXvWAayrV6UDN5+YxDM=',NULL,0,'me_student81@epita.fr',0,'Willy81','Williamson','','2018-06-09 12:51:08.595000',1,0,1),(84,'pbkdf2_sha256$100000$J31P8DzZPtCk$xl2Cj17Jttd0YmTL7sOan5SwGDwG/fUICaCu9fhlR9o=',NULL,0,'me_student82@epita.fr',0,'Willy82','Williamson','','2018-06-09 12:51:08.659000',1,0,1),(85,'pbkdf2_sha256$100000$MdVG5BS9TCKa$jrXlulJpqNO5H9sHHcTlywNh+bz5t4Flu4PabjhLLQw=',NULL,0,'me_student83@epita.fr',0,'Willy83','Williamson','','2018-06-09 12:51:08.723000',1,0,1),(86,'pbkdf2_sha256$100000$ArMCDN57SKbB$fEoX5x74BPiiol/wsb2jH6uofluM8w0mzPnsL5HNVZw=',NULL,0,'me_student84@epita.fr',0,'Willy84','Williamson','','2018-06-09 12:51:08.787000',1,0,1),(87,'pbkdf2_sha256$100000$yI1vXpP0EZFj$AUZnOIjBQif1p0PyoKE9uvm5ftDAl4yaO0Xd88EJjMQ=',NULL,0,'me_student85@epita.fr',0,'Willy85','Williamson','','2018-06-09 12:51:08.848000',1,0,1),(88,'pbkdf2_sha256$100000$GVnbjHdhTCNr$KiNJ9FhGItZ4+9IGwHLGoHKUbiKq+D0JlrPNXx6iqL4=',NULL,0,'me_student86@epita.fr',0,'Willy86','Williamson','','2018-06-09 12:51:08.913000',1,0,1),(89,'pbkdf2_sha256$100000$V52GTSq0b5rK$I/Zro4APOKj2if09pnGTNIlyZuq83OjSmqfyikF2nag=',NULL,0,'me_student87@epita.fr',0,'Willy87','Williamson','','2018-06-09 12:51:08.977000',1,0,1),(90,'pbkdf2_sha256$100000$6ccx93yLLGRp$eqJpGqKVfS8EeHJ4LBlnveekal0lEAl65RM5b8K6k6c=',NULL,0,'me_student88@epita.fr',0,'Willy88','Williamson','','2018-06-09 12:51:09.041000',1,0,1),(91,'pbkdf2_sha256$100000$vIUbyIIkrIl2$H9bkW41YKIyPoODblB1ZjGdaaru9d9Myq1waQpZ+oU4=',NULL,0,'me_student89@epita.fr',0,'Willy89','Williamson','','2018-06-09 12:51:09.105000',1,0,1),(92,'pbkdf2_sha256$100000$hmxfwuUIdbtS$Y/IJaJSTDGqLsJ66MQnacBtEWtpCh4ihmvGIIPfA64o=',NULL,0,'me_student90@epita.fr',0,'Willy90','Williamson','','2018-06-09 12:51:09.192000',1,0,1),(93,'pbkdf2_sha256$100000$eOWTNHZNXiYI$djF15PSbqjSTBHCwqF9x9bl4pqWe3vQ1wG3qaWYvhl4=',NULL,0,'me_student91@epita.fr',0,'Willy91','Williamson','','2018-06-09 12:51:09.256000',1,0,1),(94,'pbkdf2_sha256$100000$T8O27CJfAxhs$AJqtmdLyPaJEab6mAMrxiKcPierjuAoIf44hcqTqB/s=',NULL,0,'me_student92@epita.fr',0,'Willy92','Williamson','','2018-06-09 12:51:09.319000',1,0,1),(95,'pbkdf2_sha256$100000$9B2w7MutJccP$N8+PGG1UjImm0mLun86bK3LVOvYwRgqrym8MVRXqnSM=',NULL,0,'me_student93@epita.fr',0,'Willy93','Williamson','','2018-06-09 12:51:09.383000',1,0,1),(96,'pbkdf2_sha256$100000$Zra0w2dDP8xj$K+VIVj4d522w7xHMP/8K2nVNJ0ibrnBPnTTodev2HNA=',NULL,0,'me_student94@epita.fr',0,'Willy94','Williamson','','2018-06-09 12:51:09.447000',1,0,1),(97,'pbkdf2_sha256$100000$jeRyecidBlkx$ms16GvQ3Smu46lTQ3EpGbIbDy/vo1QOFCyTCdnWHPAE=',NULL,0,'me_student95@epita.fr',0,'Willy95','Williamson','','2018-06-09 12:51:09.511000',1,0,1),(98,'pbkdf2_sha256$100000$FpwydYESnxYw$yFt3Ua62KOwmo3+I5lT74zxaIVVEmILRZFLrTWkotGg=',NULL,0,'me_student96@epita.fr',0,'Willy96','Williamson','','2018-06-09 12:51:09.583000',1,0,1),(99,'pbkdf2_sha256$100000$WR52pQvyIVn1$U858L+giYiYYWFgg42JgOagrdZY4+EKGapJFdGIZXd4=',NULL,0,'me_student97@epita.fr',0,'Willy97','Williamson','','2018-06-09 12:51:09.656000',1,0,1),(100,'pbkdf2_sha256$100000$tcwzdSRvnzXz$MobA8bmphT5TBX7q9JVYg9qE5UUoSKSeexYQXOK7Lu8=',NULL,0,'me_student98@epita.fr',0,'Willy98','Williamson','','2018-06-09 12:51:09.720000',1,0,1),(101,'pbkdf2_sha256$100000$XjpTxR8iZrNe$87WjDwWf9WoYBBJ9JFTY3lVExM0OPdLJmhagPuxITH8=',NULL,0,'me_student99@epita.fr',0,'Willy99','Williamson','','2018-06-09 12:51:09.800000',1,0,1),(102,'pbkdf2_sha256$100000$fH96qGbRYZuk$SoQWA6c81jYZFejstPbWbN9lU/54I6ZYrUPDrm7yETI=','2018-06-27 17:33:01.988000',0,'me_student100@epita.fr',0,'Willy100','Williamson','','2018-06-09 12:51:09.894000',1,0,1),(103,'pbkdf2_sha256$100000$BkrfdtGhA1SK$SCpt9iJrhqFFzc6FhHLnjV7TF/NjrSYKfZL6o3DGAEU=',NULL,0,'me_student101@epita.fr',0,'Willy101','Williamson','','2018-06-09 12:51:09.959000',1,0,1),(104,'pbkdf2_sha256$100000$8frTmrewjeKu$MFr60rI4rDqKbXpILf8QF3BvD2WfCmPGIY2dJXKLL+8=',NULL,0,'me_student102@epita.fr',0,'Willy102','Williamson','','2018-06-09 12:51:10.024000',1,0,1),(105,'pbkdf2_sha256$100000$cNB77pcKr3Ci$ULv8ZDCHuCXw9WXa9QOzxmRYqJ0xLmFNmpkHYVKcT7I=',NULL,0,'me_student103@epita.fr',0,'Willy103','Williamson','','2018-06-09 12:51:10.091000',1,0,1),(106,'pbkdf2_sha256$100000$ddPtC3bYg4jy$pa20j/2z6hROAxeQJAvRRP1i9C4p+O3Oc1g/p1wX0eM=',NULL,0,'me_student104@epita.fr',0,'Willy104','Williamson','','2018-06-09 12:51:10.186000',1,0,1),(107,'pbkdf2_sha256$100000$2awf1iGikDj2$XHJnTHufevJCHlMLCl1GrYAG6wabTP/6ke30nvVd9Ak=',NULL,0,'me_student105@epita.fr',0,'Willy105','Williamson','','2018-06-09 12:51:10.248000',1,0,1),(108,'pbkdf2_sha256$100000$CJShD6HsWFzW$HWW0jOAxIE+jZhSYOBJCLLt1r+0h39wYSilQYqI1zyw=',NULL,0,'me_student106@epita.fr',0,'Willy106','Williamson','','2018-06-09 12:51:10.314000',1,0,1),(109,'pbkdf2_sha256$100000$PmbGxE0lBthA$Boz3bNph6fnMEqrj/zLnPL1pMDyBrRK6d/+PBXdxVNI=',NULL,0,'me_student107@epita.fr',0,'Willy107','Williamson','','2018-06-09 12:51:10.376000',1,0,1),(110,'pbkdf2_sha256$100000$0tgnooTHp5eX$G8LF54boUxmHvZKQEy4V02crkc90N/9bJ+pUONrhaIA=',NULL,0,'me_student108@epita.fr',0,'Willy108','Williamson','','2018-06-09 12:51:10.446000',1,0,1),(111,'pbkdf2_sha256$100000$b5oeviBlLil5$6SVXcGEih9dJKjOdrKeRyyAmwy+wWYSr3tjEKf8DKho=',NULL,0,'me_student109@epita.fr',0,'Willy109','Williamson','','2018-06-09 12:51:10.510000',1,0,1),(112,'pbkdf2_sha256$100000$0PDR3YPV9P0F$AjMNe0EiSVxz5yo/O2nh8QQrtvTHmItYfWDJey3cgvo=',NULL,0,'me_student110@epita.fr',0,'Willy110','Williamson','','2018-06-09 12:51:10.575000',1,0,1),(113,'pbkdf2_sha256$100000$2ToBo6PMhm9h$h2q9OncLjorVJdZMb1x0TMl8DAhsiahhML1tkeiN0mo=',NULL,0,'me_student111@epita.fr',0,'Willy111','Williamson','','2018-06-09 12:51:10.641000',1,0,1),(114,'pbkdf2_sha256$100000$rdGkhvdqI3ek$jkqLnigfC57WIFOj6lupMO5TItNDmWWl6TlX7EiMDRo=',NULL,0,'me_student112@epita.fr',0,'Willy112','Williamson','','2018-06-09 12:51:10.707000',1,0,1),(115,'pbkdf2_sha256$100000$JCmh0eJYXZFX$QDHKYSww9xtEu4ntgq8Ri1MxsmQIeHs8TiOXdGCyKoE=',NULL,0,'me_student113@epita.fr',0,'Willy113','Williamson','','2018-06-09 12:51:10.774000',1,0,1),(116,'pbkdf2_sha256$100000$9g8TeLELpFiz$hd/Mp8C/NOxq6+KQ9Vwfxzn6vnTqX0tqQlYp+xnnGL8=',NULL,0,'me_student114@epita.fr',0,'Willy114','Williamson','','2018-06-09 12:51:10.840000',1,0,1),(117,'pbkdf2_sha256$100000$eHV8pMPBOG4V$YpI6WUFd/g6wrtaOYpU8RFJ+XUbJTK2gcSyxkbrYcS4=',NULL,0,'me_student115@epita.fr',0,'Willy115','Williamson','','2018-06-09 12:51:10.904000',1,0,1),(118,'pbkdf2_sha256$100000$1gUgNCnBaZNe$G/f3KsDZhCD1/tdl4/u2vhDpoDNwCkqxfIJ0HzSuMzU=',NULL,0,'me_student116@epita.fr',0,'Willy116','Williamson','','2018-06-09 12:51:10.969000',1,0,1),(119,'pbkdf2_sha256$100000$BVJJhfsMfz0g$B2npVeIwO80UCK8poIK6YZrmeXJ5dzN+YSsNG97evsw=',NULL,0,'me_student117@epita.fr',0,'Willy117','Williamson','','2018-06-09 12:51:11.033000',1,0,1),(120,'pbkdf2_sha256$100000$ChoHc50zO9L5$mED39y1t9Poc9WiH1/mhtznzLHzwmLw5BHO402mTy78=',NULL,0,'me_student118@epita.fr',0,'Willy118','Williamson','','2018-06-09 12:51:11.114000',1,0,1),(121,'pbkdf2_sha256$100000$QZI1gLFdszKI$j6GCrqwl1soLgbQur+B8IC3PBL6NWNbmMUNC8+QB7Os=',NULL,0,'me_student119@epita.fr',0,'Willy119','Williamson','','2018-06-09 12:51:11.176000',1,0,1),(122,'pbkdf2_sha256$100000$ozXgpLBRQzQr$u8WbVjv6nq16fVL4bUTRXS1yd3rFU9lGCqGXus1hyJ4=',NULL,0,'me_student120@epita.fr',0,'Willy120','Williamson','','2018-06-09 12:51:11.241000',1,0,1),(123,'pbkdf2_sha256$100000$5Ew0xY9sifmL$z3UzibWsS3HreCdaNWtlp/E+EIXtkfGTElWzz9bDxqY=',NULL,0,'me_student121@epita.fr',0,'Willy121','Williamson','','2018-06-09 12:51:11.323000',1,0,1),(124,'pbkdf2_sha256$100000$owDH3Q4sGfMS$kXQBliHvcQ0KF/TIEI90Cju0jZbu8DgB1ZuowvDj8ok=',NULL,0,'me_student122@epita.fr',0,'Willy122','Williamson','','2018-06-09 12:51:11.387000',1,0,1),(125,'pbkdf2_sha256$100000$ocLDNcv55bWa$zldyGjk4GFzt87WeMcL4Hc+4WLLiKTNg+sz6BappeCs=',NULL,0,'me_student123@epita.fr',0,'Willy123','Williamson','','2018-06-09 12:51:11.481000',1,0,1),(126,'pbkdf2_sha256$100000$bX5MhuMdDLZc$r6TX9GKE26CkajskHXZjHOxc7euHZTGwphc5NOsyhk8=',NULL,0,'me_student124@epita.fr',0,'Willy124','Williamson','','2018-06-09 12:51:11.546000',1,0,1),(127,'pbkdf2_sha256$100000$o3zLO55igfhP$55Q45t6YYPlfUffvL3ldERweFHrbnpiEx/8bYOb8ZuU=',NULL,0,'me_student125@epita.fr',0,'Willy125','Williamson','','2018-06-09 12:51:11.636000',1,0,1),(128,'pbkdf2_sha256$100000$5N4pSHciWqjE$ZqG8KgxfGAsOx1IIJ7NzbyFVRKWSLnlYmzDUIciOFEM=',NULL,0,'me_student126@epita.fr',0,'Willy126','Williamson','','2018-06-09 12:51:11.700000',1,0,1),(129,'pbkdf2_sha256$100000$1d7hwMB4D67B$k8Fx1aehQYAyk7ywkasJh32vIWCNpEgLwrWfOwlv5rY=',NULL,0,'me_student127@epita.fr',0,'Willy127','Williamson','','2018-06-09 12:51:11.783000',1,0,1),(130,'pbkdf2_sha256$100000$gT3uNJ6Lonxy$6Np610buldQjSTXB/Z9SxM6h84Jnypj4H/zNqThtMSA=',NULL,0,'me_student128@epita.fr',0,'Willy128','Williamson','','2018-06-09 12:51:11.847000',1,0,1),(131,'pbkdf2_sha256$100000$eM45VRbVpjoD$X8JWHVarfJlliz5/Z0yXu7RY5c8DqfLD8P+lHqRB+JA=',NULL,0,'me_student129@epita.fr',0,'Willy129','Williamson','','2018-06-09 12:51:11.937000',1,0,1),(132,'pbkdf2_sha256$100000$muv6STklWil3$lm8cnmTICJn4DD06YiLdWvq2wn8fDNg5mmSDhmPzjuQ=',NULL,0,'me_student130@epita.fr',0,'Willy130','Williamson','','2018-06-09 12:51:12.013000',1,0,1),(133,'pbkdf2_sha256$100000$5MgMFbTVFf7k$Mj8grmbTruEGnITcKq43Tr/BniyPflN/e/Ao2orzbJM=',NULL,0,'me_student131@epita.fr',0,'Willy131','Williamson','','2018-06-09 12:51:12.076000',1,0,1),(134,'pbkdf2_sha256$100000$F9W16MUpkQ6G$7ynn2Nbvx/cY8RrIGbQDJ1B/17BP6JvxZdwTXf/4E7I=',NULL,0,'me_student132@epita.fr',0,'Willy132','Williamson','','2018-06-09 12:51:12.140000',1,0,1),(135,'pbkdf2_sha256$100000$7gMxwXSG4ONM$SsgzjYFsfolqEDJgUqes7tYfTmfEb7JEOMZ6HttMzSk=',NULL,0,'me_student133@epita.fr',0,'Willy133','Williamson','','2018-06-09 12:51:12.231000',1,0,1),(136,'pbkdf2_sha256$100000$oUk8T3f2GHP8$4CHGypoOylt+vk5rseW6HUeogylM8rpFyq7FguXcncI=',NULL,0,'msc_student0@epita.fr',0,'John0','Johnson','','2018-06-09 12:51:30.203000',1,0,1),(137,'pbkdf2_sha256$100000$LVbdz2ndwnbc$R2r0H0DY4vCl8rzVL6GmbEhIQaO0G+h6o2v5EYEoFwY=',NULL,0,'msc_student1@epita.fr',0,'John1','Johnson','','2018-06-09 12:51:30.267000',1,0,1),(138,'pbkdf2_sha256$100000$Vo6uoU9S5lI8$Qtzv4BorIDUD2VVKXR47tiYvpwvDSxjhcQBDkZxu97Y=',NULL,0,'msc_student2@epita.fr',0,'John2','Johnson','','2018-06-09 12:51:30.331000',1,0,1),(139,'pbkdf2_sha256$100000$4KVkHRVsOwON$sHNISp9Ge8TGCGy3z/5ha3IiX4VRecen17PRqMgAHuE=',NULL,0,'msc_student3@epita.fr',0,'John3','Johnson','','2018-06-09 12:51:30.422000',1,0,1),(140,'pbkdf2_sha256$100000$uSLlLTj2EOeJ$9U3/U5yXd2jDUmZf6dcCdrrGWym/GJqYN/PyQfNwMXQ=',NULL,0,'msc_student4@epita.fr',0,'John4','Johnson','','2018-06-09 12:51:30.484000',1,0,1),(141,'pbkdf2_sha256$100000$8ntV5D0C38DL$5tIBkNjkX99iToX7yS+FZwYbeMbRMQnYtCo/Vt2nE74=',NULL,0,'msc_student5@epita.fr',0,'John5','Johnson','','2018-06-09 12:51:30.549000',1,0,1),(142,'pbkdf2_sha256$100000$fnHilLHm7soH$OfjWUnd3+ZHR6Gmd1XfXlBWiXA8MmT8tKLk7U1yrXDs=',NULL,0,'msc_student6@epita.fr',0,'John6','Johnson','','2018-06-09 12:51:30.612000',1,0,1),(143,'pbkdf2_sha256$100000$Io57BQBgFc2b$TAkQk9Z4dci+jMkstdWbnOAUPhZdKaIvzG/KHAIj6fc=',NULL,0,'msc_student7@epita.fr',0,'John7','Johnson','','2018-06-09 12:51:30.677000',1,0,1),(144,'pbkdf2_sha256$100000$Ug2BTkiN7R6L$Hszyqu05fhvUY2kQyHA8unCrINR1UOHPQLq2Vyk80hc=',NULL,0,'msc_student8@epita.fr',0,'John8','Johnson','','2018-06-09 12:51:30.741000',1,0,1),(145,'pbkdf2_sha256$100000$e1iUcQ4P1ETN$5SkYqW6yK69fiBnkDLibKtM+FRify7vyQuW2zv1LYCM=',NULL,0,'msc_student9@epita.fr',0,'John9','Johnson','','2018-06-09 12:51:30.829000',1,0,1),(146,'pbkdf2_sha256$100000$VdQpFmKg69MD$rBAwOCFERPamC8HnmzSmxQOPcaCfmVtbazTQvdzcan4=',NULL,0,'msc_student10@epita.fr',0,'John10','Johnson','','2018-06-09 12:51:30.893000',1,0,1),(147,'pbkdf2_sha256$100000$QkTRiiRq3y0e$ZUSg7nvfwHM+AnSDRDEdBRULbEDD1Nkv+SF6BkYgIM4=',NULL,0,'msc_student11@epita.fr',0,'John11','Johnson','','2018-06-09 12:51:30.960000',1,0,1),(148,'pbkdf2_sha256$100000$sKV5fs2iLA56$WFIPDbiGBXe4aNFqHb59elvPCqB8EptSUYsXBhRW/cI=',NULL,0,'msc_student12@epita.fr',0,'John12','Johnson','','2018-06-09 12:51:31.023000',1,0,1),(149,'pbkdf2_sha256$100000$Kfi4CWPlmuTV$AqDCFAwsxekxDbvv86z4XkdfAZDwpU11nRe5A3Gbcvg=',NULL,0,'msc_student13@epita.fr',0,'John13','Johnson','','2018-06-09 12:51:31.085000',1,0,1),(150,'pbkdf2_sha256$100000$aVWnt4E3VTCW$alCJ/o1iUALJU2rU7XpE6yl3XtCLta7CNDcgBzORw/w=',NULL,0,'msc_student14@epita.fr',0,'John14','Johnson','','2018-06-09 12:51:31.149000',1,0,1),(151,'pbkdf2_sha256$100000$UhZjspg9ULhd$93HLdTPQYb3P9MmS1bg3tTae2+Wgu3Wa3cgqdPOZvtk=',NULL,0,'msc_student15@epita.fr',0,'John15','Johnson','','2018-06-09 12:51:31.213000',1,0,1),(152,'pbkdf2_sha256$100000$bEpl93qM3sWL$m5dczXse4x3dR1Qf/icPJfcfSPJ842q+I4JCl4B52vA=',NULL,0,'msc_student16@epita.fr',0,'John16','Johnson','','2018-06-09 12:51:31.278000',1,0,1),(153,'pbkdf2_sha256$100000$BF7B2eEwQHVK$o8TZKHlSsKDhd9C0kQ12pACpAvXcYHFmTlGuhnbzmLU=',NULL,0,'msc_student17@epita.fr',0,'John17','Johnson','','2018-06-09 12:51:31.339000',1,0,1),(154,'pbkdf2_sha256$100000$n10q68R80oPM$FU95GbUYyWxmv8evIaPV8zXJVGEks6NhLcKwCzVgeLA=',NULL,0,'msc_student18@epita.fr',0,'John18','Johnson','','2018-06-09 12:51:31.403000',1,0,1),(155,'pbkdf2_sha256$100000$frZojJQV7Dj7$OBeU1o9I91kSCiJy9FutEESbLLG8wGCTwIO8j8H6Dmo=',NULL,0,'msc_student19@epita.fr',0,'John19','Johnson','','2018-06-09 12:51:31.467000',1,0,1),(156,'pbkdf2_sha256$100000$1Xmj5wJDmRDB$SoWnGbphBZ2HFCuOP8e3VRrcFcL3x6DRgLf8l1PYlOc=',NULL,0,'msc_student20@epita.fr',0,'John20','Johnson','','2018-06-09 12:51:31.531000',1,0,1),(157,'pbkdf2_sha256$100000$MGYM0nGHQkUk$DLCWfYw3d3mugWYv6xGQ0pcAl48jhxr7kYInIefEbWo=',NULL,0,'msc_student21@epita.fr',0,'John21','Johnson','','2018-06-09 12:51:31.594000',1,0,1),(158,'pbkdf2_sha256$100000$f71bpObz8eNI$66Z2wCSGXG8ysYQCuQkmfp9k0A1W78KC/pKlXYG2qUQ=',NULL,0,'msc_student22@epita.fr',0,'John22','Johnson','','2018-06-09 12:51:31.658000',1,0,1),(159,'pbkdf2_sha256$100000$CG5B8yYEQ828$VV2iJgpiSVWxmG409GKjVjVSESrz0qPAtRFp+YpbGeE=',NULL,0,'msc_student23@epita.fr',0,'John23','Johnson','','2018-06-09 12:51:31.742000',1,0,1),(160,'pbkdf2_sha256$100000$KIGSJxvZUQPw$UKrB04kgF9WLUnr3Nunf3HZ1pr3OczpIKzNatzGsugI=',NULL,0,'msc_student24@epita.fr',0,'John24','Johnson','','2018-06-09 12:51:31.817000',1,0,1),(161,'pbkdf2_sha256$100000$FdmBd4tkqKMb$2vAYHTZWCnJw8xdhCbTjbZx8DplY1dE8oIKCIyWlFcU=',NULL,0,'msc_student25@epita.fr',0,'John25','Johnson','','2018-06-09 12:51:31.889000',1,0,1),(162,'pbkdf2_sha256$100000$yKCW4bt0860f$P1qIlnTXyH/dc7kiLXYdRyIWDORQ+m6SdMhsQfZGrIs=',NULL,0,'msc_student26@epita.fr',0,'John26','Johnson','','2018-06-09 12:51:31.953000',1,0,1),(163,'pbkdf2_sha256$100000$TJ4Ly8JgnNwz$6Wx1HcDzhDaxScc9JNYuWr5t+vME6I/Zzupe++AHElM=',NULL,0,'msc_student27@epita.fr',0,'John27','Johnson','','2018-06-09 12:51:32.016000',1,0,1),(164,'pbkdf2_sha256$100000$xLrpr5FSyUns$1awSSGzUK53sCXIJ3Y0KqSgd/0oWAU3SmMDNLgRZqVo=',NULL,0,'msc_student28@epita.fr',0,'John28','Johnson','','2018-06-09 12:51:32.080000',1,0,1),(165,'pbkdf2_sha256$100000$LjkHFUhxpYo9$ADMctB9qkj4wNAWqneZdNjH3yhNpxrgvVg1sFl/Wlgo=',NULL,0,'msc_student29@epita.fr',0,'John29','Johnson','','2018-06-09 12:51:32.147000',1,0,1),(166,'pbkdf2_sha256$100000$tRHvnJTs0TAf$5wFE6F7z9hucCZ/j1dMlBZJjAnDjaXd7BNKDaW95Nxg=',NULL,0,'msc_student30@epita.fr',0,'John30','Johnson','','2018-06-09 12:51:32.210000',1,0,1),(167,'pbkdf2_sha256$100000$14KYv0OgKCyD$KJA4/AXbha62+/I5ijg1eFF1+evAlHBGi22uWLqfKKI=',NULL,0,'msc_student31@epita.fr',0,'John31','Johnson','','2018-06-09 12:51:32.282000',1,0,1),(168,'pbkdf2_sha256$100000$cuWjiA7rRw52$H1wRDEMdMnT/uf2k+KT4nrtOFHBp3QOsA7aDKyeW/fI=',NULL,0,'msc_student32@epita.fr',0,'John32','Johnson','','2018-06-09 12:51:32.348000',1,0,1),(169,'pbkdf2_sha256$100000$gc0JDF43kBUI$30XWJebfflbPi57iy2M12KQqtr8iJYI5BpjHn/5NiOE=',NULL,0,'msc_student33@epita.fr',0,'John33','Johnson','','2018-06-09 12:51:32.411000',1,0,1),(170,'pbkdf2_sha256$100000$LVVv6rKumTX6$wEEaVBBCmKMCn8EorB5nd1pKJaYJVjjQxxAajhXo+2A=',NULL,0,'msc_student34@epita.fr',0,'John34','Johnson','','2018-06-09 12:51:32.498000',1,0,1),(171,'pbkdf2_sha256$100000$jYyIKrHkLqp8$l7YT/AI7vRcy7fq+kTjdEcjVceQxo0Hafq8iXzZ6mJE=',NULL,0,'msc_student35@epita.fr',0,'John35','Johnson','','2018-06-09 12:51:32.576000',1,0,1),(172,'pbkdf2_sha256$100000$kkS1xXQBKHnY$vV3cv7brotEVMFRwU3yI7RD5SX2n1/hkc1DiV9QrPN8=',NULL,0,'msc_student36@epita.fr',0,'John36','Johnson','','2018-06-09 12:51:32.640000',1,0,1),(173,'pbkdf2_sha256$100000$eYyV7ucdBZ9Q$Uxpt3wG2+zV1dSgfsOySraGXxrqaUkFJBYqATJ2Pefs=',NULL,0,'msc_student37@epita.fr',0,'John37','Johnson','','2018-06-09 12:51:32.704000',1,0,1),(174,'pbkdf2_sha256$100000$tAFK4Gf520Rk$3+DtCrRISwjeWOzOumSt0uJ6t4EGxs4yeCqT07ABv/g=',NULL,0,'msc_student38@epita.fr',0,'John38','Johnson','','2018-06-09 12:51:32.771000',1,0,1),(175,'pbkdf2_sha256$100000$ZclELItU4SWv$+a9Bfuu2kqfjYd13pwYTDby1peDfer/Id4jTSCyuTYc=',NULL,0,'msc_student39@epita.fr',0,'John39','Johnson','','2018-06-09 12:51:32.832000',1,0,1),(176,'pbkdf2_sha256$100000$eWD3HIbgK9K2$lBiLxRGwO0ftT0E8npUzdW4cl7K9R4UYQFhzSdibu4A=',NULL,0,'msc_student40@epita.fr',0,'John40','Johnson','','2018-06-09 12:51:32.895000',1,0,1),(177,'pbkdf2_sha256$100000$h75DWnkMvm7s$z3jzHfxZ+zLuIkE1nDZnKJab8AYbvq9u/ndmbglNQkI=',NULL,0,'msc_student41@epita.fr',0,'John41','Johnson','','2018-06-09 12:51:32.958000',1,0,1),(178,'pbkdf2_sha256$100000$MUrrY6iLBSwk$yI/6i7i6pzgmk6yMWyNBol0s3Gs3ea71Y3w5DSvPNLs=',NULL,0,'msc_student42@epita.fr',0,'John42','Johnson','','2018-06-09 12:51:33.020000',1,0,1),(179,'pbkdf2_sha256$100000$OM3PvZAF3pWT$t2wQUlOkEKyBdMi4o/8DvwLxfTGT4X4v2pJAdzWZtJA=',NULL,0,'msc_student43@epita.fr',0,'John43','Johnson','','2018-06-09 12:51:33.106000',1,0,1),(180,'pbkdf2_sha256$100000$4VA1pioznvmH$ljmKqYP1FrZaurKlt6Wrj8E5cewqUSwf9W1i3SWWleI=',NULL,0,'msc_student44@epita.fr',0,'John44','Johnson','','2018-06-09 12:51:33.170000',1,0,1),(181,'pbkdf2_sha256$100000$9OBlRAZ4bLT1$D09R+tKHJ7PPVwBcscXsqq1YeXkl+qEsQR/hVqPyuOQ=',NULL,0,'msc_student45@epita.fr',0,'John45','Johnson','','2018-06-09 12:51:33.247000',1,0,1),(182,'pbkdf2_sha256$100000$di55d3UVby5D$o09ALNaBT122Hw1wsrU5sFAx70y8TxNe2SOOwv5waLs=',NULL,0,'msc_student46@epita.fr',0,'John46','Johnson','','2018-06-09 12:51:33.314000',1,0,1),(183,'pbkdf2_sha256$100000$vwjNc3stGsV3$R2iGIXlUe1UZi5T85OwivM+prujl2Ib32EglqdxuFNg=',NULL,0,'msc_student47@epita.fr',0,'John47','Johnson','','2018-06-09 12:51:33.375000',1,0,1),(184,'pbkdf2_sha256$100000$fUVUpeBRGBdM$PYr4IUnTlZPjwmP+daPY2R8KpWgkwxifcFuzH+YlwIA=',NULL,0,'msc_student48@epita.fr',0,'John48','Johnson','','2018-06-09 12:51:33.439000',1,0,1),(185,'pbkdf2_sha256$100000$wTSE9SFyCiWU$of3LpNXecIBEJnL5pvda3AEDlBAx2qgWNG/jnt7sNxg=',NULL,0,'msc_student49@epita.fr',0,'John49','Johnson','','2018-06-09 12:51:33.500000',1,0,1),(186,'pbkdf2_sha256$100000$KsY6HibPZtg5$nt5bBZG2lbsB8iJuuDhllXZpFBBOcLDyQsYop0XaCig=',NULL,0,'msc_student50@epita.fr',0,'John50','Johnson','','2018-06-09 12:51:33.563000',1,0,1),(187,'pbkdf2_sha256$100000$5fRagnQyW214$ewuYTVmX+a/l9WWku/Ptp+G5WCBq+KzFspCAwBenA/M=',NULL,0,'msc_student51@epita.fr',0,'John51','Johnson','','2018-06-09 12:51:33.631000',1,0,1),(188,'pbkdf2_sha256$100000$eCLxjFpCJUmF$i4d7gVOQVOZp9qN9zCW4Hhpj+VJlEXe4KM2ctbi1g4c=',NULL,0,'msc_student52@epita.fr',0,'John52','Johnson','','2018-06-09 12:51:33.698000',1,0,1),(189,'pbkdf2_sha256$100000$mvmK8oJUtrWh$kArFYeKFi1wqjdoZM3QmJalY5O62PyA4Fwcx8FkwIvI=',NULL,0,'msc_student53@epita.fr',0,'John53','Johnson','','2018-06-09 12:51:33.787000',1,0,1),(190,'pbkdf2_sha256$100000$YyNxb67ZwnOC$Ke+4vjEeKOOXZcloI67NTiAPYG8vMqiMwE9rp1IY7A8=',NULL,0,'msc_student54@epita.fr',0,'John54','Johnson','','2018-06-09 12:51:33.851000',1,0,1),(191,'pbkdf2_sha256$100000$lA6kVINbgC4V$ECQiMzty1dq5yseBdv8emFOqqKWOkmv8iCsF+D9kjBQ=',NULL,0,'msc_student55@epita.fr',0,'John55','Johnson','','2018-06-09 12:51:33.916000',1,0,1),(192,'pbkdf2_sha256$100000$aHcFKVsZmwUG$gRNwxF/HuHn3OGl6wI+qaFcMUovn4Px7bXXBj7eq2Zs=',NULL,0,'msc_student56@epita.fr',0,'John56','Johnson','','2018-06-09 12:51:33.979000',1,0,1),(193,'pbkdf2_sha256$100000$lkd1LsTDooHl$1sntFXqn3+ieqUk/LjiMUWZikJ5jGbHSy2HhKfCBGiQ=',NULL,0,'msc_student57@epita.fr',0,'John57','Johnson','','2018-06-09 12:51:34.059000',1,0,1),(194,'pbkdf2_sha256$100000$eigFuuxeZmto$DXUdd3ookveYwjUrG69p/BXGbxU7a2e01PBBeixyXQ0=',NULL,0,'msc_student58@epita.fr',0,'John58','Johnson','','2018-06-09 12:51:34.123000',1,0,1),(195,'pbkdf2_sha256$100000$IFOeyNWYZrIB$gH5ohc2OPTaWJIfNL65pbFUklsvFqbaWxVg/3h3UgRQ=',NULL,0,'msc_student59@epita.fr',0,'John59','Johnson','','2018-06-09 12:51:34.185000',1,0,1),(196,'pbkdf2_sha256$100000$rqn4Rk4yw55I$rmDB2DBwBn3JVtVwUjnEsVxzz9mfDpfyZIMkZwxgpbY=',NULL,0,'msc_student60@epita.fr',0,'John60','Johnson','','2018-06-09 12:51:34.252000',1,0,1),(197,'pbkdf2_sha256$100000$k0frk4AOPJbn$qA6KO1KuYNwwhy2AL241sh2N0GT8VL6fx/Cj/iQA84Q=',NULL,0,'msc_student61@epita.fr',0,'John61','Johnson','','2018-06-09 12:51:34.316000',1,0,1),(198,'pbkdf2_sha256$100000$lHO2EcbiGf63$JAEEAZ13HD81wVHNl2ZWBYkX2FoLJ9E1k6fOs27ikCM=',NULL,0,'msc_student62@epita.fr',0,'John62','Johnson','','2018-06-09 12:51:34.380000',1,0,1),(199,'pbkdf2_sha256$100000$woj6e2daNkmd$woHGjaDMAz0Y8wVS2zFaq+tRGEcafKgR8zCP5iteFbw=',NULL,0,'msc_student63@epita.fr',0,'John63','Johnson','','2018-06-09 12:51:34.444000',1,0,1),(200,'pbkdf2_sha256$100000$v1IvNZMx3ox8$cd2YrmcvNpHiUCslTAW95bV6gkYNzEXkYMaDD1roORw=',NULL,0,'msc_student64@epita.fr',0,'John64','Johnson','','2018-06-09 12:51:34.508000',1,0,1),(201,'pbkdf2_sha256$100000$58TCIC7WBM8X$m4pQ+bKK1z9uCvXNWiCu/zjszX0ekd7G/HJMSfvSjhg=',NULL,0,'msc_student65@epita.fr',0,'John65','Johnson','','2018-06-09 12:51:34.573000',1,0,1),(202,'pbkdf2_sha256$100000$17U6M8d3DOAq$go7z7NAyZ/on7RFzki1DbRijZOJPSmrCqE91sm5ss5I=',NULL,0,'msc_student66@epita.fr',0,'John66','Johnson','','2018-06-09 12:51:34.636000',1,0,1),(203,'pbkdf2_sha256$100000$Zw7sZLG68W9T$KK3ZEZJnmiwtoyvx2CJiYiLJaqo02M0H78OvvuAPFns=',NULL,0,'msc_student67@epita.fr',0,'John67','Johnson','','2018-06-09 12:51:34.731000',1,0,1),(204,'pbkdf2_sha256$100000$xSRJRPqCt3ec$v5GWZfstXLPUC5AqZDrxM9Kc/MWnAfp1aGnV1oBI6sw=',NULL,0,'msc_student68@epita.fr',0,'John68','Johnson','','2018-06-09 12:51:34.813000',1,0,1),(205,'pbkdf2_sha256$100000$Qxj382SvAKip$m6Q+eBnRlB3PBS7HNmjiwCngHCrENnBF5guzXfXKt0I=',NULL,0,'msc_student69@epita.fr',0,'John69','Johnson','','2018-06-09 12:51:34.877000',1,0,1),(206,'pbkdf2_sha256$100000$ZJfFiOLk9dxW$SHX4VhUh+YGEaZm3nrcliTRos2oMwBZehgx3rOxCdEk=',NULL,0,'msc_student70@epita.fr',0,'John70','Johnson','','2018-06-09 12:51:34.949000',1,0,1),(207,'pbkdf2_sha256$100000$bZPgmv8BPVaZ$qimjR5wIH0TUWCBBkI3xYQQNMxSB6+WFie6rHYLAEeg=',NULL,0,'msc_student71@epita.fr',0,'John71','Johnson','','2018-06-09 12:51:35.021000',1,0,1),(208,'pbkdf2_sha256$100000$xyecDmXUgNPA$FWfzJ9TPlgFyyeOAUPGCu7fet8wTlz2nPLBuUhleaAc=',NULL,0,'msc_student72@epita.fr',0,'John72','Johnson','','2018-06-09 12:51:35.085000',1,0,1),(209,'pbkdf2_sha256$100000$PTVv4NU7KjX3$IL/PcWSc1TYhyhEa0wzLrU2/SjN1NbCh/GWdmx0iip0=',NULL,0,'msc_student73@epita.fr',0,'John73','Johnson','','2018-06-09 12:51:35.171000',1,0,1),(210,'pbkdf2_sha256$100000$2y3UWFbApwGb$HRL/IPIv1BmQXvBF45rZ2+E74euRWsQYCusMVWteR2k=',NULL,0,'msc_student74@epita.fr',0,'John74','Johnson','','2018-06-09 12:51:35.236000',1,0,1),(211,'pbkdf2_sha256$100000$T1BmcDRsl7jm$Vg8Yd0W8aAPJGxDkZ4mCPTR8zJKsDfGRKE7zyz4L7fk=',NULL,0,'msc_student75@epita.fr',0,'John75','Johnson','','2018-06-09 12:51:35.301000',1,0,1),(212,'pbkdf2_sha256$100000$Av33xrWLttkL$AaMUPTVyVbYIV4kTSlFPdhC9ho2jvR4Q5MIdKtZh66A=',NULL,0,'msc_student76@epita.fr',0,'John76','Johnson','','2018-06-09 12:51:35.364000',1,0,1),(213,'pbkdf2_sha256$100000$r44SXQR747WX$l+0YeCZj7RrmOsiRjoFTOe1s+yHMngA4IoICt9fSHw8=',NULL,0,'msc_student77@epita.fr',0,'John77','Johnson','','2018-06-09 12:51:35.428000',1,0,1),(214,'pbkdf2_sha256$100000$c29JcedgrrGT$DM/F4w5bM8yAApg6j52sZnAIhEnkVt2kDDqXCtqGC30=',NULL,0,'msc_student78@epita.fr',0,'John78','Johnson','','2018-06-09 12:51:35.492000',1,0,1),(215,'pbkdf2_sha256$100000$fK6WTr41ElpB$V20k5Kc8Ob1PpRW/582NvwLlKVptBz53yI7m6KHm0sA=',NULL,0,'msc_student79@epita.fr',0,'John79','Johnson','','2018-06-09 12:51:35.556000',1,0,1),(216,'pbkdf2_sha256$100000$mUuUhtZw3ntp$pYdcsud+Q4uaHC5GtL6NRGdGOetyDvDIC/nOVyye5us=',NULL,0,'msc_student80@epita.fr',0,'John80','Johnson','','2018-06-09 12:51:35.620000',1,0,1),(217,'pbkdf2_sha256$100000$L1A7m1nCoSJs$qod+4ltIO4bn8S1JOgP/ew/WM/9QKJhrlOdSELoXB8Y=',NULL,0,'msc_student81@epita.fr',0,'John81','Johnson','','2018-06-09 12:51:35.683000',1,0,1),(218,'pbkdf2_sha256$100000$InM6udJ0JLYc$yMQTYvf/gYprkaOzvze6b9RwFyj3G/3Sr6SqW2ViaAc=',NULL,0,'msc_student82@epita.fr',0,'John82','Johnson','','2018-06-09 12:51:35.747000',1,0,1),(219,'pbkdf2_sha256$100000$YYOLyimr4heX$M4sUGeiktSzWny4uXMioyFzvghrWrR9ps39f5vq6VWM=',NULL,0,'msc_student83@epita.fr',0,'John83','Johnson','','2018-06-09 12:51:35.811000',1,0,1),(220,'pbkdf2_sha256$100000$nBFt42bcsjxM$Df9v1+XV8NoUesGmBrGoiY3GpA+5okscUiMmAvGc0R8=',NULL,0,'msc_student84@epita.fr',0,'John84','Johnson','','2018-06-09 12:51:35.875000',1,0,1),(221,'pbkdf2_sha256$100000$Ntfr7IVadCmb$pxXIVswwdrWg3zqwArSu0jiTk8cZf16jvC+XSF/br84=',NULL,0,'msc_student85@epita.fr',0,'John85','Johnson','','2018-06-09 12:51:35.939000',1,0,1),(222,'pbkdf2_sha256$100000$GqGF3JipRgpL$3ycu9P32JtV1IyAGJvpC/B10pDgQVtSEfkDwwV6ZmH8=',NULL,0,'msc_student86@epita.fr',0,'John86','Johnson','','2018-06-09 12:51:36.003000',1,0,1),(223,'pbkdf2_sha256$100000$AehJKwi37BWf$65KPWRrNvCti+vh8DyIA6BDLgv2BPDDV+ER1f1ls96Q=',NULL,0,'msc_student87@epita.fr',0,'John87','Johnson','','2018-06-09 12:51:36.073000',1,0,1),(224,'pbkdf2_sha256$100000$sVq3XZvZrUFA$NQEuBPqLIKsS2CBG3AGDVcCOfduFlH1bzcqWS97kvn0=',NULL,0,'msc_student88@epita.fr',0,'John88','Johnson','','2018-06-09 12:51:36.136000',1,0,1),(225,'pbkdf2_sha256$100000$uIswmk0FlmCK$aRLxcRw6Mh/oNma6KAM7N0pzwl+dr8fV8ZscNOOGK8Y=',NULL,0,'msc_student89@epita.fr',0,'John89','Johnson','','2018-06-09 12:51:36.201000',1,0,1),(226,'pbkdf2_sha256$100000$QWVW6qLztAMt$sVmdtAURRVwnQr9kOWwJ5ljKjbQhVce9Fh8KLS8QJMw=',NULL,0,'msc_student90@epita.fr',0,'John90','Johnson','','2018-06-09 12:51:36.264000',1,0,1),(227,'pbkdf2_sha256$100000$i7lqOcKnWSYy$QXEyKtYOrgFqwbvl2buZjPVi04H/5IHTTpaxfwph8wI=',NULL,0,'msc_student91@epita.fr',0,'John91','Johnson','','2018-06-09 12:51:36.328000',1,0,1),(228,'pbkdf2_sha256$100000$UkSvJo30CdM8$H72eJYQksHkz/ZrHYcyISCIRS6JijdLDSdEzukmAxFk=',NULL,0,'msc_student92@epita.fr',0,'John92','Johnson','','2018-06-09 12:51:36.391000',1,0,1),(229,'pbkdf2_sha256$100000$0YgqaPzpIfom$5gn2MMcv1K4SWWplUXI5f1nxe9IRJ4xohnSN6E58ScU=',NULL,0,'msc_student93@epita.fr',0,'John93','Johnson','','2018-06-09 12:51:36.453000',1,0,1),(230,'pbkdf2_sha256$100000$fARAC7ajv8Yb$T/k4DuugsKwFzLb0EwrRezkYqJJvYW/ZcNjQlsiSVVc=',NULL,0,'msc_student94@epita.fr',0,'John94','Johnson','','2018-06-09 12:51:36.516000',1,0,1),(231,'pbkdf2_sha256$100000$phFrZ50tVg32$4YwhEDTdNk3Fmt8oZECYAK0BFcathSJiCh9NNira5S0=',NULL,0,'msc_student95@epita.fr',0,'John95','Johnson','','2018-06-09 12:51:36.580000',1,0,1),(232,'pbkdf2_sha256$100000$qrm3DN3J6I9B$rxK2OfQ/U1GbcYXUCsVTzTxj7nHQXlHJa4/qQZNj9lY=',NULL,0,'msc_student96@epita.fr',0,'John96','Johnson','','2018-06-09 12:51:36.644000',1,0,1),(233,'pbkdf2_sha256$100000$8UhWh3om5hof$2GTsj5sApBDOldJ+ZAa0KzY+vXMBN3dYtAIQ/8SKFdM=',NULL,0,'msc_student97@epita.fr',0,'John97','Johnson','','2018-06-09 12:51:36.708000',1,0,1),(234,'pbkdf2_sha256$100000$ESwDzbj9Fo3p$7w3fKp/tHgXm4kK3AEJQj981G9Rvimagygl91s99iuU=',NULL,0,'msc_student98@epita.fr',0,'John98','Johnson','','2018-06-09 12:51:36.772000',1,0,1),(235,'pbkdf2_sha256$100000$uC99DxVbk4rl$NoLYuIQwQ3zpbeYXHe1eGEa9WpMCHppx8ksMCaP5Rek=',NULL,0,'msc_student99@epita.fr',0,'John99','Johnson','','2018-06-09 12:51:36.840000',1,0,1),(236,'pbkdf2_sha256$100000$0jweEJBjnwqb$XuT7jEUNDWduIru4S173H9XSWSe8CHvtuSeGZGZ4poQ=',NULL,0,'msc_student100@epita.fr',0,'John100','Johnson','','2018-06-09 12:51:36.903000',1,0,1),(237,'pbkdf2_sha256$100000$Lqq9k24y5vlu$VwOtHVCFo5ILoSQVto2NQfwzuVOcDM6mOKx/fCvNY+4=',NULL,0,'msc_student101@epita.fr',0,'John101','Johnson','','2018-06-09 12:51:36.966000',1,0,1),(238,'pbkdf2_sha256$100000$ynSz79Jq861g$9/d0h3TgZH2GJC/aNeeLefv3SKG/iazUQXjV336wtyE=',NULL,0,'msc_student102@epita.fr',0,'John102','Johnson','','2018-06-09 12:51:37.027000',1,0,1),(239,'pbkdf2_sha256$100000$jjCs9o7Q4uJk$phG46i8ixfPuE7jQdSDpvkGCCtl+SI+IbinmY9es5ag=',NULL,0,'msc_student103@epita.fr',0,'John103','Johnson','','2018-06-09 12:51:37.091000',1,0,1),(240,'pbkdf2_sha256$100000$V1Mcgl9KmPdP$MmXrx8ox1gviT/GYvz5UzKqaB8ksSwvv3LBjY8Wb/cI=',NULL,0,'msc_student104@epita.fr',0,'John104','Johnson','','2018-06-09 12:51:37.156000',1,0,1),(241,'pbkdf2_sha256$100000$YGROZ2WfCgGD$4Td2DX4QT+Up2AWKuUEQp8HBxzfzQKdlScoDvdo4Hfk=',NULL,0,'msc_student105@epita.fr',0,'John105','Johnson','','2018-06-09 12:51:37.242000',1,0,1),(242,'pbkdf2_sha256$100000$yZkZRkWYl3Fl$BzeXUExfOEb74Rl33hEQKl9WFeVlMOL486Vns7GlcjE=',NULL,0,'msc_student106@epita.fr',0,'John106','Johnson','','2018-06-09 12:51:37.304000',1,0,1),(243,'pbkdf2_sha256$100000$Xb7ztRSydIN3$5O4r1tKWnPG0ZunkSPUsglgulBjmb6Gy8i7j5+zOg7Y=',NULL,0,'msc_student107@epita.fr',0,'John107','Johnson','','2018-06-09 12:51:37.368000',1,0,1),(244,'pbkdf2_sha256$100000$lTZx0pgQZdul$tTtMLfoyEu6Rp+nueaOgEdLJUUDNLRauIO3EB7iH050=',NULL,0,'msc_student108@epita.fr',0,'John108','Johnson','','2018-06-09 12:51:37.432000',1,0,1),(245,'pbkdf2_sha256$100000$mFL5iFpkbSEb$k1vOTw76DwdfjU39borOFBqGUIox5o3rHuTiU6NAMMQ=',NULL,0,'msc_student109@epita.fr',0,'John109','Johnson','','2018-06-09 12:51:37.498000',1,0,1),(246,'pbkdf2_sha256$100000$tQ8CdsYjIJEM$YzZfY2p6mO/uoNtjrzHnNjPCaYga4lLa66taYsnZAIs=',NULL,0,'msc_student110@epita.fr',0,'John110','Johnson','','2018-06-09 12:51:37.564000',1,0,1),(247,'pbkdf2_sha256$100000$ExeJMrQokQeW$VUL/WItU/4GHDxi7JwDRuLM6ia3MjctQc/jxMK7w9PI=',NULL,0,'msc_student111@epita.fr',0,'John111','Johnson','','2018-06-09 12:51:37.628000',1,0,1),(248,'pbkdf2_sha256$100000$zAIs4SKf3B2m$m4aLshyBjij1ks1MImf2ngs4a+P1cuBJqlEy3kXCY7g=',NULL,0,'msc_student112@epita.fr',0,'John112','Johnson','','2018-06-09 12:51:37.712000',1,0,1),(249,'pbkdf2_sha256$100000$85j5PiNwUdse$vARcKOWTU/uTpifGtim9C0LQ65rPFOLjsP3rYE3YJ94=',NULL,0,'msc_student113@epita.fr',0,'John113','Johnson','','2018-06-09 12:51:37.777000',1,0,1),(250,'pbkdf2_sha256$100000$LCOHFzHUcl0B$v7BXvu6FhnGnjjFh1kzIsrIiK1hp7/eb1UWhvnpMYF8=',NULL,0,'msc_student114@epita.fr',0,'John114','Johnson','','2018-06-09 12:51:37.841000',1,0,1),(251,'pbkdf2_sha256$100000$LWfPVWrLOq4B$e9hTsa+KJaO2DA/xBtEJe4aUblGIvu9VRTU3dQCVefc=',NULL,0,'msc_student115@epita.fr',0,'John115','Johnson','','2018-06-09 12:51:37.905000',1,0,1),(252,'pbkdf2_sha256$100000$ket0jt9fGoWs$yUZpghAPjGFUeuPzzfRkmx/zngUgK/nUitREBX2URt0=',NULL,0,'msc_student116@epita.fr',0,'John116','Johnson','','2018-06-09 12:51:37.964000',1,0,1),(253,'pbkdf2_sha256$100000$yUSJs2CCcS0N$G3KzS/wD8ToeVzNlKxV6seln0IWSRf+sFEY97ex9e9A=',NULL,0,'msc_student117@epita.fr',0,'John117','Johnson','','2018-06-09 12:51:38.042000',1,0,1),(254,'pbkdf2_sha256$100000$yWjfZ3gf7zpf$EbzAYKjqb4k1bR77nGVFLzKY+k/zsVBGw+3mmGaB/QI=',NULL,0,'msc_student118@epita.fr',0,'John118','Johnson','','2018-06-09 12:51:38.107000',1,0,1),(255,'pbkdf2_sha256$100000$TdOuNhpBSmhQ$GdpQnqfAGWZlrOkesGfQkLpR9lKTU7vnEM+Na9dwoAQ=',NULL,0,'msc_student119@epita.fr',0,'John119','Johnson','','2018-06-09 12:51:38.172000',1,0,1),(256,'pbkdf2_sha256$100000$eBstBH4xdkaW$nsNh9zU4D/X/+ydJMYnhqXdHE7/SzNVmby/8xwtuxl8=',NULL,0,'msc_student120@epita.fr',0,'John120','Johnson','','2018-06-09 12:51:38.236000',1,0,1),(257,'pbkdf2_sha256$100000$XB5XfZ6d06kI$ZDR5js1nBlIN4O+cJsErmRkfNqZqjIqPwSLfG5XWN9U=',NULL,0,'msc_student121@epita.fr',0,'John121','Johnson','','2018-06-09 12:51:38.300000',1,0,1),(258,'pbkdf2_sha256$100000$VjYgIGHGFx1O$k+4jmkX85D9WN5j1o3Ubvg03w0xtADtG7xoQLV++nvI=',NULL,0,'msc_student122@epita.fr',0,'John122','Johnson','','2018-06-09 12:51:38.387000',1,0,1),(259,'pbkdf2_sha256$100000$9EvpXEL3KtWO$uKfXAwQr3Mxhbbaz4CTt4vSqpEoqVoZb1qxHtLxpSvg=',NULL,0,'msc_student123@epita.fr',0,'John123','Johnson','','2018-06-09 12:51:38.448000',1,0,1),(260,'pbkdf2_sha256$100000$iRnm1I2XuTo8$ztuyxVPkZ6mLCuT+WyfFmuYmYheVSWoYE2bkdfO+d3g=',NULL,0,'msc_student124@epita.fr',0,'John124','Johnson','','2018-06-09 12:51:38.512000',1,0,1),(261,'pbkdf2_sha256$100000$JNYxXwtCgHYe$eM3MGl0bCkkd/VYzB0BdDoRTmAVe1SfqJ3WMLxekEdA=',NULL,0,'msc_student125@epita.fr',0,'John125','Johnson','','2018-06-09 12:51:38.576000',1,0,1),(262,'pbkdf2_sha256$100000$afU9pTqQzMTX$eXruhCyo3FiqaOomj9y3tx9ij7qlLIhjauBPGIfJOCs=',NULL,0,'msc_student126@epita.fr',0,'John126','Johnson','','2018-06-09 12:51:38.640000',1,0,1),(263,'pbkdf2_sha256$100000$zVbA2onSVwHg$n3ESkmG1yOef7Pzs4q10N/PzLWtwhsPqbP0gOdtg2y8=',NULL,0,'msc_student127@epita.fr',0,'John127','Johnson','','2018-06-09 12:51:38.727000',1,0,1),(264,'pbkdf2_sha256$100000$drAggIn000DD$WJiXyEp5Oe1IPH/sSWMmG5/MWOOm1ssMWmZTPTEkdKo=',NULL,0,'msc_student128@epita.fr',0,'John128','Johnson','','2018-06-09 12:51:38.792000',1,0,1),(265,'pbkdf2_sha256$100000$WJqxDUuju5kR$cnPmEFBl7m4USB8blXy1taBmPT4fGUwYq8ApICdmDz4=',NULL,0,'msc_student129@epita.fr',0,'John129','Johnson','','2018-06-09 12:51:38.856000',1,0,1),(266,'pbkdf2_sha256$100000$dXkkO6Keal3X$eaeC5vmWvd88P5Nr80btm5d2rFEa5hqaA9Cu6DobOOs=',NULL,0,'msc_student130@epita.fr',0,'John130','Johnson','','2018-06-09 12:51:38.946000',1,0,1),(267,'pbkdf2_sha256$100000$D84FMVIzLY5K$ACVsQ0XfFbKkDMF4kEp5+M3GjthD3Jc6FxRrAyUb1TE=',NULL,0,'msc_student131@epita.fr',0,'John131','Johnson','','2018-06-09 12:51:39.007000',1,0,1),(268,'pbkdf2_sha256$100000$qybKCuX8QLUN$LuIfPAv4WmCL/fU+awlhqrfmB5sik5mG+vWJDPBT5eM=',NULL,0,'msc_student132@epita.fr',0,'John132','Johnson','','2018-06-09 12:51:39.105000',1,0,1),(269,'pbkdf2_sha256$100000$ITO8pcRLufVT$JbYTgD7ublCGo+7/rWKmw0Dn9/tJiLsN6WEegxaq408=',NULL,0,'msc_student133@epita.fr',0,'John133','Johnson','','2018-06-09 12:51:39.169000',1,0,1),(270,'pbkdf2_sha256$100000$i1n3oGVo5nzF$g79KU2JO/yqj5NzKpZi5wx8Mz2OzLOd0u0zlA9KdwGo=','2018-06-29 12:02:53.148788',1,'admin@epita.fr',0,'','','','2018-06-29 12:02:01.232036',1,1,1);
/*!40000 ALTER TABLE `accounts_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user_groups`
--

DROP TABLE IF EXISTS `accounts_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_user_groups_user_id_group_id_59c0b32f_uniq` (`user_id`,`group_id`),
  KEY `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` (`group_id`),
  CONSTRAINT `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `accounts_user_groups_user_id_52b62117_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user_groups`
--

LOCK TABLES `accounts_user_groups` WRITE;
/*!40000 ALTER TABLE `accounts_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user_user_permissions`
--

DROP TABLE IF EXISTS `accounts_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq` (`user_id`,`permission_id`),
  KEY `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` (`permission_id`),
  CONSTRAINT `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `accounts_user_user_p_user_id_e4f0a161_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user_user_permissions`
--

LOCK TABLES `accounts_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `accounts_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add attendance',6,'add_attendance'),(17,'Can change attendance',6,'change_attendance'),(18,'Can delete attendance',6,'delete_attendance'),(19,'Can add course',7,'add_course'),(20,'Can change course',7,'change_course'),(21,'Can delete course',7,'delete_course'),(22,'Can add grades',8,'add_grades'),(23,'Can change grades',8,'change_grades'),(24,'Can delete grades',8,'delete_grades'),(25,'Can add professor',9,'add_professor'),(26,'Can change professor',9,'change_professor'),(27,'Can delete professor',9,'delete_professor'),(28,'Can add schedule',10,'add_schedule'),(29,'Can change schedule',10,'change_schedule'),(30,'Can delete schedule',10,'delete_schedule'),(31,'Can add student',11,'add_student'),(32,'Can change student',11,'change_student'),(33,'Can delete student',11,'delete_student'),(34,'Can add student course',12,'add_studentcourse'),(35,'Can change student course',12,'change_studentcourse'),(36,'Can delete student course',12,'delete_studentcourse'),(37,'Can add user',13,'add_user'),(38,'Can change user',13,'change_user'),(39,'Can delete user',13,'delete_user'),(40,'Can add reset token',14,'add_resettoken'),(41,'Can change reset token',14,'change_resettoken'),(42,'Can delete reset token',14,'delete_resettoken'),(43,'Can add Option',15,'add_multiplechoiceoption'),(44,'Can change Option',15,'change_multiplechoiceoption'),(45,'Can delete Option',15,'delete_multiplechoiceoption'),(46,'Can add question',16,'add_question'),(47,'Can change question',16,'change_question'),(48,'Can delete question',16,'delete_question'),(49,'Can add Quiz',17,'add_quiz'),(50,'Can change Quiz',17,'change_quiz'),(51,'Can delete Quiz',17,'delete_quiz'),(52,'Can add quiz progression',18,'add_quizprogression'),(53,'Can change quiz progression',18,'change_quizprogression'),(54,'Can delete quiz progression',18,'delete_quizprogression'),(55,'Can add multiple choice question',19,'add_multiplechoicequestion'),(56,'Can change multiple choice question',19,'change_multiplechoicequestion'),(57,'Can delete multiple choice question',19,'delete_multiplechoicequestion'),(58,'Can add numeric scale question',20,'add_numericscalequestion'),(59,'Can change numeric scale question',20,'change_numericscalequestion'),(60,'Can delete numeric scale question',20,'delete_numericscalequestion'),(61,'Can add checkbox question',21,'add_checkboxquestion'),(62,'Can change checkbox question',21,'change_checkboxquestion'),(63,'Can delete checkbox question',21,'delete_checkboxquestion'),(64,'Can add room',22,'add_room'),(65,'Can change room',22,'change_room'),(66,'Can delete room',22,'delete_room');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
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
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_accounts_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (14,'accounts','resettoken'),(13,'accounts','user'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(6,'epita','attendance'),(7,'epita','course'),(8,'epita','grades'),(9,'epita','professor'),(22,'epita','room'),(10,'epita','schedule'),(11,'epita','student'),(12,'epita','studentcourse'),(21,'quiz','checkboxquestion'),(15,'quiz','multiplechoiceoption'),(19,'quiz','multiplechoicequestion'),(20,'quiz','numericscalequestion'),(16,'quiz','question'),(17,'quiz','quiz'),(18,'quiz','quizprogression'),(5,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-06-29 10:52:39.942717'),(2,'contenttypes','0002_remove_content_type_name','2018-06-29 10:52:40.064510'),(3,'auth','0001_initial','2018-06-29 10:52:40.493925'),(4,'auth','0002_alter_permission_name_max_length','2018-06-29 10:52:40.560690'),(5,'auth','0003_alter_user_email_max_length','2018-06-29 10:52:40.572063'),(6,'auth','0004_alter_user_username_opts','2018-06-29 10:52:40.583556'),(7,'auth','0005_alter_user_last_login_null','2018-06-29 10:52:40.594625'),(8,'auth','0006_require_contenttypes_0002','2018-06-29 10:52:40.599104'),(9,'auth','0007_alter_validators_add_error_messages','2018-06-29 10:52:40.609042'),(10,'auth','0008_alter_user_username_max_length','2018-06-29 10:52:40.620531'),(11,'auth','0009_alter_user_last_name_max_length','2018-06-29 10:52:40.632437'),(12,'accounts','0001_initial','2018-06-29 10:52:41.218047'),(13,'admin','0001_initial','2018-06-29 10:52:41.388362'),(14,'admin','0002_logentry_remove_auto_add','2018-06-29 10:52:41.404030'),(15,'epita','0001_initial','2018-06-29 10:52:42.800369'),(16,'quiz','0001_initial','2018-06-29 10:52:43.942593'),(17,'sessions','0001_initial','2018-06-29 10:52:44.005376');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0ga9iffe198l267x9ia0f3eft4zwf1ql','MWJmYzM3ZWM4Mjg5ZDk3NzFmOGIxOGZlYWYxYzNmNmVlZTFjMTcwYTp7Il9hdXRoX3VzZXJfaWQiOiIyNzEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijg0ODQzNDZiMGRmNDdmYzdjZjgxNDUyNGFlNmNjOGY4YzUzZmQxY2IifQ==','2018-07-11 17:46:14.494000'),('25qt1fekkcif46qsqjzzht1jshnsg9q4','Y2JjNDUzOGFjY2E3YjExOTAwZjgzMTI4MTRjYTE4MmIwZDFkMTI4Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5Y2ZmZDg2MTVmZDU5NjMxYTUxOGQ5NzZkYjVhNTZjNmQxMDVjNmI0In0=','2018-06-23 12:44:57.346000'),('7rpwk7c50t83j3qon4mlue49wvkfuyf4','NWVlZGUyYjgzZGYwNjFmYjMxNWQ4OTJlNGJhZjU0NDI3ZDI4MzE1YTp7Il9hdXRoX3VzZXJfaWQiOiIyNzAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImM1NjdlN2I3ZmM0YzkyNWVmOWQwYjViZWEwMjc1MTVjNWNkODZhOWUifQ==','2018-07-13 12:02:53.153607'),('cpouf8ff6sqc0uud2sr2q41cfkwg24lf','Y2JjNDUzOGFjY2E3YjExOTAwZjgzMTI4MTRjYTE4MmIwZDFkMTI4Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5Y2ZmZDg2MTVmZDU5NjMxYTUxOGQ5NzZkYjVhNTZjNmQxMDVjNmI0In0=','2018-06-27 12:48:01.228000'),('geq63059fbucy3rjq4eofabpik7ri5qp','MWJmYzM3ZWM4Mjg5ZDk3NzFmOGIxOGZlYWYxYzNmNmVlZTFjMTcwYTp7Il9hdXRoX3VzZXJfaWQiOiIyNzEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijg0ODQzNDZiMGRmNDdmYzdjZjgxNDUyNGFlNmNjOGY4YzUzZmQxY2IifQ==','2018-07-12 14:37:26.031000'),('k8422p16c1qwyt91tqhc5d6jripw4bnd','MTc3M2E2NWQxODk3ZWJlZDA4MWM3YWRkZWI2NzBlYWU2ZjlkZjk2Njp7Il9hdXRoX3VzZXJfaWQiOiIxMDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwZGQyZGYyYjYxM2M0Y2Y3ZWE0NDBkZGYzNDc4MTYxODRmYTQxMDIifQ==','2018-07-02 09:54:25.391000'),('qhtr9gobbiptvmazjiur7n6yo4tsqxno','Y2JjNDUzOGFjY2E3YjExOTAwZjgzMTI4MTRjYTE4MmIwZDFkMTI4Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5Y2ZmZDg2MTVmZDU5NjMxYTUxOGQ5NzZkYjVhNTZjNmQxMDVjNmI0In0=','2018-06-26 14:26:34.078000');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epita_attendance`
--

DROP TABLE IF EXISTS `epita_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epita_attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL,
  `file_upload` varchar(100) DEFAULT NULL,
  `upload_time` datetime(6) DEFAULT NULL,
  `schedule_id_id` int(11) NOT NULL,
  `student_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `epita_attendance_schedule_id_id_8531aff9_fk_epita_schedule_id` (`schedule_id_id`),
  KEY `epita_attendance_student_id_id_f44bdece_fk_epita_student_id` (`student_id_id`),
  CONSTRAINT `epita_attendance_schedule_id_id_8531aff9_fk_epita_schedule_id` FOREIGN KEY (`schedule_id_id`) REFERENCES `epita_schedule` (`id`),
  CONSTRAINT `epita_attendance_student_id_id_f44bdece_fk_epita_student_id` FOREIGN KEY (`student_id_id`) REFERENCES `epita_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1341 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epita_attendance`
--

LOCK TABLES `epita_attendance` WRITE;
/*!40000 ALTER TABLE `epita_attendance` DISABLE KEYS */;
INSERT INTO `epita_attendance` VALUES (1,2,'',NULL,1,1),(2,2,'',NULL,1,2),(3,2,'',NULL,1,3),(4,2,'',NULL,1,4),(5,2,'',NULL,1,5),(6,2,'',NULL,1,6),(7,2,'',NULL,1,7),(8,2,'',NULL,1,8),(9,2,'',NULL,1,9),(10,2,'',NULL,1,10),(11,2,'',NULL,1,11),(12,2,'',NULL,1,12),(13,2,'',NULL,1,13),(14,2,'',NULL,1,14),(15,2,'',NULL,1,15),(16,2,'',NULL,1,16),(17,2,'',NULL,1,17),(18,2,'',NULL,1,18),(19,2,'',NULL,1,19),(20,2,'',NULL,1,20),(21,2,'',NULL,1,21),(22,2,'',NULL,1,22),(23,2,'',NULL,1,23),(24,2,'',NULL,1,24),(25,2,'',NULL,1,25),(26,2,'',NULL,1,26),(27,2,'',NULL,1,27),(28,2,'',NULL,1,28),(29,2,'',NULL,1,29),(30,2,'',NULL,1,30),(31,2,'',NULL,1,31),(32,2,'',NULL,1,32),(33,2,'',NULL,1,33),(34,2,'',NULL,1,34),(35,2,'',NULL,1,35),(36,2,'',NULL,1,36),(37,2,'',NULL,1,37),(38,2,'',NULL,1,38),(39,2,'',NULL,1,39),(40,2,'',NULL,1,40),(41,2,'',NULL,1,41),(42,2,'',NULL,1,42),(43,2,'',NULL,1,43),(44,2,'',NULL,1,44),(45,2,'',NULL,1,45),(46,2,'',NULL,1,46),(47,2,'',NULL,1,47),(48,2,'',NULL,1,48),(49,2,'',NULL,1,49),(50,2,'',NULL,1,50),(51,2,'',NULL,1,51),(52,2,'',NULL,1,52),(53,2,'',NULL,1,53),(54,2,'',NULL,1,54),(55,2,'',NULL,1,55),(56,2,'',NULL,1,56),(57,2,'',NULL,1,57),(58,2,'',NULL,1,58),(59,2,'',NULL,1,59),(60,2,'',NULL,1,60),(61,2,'',NULL,1,61),(62,2,'',NULL,1,62),(63,2,'',NULL,1,63),(64,2,'',NULL,1,64),(65,2,'',NULL,1,65),(66,2,'',NULL,1,66),(67,2,'',NULL,1,67),(68,2,'',NULL,1,68),(69,2,'',NULL,1,69),(70,2,'',NULL,1,70),(71,2,'',NULL,1,71),(72,2,'',NULL,1,72),(73,2,'',NULL,1,73),(74,2,'',NULL,1,74),(75,2,'',NULL,1,75),(76,2,'',NULL,1,76),(77,2,'',NULL,1,77),(78,2,'',NULL,1,78),(79,2,'',NULL,1,79),(80,2,'',NULL,1,80),(81,2,'',NULL,1,81),(82,2,'',NULL,1,82),(83,2,'',NULL,1,83),(84,2,'',NULL,1,84),(85,2,'',NULL,1,85),(86,2,'',NULL,1,86),(87,2,'',NULL,1,87),(88,2,'',NULL,1,88),(89,2,'',NULL,1,89),(90,2,'',NULL,1,90),(91,2,'',NULL,1,91),(92,2,'',NULL,1,92),(93,2,'',NULL,1,93),(94,2,'',NULL,1,94),(95,2,'',NULL,1,95),(96,2,'',NULL,1,96),(97,2,'',NULL,1,97),(98,2,'',NULL,1,98),(99,2,'',NULL,1,99),(100,2,'',NULL,1,100),(101,1,'',NULL,1,101),(102,2,'',NULL,1,102),(103,2,'',NULL,1,103),(104,2,'',NULL,1,104),(105,2,'',NULL,1,105),(106,2,'',NULL,1,106),(107,2,'',NULL,1,107),(108,2,'',NULL,1,108),(109,2,'',NULL,1,109),(110,2,'',NULL,1,110),(111,2,'',NULL,1,111),(112,2,'',NULL,1,112),(113,2,'',NULL,1,113),(114,2,'',NULL,1,114),(115,2,'',NULL,1,115),(116,2,'',NULL,1,116),(117,2,'',NULL,1,117),(118,2,'',NULL,1,118),(119,2,'',NULL,1,119),(120,2,'',NULL,1,120),(121,2,'',NULL,1,121),(122,2,'',NULL,1,122),(123,2,'',NULL,1,123),(124,2,'',NULL,1,124),(125,2,'',NULL,1,125),(126,2,'',NULL,1,126),(127,2,'',NULL,1,127),(128,2,'',NULL,1,128),(129,2,'',NULL,1,129),(130,2,'',NULL,1,130),(131,2,'',NULL,1,131),(132,2,'',NULL,1,132),(133,2,'',NULL,1,133),(134,2,'',NULL,1,134),(135,2,'',NULL,2,1),(136,2,'',NULL,2,2),(137,2,'',NULL,2,3),(138,2,'',NULL,2,4),(139,2,'',NULL,2,5),(140,2,'',NULL,2,6),(141,2,'',NULL,2,7),(142,2,'',NULL,2,8),(143,2,'',NULL,2,9),(144,2,'',NULL,2,10),(145,2,'',NULL,2,11),(146,2,'',NULL,2,12),(147,2,'',NULL,2,13),(148,2,'',NULL,2,14),(149,2,'',NULL,2,15),(150,2,'',NULL,2,16),(151,2,'',NULL,2,17),(152,2,'',NULL,2,18),(153,2,'',NULL,2,19),(154,2,'',NULL,2,20),(155,2,'',NULL,2,21),(156,2,'',NULL,2,22),(157,2,'',NULL,2,23),(158,2,'',NULL,2,24),(159,2,'',NULL,2,25),(160,2,'',NULL,2,26),(161,2,'',NULL,2,27),(162,2,'',NULL,2,28),(163,2,'',NULL,2,29),(164,2,'',NULL,2,30),(165,2,'',NULL,2,31),(166,2,'',NULL,2,32),(167,2,'',NULL,2,33),(168,2,'',NULL,2,34),(169,2,'',NULL,2,35),(170,2,'',NULL,2,36),(171,2,'',NULL,2,37),(172,2,'',NULL,2,38),(173,2,'',NULL,2,39),(174,2,'',NULL,2,40),(175,2,'',NULL,2,41),(176,2,'',NULL,2,42),(177,2,'',NULL,2,43),(178,2,'',NULL,2,44),(179,2,'',NULL,2,45),(180,2,'',NULL,2,46),(181,2,'',NULL,2,47),(182,2,'',NULL,2,48),(183,2,'',NULL,2,49),(184,2,'',NULL,2,50),(185,2,'',NULL,2,51),(186,2,'',NULL,2,52),(187,2,'',NULL,2,53),(188,2,'',NULL,2,54),(189,2,'',NULL,2,55),(190,2,'',NULL,2,56),(191,2,'',NULL,2,57),(192,2,'',NULL,2,58),(193,2,'',NULL,2,59),(194,2,'',NULL,2,60),(195,2,'',NULL,2,61),(196,2,'',NULL,2,62),(197,2,'',NULL,2,63),(198,2,'',NULL,2,64),(199,2,'',NULL,2,65),(200,2,'',NULL,2,66),(201,2,'',NULL,2,67),(202,2,'',NULL,2,68),(203,2,'',NULL,2,69),(204,2,'',NULL,2,70),(205,2,'',NULL,2,71),(206,2,'',NULL,2,72),(207,2,'',NULL,2,73),(208,2,'',NULL,2,74),(209,2,'',NULL,2,75),(210,2,'',NULL,2,76),(211,2,'',NULL,2,77),(212,2,'',NULL,2,78),(213,2,'',NULL,2,79),(214,2,'',NULL,2,80),(215,2,'',NULL,2,81),(216,2,'',NULL,2,82),(217,2,'',NULL,2,83),(218,2,'',NULL,2,84),(219,2,'',NULL,2,85),(220,2,'',NULL,2,86),(221,2,'',NULL,2,87),(222,2,'',NULL,2,88),(223,2,'',NULL,2,89),(224,2,'',NULL,2,90),(225,2,'',NULL,2,91),(226,2,'',NULL,2,92),(227,2,'',NULL,2,93),(228,2,'',NULL,2,94),(229,2,'',NULL,2,95),(230,2,'',NULL,2,96),(231,2,'',NULL,2,97),(232,2,'',NULL,2,98),(233,2,'',NULL,2,99),(234,2,'',NULL,2,100),(235,2,'',NULL,2,101),(236,2,'',NULL,2,102),(237,2,'',NULL,2,103),(238,2,'',NULL,2,104),(239,2,'',NULL,2,105),(240,2,'',NULL,2,106),(241,2,'',NULL,2,107),(242,2,'',NULL,2,108),(243,2,'',NULL,2,109),(244,2,'',NULL,2,110),(245,2,'',NULL,2,111),(246,2,'',NULL,2,112),(247,2,'',NULL,2,113),(248,2,'',NULL,2,114),(249,2,'',NULL,2,115),(250,2,'',NULL,2,116),(251,2,'',NULL,2,117),(252,2,'',NULL,2,118),(253,2,'',NULL,2,119),(254,2,'',NULL,2,120),(255,2,'',NULL,2,121),(256,2,'',NULL,2,122),(257,2,'',NULL,2,123),(258,2,'',NULL,2,124),(259,2,'',NULL,2,125),(260,2,'',NULL,2,126),(261,2,'',NULL,2,127),(262,2,'',NULL,2,128),(263,2,'',NULL,2,129),(264,2,'',NULL,2,130),(265,2,'',NULL,2,131),(266,2,'',NULL,2,132),(267,2,'',NULL,2,133),(268,2,'',NULL,2,134),(269,2,'',NULL,2,135),(270,2,'',NULL,2,136),(271,2,'',NULL,2,137),(272,2,'',NULL,2,138),(273,2,'',NULL,2,139),(274,2,'',NULL,2,140),(275,2,'',NULL,2,141),(276,2,'',NULL,2,142),(277,2,'',NULL,2,143),(278,2,'',NULL,2,144),(279,2,'',NULL,2,145),(280,2,'',NULL,2,146),(281,2,'',NULL,2,147),(282,2,'',NULL,2,148),(283,2,'',NULL,2,149),(284,2,'',NULL,2,150),(285,2,'',NULL,2,151),(286,2,'',NULL,2,152),(287,2,'',NULL,2,153),(288,2,'',NULL,2,154),(289,2,'',NULL,2,155),(290,2,'',NULL,2,156),(291,2,'',NULL,2,157),(292,2,'',NULL,2,158),(293,2,'',NULL,2,159),(294,2,'',NULL,2,160),(295,2,'',NULL,2,161),(296,2,'',NULL,2,162),(297,2,'',NULL,2,163),(298,2,'',NULL,2,164),(299,2,'',NULL,2,165),(300,2,'',NULL,2,166),(301,2,'',NULL,2,167),(302,2,'',NULL,2,168),(303,2,'',NULL,2,169),(304,2,'',NULL,2,170),(305,2,'',NULL,2,171),(306,2,'',NULL,2,172),(307,2,'',NULL,2,173),(308,2,'',NULL,2,174),(309,2,'',NULL,2,175),(310,2,'',NULL,2,176),(311,2,'',NULL,2,177),(312,2,'',NULL,2,178),(313,2,'',NULL,2,179),(314,2,'',NULL,2,180),(315,2,'',NULL,2,181),(316,2,'',NULL,2,182),(317,2,'',NULL,2,183),(318,2,'',NULL,2,184),(319,2,'',NULL,2,185),(320,2,'',NULL,2,186),(321,2,'',NULL,2,187),(322,2,'',NULL,2,188),(323,2,'',NULL,2,189),(324,2,'',NULL,2,190),(325,2,'',NULL,2,191),(326,2,'',NULL,2,192),(327,2,'',NULL,2,193),(328,2,'',NULL,2,194),(329,2,'',NULL,2,195),(330,2,'',NULL,2,196),(331,2,'',NULL,2,197),(332,2,'',NULL,2,198),(333,2,'',NULL,2,199),(334,2,'',NULL,2,200),(335,2,'',NULL,2,201),(336,2,'',NULL,2,202),(337,2,'',NULL,2,203),(338,2,'',NULL,2,204),(339,2,'',NULL,2,205),(340,2,'',NULL,2,206),(341,2,'',NULL,2,207),(342,2,'',NULL,2,208),(343,2,'',NULL,2,209),(344,2,'',NULL,2,210),(345,2,'',NULL,2,211),(346,2,'',NULL,2,212),(347,2,'',NULL,2,213),(348,2,'',NULL,2,214),(349,2,'',NULL,2,215),(350,2,'',NULL,2,216),(351,2,'',NULL,2,217),(352,2,'',NULL,2,218),(353,2,'',NULL,2,219),(354,2,'',NULL,2,220),(355,2,'',NULL,2,221),(356,2,'',NULL,2,222),(357,2,'',NULL,2,223),(358,2,'',NULL,2,224),(359,2,'',NULL,2,225),(360,2,'',NULL,2,226),(361,2,'',NULL,2,227),(362,2,'',NULL,2,228),(363,2,'',NULL,2,229),(364,2,'',NULL,2,230),(365,2,'',NULL,2,231),(366,2,'',NULL,2,232),(367,2,'',NULL,2,233),(368,2,'',NULL,2,234),(369,2,'',NULL,2,235),(370,2,'',NULL,2,236),(371,2,'',NULL,2,237),(372,2,'',NULL,2,238),(373,2,'',NULL,2,239),(374,2,'',NULL,2,240),(375,2,'',NULL,2,241),(376,2,'',NULL,2,242),(377,2,'',NULL,2,243),(378,2,'',NULL,2,244),(379,2,'',NULL,2,245),(380,2,'',NULL,2,246),(381,2,'',NULL,2,247),(382,2,'',NULL,2,248),(383,2,'',NULL,2,249),(384,2,'',NULL,2,250),(385,2,'',NULL,2,251),(386,2,'',NULL,2,252),(387,2,'',NULL,2,253),(388,2,'',NULL,2,254),(389,2,'',NULL,2,255),(390,2,'',NULL,2,256),(391,2,'',NULL,2,257),(392,2,'',NULL,2,258),(393,2,'',NULL,2,259),(394,2,'',NULL,2,260),(395,2,'',NULL,2,261),(396,2,'',NULL,2,262),(397,2,'',NULL,2,263),(398,2,'',NULL,2,264),(399,2,'',NULL,2,265),(400,2,'',NULL,2,266),(401,2,'',NULL,2,267),(402,2,'',NULL,2,268),(403,2,'',NULL,3,1),(404,2,'',NULL,3,2),(405,2,'',NULL,3,3),(406,2,'',NULL,3,4),(407,2,'',NULL,3,5),(408,2,'',NULL,3,6),(409,2,'',NULL,3,7),(410,2,'',NULL,3,8),(411,2,'',NULL,3,9),(412,2,'',NULL,3,10),(413,2,'',NULL,3,11),(414,2,'',NULL,3,12),(415,2,'',NULL,3,13),(416,2,'',NULL,3,14),(417,2,'',NULL,3,15),(418,2,'',NULL,3,16),(419,2,'',NULL,3,17),(420,2,'',NULL,3,18),(421,2,'',NULL,3,19),(422,2,'',NULL,3,20),(423,2,'',NULL,3,21),(424,2,'',NULL,3,22),(425,2,'',NULL,3,23),(426,2,'',NULL,3,24),(427,2,'',NULL,3,25),(428,2,'',NULL,3,26),(429,2,'',NULL,3,27),(430,2,'',NULL,3,28),(431,2,'',NULL,3,29),(432,2,'',NULL,3,30),(433,2,'',NULL,3,31),(434,2,'',NULL,3,32),(435,2,'',NULL,3,33),(436,2,'',NULL,3,34),(437,2,'',NULL,3,35),(438,2,'',NULL,3,36),(439,2,'',NULL,3,37),(440,2,'',NULL,3,38),(441,2,'',NULL,3,39),(442,2,'',NULL,3,40),(443,2,'',NULL,3,41),(444,2,'',NULL,3,42),(445,2,'',NULL,3,43),(446,2,'',NULL,3,44),(447,2,'',NULL,3,45),(448,2,'',NULL,3,46),(449,2,'',NULL,3,47),(450,2,'',NULL,3,48),(451,2,'',NULL,3,49),(452,2,'',NULL,3,50),(453,2,'',NULL,3,51),(454,2,'',NULL,3,52),(455,2,'',NULL,3,53),(456,2,'',NULL,3,54),(457,2,'',NULL,3,55),(458,2,'',NULL,3,56),(459,2,'',NULL,3,57),(460,2,'',NULL,3,58),(461,2,'',NULL,3,59),(462,2,'',NULL,3,60),(463,2,'',NULL,3,61),(464,2,'',NULL,3,62),(465,2,'',NULL,3,63),(466,2,'',NULL,3,64),(467,2,'',NULL,3,65),(468,2,'',NULL,3,66),(469,2,'',NULL,3,67),(470,2,'',NULL,3,68),(471,2,'',NULL,3,69),(472,2,'',NULL,3,70),(473,2,'',NULL,3,71),(474,2,'',NULL,3,72),(475,2,'',NULL,3,73),(476,2,'',NULL,3,74),(477,2,'',NULL,3,75),(478,2,'',NULL,3,76),(479,2,'',NULL,3,77),(480,2,'',NULL,3,78),(481,2,'',NULL,3,79),(482,2,'',NULL,3,80),(483,2,'',NULL,3,81),(484,2,'',NULL,3,82),(485,2,'',NULL,3,83),(486,2,'',NULL,3,84),(487,2,'',NULL,3,85),(488,2,'',NULL,3,86),(489,2,'',NULL,3,87),(490,2,'',NULL,3,88),(491,2,'',NULL,3,89),(492,2,'',NULL,3,90),(493,2,'',NULL,3,91),(494,2,'',NULL,3,92),(495,2,'',NULL,3,93),(496,2,'',NULL,3,94),(497,2,'',NULL,3,95),(498,2,'',NULL,3,96),(499,2,'',NULL,3,97),(500,2,'',NULL,3,98),(501,2,'',NULL,3,99),(502,2,'',NULL,3,100),(503,2,'',NULL,3,101),(504,2,'',NULL,3,102),(505,2,'',NULL,3,103),(506,2,'',NULL,3,104),(507,2,'',NULL,3,105),(508,2,'',NULL,3,106),(509,2,'',NULL,3,107),(510,2,'',NULL,3,108),(511,2,'',NULL,3,109),(512,2,'',NULL,3,110),(513,2,'',NULL,3,111),(514,2,'',NULL,3,112),(515,2,'',NULL,3,113),(516,2,'',NULL,3,114),(517,2,'',NULL,3,115),(518,2,'',NULL,3,116),(519,2,'',NULL,3,117),(520,2,'',NULL,3,118),(521,2,'',NULL,3,119),(522,2,'',NULL,3,120),(523,2,'',NULL,3,121),(524,2,'',NULL,3,122),(525,2,'',NULL,3,123),(526,2,'',NULL,3,124),(527,2,'',NULL,3,125),(528,2,'',NULL,3,126),(529,2,'',NULL,3,127),(530,2,'',NULL,3,128),(531,2,'',NULL,3,129),(532,2,'',NULL,3,130),(533,2,'',NULL,3,131),(534,2,'',NULL,3,132),(535,2,'',NULL,3,133),(536,2,'',NULL,3,134),(537,2,'',NULL,3,135),(538,2,'',NULL,3,136),(539,2,'',NULL,3,137),(540,2,'',NULL,3,138),(541,2,'',NULL,3,139),(542,2,'',NULL,3,140),(543,2,'',NULL,3,141),(544,2,'',NULL,3,142),(545,2,'',NULL,3,143),(546,2,'',NULL,3,144),(547,2,'',NULL,3,145),(548,2,'',NULL,3,146),(549,2,'',NULL,3,147),(550,2,'',NULL,3,148),(551,2,'',NULL,3,149),(552,2,'',NULL,3,150),(553,2,'',NULL,3,151),(554,2,'',NULL,3,152),(555,2,'',NULL,3,153),(556,2,'',NULL,3,154),(557,2,'',NULL,3,155),(558,2,'',NULL,3,156),(559,2,'',NULL,3,157),(560,2,'',NULL,3,158),(561,2,'',NULL,3,159),(562,2,'',NULL,3,160),(563,2,'',NULL,3,161),(564,2,'',NULL,3,162),(565,2,'',NULL,3,163),(566,2,'',NULL,3,164),(567,2,'',NULL,3,165),(568,2,'',NULL,3,166),(569,2,'',NULL,3,167),(570,2,'',NULL,3,168),(571,2,'',NULL,3,169),(572,2,'',NULL,3,170),(573,2,'',NULL,3,171),(574,2,'',NULL,3,172),(575,2,'',NULL,3,173),(576,2,'',NULL,3,174),(577,2,'',NULL,3,175),(578,2,'',NULL,3,176),(579,2,'',NULL,3,177),(580,2,'',NULL,3,178),(581,2,'',NULL,3,179),(582,2,'',NULL,3,180),(583,2,'',NULL,3,181),(584,2,'',NULL,3,182),(585,2,'',NULL,3,183),(586,2,'',NULL,3,184),(587,2,'',NULL,3,185),(588,2,'',NULL,3,186),(589,2,'',NULL,3,187),(590,2,'',NULL,3,188),(591,2,'',NULL,3,189),(592,2,'',NULL,3,190),(593,2,'',NULL,3,191),(594,2,'',NULL,3,192),(595,2,'',NULL,3,193),(596,2,'',NULL,3,194),(597,2,'',NULL,3,195),(598,2,'',NULL,3,196),(599,2,'',NULL,3,197),(600,2,'',NULL,3,198),(601,2,'',NULL,3,199),(602,2,'',NULL,3,200),(603,2,'',NULL,3,201),(604,2,'',NULL,3,202),(605,2,'',NULL,3,203),(606,2,'',NULL,3,204),(607,2,'',NULL,3,205),(608,2,'',NULL,3,206),(609,2,'',NULL,3,207),(610,2,'',NULL,3,208),(611,2,'',NULL,3,209),(612,2,'',NULL,3,210),(613,2,'',NULL,3,211),(614,2,'',NULL,3,212),(615,2,'',NULL,3,213),(616,2,'',NULL,3,214),(617,2,'',NULL,3,215),(618,2,'',NULL,3,216),(619,2,'',NULL,3,217),(620,2,'',NULL,3,218),(621,2,'',NULL,3,219),(622,2,'',NULL,3,220),(623,2,'',NULL,3,221),(624,2,'',NULL,3,222),(625,2,'',NULL,3,223),(626,2,'',NULL,3,224),(627,2,'',NULL,3,225),(628,2,'',NULL,3,226),(629,2,'',NULL,3,227),(630,2,'',NULL,3,228),(631,2,'',NULL,3,229),(632,2,'',NULL,3,230),(633,2,'',NULL,3,231),(634,2,'',NULL,3,232),(635,2,'',NULL,3,233),(636,2,'',NULL,3,234),(637,2,'',NULL,3,235),(638,2,'',NULL,3,236),(639,2,'',NULL,3,237),(640,2,'',NULL,3,238),(641,2,'',NULL,3,239),(642,2,'',NULL,3,240),(643,2,'',NULL,3,241),(644,2,'',NULL,3,242),(645,2,'',NULL,3,243),(646,2,'',NULL,3,244),(647,2,'',NULL,3,245),(648,2,'',NULL,3,246),(649,2,'',NULL,3,247),(650,2,'',NULL,3,248),(651,2,'',NULL,3,249),(652,2,'',NULL,3,250),(653,2,'',NULL,3,251),(654,2,'',NULL,3,252),(655,2,'',NULL,3,253),(656,2,'',NULL,3,254),(657,2,'',NULL,3,255),(658,2,'',NULL,3,256),(659,2,'',NULL,3,257),(660,2,'',NULL,3,258),(661,2,'',NULL,3,259),(662,2,'',NULL,3,260),(663,2,'',NULL,3,261),(664,2,'',NULL,3,262),(665,2,'',NULL,3,263),(666,2,'',NULL,3,264),(667,2,'',NULL,3,265),(668,2,'',NULL,3,266),(669,2,'',NULL,3,267),(670,2,'',NULL,3,268),(671,2,'',NULL,4,1),(672,2,'',NULL,4,2),(673,2,'',NULL,4,3),(674,2,'',NULL,4,4),(675,2,'',NULL,4,5),(676,2,'',NULL,4,6),(677,2,'',NULL,4,7),(678,2,'',NULL,4,8),(679,2,'',NULL,4,9),(680,2,'',NULL,4,10),(681,2,'',NULL,4,11),(682,2,'',NULL,4,12),(683,2,'',NULL,4,13),(684,2,'',NULL,4,14),(685,2,'',NULL,4,15),(686,2,'',NULL,4,16),(687,2,'',NULL,4,17),(688,2,'',NULL,4,18),(689,2,'',NULL,4,19),(690,2,'',NULL,4,20),(691,2,'',NULL,4,21),(692,2,'',NULL,4,22),(693,2,'',NULL,4,23),(694,2,'',NULL,4,24),(695,2,'',NULL,4,25),(696,2,'',NULL,4,26),(697,2,'',NULL,4,27),(698,2,'',NULL,4,28),(699,2,'',NULL,4,29),(700,2,'',NULL,4,30),(701,2,'',NULL,4,31),(702,2,'',NULL,4,32),(703,2,'',NULL,4,33),(704,2,'',NULL,4,34),(705,2,'',NULL,4,35),(706,2,'',NULL,4,36),(707,2,'',NULL,4,37),(708,2,'',NULL,4,38),(709,2,'',NULL,4,39),(710,2,'',NULL,4,40),(711,2,'',NULL,4,41),(712,2,'',NULL,4,42),(713,2,'',NULL,4,43),(714,2,'',NULL,4,44),(715,2,'',NULL,4,45),(716,2,'',NULL,4,46),(717,2,'',NULL,4,47),(718,2,'',NULL,4,48),(719,2,'',NULL,4,49),(720,2,'',NULL,4,50),(721,2,'',NULL,4,51),(722,2,'',NULL,4,52),(723,2,'',NULL,4,53),(724,2,'',NULL,4,54),(725,2,'',NULL,4,55),(726,2,'',NULL,4,56),(727,2,'',NULL,4,57),(728,2,'',NULL,4,58),(729,2,'',NULL,4,59),(730,2,'',NULL,4,60),(731,2,'',NULL,4,61),(732,2,'',NULL,4,62),(733,2,'',NULL,4,63),(734,2,'',NULL,4,64),(735,2,'',NULL,4,65),(736,2,'',NULL,4,66),(737,2,'',NULL,4,67),(738,2,'',NULL,4,68),(739,2,'',NULL,4,69),(740,2,'',NULL,4,70),(741,2,'',NULL,4,71),(742,2,'',NULL,4,72),(743,2,'',NULL,4,73),(744,2,'',NULL,4,74),(745,2,'',NULL,4,75),(746,2,'',NULL,4,76),(747,2,'',NULL,4,77),(748,2,'',NULL,4,78),(749,2,'',NULL,4,79),(750,2,'',NULL,4,80),(751,2,'',NULL,4,81),(752,2,'',NULL,4,82),(753,2,'',NULL,4,83),(754,2,'',NULL,4,84),(755,2,'',NULL,4,85),(756,2,'',NULL,4,86),(757,2,'',NULL,4,87),(758,2,'',NULL,4,88),(759,2,'',NULL,4,89),(760,2,'',NULL,4,90),(761,2,'',NULL,4,91),(762,2,'',NULL,4,92),(763,2,'',NULL,4,93),(764,2,'',NULL,4,94),(765,2,'',NULL,4,95),(766,2,'',NULL,4,96),(767,2,'',NULL,4,97),(768,2,'',NULL,4,98),(769,2,'',NULL,4,99),(770,2,'',NULL,4,100),(771,2,'',NULL,4,101),(772,2,'',NULL,4,102),(773,2,'',NULL,4,103),(774,2,'',NULL,4,104),(775,2,'',NULL,4,105),(776,2,'',NULL,4,106),(777,2,'',NULL,4,107),(778,2,'',NULL,4,108),(779,2,'',NULL,4,109),(780,2,'',NULL,4,110),(781,2,'',NULL,4,111),(782,2,'',NULL,4,112),(783,2,'',NULL,4,113),(784,2,'',NULL,4,114),(785,2,'',NULL,4,115),(786,2,'',NULL,4,116),(787,2,'',NULL,4,117),(788,2,'',NULL,4,118),(789,2,'',NULL,4,119),(790,2,'',NULL,4,120),(791,2,'',NULL,4,121),(792,2,'',NULL,4,122),(793,2,'',NULL,4,123),(794,2,'',NULL,4,124),(795,2,'',NULL,4,125),(796,2,'',NULL,4,126),(797,2,'',NULL,4,127),(798,2,'',NULL,4,128),(799,2,'',NULL,4,129),(800,2,'',NULL,4,130),(801,2,'',NULL,4,131),(802,2,'',NULL,4,132),(803,2,'',NULL,4,133),(804,2,'',NULL,4,134),(805,2,'',NULL,4,135),(806,2,'',NULL,4,136),(807,2,'',NULL,4,137),(808,2,'',NULL,4,138),(809,2,'',NULL,4,139),(810,2,'',NULL,4,140),(811,2,'',NULL,4,141),(812,2,'',NULL,4,142),(813,2,'',NULL,4,143),(814,2,'',NULL,4,144),(815,2,'',NULL,4,145),(816,2,'',NULL,4,146),(817,2,'',NULL,4,147),(818,2,'',NULL,4,148),(819,2,'',NULL,4,149),(820,2,'',NULL,4,150),(821,2,'',NULL,4,151),(822,2,'',NULL,4,152),(823,2,'',NULL,4,153),(824,2,'',NULL,4,154),(825,2,'',NULL,4,155),(826,2,'',NULL,4,156),(827,2,'',NULL,4,157),(828,2,'',NULL,4,158),(829,2,'',NULL,4,159),(830,2,'',NULL,4,160),(831,2,'',NULL,4,161),(832,2,'',NULL,4,162),(833,2,'',NULL,4,163),(834,2,'',NULL,4,164),(835,2,'',NULL,4,165),(836,2,'',NULL,4,166),(837,2,'',NULL,4,167),(838,2,'',NULL,4,168),(839,2,'',NULL,4,169),(840,2,'',NULL,4,170),(841,2,'',NULL,4,171),(842,2,'',NULL,4,172),(843,2,'',NULL,4,173),(844,2,'',NULL,4,174),(845,2,'',NULL,4,175),(846,2,'',NULL,4,176),(847,2,'',NULL,4,177),(848,2,'',NULL,4,178),(849,2,'',NULL,4,179),(850,2,'',NULL,4,180),(851,2,'',NULL,4,181),(852,2,'',NULL,4,182),(853,2,'',NULL,4,183),(854,2,'',NULL,4,184),(855,2,'',NULL,4,185),(856,2,'',NULL,4,186),(857,2,'',NULL,4,187),(858,2,'',NULL,4,188),(859,2,'',NULL,4,189),(860,2,'',NULL,4,190),(861,2,'',NULL,4,191),(862,2,'',NULL,4,192),(863,2,'',NULL,4,193),(864,2,'',NULL,4,194),(865,2,'',NULL,4,195),(866,2,'',NULL,4,196),(867,2,'',NULL,4,197),(868,2,'',NULL,4,198),(869,2,'',NULL,4,199),(870,2,'',NULL,4,200),(871,2,'',NULL,4,201),(872,2,'',NULL,4,202),(873,2,'',NULL,4,203),(874,2,'',NULL,4,204),(875,2,'',NULL,4,205),(876,2,'',NULL,4,206),(877,2,'',NULL,4,207),(878,2,'',NULL,4,208),(879,2,'',NULL,4,209),(880,2,'',NULL,4,210),(881,2,'',NULL,4,211),(882,2,'',NULL,4,212),(883,2,'',NULL,4,213),(884,2,'',NULL,4,214),(885,2,'',NULL,4,215),(886,2,'',NULL,4,216),(887,2,'',NULL,4,217),(888,2,'',NULL,4,218),(889,2,'',NULL,4,219),(890,2,'',NULL,4,220),(891,2,'',NULL,4,221),(892,2,'',NULL,4,222),(893,2,'',NULL,4,223),(894,2,'',NULL,4,224),(895,2,'',NULL,4,225),(896,2,'',NULL,4,226),(897,2,'',NULL,4,227),(898,2,'',NULL,4,228),(899,2,'',NULL,4,229),(900,2,'',NULL,4,230),(901,2,'',NULL,4,231),(902,2,'',NULL,4,232),(903,2,'',NULL,4,233),(904,2,'',NULL,4,234),(905,2,'',NULL,4,235),(906,2,'',NULL,4,236),(907,2,'',NULL,4,237),(908,2,'',NULL,4,238),(909,2,'',NULL,4,239),(910,2,'',NULL,4,240),(911,2,'',NULL,4,241),(912,2,'',NULL,4,242),(913,2,'',NULL,4,243),(914,2,'',NULL,4,244),(915,2,'',NULL,4,245),(916,2,'',NULL,4,246),(917,2,'',NULL,4,247),(918,2,'',NULL,4,248),(919,2,'',NULL,4,249),(920,2,'',NULL,4,250),(921,2,'',NULL,4,251),(922,2,'',NULL,4,252),(923,2,'',NULL,4,253),(924,2,'',NULL,5,1),(925,2,'',NULL,4,254),(926,2,'',NULL,5,2),(927,2,'',NULL,5,3),(928,2,'',NULL,4,255),(929,2,'',NULL,4,256),(930,2,'',NULL,5,4),(931,2,'',NULL,4,257),(932,2,'',NULL,5,5),(933,2,'',NULL,4,258),(934,2,'',NULL,5,6),(935,2,'',NULL,4,259),(936,2,'',NULL,5,7),(937,2,'',NULL,4,260),(938,2,'',NULL,5,8),(939,2,'',NULL,4,261),(940,2,'',NULL,5,9),(941,2,'',NULL,4,262),(942,2,'',NULL,5,10),(943,2,'',NULL,4,263),(944,2,'',NULL,5,11),(945,2,'',NULL,4,264),(946,2,'',NULL,5,12),(947,2,'',NULL,4,265),(948,2,'',NULL,5,13),(949,2,'',NULL,4,266),(950,2,'',NULL,5,14),(951,2,'',NULL,4,267),(952,2,'',NULL,5,15),(953,2,'',NULL,4,268),(954,2,'',NULL,5,16),(955,2,'',NULL,5,17),(956,2,'',NULL,5,18),(957,2,'',NULL,5,19),(958,2,'',NULL,5,20),(959,2,'',NULL,5,21),(960,2,'',NULL,5,22),(961,2,'',NULL,5,23),(962,2,'',NULL,5,24),(963,2,'',NULL,5,25),(964,2,'',NULL,5,26),(965,2,'',NULL,5,27),(966,2,'',NULL,5,28),(967,2,'',NULL,5,29),(968,2,'',NULL,5,30),(969,2,'',NULL,5,31),(970,2,'',NULL,5,32),(971,2,'',NULL,5,33),(972,2,'',NULL,5,34),(973,2,'',NULL,5,35),(974,2,'',NULL,5,36),(975,2,'',NULL,5,37),(976,2,'',NULL,5,38),(977,2,'',NULL,5,39),(978,2,'',NULL,5,40),(979,2,'',NULL,5,41),(980,2,'',NULL,5,42),(981,2,'',NULL,5,43),(982,2,'',NULL,5,44),(983,2,'',NULL,5,45),(984,2,'',NULL,5,46),(985,2,'',NULL,5,47),(986,2,'',NULL,5,48),(987,2,'',NULL,5,49),(988,2,'',NULL,5,50),(989,2,'',NULL,5,51),(990,2,'',NULL,5,52),(991,2,'',NULL,5,53),(992,2,'',NULL,5,54),(993,2,'',NULL,5,55),(994,2,'',NULL,5,56),(995,2,'',NULL,5,57),(996,2,'',NULL,5,58),(997,2,'',NULL,5,59),(998,2,'',NULL,5,60),(999,2,'',NULL,5,61),(1000,2,'',NULL,5,62),(1001,2,'',NULL,5,63),(1002,2,'',NULL,5,64),(1003,2,'',NULL,5,65),(1004,2,'',NULL,5,66),(1005,2,'',NULL,5,67),(1006,2,'',NULL,5,68),(1007,2,'',NULL,5,69),(1008,2,'',NULL,5,70),(1009,2,'',NULL,5,71),(1010,2,'',NULL,5,72),(1011,2,'',NULL,5,73),(1012,2,'',NULL,5,74),(1013,2,'',NULL,5,75),(1014,2,'',NULL,5,76),(1015,2,'',NULL,5,77),(1016,2,'',NULL,5,78),(1017,2,'',NULL,5,79),(1018,2,'',NULL,5,80),(1019,2,'',NULL,5,81),(1020,2,'',NULL,5,82),(1021,2,'',NULL,5,83),(1022,2,'',NULL,5,84),(1023,2,'',NULL,5,85),(1024,2,'',NULL,5,86),(1025,2,'',NULL,5,87),(1026,2,'',NULL,5,88),(1027,2,'',NULL,5,89),(1028,2,'',NULL,5,90),(1029,2,'',NULL,5,91),(1030,2,'',NULL,5,92),(1031,2,'',NULL,5,93),(1032,2,'',NULL,5,94),(1033,2,'',NULL,5,95),(1034,2,'',NULL,5,96),(1035,2,'',NULL,5,97),(1036,2,'',NULL,5,98),(1037,2,'',NULL,5,99),(1038,2,'',NULL,5,100),(1039,1,'',NULL,5,101),(1040,2,'',NULL,5,102),(1041,2,'',NULL,5,103),(1042,2,'',NULL,5,104),(1043,2,'',NULL,5,105),(1044,2,'',NULL,5,106),(1045,2,'',NULL,5,107),(1046,2,'',NULL,5,108),(1047,2,'',NULL,5,109),(1048,2,'',NULL,5,110),(1049,2,'',NULL,5,111),(1050,2,'',NULL,5,112),(1051,2,'',NULL,5,113),(1052,2,'',NULL,5,114),(1053,2,'',NULL,5,115),(1054,2,'',NULL,5,116),(1055,2,'',NULL,5,117),(1056,2,'',NULL,5,118),(1057,2,'',NULL,5,119),(1058,2,'',NULL,5,120),(1059,2,'',NULL,5,121),(1060,2,'',NULL,5,122),(1061,2,'',NULL,5,123),(1062,2,'',NULL,5,124),(1063,2,'',NULL,5,125),(1064,2,'',NULL,5,126),(1065,2,'',NULL,5,127),(1066,2,'',NULL,5,128),(1067,2,'',NULL,5,129),(1068,2,'',NULL,5,130),(1069,2,'',NULL,5,131),(1070,2,'',NULL,5,132),(1071,2,'',NULL,5,133),(1072,2,'',NULL,5,134),(1073,2,'',NULL,5,135),(1074,2,'',NULL,5,136),(1075,2,'',NULL,5,137),(1076,2,'',NULL,5,138),(1077,2,'',NULL,5,139),(1078,2,'',NULL,5,140),(1079,2,'',NULL,5,141),(1080,2,'',NULL,5,142),(1081,2,'',NULL,5,143),(1082,2,'',NULL,5,144),(1083,2,'',NULL,5,145),(1084,2,'',NULL,5,146),(1085,2,'',NULL,5,147),(1086,2,'',NULL,5,148),(1087,2,'',NULL,5,149),(1088,2,'',NULL,5,150),(1089,2,'',NULL,5,151),(1090,2,'',NULL,5,152),(1091,2,'',NULL,5,153),(1092,2,'',NULL,5,154),(1093,2,'',NULL,5,155),(1094,2,'',NULL,5,156),(1095,2,'',NULL,5,157),(1096,2,'',NULL,5,158),(1097,2,'',NULL,5,159),(1098,2,'',NULL,5,160),(1099,2,'',NULL,5,161),(1100,2,'',NULL,5,162),(1101,2,'',NULL,5,163),(1102,2,'',NULL,5,164),(1103,2,'',NULL,5,165),(1104,2,'',NULL,5,166),(1105,2,'',NULL,5,167),(1106,2,'',NULL,5,168),(1107,2,'',NULL,5,169),(1108,2,'',NULL,5,170),(1109,2,'',NULL,5,171),(1110,2,'',NULL,5,172),(1111,2,'',NULL,5,173),(1112,2,'',NULL,5,174),(1113,2,'',NULL,5,175),(1114,2,'',NULL,5,176),(1115,2,'',NULL,5,177),(1116,2,'',NULL,5,178),(1117,2,'',NULL,5,179),(1118,2,'',NULL,5,180),(1119,2,'',NULL,5,181),(1120,2,'',NULL,5,182),(1121,2,'',NULL,5,183),(1122,2,'',NULL,5,184),(1123,2,'',NULL,5,185),(1124,2,'',NULL,5,186),(1125,2,'',NULL,5,187),(1126,2,'',NULL,5,188),(1127,2,'',NULL,5,189),(1128,2,'',NULL,5,190),(1129,2,'',NULL,5,191),(1130,2,'',NULL,5,192),(1131,2,'',NULL,5,193),(1132,2,'',NULL,5,194),(1133,2,'',NULL,5,195),(1134,2,'',NULL,5,196),(1135,2,'',NULL,5,197),(1136,2,'',NULL,5,198),(1137,2,'',NULL,5,199),(1138,2,'',NULL,5,200),(1139,2,'',NULL,5,201),(1140,2,'',NULL,5,202),(1141,2,'',NULL,5,203),(1142,2,'',NULL,5,204),(1143,2,'',NULL,5,205),(1144,2,'',NULL,5,206),(1145,2,'',NULL,5,207),(1146,2,'',NULL,5,208),(1147,2,'',NULL,5,209),(1148,2,'',NULL,5,210),(1149,2,'',NULL,5,211),(1150,2,'',NULL,5,212),(1151,2,'',NULL,5,213),(1152,2,'',NULL,5,214),(1153,2,'',NULL,5,215),(1154,2,'',NULL,5,216),(1155,2,'',NULL,5,217),(1156,2,'',NULL,5,218),(1157,2,'',NULL,5,219),(1158,2,'',NULL,5,220),(1159,2,'',NULL,5,221),(1160,2,'',NULL,5,222),(1161,2,'',NULL,5,223),(1162,2,'',NULL,5,224),(1163,2,'',NULL,5,225),(1164,2,'',NULL,5,226),(1165,2,'',NULL,5,227),(1166,2,'',NULL,5,228),(1167,2,'',NULL,5,229),(1168,2,'',NULL,5,230),(1169,2,'',NULL,5,231),(1170,2,'',NULL,5,232),(1171,2,'',NULL,5,233),(1172,2,'',NULL,5,234),(1173,2,'',NULL,5,235),(1174,2,'',NULL,5,236),(1175,2,'',NULL,5,237),(1176,2,'',NULL,5,238),(1177,2,'',NULL,5,239),(1178,2,'',NULL,5,240),(1179,2,'',NULL,5,241),(1180,2,'',NULL,5,242),(1181,2,'',NULL,5,243),(1182,2,'',NULL,5,244),(1183,2,'',NULL,5,245),(1184,2,'',NULL,5,246),(1185,2,'',NULL,5,247),(1186,2,'',NULL,5,248),(1187,2,'',NULL,5,249),(1188,2,'',NULL,5,250),(1189,2,'',NULL,5,251),(1190,2,'',NULL,5,252),(1191,2,'',NULL,5,253),(1192,2,'',NULL,5,254),(1193,2,'',NULL,5,255),(1194,2,'',NULL,5,256),(1195,2,'',NULL,5,257),(1196,2,'',NULL,5,258),(1197,2,'',NULL,5,259),(1198,2,'',NULL,5,260),(1199,2,'',NULL,5,261),(1200,2,'',NULL,5,262),(1201,2,'',NULL,5,263),(1202,2,'',NULL,5,264),(1203,2,'',NULL,5,265),(1204,2,'',NULL,5,266),(1205,2,'',NULL,5,267),(1206,2,'',NULL,5,268),(1207,2,'',NULL,6,1),(1208,2,'',NULL,6,2),(1209,2,'',NULL,6,3),(1210,1,'',NULL,6,4),(1211,2,'',NULL,6,5),(1212,2,'',NULL,6,6),(1213,2,'',NULL,6,7),(1214,2,'',NULL,6,8),(1215,2,'',NULL,6,9),(1216,2,'',NULL,6,10),(1217,1,'',NULL,6,11),(1218,2,'',NULL,6,12),(1219,2,'',NULL,6,13),(1220,2,'',NULL,6,14),(1221,2,'',NULL,6,15),(1222,2,'',NULL,6,16),(1223,2,'',NULL,6,17),(1224,2,'',NULL,6,18),(1225,2,'',NULL,6,19),(1226,2,'',NULL,6,20),(1227,2,'',NULL,6,21),(1228,2,'',NULL,6,22),(1229,2,'',NULL,6,23),(1230,2,'',NULL,6,24),(1231,2,'',NULL,6,25),(1232,2,'',NULL,6,26),(1233,2,'',NULL,6,27),(1234,2,'',NULL,6,28),(1235,2,'',NULL,6,29),(1236,2,'',NULL,6,30),(1237,2,'',NULL,6,31),(1238,2,'',NULL,6,32),(1239,2,'',NULL,6,33),(1240,2,'',NULL,6,34),(1241,2,'',NULL,6,35),(1242,2,'',NULL,6,36),(1243,2,'',NULL,6,37),(1244,2,'',NULL,6,38),(1245,2,'',NULL,6,39),(1246,2,'',NULL,6,40),(1247,2,'',NULL,6,41),(1248,2,'',NULL,6,42),(1249,2,'',NULL,6,43),(1250,2,'',NULL,6,44),(1251,2,'',NULL,6,45),(1252,2,'',NULL,6,46),(1253,2,'',NULL,6,47),(1254,2,'',NULL,6,48),(1255,2,'',NULL,6,49),(1256,2,'',NULL,6,50),(1257,2,'',NULL,6,51),(1258,2,'',NULL,6,52),(1259,2,'',NULL,6,53),(1260,2,'',NULL,6,54),(1261,2,'',NULL,6,55),(1262,2,'',NULL,6,56),(1263,2,'',NULL,6,57),(1264,2,'',NULL,6,58),(1265,2,'',NULL,6,59),(1266,2,'',NULL,6,60),(1267,2,'',NULL,6,61),(1268,2,'',NULL,6,62),(1269,2,'',NULL,6,63),(1270,2,'',NULL,6,64),(1271,2,'',NULL,6,65),(1272,2,'',NULL,6,66),(1273,2,'',NULL,6,67),(1274,2,'',NULL,6,68),(1275,2,'',NULL,6,69),(1276,2,'',NULL,6,70),(1277,2,'',NULL,6,71),(1278,2,'',NULL,6,72),(1279,2,'',NULL,6,73),(1280,2,'',NULL,6,74),(1281,2,'',NULL,6,75),(1282,2,'',NULL,6,76),(1283,2,'',NULL,6,77),(1284,2,'',NULL,6,78),(1285,2,'',NULL,6,79),(1286,2,'',NULL,6,80),(1287,2,'',NULL,6,81),(1288,2,'',NULL,6,82),(1289,2,'',NULL,6,83),(1290,2,'',NULL,6,84),(1291,2,'',NULL,6,85),(1292,2,'',NULL,6,86),(1293,2,'',NULL,6,87),(1294,2,'',NULL,6,88),(1295,2,'',NULL,6,89),(1296,2,'',NULL,6,90),(1297,2,'',NULL,6,91),(1298,2,'',NULL,6,92),(1299,2,'',NULL,6,93),(1300,2,'',NULL,6,94),(1301,2,'',NULL,6,95),(1302,2,'',NULL,6,96),(1303,2,'',NULL,6,97),(1304,2,'',NULL,6,98),(1305,2,'',NULL,6,99),(1306,2,'',NULL,6,100),(1307,2,'',NULL,6,101),(1308,2,'',NULL,6,102),(1309,2,'',NULL,6,103),(1310,2,'',NULL,6,104),(1311,2,'',NULL,6,105),(1312,2,'',NULL,6,106),(1313,2,'',NULL,6,107),(1314,2,'',NULL,6,108),(1315,2,'',NULL,6,109),(1316,2,'',NULL,6,110),(1317,2,'',NULL,6,111),(1318,2,'',NULL,6,112),(1319,2,'',NULL,6,113),(1320,2,'',NULL,6,114),(1321,2,'',NULL,6,115),(1322,2,'',NULL,6,116),(1323,2,'',NULL,6,117),(1324,2,'',NULL,6,118),(1325,2,'',NULL,6,119),(1326,2,'',NULL,6,120),(1327,2,'',NULL,6,121),(1328,2,'',NULL,6,122),(1329,2,'',NULL,6,123),(1330,2,'',NULL,6,124),(1331,2,'',NULL,6,125),(1332,2,'',NULL,6,126),(1333,2,'',NULL,6,127),(1334,2,'',NULL,6,128),(1335,2,'',NULL,6,129),(1336,2,'',NULL,6,130),(1337,2,'',NULL,6,131),(1338,2,'',NULL,6,132),(1339,2,'',NULL,6,133),(1340,2,'',NULL,6,134);
/*!40000 ALTER TABLE `epita_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epita_course`
--

DROP TABLE IF EXISTS `epita_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epita_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(127) NOT NULL,
  `title` varchar(127) NOT NULL,
  `description` longtext NOT NULL,
  `semester` varchar(31) NOT NULL,
  `module` varchar(63) NOT NULL,
  `credits` int(11) DEFAULT NULL,
  `hours` int(11) DEFAULT NULL,
  `slug` varchar(158) NOT NULL,
  `professor_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `epita_course_title_semester_0f03ea41_uniq` (`title`,`semester`),
  KEY `epita_course_slug_9390f506` (`slug`),
  KEY `epita_course_professor_id_id_c64bea89_fk_epita_professor_id` (`professor_id_id`),
  CONSTRAINT `epita_course_professor_id_id_c64bea89_fk_epita_professor_id` FOREIGN KEY (`professor_id_id`) REFERENCES `epita_professor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epita_course`
--

LOCK TABLES `epita_course` WRITE;
/*!40000 ALTER TABLE `epita_course` DISABLE KEYS */;
INSERT INTO `epita_course` VALUES (1,'','Advanced C Programming','aegr','Fall 2019','Tech',3,NULL,'fall-2019-advanced-c-programming',1),(2,'','Management Something or other','sdgfh','Fall 2019','Management',3,NULL,'fall-2019-management-something-or-other',1);
/*!40000 ALTER TABLE `epita_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epita_grades`
--

DROP TABLE IF EXISTS `epita_grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epita_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assignment` varchar(255) NOT NULL,
  `points_earned` int(11) NOT NULL,
  `points_possible` int(11) NOT NULL,
  `course_id_id` int(11) NOT NULL,
  `student_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `epita_grades_course_id_id_baa169fb_fk_epita_course_id` (`course_id_id`),
  KEY `epita_grades_student_id_id_8c356285_fk_epita_student_id` (`student_id_id`),
  CONSTRAINT `epita_grades_course_id_id_baa169fb_fk_epita_course_id` FOREIGN KEY (`course_id_id`) REFERENCES `epita_course` (`id`),
  CONSTRAINT `epita_grades_student_id_id_8c356285_fk_epita_student_id` FOREIGN KEY (`student_id_id`) REFERENCES `epita_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epita_grades`
--

LOCK TABLES `epita_grades` WRITE;
/*!40000 ALTER TABLE `epita_grades` DISABLE KEYS */;
/*!40000 ALTER TABLE `epita_grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epita_professor`
--

DROP TABLE IF EXISTS `epita_professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epita_professor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(31) NOT NULL,
  `photo_location` varchar(511) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `epita_professor_user_id_881cc30f_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epita_professor`
--

LOCK TABLES `epita_professor` WRITE;
/*!40000 ALTER TABLE `epita_professor` DISABLE KEYS */;
INSERT INTO `epita_professor` VALUES (1,'','',1);
/*!40000 ALTER TABLE `epita_professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epita_schedule`
--

DROP TABLE IF EXISTS `epita_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epita_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `start_time` time(6) NOT NULL,
  `end_time` time(6) NOT NULL,
  `attendance_closed` tinyint(1) NOT NULL,
  `course_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `epita_schedule_course_id_id_2e8b6081_fk_epita_course_id` (`course_id_id`),
  CONSTRAINT `epita_schedule_course_id_id_2e8b6081_fk_epita_course_id` FOREIGN KEY (`course_id_id`) REFERENCES `epita_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epita_schedule`
--

LOCK TABLES `epita_schedule` WRITE;
/*!40000 ALTER TABLE `epita_schedule` DISABLE KEYS */;
INSERT INTO `epita_schedule` VALUES (1,'2018-06-09','14:55:45.000000','14:55:45.000000',0,1),(2,'2018-06-09','14:55:51.000000','14:55:52.000000',1,2),(3,'2018-06-12','14:26:47.000000','16:25:41.000000',1,2),(4,'2018-06-12','14:26:47.000000','16:25:41.000000',1,2),(5,'2018-06-12','14:26:47.000000','16:25:41.000000',1,2),(6,'2018-06-13','12:53:23.000000','14:47:35.000000',1,1);
/*!40000 ALTER TABLE `epita_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epita_student`
--

DROP TABLE IF EXISTS `epita_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epita_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(31) NOT NULL,
  `program` int(11) NOT NULL,
  `specialization` int(11) NOT NULL,
  `intakeSemester` varchar(31) NOT NULL,
  `country` varchar(127) NOT NULL,
  `country_code` varchar(2) NOT NULL,
  `city` varchar(127) NOT NULL,
  `languages` varchar(127) NOT NULL,
  `photo_location` varchar(511) DEFAULT NULL,
  `address_street` varchar(255) DEFAULT NULL,
  `address_city` varchar(255) DEFAULT NULL,
  `address_misc` varchar(255) DEFAULT NULL,
  `address_code` int(11) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `enrollment_status` int(11) NOT NULL,
  `flags` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `epita_student_user_id_529318c6_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epita_student`
--

LOCK TABLES `epita_student` WRITE;
/*!40000 ALTER TABLE `epita_student` DISABLE KEYS */;
INSERT INTO `epita_student` VALUES (1,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,2),(2,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,3),(3,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,4),(4,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,5),(5,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,6),(6,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,7),(7,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,8),(8,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,9),(9,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,10),(10,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,11),(11,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,12),(12,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,13),(13,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,14),(14,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,15),(15,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,16),(16,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,17),(17,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,18),(18,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,19),(19,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,20),(20,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,21),(21,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,22),(22,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,23),(23,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,24),(24,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,25),(25,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,26),(26,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,27),(27,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,28),(28,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,29),(29,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,30),(30,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,31),(31,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,32),(32,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,33),(33,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,34),(34,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,35),(35,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,36),(36,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,37),(37,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,38),(38,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,39),(39,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,40),(40,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,41),(41,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,42),(42,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,43),(43,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,44),(44,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,45),(45,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,46),(46,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,47),(47,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,48),(48,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,49),(49,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,50),(50,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,51),(51,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,52),(52,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,53),(53,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,54),(54,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,55),(55,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,56),(56,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,57),(57,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,58),(58,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,59),(59,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,60),(60,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,61),(61,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,62),(62,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,63),(63,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,64),(64,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,65),(65,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,66),(66,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,67),(67,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,68),(68,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,69),(69,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,70),(70,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,71),(71,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,72),(72,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,73),(73,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,74),(74,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,75),(75,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,76),(76,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,77),(77,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,78),(78,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,79),(79,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,80),(80,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,81),(81,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,82),(82,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,83),(83,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,84),(84,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,85),(85,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,86),(86,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,87),(87,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,88),(88,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,89),(89,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,90),(90,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,91),(91,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,92),(92,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,93),(93,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,94),(94,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,95),(95,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,96),(96,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,97),(97,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,98),(98,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,99),(99,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,100),(100,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,101),(101,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,102),(102,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,103),(103,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,104),(104,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,105),(105,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,106),(106,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,107),(107,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,108),(108,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,109),(109,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,110),(110,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,111),(111,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,112),(112,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,113),(113,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,114),(114,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,115),(115,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,116),(116,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,117),(117,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,118),(118,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,119),(119,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,120),(120,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,121),(121,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,122),(122,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,123),(123,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,124),(124,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,125),(125,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,126),(126,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,127),(127,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,128),(128,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,129),(129,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,130),(130,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,131),(131,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,132),(132,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,133),(133,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,134),(134,'',1,2,'Spring 2017','Mexico','mx','','','',NULL,NULL,NULL,NULL,NULL,0,0,135),(135,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,136),(136,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,137),(137,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,138),(138,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,139),(139,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,140),(140,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,141),(141,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,142),(142,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,143),(143,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,144),(144,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,145),(145,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,146),(146,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,147),(147,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,148),(148,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,149),(149,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,150),(150,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,151),(151,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,152),(152,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,153),(153,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,154),(154,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,155),(155,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,156),(156,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,157),(157,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,158),(158,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,159),(159,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,160),(160,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,161),(161,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,162),(162,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,163),(163,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,164),(164,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,165),(165,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,166),(166,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,167),(167,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,168),(168,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,169),(169,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,170),(170,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,171),(171,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,172),(172,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,173),(173,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,174),(174,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,175),(175,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,176),(176,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,177),(177,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,178),(178,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,179),(179,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,180),(180,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,181),(181,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,182),(182,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,183),(183,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,184),(184,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,185),(185,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,186),(186,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,187),(187,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,188),(188,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,189),(189,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,190),(190,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,191),(191,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,192),(192,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,193),(193,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,194),(194,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,195),(195,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,196),(196,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,197),(197,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,198),(198,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,199),(199,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,200),(200,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,201),(201,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,202),(202,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,203),(203,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,204),(204,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,205),(205,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,206),(206,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,207),(207,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,208),(208,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,209),(209,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,210),(210,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,211),(211,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,212),(212,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,213),(213,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,214),(214,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,215),(215,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,216),(216,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,217),(217,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,218),(218,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,219),(219,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,220),(220,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,221),(221,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,222),(222,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,223),(223,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,224),(224,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,225),(225,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,226),(226,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,227),(227,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,228),(228,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,229),(229,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,230),(230,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,231),(231,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,232),(232,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,233),(233,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,234),(234,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,235),(235,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,236),(236,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,237),(237,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,238),(238,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,239),(239,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,240),(240,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,241),(241,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,242),(242,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,243),(243,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,244),(244,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,245),(245,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,246),(246,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,247),(247,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,248),(248,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,249),(249,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,250),(250,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,251),(251,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,252),(252,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,253),(253,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,254),(254,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,255),(255,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,256),(256,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,257),(257,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,258),(258,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,259),(259,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,260),(260,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,261),(261,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,262),(262,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,263),(263,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,264),(264,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,265),(265,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,266),(266,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,267),(267,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,268),(268,'',2,1,'Fall 2017','USA','us','','','',NULL,NULL,NULL,NULL,NULL,0,0,269);
/*!40000 ALTER TABLE `epita_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epita_studentcourse`
--

DROP TABLE IF EXISTS `epita_studentcourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epita_studentcourse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id_id` int(11) NOT NULL,
  `student_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `epita_studentcourse_course_id_id_12431daf_fk_epita_course_id` (`course_id_id`),
  KEY `epita_studentcourse_student_id_id_965ea02f_fk_epita_student_id` (`student_id_id`),
  CONSTRAINT `epita_studentcourse_course_id_id_12431daf_fk_epita_course_id` FOREIGN KEY (`course_id_id`) REFERENCES `epita_course` (`id`),
  CONSTRAINT `epita_studentcourse_student_id_id_965ea02f_fk_epita_student_id` FOREIGN KEY (`student_id_id`) REFERENCES `epita_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=403 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epita_studentcourse`
--

LOCK TABLES `epita_studentcourse` WRITE;
/*!40000 ALTER TABLE `epita_studentcourse` DISABLE KEYS */;
INSERT INTO `epita_studentcourse` VALUES (1,2,1),(2,2,2),(3,2,3),(4,2,4),(5,2,5),(6,2,6),(7,2,7),(8,2,8),(9,2,9),(10,2,10),(11,2,11),(12,2,12),(13,2,13),(14,2,14),(15,2,15),(16,2,16),(17,2,17),(18,2,18),(19,2,19),(20,2,20),(21,2,21),(22,2,22),(23,2,23),(24,2,24),(25,2,25),(26,2,26),(27,2,27),(28,2,28),(29,2,29),(30,2,30),(31,2,31),(32,2,32),(33,2,33),(34,2,34),(35,2,35),(36,2,36),(37,2,37),(38,2,38),(39,2,39),(40,2,40),(41,2,41),(42,2,42),(43,2,43),(44,2,44),(45,2,45),(46,2,46),(47,2,47),(48,2,48),(49,2,49),(50,2,50),(51,2,51),(52,2,52),(53,2,53),(54,2,54),(55,2,55),(56,2,56),(57,2,57),(58,2,58),(59,2,59),(60,2,60),(61,2,61),(62,2,62),(63,2,63),(64,2,64),(65,2,65),(66,2,66),(67,2,67),(68,2,68),(69,2,69),(70,2,70),(71,2,71),(72,2,72),(73,2,73),(74,2,74),(75,2,75),(76,2,76),(77,2,77),(78,2,78),(79,2,79),(80,2,80),(81,2,81),(82,2,82),(83,2,83),(84,2,84),(85,2,85),(86,2,86),(87,2,87),(88,2,88),(89,2,89),(90,2,90),(91,2,91),(92,2,92),(93,2,93),(94,2,94),(95,2,95),(96,2,96),(97,2,97),(98,2,98),(99,2,99),(100,2,100),(101,2,101),(102,2,102),(103,2,103),(104,2,104),(105,2,105),(106,2,106),(107,2,107),(108,2,108),(109,2,109),(110,2,110),(111,2,111),(112,2,112),(113,2,113),(114,2,114),(115,2,115),(116,2,116),(117,2,117),(118,2,118),(119,2,119),(120,2,120),(121,2,121),(122,2,122),(123,2,123),(124,2,124),(125,2,125),(126,2,126),(127,2,127),(128,2,128),(129,2,129),(130,2,130),(131,2,131),(132,2,132),(133,2,133),(134,2,134),(135,2,135),(136,2,136),(137,2,137),(138,2,138),(139,2,139),(140,2,140),(141,2,141),(142,2,142),(143,2,143),(144,2,144),(145,2,145),(146,2,146),(147,2,147),(148,2,148),(149,2,149),(150,2,150),(151,2,151),(152,2,152),(153,2,153),(154,2,154),(155,2,155),(156,2,156),(157,2,157),(158,2,158),(159,2,159),(160,2,160),(161,2,161),(162,2,162),(163,2,163),(164,2,164),(165,2,165),(166,2,166),(167,2,167),(168,2,168),(169,2,169),(170,2,170),(171,2,171),(172,2,172),(173,2,173),(174,2,174),(175,2,175),(176,2,176),(177,2,177),(178,2,178),(179,2,179),(180,2,180),(181,2,181),(182,2,182),(183,2,183),(184,2,184),(185,2,185),(186,2,186),(187,2,187),(188,2,188),(189,2,189),(190,2,190),(191,2,191),(192,2,192),(193,2,193),(194,2,194),(195,2,195),(196,2,196),(197,2,197),(198,2,198),(199,2,199),(200,2,200),(201,2,201),(202,2,202),(203,2,203),(204,2,204),(205,2,205),(206,2,206),(207,2,207),(208,2,208),(209,2,209),(210,2,210),(211,2,211),(212,2,212),(213,2,213),(214,2,214),(215,2,215),(216,2,216),(217,2,217),(218,2,218),(219,2,219),(220,2,220),(221,2,221),(222,2,222),(223,2,223),(224,2,224),(225,2,225),(226,2,226),(227,2,227),(228,2,228),(229,2,229),(230,2,230),(231,2,231),(232,2,232),(233,2,233),(234,2,234),(235,2,235),(236,2,236),(237,2,237),(238,2,238),(239,2,239),(240,2,240),(241,2,241),(242,2,242),(243,2,243),(244,2,244),(245,2,245),(246,2,246),(247,2,247),(248,2,248),(249,2,249),(250,2,250),(251,2,251),(252,2,252),(253,2,253),(254,2,254),(255,2,255),(256,2,256),(257,2,257),(258,2,258),(259,2,259),(260,2,260),(261,2,261),(262,2,262),(263,2,263),(264,2,264),(265,2,265),(266,2,266),(267,2,267),(268,2,268),(269,1,1),(270,1,2),(271,1,3),(272,1,4),(273,1,5),(274,1,6),(275,1,7),(276,1,8),(277,1,9),(278,1,10),(279,1,11),(280,1,12),(281,1,13),(282,1,14),(283,1,15),(284,1,16),(285,1,17),(286,1,18),(287,1,19),(288,1,20),(289,1,21),(290,1,22),(291,1,23),(292,1,24),(293,1,25),(294,1,26),(295,1,27),(296,1,28),(297,1,29),(298,1,30),(299,1,31),(300,1,32),(301,1,33),(302,1,34),(303,1,35),(304,1,36),(305,1,37),(306,1,38),(307,1,39),(308,1,40),(309,1,41),(310,1,42),(311,1,43),(312,1,44),(313,1,45),(314,1,46),(315,1,47),(316,1,48),(317,1,49),(318,1,50),(319,1,51),(320,1,52),(321,1,53),(322,1,54),(323,1,55),(324,1,56),(325,1,57),(326,1,58),(327,1,59),(328,1,60),(329,1,61),(330,1,62),(331,1,63),(332,1,64),(333,1,65),(334,1,66),(335,1,67),(336,1,68),(337,1,69),(338,1,70),(339,1,71),(340,1,72),(341,1,73),(342,1,74),(343,1,75),(344,1,76),(345,1,77),(346,1,78),(347,1,79),(348,1,80),(349,1,81),(350,1,82),(351,1,83),(352,1,84),(353,1,85),(354,1,86),(355,1,87),(356,1,88),(357,1,89),(358,1,90),(359,1,91),(360,1,92),(361,1,93),(362,1,94),(363,1,95),(364,1,96),(365,1,97),(366,1,98),(367,1,99),(368,1,100),(369,1,101),(370,1,102),(371,1,103),(372,1,104),(373,1,105),(374,1,106),(375,1,107),(376,1,108),(377,1,109),(378,1,110),(379,1,111),(380,1,112),(381,1,113),(382,1,114),(383,1,115),(384,1,116),(385,1,117),(386,1,118),(387,1,119),(388,1,120),(389,1,121),(390,1,122),(391,1,123),(392,1,124),(393,1,125),(394,1,126),(395,1,127),(396,1,128),(397,1,129),(398,1,130),(399,1,131),(400,1,132),(401,1,133),(402,1,134);
/*!40000 ALTER TABLE `epita_studentcourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_checkboxquestion`
--

DROP TABLE IF EXISTS `quiz_checkboxquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz_checkboxquestion` (
  `multiplechoicequestion_ptr_id` int(11) NOT NULL,
  `multiple_answers` tinyint(1) NOT NULL,
  `partial_credit` tinyint(1) NOT NULL,
  `total_correct_answers` int(11) NOT NULL,
  `incorrect_choice_points_lost` decimal(4,2) NOT NULL,
  `missed_choice_points_lost` decimal(4,2) NOT NULL,
  `allow_negative_score` tinyint(1) NOT NULL,
  PRIMARY KEY (`multiplechoicequestion_ptr_id`),
  CONSTRAINT `quiz_checkboxquestio_multiplechoicequesti_4e774491_fk_quiz_mult` FOREIGN KEY (`multiplechoicequestion_ptr_id`) REFERENCES `quiz_multiplechoicequestion` (`question_ptr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_checkboxquestion`
--

LOCK TABLES `quiz_checkboxquestion` WRITE;
/*!40000 ALTER TABLE `quiz_checkboxquestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_checkboxquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_multiplechoiceoption`
--

DROP TABLE IF EXISTS `quiz_multiplechoiceoption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz_multiplechoiceoption` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(1024) NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `question_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_multiplechoiceo_question_id_ffdd777f_fk_quiz_ques` (`question_id`),
  CONSTRAINT `quiz_multiplechoiceo_question_id_ffdd777f_fk_quiz_ques` FOREIGN KEY (`question_id`) REFERENCES `quiz_question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_multiplechoiceoption`
--

LOCK TABLES `quiz_multiplechoiceoption` WRITE;
/*!40000 ALTER TABLE `quiz_multiplechoiceoption` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_multiplechoiceoption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_multiplechoicequestion`
--

DROP TABLE IF EXISTS `quiz_multiplechoicequestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz_multiplechoicequestion` (
  `question_ptr_id` int(11) NOT NULL,
  `randomize` tinyint(1) NOT NULL,
  PRIMARY KEY (`question_ptr_id`),
  CONSTRAINT `quiz_multiplechoiceq_question_ptr_id_87370239_fk_quiz_ques` FOREIGN KEY (`question_ptr_id`) REFERENCES `quiz_question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_multiplechoicequestion`
--

LOCK TABLES `quiz_multiplechoicequestion` WRITE;
/*!40000 ALTER TABLE `quiz_multiplechoicequestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_multiplechoicequestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_numericscalequestion`
--

DROP TABLE IF EXISTS `quiz_numericscalequestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz_numericscalequestion` (
  `question_ptr_id` int(11) NOT NULL,
  `min` int(11) NOT NULL,
  `max` int(11) NOT NULL,
  `step` int(11) NOT NULL,
  `correct_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`question_ptr_id`),
  CONSTRAINT `quiz_numericscaleque_question_ptr_id_cbbc2cc1_fk_quiz_ques` FOREIGN KEY (`question_ptr_id`) REFERENCES `quiz_question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_numericscalequestion`
--

LOCK TABLES `quiz_numericscalequestion` WRITE;
/*!40000 ALTER TABLE `quiz_numericscalequestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_numericscalequestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_question`
--

DROP TABLE IF EXISTS `quiz_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(1023) NOT NULL,
  `figure` varchar(100) DEFAULT NULL,
  `explanation` varchar(1023) NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_question`
--

LOCK TABLES `quiz_question` WRITE;
/*!40000 ALTER TABLE `quiz_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_question_quiz`
--

DROP TABLE IF EXISTS `quiz_question_quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz_question_quiz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quiz_question_quiz_question_id_quiz_id_3414207a_uniq` (`question_id`,`quiz_id`),
  KEY `quiz_question_quiz_quiz_id_eccb418d_fk_quiz_quiz_id` (`quiz_id`),
  CONSTRAINT `quiz_question_quiz_question_id_2b2637b3_fk_quiz_question_id` FOREIGN KEY (`question_id`) REFERENCES `quiz_question` (`id`),
  CONSTRAINT `quiz_question_quiz_quiz_id_eccb418d_fk_quiz_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `quiz_quiz` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_question_quiz`
--

LOCK TABLES `quiz_question_quiz` WRITE;
/*!40000 ALTER TABLE `quiz_question_quiz` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_question_quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_quiz`
--

DROP TABLE IF EXISTS `quiz_quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz_quiz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `description` longtext NOT NULL,
  `url` varchar(100) NOT NULL,
  `status` varchar(9) NOT NULL,
  `open` tinyint(1) NOT NULL,
  `time_limit` time(6) DEFAULT NULL,
  `randomize` tinyint(1) NOT NULL,
  `created_on` datetime(6) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_quiz_course_id_dd25aae3_fk_epita_course_id` (`course_id`),
  KEY `quiz_quiz_url_aa508dbd` (`url`),
  CONSTRAINT `quiz_quiz_course_id_dd25aae3_fk_epita_course_id` FOREIGN KEY (`course_id`) REFERENCES `epita_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_quiz`
--

LOCK TABLES `quiz_quiz` WRITE;
/*!40000 ALTER TABLE `quiz_quiz` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_quizprogression`
--

DROP TABLE IF EXISTS `quiz_quizprogression`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz_quizprogression` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questions_order` varchar(255) DEFAULT NULL,
  `questions_answered` varchar(255) DEFAULT NULL,
  `questions_correct` varchar(255) DEFAULT NULL,
  `questions_incorrect` varchar(255) DEFAULT NULL,
  `quiz_timestamp` datetime(6) NOT NULL,
  `score_obtained` int(11) DEFAULT NULL,
  `score_possible_points` int(11) DEFAULT NULL,
  `quiz_id` int(11) DEFAULT NULL,
  `student_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_quizprogression_quiz_id_8917f477_fk_quiz_quiz_id` (`quiz_id`),
  KEY `quiz_quizprogression_student_id_id_5c64f601_fk_epita_student_id` (`student_id_id`),
  CONSTRAINT `quiz_quizprogression_quiz_id_8917f477_fk_quiz_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `quiz_quiz` (`id`),
  CONSTRAINT `quiz_quizprogression_student_id_id_5c64f601_fk_epita_student_id` FOREIGN KEY (`student_id_id`) REFERENCES `epita_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_quizprogression`
--

LOCK TABLES `quiz_quizprogression` WRITE;
/*!40000 ALTER TABLE `quiz_quizprogression` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_quizprogression` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-29 14:24:09
