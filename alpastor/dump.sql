-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: alpastor
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu18.04.1

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
  `first_name` varchar(127) NOT NULL,
  `last_name` varchar(127) NOT NULL,
  `external_email` varchar(254) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=271 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user`
--

LOCK TABLES `accounts_user` WRITE;
/*!40000 ALTER TABLE `accounts_user` DISABLE KEYS */;
INSERT INTO `accounts_user` VALUES (1,'pbkdf2_sha256$100000$Bo0iIGO0hbuI$7XSCGzCoi9Jnh++OPB8duYSI2VadgD/SEy7KxLivOBw=','2018-06-09 12:44:57.341000',1,'admin@epita.fr','','','','2018-06-09 12:44:48.662000',1,1),(2,'pbkdf2_sha256$100000$z9SMFAMnE5rc$cisEIIp42jeCGnR2IQgK6NO5BAYf1qqmMzJEHtMUhUs=',NULL,0,'john.professor@epita.fr','John','Professor','','2018-06-09 12:45:37.887000',1,1),(3,'pbkdf2_sha256$100000$a1HyxVXL4hzE$KRGmFe1OzqtaWsS77+dphyZFyorwF3fG8550OSBQGuQ=',NULL,0,'me_student0@epita.fr','Willy0','Williamson','','2018-06-09 12:51:02.964000',1,0),(4,'pbkdf2_sha256$100000$LIOf01sZZGQA$fW57qeA/vukvlIFw+/25zeNoVFRrshsPyJGnuGYlqE0=',NULL,0,'me_student1@epita.fr','Willy1','Williamson','','2018-06-09 12:51:03.032000',1,0),(5,'pbkdf2_sha256$100000$Cpn4AzAcGFGb$TAwWI0HEG776VqNbgGm39CLQqoTlls7hs2G8gwwZiKA=',NULL,0,'me_student2@epita.fr','Willy2','Williamson','','2018-06-09 12:51:03.106000',1,0),(6,'pbkdf2_sha256$100000$z8CV1UaPWQu4$29yVGplHfvjNDlr79XnEj/WegVfkeVJtsaLLzHWdCJs=',NULL,0,'me_student3@epita.fr','Willy3','Williamson','','2018-06-09 12:51:03.182000',1,0),(7,'pbkdf2_sha256$100000$boVkGZJHdhoO$PJndp+7kTl8dBZN8/P6qdE/HDgGSQUe00+oaUNqp/PA=',NULL,0,'me_student4@epita.fr','Willy4','Williamson','','2018-06-09 12:51:03.247000',1,0),(8,'pbkdf2_sha256$100000$UUvfUZnzoTqo$c/F5OlIkobB4gauJ51F0ykiLsut6jBwkHaTmaHzQhA4=',NULL,0,'me_student5@epita.fr','Willy5','Williamson','','2018-06-09 12:51:03.326000',1,0),(9,'pbkdf2_sha256$100000$qY8r0pidtEIi$hKs0hqqgYfxuTnRUB78AeeiFc0HGUnBzadkwt2Ljt20=',NULL,0,'me_student6@epita.fr','Willy6','Williamson','','2018-06-09 12:51:03.389000',1,0),(10,'pbkdf2_sha256$100000$v7GzpzC0k4W5$UwCxLVdP6HNDiBqRZF7tzJYd19MhZWtTPhVHWF9Q3vM=',NULL,0,'me_student7@epita.fr','Willy7','Williamson','','2018-06-09 12:51:03.454000',1,0),(11,'pbkdf2_sha256$100000$Wh5npMJDqpqB$7WZnVnLbH0wwtUlDiDLkmL5kvWV7I7kf7VdRCT5IxII=',NULL,0,'me_student8@epita.fr','Willy8','Williamson','','2018-06-09 12:51:03.516000',1,0),(12,'pbkdf2_sha256$100000$FICdRIzv5STm$w8LHvNs7F4H5ju6kHJnN5rz7GbFDbL6Iv5L1XxgiRM8=',NULL,0,'me_student9@epita.fr','Willy9','Williamson','','2018-06-09 12:51:03.595000',1,0),(13,'pbkdf2_sha256$100000$gV49rFjqMn4R$rYOjH+uzU4PHjVYRZs0Gx0NSUVquIdvaBd8hW/SYdnM=',NULL,0,'me_student10@epita.fr','Willy10','Williamson','','2018-06-09 12:51:03.660000',1,0),(14,'pbkdf2_sha256$100000$gbljX2GoBXiD$lEkChipGoQQ/x1+mo0Oe6MJ3ZOfMfQaLUtEzf0uSjc0=',NULL,0,'me_student11@epita.fr','Willy11','Williamson','','2018-06-09 12:51:03.724000',1,0),(15,'pbkdf2_sha256$100000$TJyS6wKVYaMx$X6S7HFw9WoOXIvkgTacReSdSmLX0AtBDvfu0ndY1Uws=',NULL,0,'me_student12@epita.fr','Willy12','Williamson','','2018-06-09 12:51:03.788000',1,0),(16,'pbkdf2_sha256$100000$jcSqsCntIPn0$oAoPtsqcL4VIZev18l84AZSYvCiKm1v1MvrDWJ5XIDk=',NULL,0,'me_student13@epita.fr','Willy13','Williamson','','2018-06-09 12:51:03.852000',1,0),(17,'pbkdf2_sha256$100000$n6e1Ff7hQ877$D/sm1WnqdygmCvy/Nd03mv8A6rUS6LbOnpnM6Q57hV0=',NULL,0,'me_student14@epita.fr','Willy14','Williamson','','2018-06-09 12:51:03.916000',1,0),(18,'pbkdf2_sha256$100000$Jx4fifUxzReC$t2htq0yn2y4Y3WNJRoj5CjUFdccJfIE2DluzWA3mqlg=',NULL,0,'me_student15@epita.fr','Willy15','Williamson','','2018-06-09 12:51:03.980000',1,0),(19,'pbkdf2_sha256$100000$cegoQDTDyTLF$G8NymmK0z2sSI5cUmLORnARc3Wj0IC0i2iOLyE7XJQg=',NULL,0,'me_student16@epita.fr','Willy16','Williamson','','2018-06-09 12:51:04.044000',1,0),(20,'pbkdf2_sha256$100000$4UbmXAdWYABg$QRTR+UeRYord1/bSnDt1rFt396eF0xXVmTZD49oKS6s=',NULL,0,'me_student17@epita.fr','Willy17','Williamson','','2018-06-09 12:51:04.110000',1,0),(21,'pbkdf2_sha256$100000$rkVEgL8GilgK$yPFciIW1n8AVbwsxScbwu7XWQAGzzpfrqIft5NH3jDg=',NULL,0,'me_student18@epita.fr','Willy18','Williamson','','2018-06-09 12:51:04.174000',1,0),(22,'pbkdf2_sha256$100000$N6PrZAzm8eZy$K0KhJQo7Zg5L23iA0qZd2NXIecllNG3FJzA6NT/b9sg=',NULL,0,'me_student19@epita.fr','Willy19','Williamson','','2018-06-09 12:51:04.236000',1,0),(23,'pbkdf2_sha256$100000$x5Ls7hA7UJDa$fU034Sn+5wNLBLfbSwVX9A0y/jNEKSlda+LtdhK9tTI=',NULL,0,'me_student20@epita.fr','Willy20','Williamson','','2018-06-09 12:51:04.299000',1,0),(24,'pbkdf2_sha256$100000$ILQDfgb9Nwsx$QPda633MouQxJAPro2f+mlmVcGzA36BGr+443P5zcNs=',NULL,0,'me_student21@epita.fr','Willy21','Williamson','','2018-06-09 12:51:04.364000',1,0),(25,'pbkdf2_sha256$100000$PGmAY94zgKGD$SFBNuyBhnqTWDYzIZqd4cp/0ohC9EtWSYu6WNekljGQ=',NULL,0,'me_student22@epita.fr','Willy22','Williamson','','2018-06-09 12:51:04.428000',1,0),(26,'pbkdf2_sha256$100000$wwzbcSUB9z9F$J7HmKs464XWOtthTqJ8Oki1bN4c0XtQ2fAtkKSHUMuY=',NULL,0,'me_student23@epita.fr','Willy23','Williamson','','2018-06-09 12:51:04.492000',1,0),(27,'pbkdf2_sha256$100000$GUEaSKgA5YyT$ZWDoZxfsdvF6NhmJFttGNQTX5Bhew47nepaL4gdVyjw=',NULL,0,'me_student24@epita.fr','Willy24','Williamson','','2018-06-09 12:51:04.578000',1,0),(28,'pbkdf2_sha256$100000$bnzmdkhrynY4$ZdfRCbgHdgtEyIVKem6f+88HvYXwPUYIwydSE7PXVVU=',NULL,0,'me_student25@epita.fr','Willy25','Williamson','','2018-06-09 12:51:04.640000',1,0),(29,'pbkdf2_sha256$100000$k4m2QtT3NToJ$CtW1u+hIOGCHGm5/sPAFQileB4Vur1MgekCdK18EkTg=',NULL,0,'me_student26@epita.fr','Willy26','Williamson','','2018-06-09 12:51:04.704000',1,0),(30,'pbkdf2_sha256$100000$LYwJTdhTmgjx$oFMbjRQHGMljje+D+sgMRW9DtutU+yfWbm4zNlSwsHA=',NULL,0,'me_student27@epita.fr','Willy27','Williamson','','2018-06-09 12:51:04.813000',1,0),(31,'pbkdf2_sha256$100000$c2dBPpHcTv9Q$co/nItPF7ErFQebf5SKrcXdOLk8gMclH6Xqwz2Tje+g=',NULL,0,'me_student28@epita.fr','Willy28','Williamson','','2018-06-09 12:51:04.877000',1,0),(32,'pbkdf2_sha256$100000$pCojsPzCqgs2$gML79tYOfOboPPq/eG0tX3aAso2WtvOu2Tqp1laVawc=',NULL,0,'me_student29@epita.fr','Willy29','Williamson','','2018-06-09 12:51:04.941000',1,0),(33,'pbkdf2_sha256$100000$XJrWtD9WNLru$x9T5wmtCjEtrXSjI8xjeDcHl0ueAtz67zKdMeoWBbN8=',NULL,0,'me_student30@epita.fr','Willy30','Williamson','','2018-06-09 12:51:05.015000',1,0),(34,'pbkdf2_sha256$100000$DLQoK9evXbNI$HEmVofTloC1we6T+cEwvtqkm9BEaoNeeqQA70Weda1k=',NULL,0,'me_student31@epita.fr','Willy31','Williamson','','2018-06-09 12:51:05.080000',1,0),(35,'pbkdf2_sha256$100000$epdw4sc4RMf3$sD3kGEcvZVh7Lrmzmw+MXyJ3ztKOMVCd00yFxAk6Rrc=',NULL,0,'me_student32@epita.fr','Willy32','Williamson','','2018-06-09 12:51:05.144000',1,0),(36,'pbkdf2_sha256$100000$DzLNFPL5EEwo$xAvxlOeUD8T17MAJEnbmvP3GLk17kO8eKj1E2lNWWjk=',NULL,0,'me_student33@epita.fr','Willy33','Williamson','','2018-06-09 12:51:05.209000',1,0),(37,'pbkdf2_sha256$100000$ogYNRA57llw4$z0smc+9AL24E/2Od/3YBi6EbRvJVVCmuBO3niRYqdYs=',NULL,0,'me_student34@epita.fr','Willy34','Williamson','','2018-06-09 12:51:05.273000',1,0),(38,'pbkdf2_sha256$100000$KdxHfjV8SEle$u0dvpV7N+dKtfjAgU5lLuDHO06DIJHx35so5aa/EeF0=',NULL,0,'me_student35@epita.fr','Willy35','Williamson','','2018-06-09 12:51:05.337000',1,0),(39,'pbkdf2_sha256$100000$mFaeNyVJeVFX$Y6Dp6GXM41eM2LpYKkx6wMxKf6KBgya7TYf6aEuJpsM=',NULL,0,'me_student36@epita.fr','Willy36','Williamson','','2018-06-09 12:51:05.401000',1,0),(40,'pbkdf2_sha256$100000$IffJZZC2J300$vV5JcQ4T6f9KAGIJk/T5fmty0Lcm71P5Fel7SE1Jm10=',NULL,0,'me_student37@epita.fr','Willy37','Williamson','','2018-06-09 12:51:05.465000',1,0),(41,'pbkdf2_sha256$100000$z77jwOxVvJ1N$9aKad+iwEoyEjwod7NbnDVW9pgKLVqmt/beF6pVKDTg=',NULL,0,'me_student38@epita.fr','Willy38','Williamson','','2018-06-09 12:51:05.538000',1,0),(42,'pbkdf2_sha256$100000$C1Xtms8Q9tkR$zaECKR3z0nJfQu5nPJ0OB39ZX3L4ufFd2+b7YjNyUEE=',NULL,0,'me_student39@epita.fr','Willy39','Williamson','','2018-06-09 12:51:05.600000',1,0),(43,'pbkdf2_sha256$100000$lZZbqSWtZtZR$rQ9/59+Zp+ua5kjBcL7FK3fZvb1UyIZN3FH5Kh2UrRs=',NULL,0,'me_student40@epita.fr','Willy40','Williamson','','2018-06-09 12:51:05.665000',1,0),(44,'pbkdf2_sha256$100000$aMjq18h3U2pB$9cnZ2FK2jknKIe3FgOMlXEkF3HszKudXkHyAJzS+LHo=',NULL,0,'me_student41@epita.fr','Willy41','Williamson','','2018-06-09 12:51:05.730000',1,0),(45,'pbkdf2_sha256$100000$DY9TBYNDBbO4$4qN+DxuoflYjdUn4ZHnZ8Zsf5R60aZVHxZUdewkDAc4=',NULL,0,'me_student42@epita.fr','Willy42','Williamson','','2018-06-09 12:51:05.826000',1,0),(46,'pbkdf2_sha256$100000$vtiWL3WZJuqP$T/eEXJVnEJTvefGr/+MsqAoaJ1a5wtPEsvuXCtpUa34=',NULL,0,'me_student43@epita.fr','Willy43','Williamson','','2018-06-09 12:51:05.915000',1,0),(47,'pbkdf2_sha256$100000$96Fi8IH4W5T0$0MiA/eMX2XDWFdfez95wNXR+tN9fm4EcS9oB+WkQwCQ=',NULL,0,'me_student44@epita.fr','Willy44','Williamson','','2018-06-09 12:51:06.017000',1,0),(48,'pbkdf2_sha256$100000$J4WSEQT8YaQz$/Keo1erALNjog3+soryjQ75t8bSb/slHviFQ2hqjEaM=',NULL,0,'me_student45@epita.fr','Willy45','Williamson','','2018-06-09 12:51:06.081000',1,0),(49,'pbkdf2_sha256$100000$GqzGnKfM5t5a$/aTaUAf60FgxdPKAyLBLACygSXc5fY8PcY2HPSNTyCY=',NULL,0,'me_student46@epita.fr','Willy46','Williamson','','2018-06-09 12:51:06.173000',1,0),(50,'pbkdf2_sha256$100000$K2WV0T43s32M$Pmk0lwyMTfCghmw0x538GcpDm7rztaM6W+ED4eDqEak=',NULL,0,'me_student47@epita.fr','Willy47','Williamson','','2018-06-09 12:51:06.236000',1,0),(51,'pbkdf2_sha256$100000$aGt1jCzqBPF2$HZI/eFNrdn5hcDJw080NByUP0907xubsH83roDbaExc=',NULL,0,'me_student48@epita.fr','Willy48','Williamson','','2018-06-09 12:51:06.302000',1,0),(52,'pbkdf2_sha256$100000$dmtl9smmO0qk$uAY1Xk/c53Pw19H6l7BWzD5V64R5J4U1U1p5J5YPcNs=',NULL,0,'me_student49@epita.fr','Willy49','Williamson','','2018-06-09 12:51:06.363000',1,0),(53,'pbkdf2_sha256$100000$qOLnJoKG8Blg$tELUBxLrULtpnAZxOTd1eOJOqjGQ0wRzH2dwvDGuHIU=',NULL,0,'me_student50@epita.fr','Willy50','Williamson','','2018-06-09 12:51:06.427000',1,0),(54,'pbkdf2_sha256$100000$tVL2mUp4YDT0$hlhluZiEeVN8sWYhJASN3mHgc8YMbdRub6Xun8tZnn0=',NULL,0,'me_student51@epita.fr','Willy51','Williamson','','2018-06-09 12:51:06.491000',1,0),(55,'pbkdf2_sha256$100000$kfpHwfKTXEQ5$nHkECFhISj1gneQ3FCGc4+k7XjvVNqZOXLqasyg5+Bc=',NULL,0,'me_student52@epita.fr','Willy52','Williamson','','2018-06-09 12:51:06.555000',1,0),(56,'pbkdf2_sha256$100000$yUSoEu9EIPcL$c/BEa5sR4zZGW//WUJXiBxRDLHktoD7C7W9lMPpRJUM=',NULL,0,'me_student53@epita.fr','Willy53','Williamson','','2018-06-09 12:51:06.619000',1,0),(57,'pbkdf2_sha256$100000$s2X8cZ6wktg1$MI+Rsjms53CpeKtEc6UCp9KqNqBfOCRZA75oJmVM2G8=',NULL,0,'me_student54@epita.fr','Willy54','Williamson','','2018-06-09 12:51:06.684000',1,0),(58,'pbkdf2_sha256$100000$WIvZrGB2LXhb$ZLEIXoxSZJsxyE/Idlt6OQTEt0Kqu043DoQ3uTPhNmk=',NULL,0,'me_student55@epita.fr','Willy55','Williamson','','2018-06-09 12:51:06.748000',1,0),(59,'pbkdf2_sha256$100000$LCVrFv5Bl3EM$UJPyvgybO4DE/9ssSddQbjy/Ds9h5iZE5aJ6bEsx2W0=',NULL,0,'me_student56@epita.fr','Willy56','Williamson','','2018-06-09 12:51:06.812000',1,0),(60,'pbkdf2_sha256$100000$6rra0pP1MLUa$i6MyORFn9ytDCesTBtIM1tOrZcu5hlemlhDUzAFHD6w=',NULL,0,'me_student57@epita.fr','Willy57','Williamson','','2018-06-09 12:51:06.876000',1,0),(61,'pbkdf2_sha256$100000$18UIrlF5Kbhq$9+gpXtr0tgNdroUxySTh2KJsI90IFHXR1sSOUMrP2ac=',NULL,0,'me_student58@epita.fr','Willy58','Williamson','','2018-06-09 12:51:06.940000',1,0),(62,'pbkdf2_sha256$100000$SIe5q4YjX6Gv$1UIzlcj3fc9EKw+n0XCZUjDo4enuZgUQPbM4uRO7Lzg=',NULL,0,'me_student59@epita.fr','Willy59','Williamson','','2018-06-09 12:51:07.004000',1,0),(63,'pbkdf2_sha256$100000$mewNY1baEDj5$g6gdUscGsdt14Ytqu0RvlJJiqhwwj8g8Pys3Ot6lNFk=',NULL,0,'me_student60@epita.fr','Willy60','Williamson','','2018-06-09 12:51:07.072000',1,0),(64,'pbkdf2_sha256$100000$CLkYFvp0c2V6$dltkVcobql/aW3AHjHME2AItt0YdbSGkCA+cSJbljtk=',NULL,0,'me_student61@epita.fr','Willy61','Williamson','','2018-06-09 12:51:07.136000',1,0),(65,'pbkdf2_sha256$100000$JgCbk3TvXLRB$8i5hm1qczF3y+yUH84klDwHEintTzWyhK38ivHDo67k=',NULL,0,'me_student62@epita.fr','Willy62','Williamson','','2018-06-09 12:51:07.203000',1,0),(66,'pbkdf2_sha256$100000$36tqkfj7LwUx$jGlco+1uOr2ELLFKbmfECVbOiYxXqiU2CzEPYg9xVbc=',NULL,0,'me_student63@epita.fr','Willy63','Williamson','','2018-06-09 12:51:07.292000',1,0),(67,'pbkdf2_sha256$100000$zLeFJ3dl0Wbf$D8i+FOTp549IYvjfSPYlBmGSmlkL4ru34hdxCTvImcU=',NULL,0,'me_student64@epita.fr','Willy64','Williamson','','2018-06-09 12:51:07.356000',1,0),(68,'pbkdf2_sha256$100000$9oApt0xlJMMN$92XVJFHGsB2HFvA2L13sdNnQlKg88LEeLbiK0H2MMcE=',NULL,0,'me_student65@epita.fr','Willy65','Williamson','','2018-06-09 12:51:07.427000',1,0),(69,'pbkdf2_sha256$100000$SutI9tZsqK5K$F+jVxZJif/DXHN9w7nIY2ompb8MILmjNgxmaLOn8BwE=',NULL,0,'me_student66@epita.fr','Willy66','Williamson','','2018-06-09 12:51:07.492000',1,0),(70,'pbkdf2_sha256$100000$wyTIfTnfMlyX$HqMlm+bETn7etK0srl7upFuI5dJlivSTaQQ6+SuaP/k=',NULL,0,'me_student67@epita.fr','Willy67','Williamson','','2018-06-09 12:51:07.557000',1,0),(71,'pbkdf2_sha256$100000$WhNdoScKntle$RoBt0twNpgX2CheGUEI8t5baJjULyRBDvHFfhxIZJy0=',NULL,0,'me_student68@epita.fr','Willy68','Williamson','','2018-06-09 12:51:07.621000',1,0),(72,'pbkdf2_sha256$100000$NQOx6uAFlCgC$RGSQMLJwQqO/g8VWEGggPlshiPBjKzRPgFIhSDehdAE=',NULL,0,'me_student69@epita.fr','Willy69','Williamson','','2018-06-09 12:51:07.707000',1,0),(73,'pbkdf2_sha256$100000$QPZoVT8ywB1S$50Ygch8Sg7JfJ4ZI1ERysZIvg7OsrcvdBySDw7S+QUE=',NULL,0,'me_student70@epita.fr','Willy70','Williamson','','2018-06-09 12:51:07.789000',1,0),(74,'pbkdf2_sha256$100000$VnmBOP6ReGll$PXdNR1nPcShwKvp1TgYSjiSRvXnuyd+5YTmvS0GURO8=',NULL,0,'me_student71@epita.fr','Willy71','Williamson','','2018-06-09 12:51:07.852000',1,0),(75,'pbkdf2_sha256$100000$AKp34uC3wSfa$tQr/S5RIxy3xeH6qNocw2dSipLfeafB1rGc/s1qv+/M=',NULL,0,'me_student72@epita.fr','Willy72','Williamson','','2018-06-09 12:51:07.947000',1,0),(76,'pbkdf2_sha256$100000$DbXMKzdZ6qzE$70X76NO2nRxMC1r6WcDZIu5sGR0roQctagARstS26ng=',NULL,0,'me_student73@epita.fr','Willy73','Williamson','','2018-06-09 12:51:08.011000',1,0),(77,'pbkdf2_sha256$100000$llpMqDcDaBC9$fRy73t+jH1N1XmLailtndsvf8am9GR1WnPmLdUwh2Yo=',NULL,0,'me_student74@epita.fr','Willy74','Williamson','','2018-06-09 12:51:08.105000',1,0),(78,'pbkdf2_sha256$100000$14LKX6B9VDsZ$/QXpAyEM7xZVIKwvOM32WvLLq06nPacWdcrLE8/DsgU=',NULL,0,'me_student75@epita.fr','Willy75','Williamson','','2018-06-09 12:51:08.170000',1,0),(79,'pbkdf2_sha256$100000$kflCFHsrOXY9$VCmuBF6yzSA1xpUJrlO3VQBHLoKMmgnsqsWUjngkaHo=',NULL,0,'me_student76@epita.fr','Willy76','Williamson','','2018-06-09 12:51:08.232000',1,0),(80,'pbkdf2_sha256$100000$v73lqkapvtU6$uOLrkMGeVYnxIc2DTTCM/3aLFuTLs3Ivp9o6uIPvFuw=',NULL,0,'me_student77@epita.fr','Willy77','Williamson','','2018-06-09 12:51:08.322000',1,0),(81,'pbkdf2_sha256$100000$86QEcUnu96x0$0ZSDuegbJeUwEZUtcFoNhpRjWg9mG8Vc/eV4UJG/+D4=',NULL,0,'me_student78@epita.fr','Willy78','Williamson','','2018-06-09 12:51:08.400000',1,0),(82,'pbkdf2_sha256$100000$uQUZUmcFbvlG$csSlBGK2jOsD0nR7+Ok2+qPDYlkAuS138SLOn30pnY0=',NULL,0,'me_student79@epita.fr','Willy79','Williamson','','2018-06-09 12:51:08.464000',1,0),(83,'pbkdf2_sha256$100000$kAF7eA6vOSTA$kjwdnlGXh+yEM7C/SrtRTpX4/A+PPgl04qP7q0dvyeQ=',NULL,0,'me_student80@epita.fr','Willy80','Williamson','','2018-06-09 12:51:08.532000',1,0),(84,'pbkdf2_sha256$100000$Um6YZhdSTMxt$ffn15Gn8S1p7vk/IS+Eh7P2OAXvWAayrV6UDN5+YxDM=',NULL,0,'me_student81@epita.fr','Willy81','Williamson','','2018-06-09 12:51:08.595000',1,0),(85,'pbkdf2_sha256$100000$J31P8DzZPtCk$xl2Cj17Jttd0YmTL7sOan5SwGDwG/fUICaCu9fhlR9o=',NULL,0,'me_student82@epita.fr','Willy82','Williamson','','2018-06-09 12:51:08.659000',1,0),(86,'pbkdf2_sha256$100000$MdVG5BS9TCKa$jrXlulJpqNO5H9sHHcTlywNh+bz5t4Flu4PabjhLLQw=',NULL,0,'me_student83@epita.fr','Willy83','Williamson','','2018-06-09 12:51:08.723000',1,0),(87,'pbkdf2_sha256$100000$ArMCDN57SKbB$fEoX5x74BPiiol/wsb2jH6uofluM8w0mzPnsL5HNVZw=',NULL,0,'me_student84@epita.fr','Willy84','Williamson','','2018-06-09 12:51:08.787000',1,0),(88,'pbkdf2_sha256$100000$yI1vXpP0EZFj$AUZnOIjBQif1p0PyoKE9uvm5ftDAl4yaO0Xd88EJjMQ=',NULL,0,'me_student85@epita.fr','Willy85','Williamson','','2018-06-09 12:51:08.848000',1,0),(89,'pbkdf2_sha256$100000$GVnbjHdhTCNr$KiNJ9FhGItZ4+9IGwHLGoHKUbiKq+D0JlrPNXx6iqL4=',NULL,0,'me_student86@epita.fr','Willy86','Williamson','','2018-06-09 12:51:08.913000',1,0),(90,'pbkdf2_sha256$100000$V52GTSq0b5rK$I/Zro4APOKj2if09pnGTNIlyZuq83OjSmqfyikF2nag=',NULL,0,'me_student87@epita.fr','Willy87','Williamson','','2018-06-09 12:51:08.977000',1,0),(91,'pbkdf2_sha256$100000$6ccx93yLLGRp$eqJpGqKVfS8EeHJ4LBlnveekal0lEAl65RM5b8K6k6c=',NULL,0,'me_student88@epita.fr','Willy88','Williamson','','2018-06-09 12:51:09.041000',1,0),(92,'pbkdf2_sha256$100000$vIUbyIIkrIl2$H9bkW41YKIyPoODblB1ZjGdaaru9d9Myq1waQpZ+oU4=',NULL,0,'me_student89@epita.fr','Willy89','Williamson','','2018-06-09 12:51:09.105000',1,0),(93,'pbkdf2_sha256$100000$hmxfwuUIdbtS$Y/IJaJSTDGqLsJ66MQnacBtEWtpCh4ihmvGIIPfA64o=',NULL,0,'me_student90@epita.fr','Willy90','Williamson','','2018-06-09 12:51:09.192000',1,0),(94,'pbkdf2_sha256$100000$eOWTNHZNXiYI$djF15PSbqjSTBHCwqF9x9bl4pqWe3vQ1wG3qaWYvhl4=',NULL,0,'me_student91@epita.fr','Willy91','Williamson','','2018-06-09 12:51:09.256000',1,0),(95,'pbkdf2_sha256$100000$T8O27CJfAxhs$AJqtmdLyPaJEab6mAMrxiKcPierjuAoIf44hcqTqB/s=',NULL,0,'me_student92@epita.fr','Willy92','Williamson','','2018-06-09 12:51:09.319000',1,0),(96,'pbkdf2_sha256$100000$9B2w7MutJccP$N8+PGG1UjImm0mLun86bK3LVOvYwRgqrym8MVRXqnSM=',NULL,0,'me_student93@epita.fr','Willy93','Williamson','','2018-06-09 12:51:09.383000',1,0),(97,'pbkdf2_sha256$100000$Zra0w2dDP8xj$K+VIVj4d522w7xHMP/8K2nVNJ0ibrnBPnTTodev2HNA=',NULL,0,'me_student94@epita.fr','Willy94','Williamson','','2018-06-09 12:51:09.447000',1,0),(98,'pbkdf2_sha256$100000$jeRyecidBlkx$ms16GvQ3Smu46lTQ3EpGbIbDy/vo1QOFCyTCdnWHPAE=',NULL,0,'me_student95@epita.fr','Willy95','Williamson','','2018-06-09 12:51:09.511000',1,0),(99,'pbkdf2_sha256$100000$FpwydYESnxYw$yFt3Ua62KOwmo3+I5lT74zxaIVVEmILRZFLrTWkotGg=',NULL,0,'me_student96@epita.fr','Willy96','Williamson','','2018-06-09 12:51:09.583000',1,0),(100,'pbkdf2_sha256$100000$WR52pQvyIVn1$U858L+giYiYYWFgg42JgOagrdZY4+EKGapJFdGIZXd4=',NULL,0,'me_student97@epita.fr','Willy97','Williamson','','2018-06-09 12:51:09.656000',1,0),(101,'pbkdf2_sha256$100000$tcwzdSRvnzXz$MobA8bmphT5TBX7q9JVYg9qE5UUoSKSeexYQXOK7Lu8=',NULL,0,'me_student98@epita.fr','Willy98','Williamson','','2018-06-09 12:51:09.720000',1,0),(102,'pbkdf2_sha256$100000$XjpTxR8iZrNe$87WjDwWf9WoYBBJ9JFTY3lVExM0OPdLJmhagPuxITH8=',NULL,0,'me_student99@epita.fr','Willy99','Williamson','','2018-06-09 12:51:09.800000',1,0),(103,'pbkdf2_sha256$100000$fH96qGbRYZuk$SoQWA6c81jYZFejstPbWbN9lU/54I6ZYrUPDrm7yETI=',NULL,0,'me_student100@epita.fr','Willy100','Williamson','','2018-06-09 12:51:09.894000',1,0),(104,'pbkdf2_sha256$100000$BkrfdtGhA1SK$SCpt9iJrhqFFzc6FhHLnjV7TF/NjrSYKfZL6o3DGAEU=',NULL,0,'me_student101@epita.fr','Willy101','Williamson','','2018-06-09 12:51:09.959000',1,0),(105,'pbkdf2_sha256$100000$8frTmrewjeKu$MFr60rI4rDqKbXpILf8QF3BvD2WfCmPGIY2dJXKLL+8=',NULL,0,'me_student102@epita.fr','Willy102','Williamson','','2018-06-09 12:51:10.024000',1,0),(106,'pbkdf2_sha256$100000$cNB77pcKr3Ci$ULv8ZDCHuCXw9WXa9QOzxmRYqJ0xLmFNmpkHYVKcT7I=',NULL,0,'me_student103@epita.fr','Willy103','Williamson','','2018-06-09 12:51:10.091000',1,0),(107,'pbkdf2_sha256$100000$ddPtC3bYg4jy$pa20j/2z6hROAxeQJAvRRP1i9C4p+O3Oc1g/p1wX0eM=',NULL,0,'me_student104@epita.fr','Willy104','Williamson','','2018-06-09 12:51:10.186000',1,0),(108,'pbkdf2_sha256$100000$2awf1iGikDj2$XHJnTHufevJCHlMLCl1GrYAG6wabTP/6ke30nvVd9Ak=',NULL,0,'me_student105@epita.fr','Willy105','Williamson','','2018-06-09 12:51:10.248000',1,0),(109,'pbkdf2_sha256$100000$CJShD6HsWFzW$HWW0jOAxIE+jZhSYOBJCLLt1r+0h39wYSilQYqI1zyw=',NULL,0,'me_student106@epita.fr','Willy106','Williamson','','2018-06-09 12:51:10.314000',1,0),(110,'pbkdf2_sha256$100000$PmbGxE0lBthA$Boz3bNph6fnMEqrj/zLnPL1pMDyBrRK6d/+PBXdxVNI=',NULL,0,'me_student107@epita.fr','Willy107','Williamson','','2018-06-09 12:51:10.376000',1,0),(111,'pbkdf2_sha256$100000$0tgnooTHp5eX$G8LF54boUxmHvZKQEy4V02crkc90N/9bJ+pUONrhaIA=',NULL,0,'me_student108@epita.fr','Willy108','Williamson','','2018-06-09 12:51:10.446000',1,0),(112,'pbkdf2_sha256$100000$b5oeviBlLil5$6SVXcGEih9dJKjOdrKeRyyAmwy+wWYSr3tjEKf8DKho=',NULL,0,'me_student109@epita.fr','Willy109','Williamson','','2018-06-09 12:51:10.510000',1,0),(113,'pbkdf2_sha256$100000$0PDR3YPV9P0F$AjMNe0EiSVxz5yo/O2nh8QQrtvTHmItYfWDJey3cgvo=',NULL,0,'me_student110@epita.fr','Willy110','Williamson','','2018-06-09 12:51:10.575000',1,0),(114,'pbkdf2_sha256$100000$2ToBo6PMhm9h$h2q9OncLjorVJdZMb1x0TMl8DAhsiahhML1tkeiN0mo=',NULL,0,'me_student111@epita.fr','Willy111','Williamson','','2018-06-09 12:51:10.641000',1,0),(115,'pbkdf2_sha256$100000$rdGkhvdqI3ek$jkqLnigfC57WIFOj6lupMO5TItNDmWWl6TlX7EiMDRo=',NULL,0,'me_student112@epita.fr','Willy112','Williamson','','2018-06-09 12:51:10.707000',1,0),(116,'pbkdf2_sha256$100000$JCmh0eJYXZFX$QDHKYSww9xtEu4ntgq8Ri1MxsmQIeHs8TiOXdGCyKoE=',NULL,0,'me_student113@epita.fr','Willy113','Williamson','','2018-06-09 12:51:10.774000',1,0),(117,'pbkdf2_sha256$100000$9g8TeLELpFiz$hd/Mp8C/NOxq6+KQ9Vwfxzn6vnTqX0tqQlYp+xnnGL8=',NULL,0,'me_student114@epita.fr','Willy114','Williamson','','2018-06-09 12:51:10.840000',1,0),(118,'pbkdf2_sha256$100000$eHV8pMPBOG4V$YpI6WUFd/g6wrtaOYpU8RFJ+XUbJTK2gcSyxkbrYcS4=',NULL,0,'me_student115@epita.fr','Willy115','Williamson','','2018-06-09 12:51:10.904000',1,0),(119,'pbkdf2_sha256$100000$1gUgNCnBaZNe$G/f3KsDZhCD1/tdl4/u2vhDpoDNwCkqxfIJ0HzSuMzU=',NULL,0,'me_student116@epita.fr','Willy116','Williamson','','2018-06-09 12:51:10.969000',1,0),(120,'pbkdf2_sha256$100000$BVJJhfsMfz0g$B2npVeIwO80UCK8poIK6YZrmeXJ5dzN+YSsNG97evsw=',NULL,0,'me_student117@epita.fr','Willy117','Williamson','','2018-06-09 12:51:11.033000',1,0),(121,'pbkdf2_sha256$100000$ChoHc50zO9L5$mED39y1t9Poc9WiH1/mhtznzLHzwmLw5BHO402mTy78=',NULL,0,'me_student118@epita.fr','Willy118','Williamson','','2018-06-09 12:51:11.114000',1,0),(122,'pbkdf2_sha256$100000$QZI1gLFdszKI$j6GCrqwl1soLgbQur+B8IC3PBL6NWNbmMUNC8+QB7Os=',NULL,0,'me_student119@epita.fr','Willy119','Williamson','','2018-06-09 12:51:11.176000',1,0),(123,'pbkdf2_sha256$100000$ozXgpLBRQzQr$u8WbVjv6nq16fVL4bUTRXS1yd3rFU9lGCqGXus1hyJ4=',NULL,0,'me_student120@epita.fr','Willy120','Williamson','','2018-06-09 12:51:11.241000',1,0),(124,'pbkdf2_sha256$100000$5Ew0xY9sifmL$z3UzibWsS3HreCdaNWtlp/E+EIXtkfGTElWzz9bDxqY=',NULL,0,'me_student121@epita.fr','Willy121','Williamson','','2018-06-09 12:51:11.323000',1,0),(125,'pbkdf2_sha256$100000$owDH3Q4sGfMS$kXQBliHvcQ0KF/TIEI90Cju0jZbu8DgB1ZuowvDj8ok=',NULL,0,'me_student122@epita.fr','Willy122','Williamson','','2018-06-09 12:51:11.387000',1,0),(126,'pbkdf2_sha256$100000$ocLDNcv55bWa$zldyGjk4GFzt87WeMcL4Hc+4WLLiKTNg+sz6BappeCs=',NULL,0,'me_student123@epita.fr','Willy123','Williamson','','2018-06-09 12:51:11.481000',1,0),(127,'pbkdf2_sha256$100000$bX5MhuMdDLZc$r6TX9GKE26CkajskHXZjHOxc7euHZTGwphc5NOsyhk8=',NULL,0,'me_student124@epita.fr','Willy124','Williamson','','2018-06-09 12:51:11.546000',1,0),(128,'pbkdf2_sha256$100000$o3zLO55igfhP$55Q45t6YYPlfUffvL3ldERweFHrbnpiEx/8bYOb8ZuU=',NULL,0,'me_student125@epita.fr','Willy125','Williamson','','2018-06-09 12:51:11.636000',1,0),(129,'pbkdf2_sha256$100000$5N4pSHciWqjE$ZqG8KgxfGAsOx1IIJ7NzbyFVRKWSLnlYmzDUIciOFEM=',NULL,0,'me_student126@epita.fr','Willy126','Williamson','','2018-06-09 12:51:11.700000',1,0),(130,'pbkdf2_sha256$100000$1d7hwMB4D67B$k8Fx1aehQYAyk7ywkasJh32vIWCNpEgLwrWfOwlv5rY=',NULL,0,'me_student127@epita.fr','Willy127','Williamson','','2018-06-09 12:51:11.783000',1,0),(131,'pbkdf2_sha256$100000$gT3uNJ6Lonxy$6Np610buldQjSTXB/Z9SxM6h84Jnypj4H/zNqThtMSA=',NULL,0,'me_student128@epita.fr','Willy128','Williamson','','2018-06-09 12:51:11.847000',1,0),(132,'pbkdf2_sha256$100000$eM45VRbVpjoD$X8JWHVarfJlliz5/Z0yXu7RY5c8DqfLD8P+lHqRB+JA=',NULL,0,'me_student129@epita.fr','Willy129','Williamson','','2018-06-09 12:51:11.937000',1,0),(133,'pbkdf2_sha256$100000$muv6STklWil3$lm8cnmTICJn4DD06YiLdWvq2wn8fDNg5mmSDhmPzjuQ=',NULL,0,'me_student130@epita.fr','Willy130','Williamson','','2018-06-09 12:51:12.013000',1,0),(134,'pbkdf2_sha256$100000$5MgMFbTVFf7k$Mj8grmbTruEGnITcKq43Tr/BniyPflN/e/Ao2orzbJM=',NULL,0,'me_student131@epita.fr','Willy131','Williamson','','2018-06-09 12:51:12.076000',1,0),(135,'pbkdf2_sha256$100000$F9W16MUpkQ6G$7ynn2Nbvx/cY8RrIGbQDJ1B/17BP6JvxZdwTXf/4E7I=',NULL,0,'me_student132@epita.fr','Willy132','Williamson','','2018-06-09 12:51:12.140000',1,0),(136,'pbkdf2_sha256$100000$7gMxwXSG4ONM$SsgzjYFsfolqEDJgUqes7tYfTmfEb7JEOMZ6HttMzSk=',NULL,0,'me_student133@epita.fr','Willy133','Williamson','','2018-06-09 12:51:12.231000',1,0),(137,'pbkdf2_sha256$100000$oUk8T3f2GHP8$4CHGypoOylt+vk5rseW6HUeogylM8rpFyq7FguXcncI=',NULL,0,'msc_student0@epita.fr','John0','Johnson','','2018-06-09 12:51:30.203000',1,0),(138,'pbkdf2_sha256$100000$LVbdz2ndwnbc$R2r0H0DY4vCl8rzVL6GmbEhIQaO0G+h6o2v5EYEoFwY=',NULL,0,'msc_student1@epita.fr','John1','Johnson','','2018-06-09 12:51:30.267000',1,0),(139,'pbkdf2_sha256$100000$Vo6uoU9S5lI8$Qtzv4BorIDUD2VVKXR47tiYvpwvDSxjhcQBDkZxu97Y=',NULL,0,'msc_student2@epita.fr','John2','Johnson','','2018-06-09 12:51:30.331000',1,0),(140,'pbkdf2_sha256$100000$4KVkHRVsOwON$sHNISp9Ge8TGCGy3z/5ha3IiX4VRecen17PRqMgAHuE=',NULL,0,'msc_student3@epita.fr','John3','Johnson','','2018-06-09 12:51:30.422000',1,0),(141,'pbkdf2_sha256$100000$uSLlLTj2EOeJ$9U3/U5yXd2jDUmZf6dcCdrrGWym/GJqYN/PyQfNwMXQ=',NULL,0,'msc_student4@epita.fr','John4','Johnson','','2018-06-09 12:51:30.484000',1,0),(142,'pbkdf2_sha256$100000$8ntV5D0C38DL$5tIBkNjkX99iToX7yS+FZwYbeMbRMQnYtCo/Vt2nE74=',NULL,0,'msc_student5@epita.fr','John5','Johnson','','2018-06-09 12:51:30.549000',1,0),(143,'pbkdf2_sha256$100000$fnHilLHm7soH$OfjWUnd3+ZHR6Gmd1XfXlBWiXA8MmT8tKLk7U1yrXDs=',NULL,0,'msc_student6@epita.fr','John6','Johnson','','2018-06-09 12:51:30.612000',1,0),(144,'pbkdf2_sha256$100000$Io57BQBgFc2b$TAkQk9Z4dci+jMkstdWbnOAUPhZdKaIvzG/KHAIj6fc=',NULL,0,'msc_student7@epita.fr','John7','Johnson','','2018-06-09 12:51:30.677000',1,0),(145,'pbkdf2_sha256$100000$Ug2BTkiN7R6L$Hszyqu05fhvUY2kQyHA8unCrINR1UOHPQLq2Vyk80hc=',NULL,0,'msc_student8@epita.fr','John8','Johnson','','2018-06-09 12:51:30.741000',1,0),(146,'pbkdf2_sha256$100000$e1iUcQ4P1ETN$5SkYqW6yK69fiBnkDLibKtM+FRify7vyQuW2zv1LYCM=',NULL,0,'msc_student9@epita.fr','John9','Johnson','','2018-06-09 12:51:30.829000',1,0),(147,'pbkdf2_sha256$100000$VdQpFmKg69MD$rBAwOCFERPamC8HnmzSmxQOPcaCfmVtbazTQvdzcan4=',NULL,0,'msc_student10@epita.fr','John10','Johnson','','2018-06-09 12:51:30.893000',1,0),(148,'pbkdf2_sha256$100000$QkTRiiRq3y0e$ZUSg7nvfwHM+AnSDRDEdBRULbEDD1Nkv+SF6BkYgIM4=',NULL,0,'msc_student11@epita.fr','John11','Johnson','','2018-06-09 12:51:30.960000',1,0),(149,'pbkdf2_sha256$100000$sKV5fs2iLA56$WFIPDbiGBXe4aNFqHb59elvPCqB8EptSUYsXBhRW/cI=',NULL,0,'msc_student12@epita.fr','John12','Johnson','','2018-06-09 12:51:31.023000',1,0),(150,'pbkdf2_sha256$100000$Kfi4CWPlmuTV$AqDCFAwsxekxDbvv86z4XkdfAZDwpU11nRe5A3Gbcvg=',NULL,0,'msc_student13@epita.fr','John13','Johnson','','2018-06-09 12:51:31.085000',1,0),(151,'pbkdf2_sha256$100000$aVWnt4E3VTCW$alCJ/o1iUALJU2rU7XpE6yl3XtCLta7CNDcgBzORw/w=',NULL,0,'msc_student14@epita.fr','John14','Johnson','','2018-06-09 12:51:31.149000',1,0),(152,'pbkdf2_sha256$100000$UhZjspg9ULhd$93HLdTPQYb3P9MmS1bg3tTae2+Wgu3Wa3cgqdPOZvtk=',NULL,0,'msc_student15@epita.fr','John15','Johnson','','2018-06-09 12:51:31.213000',1,0),(153,'pbkdf2_sha256$100000$bEpl93qM3sWL$m5dczXse4x3dR1Qf/icPJfcfSPJ842q+I4JCl4B52vA=',NULL,0,'msc_student16@epita.fr','John16','Johnson','','2018-06-09 12:51:31.278000',1,0),(154,'pbkdf2_sha256$100000$BF7B2eEwQHVK$o8TZKHlSsKDhd9C0kQ12pACpAvXcYHFmTlGuhnbzmLU=',NULL,0,'msc_student17@epita.fr','John17','Johnson','','2018-06-09 12:51:31.339000',1,0),(155,'pbkdf2_sha256$100000$n10q68R80oPM$FU95GbUYyWxmv8evIaPV8zXJVGEks6NhLcKwCzVgeLA=',NULL,0,'msc_student18@epita.fr','John18','Johnson','','2018-06-09 12:51:31.403000',1,0),(156,'pbkdf2_sha256$100000$frZojJQV7Dj7$OBeU1o9I91kSCiJy9FutEESbLLG8wGCTwIO8j8H6Dmo=',NULL,0,'msc_student19@epita.fr','John19','Johnson','','2018-06-09 12:51:31.467000',1,0),(157,'pbkdf2_sha256$100000$1Xmj5wJDmRDB$SoWnGbphBZ2HFCuOP8e3VRrcFcL3x6DRgLf8l1PYlOc=',NULL,0,'msc_student20@epita.fr','John20','Johnson','','2018-06-09 12:51:31.531000',1,0),(158,'pbkdf2_sha256$100000$MGYM0nGHQkUk$DLCWfYw3d3mugWYv6xGQ0pcAl48jhxr7kYInIefEbWo=',NULL,0,'msc_student21@epita.fr','John21','Johnson','','2018-06-09 12:51:31.594000',1,0),(159,'pbkdf2_sha256$100000$f71bpObz8eNI$66Z2wCSGXG8ysYQCuQkmfp9k0A1W78KC/pKlXYG2qUQ=',NULL,0,'msc_student22@epita.fr','John22','Johnson','','2018-06-09 12:51:31.658000',1,0),(160,'pbkdf2_sha256$100000$CG5B8yYEQ828$VV2iJgpiSVWxmG409GKjVjVSESrz0qPAtRFp+YpbGeE=',NULL,0,'msc_student23@epita.fr','John23','Johnson','','2018-06-09 12:51:31.742000',1,0),(161,'pbkdf2_sha256$100000$KIGSJxvZUQPw$UKrB04kgF9WLUnr3Nunf3HZ1pr3OczpIKzNatzGsugI=',NULL,0,'msc_student24@epita.fr','John24','Johnson','','2018-06-09 12:51:31.817000',1,0),(162,'pbkdf2_sha256$100000$FdmBd4tkqKMb$2vAYHTZWCnJw8xdhCbTjbZx8DplY1dE8oIKCIyWlFcU=',NULL,0,'msc_student25@epita.fr','John25','Johnson','','2018-06-09 12:51:31.889000',1,0),(163,'pbkdf2_sha256$100000$yKCW4bt0860f$P1qIlnTXyH/dc7kiLXYdRyIWDORQ+m6SdMhsQfZGrIs=',NULL,0,'msc_student26@epita.fr','John26','Johnson','','2018-06-09 12:51:31.953000',1,0),(164,'pbkdf2_sha256$100000$TJ4Ly8JgnNwz$6Wx1HcDzhDaxScc9JNYuWr5t+vME6I/Zzupe++AHElM=',NULL,0,'msc_student27@epita.fr','John27','Johnson','','2018-06-09 12:51:32.016000',1,0),(165,'pbkdf2_sha256$100000$xLrpr5FSyUns$1awSSGzUK53sCXIJ3Y0KqSgd/0oWAU3SmMDNLgRZqVo=',NULL,0,'msc_student28@epita.fr','John28','Johnson','','2018-06-09 12:51:32.080000',1,0),(166,'pbkdf2_sha256$100000$LjkHFUhxpYo9$ADMctB9qkj4wNAWqneZdNjH3yhNpxrgvVg1sFl/Wlgo=',NULL,0,'msc_student29@epita.fr','John29','Johnson','','2018-06-09 12:51:32.147000',1,0),(167,'pbkdf2_sha256$100000$tRHvnJTs0TAf$5wFE6F7z9hucCZ/j1dMlBZJjAnDjaXd7BNKDaW95Nxg=',NULL,0,'msc_student30@epita.fr','John30','Johnson','','2018-06-09 12:51:32.210000',1,0),(168,'pbkdf2_sha256$100000$14KYv0OgKCyD$KJA4/AXbha62+/I5ijg1eFF1+evAlHBGi22uWLqfKKI=',NULL,0,'msc_student31@epita.fr','John31','Johnson','','2018-06-09 12:51:32.282000',1,0),(169,'pbkdf2_sha256$100000$cuWjiA7rRw52$H1wRDEMdMnT/uf2k+KT4nrtOFHBp3QOsA7aDKyeW/fI=',NULL,0,'msc_student32@epita.fr','John32','Johnson','','2018-06-09 12:51:32.348000',1,0),(170,'pbkdf2_sha256$100000$gc0JDF43kBUI$30XWJebfflbPi57iy2M12KQqtr8iJYI5BpjHn/5NiOE=',NULL,0,'msc_student33@epita.fr','John33','Johnson','','2018-06-09 12:51:32.411000',1,0),(171,'pbkdf2_sha256$100000$LVVv6rKumTX6$wEEaVBBCmKMCn8EorB5nd1pKJaYJVjjQxxAajhXo+2A=',NULL,0,'msc_student34@epita.fr','John34','Johnson','','2018-06-09 12:51:32.498000',1,0),(172,'pbkdf2_sha256$100000$jYyIKrHkLqp8$l7YT/AI7vRcy7fq+kTjdEcjVceQxo0Hafq8iXzZ6mJE=',NULL,0,'msc_student35@epita.fr','John35','Johnson','','2018-06-09 12:51:32.576000',1,0),(173,'pbkdf2_sha256$100000$kkS1xXQBKHnY$vV3cv7brotEVMFRwU3yI7RD5SX2n1/hkc1DiV9QrPN8=',NULL,0,'msc_student36@epita.fr','John36','Johnson','','2018-06-09 12:51:32.640000',1,0),(174,'pbkdf2_sha256$100000$eYyV7ucdBZ9Q$Uxpt3wG2+zV1dSgfsOySraGXxrqaUkFJBYqATJ2Pefs=',NULL,0,'msc_student37@epita.fr','John37','Johnson','','2018-06-09 12:51:32.704000',1,0),(175,'pbkdf2_sha256$100000$tAFK4Gf520Rk$3+DtCrRISwjeWOzOumSt0uJ6t4EGxs4yeCqT07ABv/g=',NULL,0,'msc_student38@epita.fr','John38','Johnson','','2018-06-09 12:51:32.771000',1,0),(176,'pbkdf2_sha256$100000$ZclELItU4SWv$+a9Bfuu2kqfjYd13pwYTDby1peDfer/Id4jTSCyuTYc=',NULL,0,'msc_student39@epita.fr','John39','Johnson','','2018-06-09 12:51:32.832000',1,0),(177,'pbkdf2_sha256$100000$eWD3HIbgK9K2$lBiLxRGwO0ftT0E8npUzdW4cl7K9R4UYQFhzSdibu4A=',NULL,0,'msc_student40@epita.fr','John40','Johnson','','2018-06-09 12:51:32.895000',1,0),(178,'pbkdf2_sha256$100000$h75DWnkMvm7s$z3jzHfxZ+zLuIkE1nDZnKJab8AYbvq9u/ndmbglNQkI=',NULL,0,'msc_student41@epita.fr','John41','Johnson','','2018-06-09 12:51:32.958000',1,0),(179,'pbkdf2_sha256$100000$MUrrY6iLBSwk$yI/6i7i6pzgmk6yMWyNBol0s3Gs3ea71Y3w5DSvPNLs=',NULL,0,'msc_student42@epita.fr','John42','Johnson','','2018-06-09 12:51:33.020000',1,0),(180,'pbkdf2_sha256$100000$OM3PvZAF3pWT$t2wQUlOkEKyBdMi4o/8DvwLxfTGT4X4v2pJAdzWZtJA=',NULL,0,'msc_student43@epita.fr','John43','Johnson','','2018-06-09 12:51:33.106000',1,0),(181,'pbkdf2_sha256$100000$4VA1pioznvmH$ljmKqYP1FrZaurKlt6Wrj8E5cewqUSwf9W1i3SWWleI=',NULL,0,'msc_student44@epita.fr','John44','Johnson','','2018-06-09 12:51:33.170000',1,0),(182,'pbkdf2_sha256$100000$9OBlRAZ4bLT1$D09R+tKHJ7PPVwBcscXsqq1YeXkl+qEsQR/hVqPyuOQ=',NULL,0,'msc_student45@epita.fr','John45','Johnson','','2018-06-09 12:51:33.247000',1,0),(183,'pbkdf2_sha256$100000$di55d3UVby5D$o09ALNaBT122Hw1wsrU5sFAx70y8TxNe2SOOwv5waLs=',NULL,0,'msc_student46@epita.fr','John46','Johnson','','2018-06-09 12:51:33.314000',1,0),(184,'pbkdf2_sha256$100000$vwjNc3stGsV3$R2iGIXlUe1UZi5T85OwivM+prujl2Ib32EglqdxuFNg=',NULL,0,'msc_student47@epita.fr','John47','Johnson','','2018-06-09 12:51:33.375000',1,0),(185,'pbkdf2_sha256$100000$fUVUpeBRGBdM$PYr4IUnTlZPjwmP+daPY2R8KpWgkwxifcFuzH+YlwIA=',NULL,0,'msc_student48@epita.fr','John48','Johnson','','2018-06-09 12:51:33.439000',1,0),(186,'pbkdf2_sha256$100000$wTSE9SFyCiWU$of3LpNXecIBEJnL5pvda3AEDlBAx2qgWNG/jnt7sNxg=',NULL,0,'msc_student49@epita.fr','John49','Johnson','','2018-06-09 12:51:33.500000',1,0),(187,'pbkdf2_sha256$100000$KsY6HibPZtg5$nt5bBZG2lbsB8iJuuDhllXZpFBBOcLDyQsYop0XaCig=',NULL,0,'msc_student50@epita.fr','John50','Johnson','','2018-06-09 12:51:33.563000',1,0),(188,'pbkdf2_sha256$100000$5fRagnQyW214$ewuYTVmX+a/l9WWku/Ptp+G5WCBq+KzFspCAwBenA/M=',NULL,0,'msc_student51@epita.fr','John51','Johnson','','2018-06-09 12:51:33.631000',1,0),(189,'pbkdf2_sha256$100000$eCLxjFpCJUmF$i4d7gVOQVOZp9qN9zCW4Hhpj+VJlEXe4KM2ctbi1g4c=',NULL,0,'msc_student52@epita.fr','John52','Johnson','','2018-06-09 12:51:33.698000',1,0),(190,'pbkdf2_sha256$100000$mvmK8oJUtrWh$kArFYeKFi1wqjdoZM3QmJalY5O62PyA4Fwcx8FkwIvI=',NULL,0,'msc_student53@epita.fr','John53','Johnson','','2018-06-09 12:51:33.787000',1,0),(191,'pbkdf2_sha256$100000$YyNxb67ZwnOC$Ke+4vjEeKOOXZcloI67NTiAPYG8vMqiMwE9rp1IY7A8=',NULL,0,'msc_student54@epita.fr','John54','Johnson','','2018-06-09 12:51:33.851000',1,0),(192,'pbkdf2_sha256$100000$lA6kVINbgC4V$ECQiMzty1dq5yseBdv8emFOqqKWOkmv8iCsF+D9kjBQ=',NULL,0,'msc_student55@epita.fr','John55','Johnson','','2018-06-09 12:51:33.916000',1,0),(193,'pbkdf2_sha256$100000$aHcFKVsZmwUG$gRNwxF/HuHn3OGl6wI+qaFcMUovn4Px7bXXBj7eq2Zs=',NULL,0,'msc_student56@epita.fr','John56','Johnson','','2018-06-09 12:51:33.979000',1,0),(194,'pbkdf2_sha256$100000$lkd1LsTDooHl$1sntFXqn3+ieqUk/LjiMUWZikJ5jGbHSy2HhKfCBGiQ=',NULL,0,'msc_student57@epita.fr','John57','Johnson','','2018-06-09 12:51:34.059000',1,0),(195,'pbkdf2_sha256$100000$eigFuuxeZmto$DXUdd3ookveYwjUrG69p/BXGbxU7a2e01PBBeixyXQ0=',NULL,0,'msc_student58@epita.fr','John58','Johnson','','2018-06-09 12:51:34.123000',1,0),(196,'pbkdf2_sha256$100000$IFOeyNWYZrIB$gH5ohc2OPTaWJIfNL65pbFUklsvFqbaWxVg/3h3UgRQ=',NULL,0,'msc_student59@epita.fr','John59','Johnson','','2018-06-09 12:51:34.185000',1,0),(197,'pbkdf2_sha256$100000$rqn4Rk4yw55I$rmDB2DBwBn3JVtVwUjnEsVxzz9mfDpfyZIMkZwxgpbY=',NULL,0,'msc_student60@epita.fr','John60','Johnson','','2018-06-09 12:51:34.252000',1,0),(198,'pbkdf2_sha256$100000$k0frk4AOPJbn$qA6KO1KuYNwwhy2AL241sh2N0GT8VL6fx/Cj/iQA84Q=',NULL,0,'msc_student61@epita.fr','John61','Johnson','','2018-06-09 12:51:34.316000',1,0),(199,'pbkdf2_sha256$100000$lHO2EcbiGf63$JAEEAZ13HD81wVHNl2ZWBYkX2FoLJ9E1k6fOs27ikCM=',NULL,0,'msc_student62@epita.fr','John62','Johnson','','2018-06-09 12:51:34.380000',1,0),(200,'pbkdf2_sha256$100000$woj6e2daNkmd$woHGjaDMAz0Y8wVS2zFaq+tRGEcafKgR8zCP5iteFbw=',NULL,0,'msc_student63@epita.fr','John63','Johnson','','2018-06-09 12:51:34.444000',1,0),(201,'pbkdf2_sha256$100000$v1IvNZMx3ox8$cd2YrmcvNpHiUCslTAW95bV6gkYNzEXkYMaDD1roORw=',NULL,0,'msc_student64@epita.fr','John64','Johnson','','2018-06-09 12:51:34.508000',1,0),(202,'pbkdf2_sha256$100000$58TCIC7WBM8X$m4pQ+bKK1z9uCvXNWiCu/zjszX0ekd7G/HJMSfvSjhg=',NULL,0,'msc_student65@epita.fr','John65','Johnson','','2018-06-09 12:51:34.573000',1,0),(203,'pbkdf2_sha256$100000$17U6M8d3DOAq$go7z7NAyZ/on7RFzki1DbRijZOJPSmrCqE91sm5ss5I=',NULL,0,'msc_student66@epita.fr','John66','Johnson','','2018-06-09 12:51:34.636000',1,0),(204,'pbkdf2_sha256$100000$Zw7sZLG68W9T$KK3ZEZJnmiwtoyvx2CJiYiLJaqo02M0H78OvvuAPFns=',NULL,0,'msc_student67@epita.fr','John67','Johnson','','2018-06-09 12:51:34.731000',1,0),(205,'pbkdf2_sha256$100000$xSRJRPqCt3ec$v5GWZfstXLPUC5AqZDrxM9Kc/MWnAfp1aGnV1oBI6sw=',NULL,0,'msc_student68@epita.fr','John68','Johnson','','2018-06-09 12:51:34.813000',1,0),(206,'pbkdf2_sha256$100000$Qxj382SvAKip$m6Q+eBnRlB3PBS7HNmjiwCngHCrENnBF5guzXfXKt0I=',NULL,0,'msc_student69@epita.fr','John69','Johnson','','2018-06-09 12:51:34.877000',1,0),(207,'pbkdf2_sha256$100000$ZJfFiOLk9dxW$SHX4VhUh+YGEaZm3nrcliTRos2oMwBZehgx3rOxCdEk=',NULL,0,'msc_student70@epita.fr','John70','Johnson','','2018-06-09 12:51:34.949000',1,0),(208,'pbkdf2_sha256$100000$bZPgmv8BPVaZ$qimjR5wIH0TUWCBBkI3xYQQNMxSB6+WFie6rHYLAEeg=',NULL,0,'msc_student71@epita.fr','John71','Johnson','','2018-06-09 12:51:35.021000',1,0),(209,'pbkdf2_sha256$100000$xyecDmXUgNPA$FWfzJ9TPlgFyyeOAUPGCu7fet8wTlz2nPLBuUhleaAc=',NULL,0,'msc_student72@epita.fr','John72','Johnson','','2018-06-09 12:51:35.085000',1,0),(210,'pbkdf2_sha256$100000$PTVv4NU7KjX3$IL/PcWSc1TYhyhEa0wzLrU2/SjN1NbCh/GWdmx0iip0=',NULL,0,'msc_student73@epita.fr','John73','Johnson','','2018-06-09 12:51:35.171000',1,0),(211,'pbkdf2_sha256$100000$2y3UWFbApwGb$HRL/IPIv1BmQXvBF45rZ2+E74euRWsQYCusMVWteR2k=',NULL,0,'msc_student74@epita.fr','John74','Johnson','','2018-06-09 12:51:35.236000',1,0),(212,'pbkdf2_sha256$100000$T1BmcDRsl7jm$Vg8Yd0W8aAPJGxDkZ4mCPTR8zJKsDfGRKE7zyz4L7fk=',NULL,0,'msc_student75@epita.fr','John75','Johnson','','2018-06-09 12:51:35.301000',1,0),(213,'pbkdf2_sha256$100000$Av33xrWLttkL$AaMUPTVyVbYIV4kTSlFPdhC9ho2jvR4Q5MIdKtZh66A=',NULL,0,'msc_student76@epita.fr','John76','Johnson','','2018-06-09 12:51:35.364000',1,0),(214,'pbkdf2_sha256$100000$r44SXQR747WX$l+0YeCZj7RrmOsiRjoFTOe1s+yHMngA4IoICt9fSHw8=',NULL,0,'msc_student77@epita.fr','John77','Johnson','','2018-06-09 12:51:35.428000',1,0),(215,'pbkdf2_sha256$100000$c29JcedgrrGT$DM/F4w5bM8yAApg6j52sZnAIhEnkVt2kDDqXCtqGC30=',NULL,0,'msc_student78@epita.fr','John78','Johnson','','2018-06-09 12:51:35.492000',1,0),(216,'pbkdf2_sha256$100000$fK6WTr41ElpB$V20k5Kc8Ob1PpRW/582NvwLlKVptBz53yI7m6KHm0sA=',NULL,0,'msc_student79@epita.fr','John79','Johnson','','2018-06-09 12:51:35.556000',1,0),(217,'pbkdf2_sha256$100000$mUuUhtZw3ntp$pYdcsud+Q4uaHC5GtL6NRGdGOetyDvDIC/nOVyye5us=',NULL,0,'msc_student80@epita.fr','John80','Johnson','','2018-06-09 12:51:35.620000',1,0),(218,'pbkdf2_sha256$100000$L1A7m1nCoSJs$qod+4ltIO4bn8S1JOgP/ew/WM/9QKJhrlOdSELoXB8Y=',NULL,0,'msc_student81@epita.fr','John81','Johnson','','2018-06-09 12:51:35.683000',1,0),(219,'pbkdf2_sha256$100000$InM6udJ0JLYc$yMQTYvf/gYprkaOzvze6b9RwFyj3G/3Sr6SqW2ViaAc=',NULL,0,'msc_student82@epita.fr','John82','Johnson','','2018-06-09 12:51:35.747000',1,0),(220,'pbkdf2_sha256$100000$YYOLyimr4heX$M4sUGeiktSzWny4uXMioyFzvghrWrR9ps39f5vq6VWM=',NULL,0,'msc_student83@epita.fr','John83','Johnson','','2018-06-09 12:51:35.811000',1,0),(221,'pbkdf2_sha256$100000$nBFt42bcsjxM$Df9v1+XV8NoUesGmBrGoiY3GpA+5okscUiMmAvGc0R8=',NULL,0,'msc_student84@epita.fr','John84','Johnson','','2018-06-09 12:51:35.875000',1,0),(222,'pbkdf2_sha256$100000$Ntfr7IVadCmb$pxXIVswwdrWg3zqwArSu0jiTk8cZf16jvC+XSF/br84=',NULL,0,'msc_student85@epita.fr','John85','Johnson','','2018-06-09 12:51:35.939000',1,0),(223,'pbkdf2_sha256$100000$GqGF3JipRgpL$3ycu9P32JtV1IyAGJvpC/B10pDgQVtSEfkDwwV6ZmH8=',NULL,0,'msc_student86@epita.fr','John86','Johnson','','2018-06-09 12:51:36.003000',1,0),(224,'pbkdf2_sha256$100000$AehJKwi37BWf$65KPWRrNvCti+vh8DyIA6BDLgv2BPDDV+ER1f1ls96Q=',NULL,0,'msc_student87@epita.fr','John87','Johnson','','2018-06-09 12:51:36.073000',1,0),(225,'pbkdf2_sha256$100000$sVq3XZvZrUFA$NQEuBPqLIKsS2CBG3AGDVcCOfduFlH1bzcqWS97kvn0=',NULL,0,'msc_student88@epita.fr','John88','Johnson','','2018-06-09 12:51:36.136000',1,0),(226,'pbkdf2_sha256$100000$uIswmk0FlmCK$aRLxcRw6Mh/oNma6KAM7N0pzwl+dr8fV8ZscNOOGK8Y=',NULL,0,'msc_student89@epita.fr','John89','Johnson','','2018-06-09 12:51:36.201000',1,0),(227,'pbkdf2_sha256$100000$QWVW6qLztAMt$sVmdtAURRVwnQr9kOWwJ5ljKjbQhVce9Fh8KLS8QJMw=',NULL,0,'msc_student90@epita.fr','John90','Johnson','','2018-06-09 12:51:36.264000',1,0),(228,'pbkdf2_sha256$100000$i7lqOcKnWSYy$QXEyKtYOrgFqwbvl2buZjPVi04H/5IHTTpaxfwph8wI=',NULL,0,'msc_student91@epita.fr','John91','Johnson','','2018-06-09 12:51:36.328000',1,0),(229,'pbkdf2_sha256$100000$UkSvJo30CdM8$H72eJYQksHkz/ZrHYcyISCIRS6JijdLDSdEzukmAxFk=',NULL,0,'msc_student92@epita.fr','John92','Johnson','','2018-06-09 12:51:36.391000',1,0),(230,'pbkdf2_sha256$100000$0YgqaPzpIfom$5gn2MMcv1K4SWWplUXI5f1nxe9IRJ4xohnSN6E58ScU=',NULL,0,'msc_student93@epita.fr','John93','Johnson','','2018-06-09 12:51:36.453000',1,0),(231,'pbkdf2_sha256$100000$fARAC7ajv8Yb$T/k4DuugsKwFzLb0EwrRezkYqJJvYW/ZcNjQlsiSVVc=',NULL,0,'msc_student94@epita.fr','John94','Johnson','','2018-06-09 12:51:36.516000',1,0),(232,'pbkdf2_sha256$100000$phFrZ50tVg32$4YwhEDTdNk3Fmt8oZECYAK0BFcathSJiCh9NNira5S0=',NULL,0,'msc_student95@epita.fr','John95','Johnson','','2018-06-09 12:51:36.580000',1,0),(233,'pbkdf2_sha256$100000$qrm3DN3J6I9B$rxK2OfQ/U1GbcYXUCsVTzTxj7nHQXlHJa4/qQZNj9lY=',NULL,0,'msc_student96@epita.fr','John96','Johnson','','2018-06-09 12:51:36.644000',1,0),(234,'pbkdf2_sha256$100000$8UhWh3om5hof$2GTsj5sApBDOldJ+ZAa0KzY+vXMBN3dYtAIQ/8SKFdM=',NULL,0,'msc_student97@epita.fr','John97','Johnson','','2018-06-09 12:51:36.708000',1,0),(235,'pbkdf2_sha256$100000$ESwDzbj9Fo3p$7w3fKp/tHgXm4kK3AEJQj981G9Rvimagygl91s99iuU=',NULL,0,'msc_student98@epita.fr','John98','Johnson','','2018-06-09 12:51:36.772000',1,0),(236,'pbkdf2_sha256$100000$uC99DxVbk4rl$NoLYuIQwQ3zpbeYXHe1eGEa9WpMCHppx8ksMCaP5Rek=',NULL,0,'msc_student99@epita.fr','John99','Johnson','','2018-06-09 12:51:36.840000',1,0),(237,'pbkdf2_sha256$100000$0jweEJBjnwqb$XuT7jEUNDWduIru4S173H9XSWSe8CHvtuSeGZGZ4poQ=',NULL,0,'msc_student100@epita.fr','John100','Johnson','','2018-06-09 12:51:36.903000',1,0),(238,'pbkdf2_sha256$100000$Lqq9k24y5vlu$VwOtHVCFo5ILoSQVto2NQfwzuVOcDM6mOKx/fCvNY+4=',NULL,0,'msc_student101@epita.fr','John101','Johnson','','2018-06-09 12:51:36.966000',1,0),(239,'pbkdf2_sha256$100000$ynSz79Jq861g$9/d0h3TgZH2GJC/aNeeLefv3SKG/iazUQXjV336wtyE=',NULL,0,'msc_student102@epita.fr','John102','Johnson','','2018-06-09 12:51:37.027000',1,0),(240,'pbkdf2_sha256$100000$jjCs9o7Q4uJk$phG46i8ixfPuE7jQdSDpvkGCCtl+SI+IbinmY9es5ag=',NULL,0,'msc_student103@epita.fr','John103','Johnson','','2018-06-09 12:51:37.091000',1,0),(241,'pbkdf2_sha256$100000$V1Mcgl9KmPdP$MmXrx8ox1gviT/GYvz5UzKqaB8ksSwvv3LBjY8Wb/cI=',NULL,0,'msc_student104@epita.fr','John104','Johnson','','2018-06-09 12:51:37.156000',1,0),(242,'pbkdf2_sha256$100000$YGROZ2WfCgGD$4Td2DX4QT+Up2AWKuUEQp8HBxzfzQKdlScoDvdo4Hfk=',NULL,0,'msc_student105@epita.fr','John105','Johnson','','2018-06-09 12:51:37.242000',1,0),(243,'pbkdf2_sha256$100000$yZkZRkWYl3Fl$BzeXUExfOEb74Rl33hEQKl9WFeVlMOL486Vns7GlcjE=',NULL,0,'msc_student106@epita.fr','John106','Johnson','','2018-06-09 12:51:37.304000',1,0),(244,'pbkdf2_sha256$100000$Xb7ztRSydIN3$5O4r1tKWnPG0ZunkSPUsglgulBjmb6Gy8i7j5+zOg7Y=',NULL,0,'msc_student107@epita.fr','John107','Johnson','','2018-06-09 12:51:37.368000',1,0),(245,'pbkdf2_sha256$100000$lTZx0pgQZdul$tTtMLfoyEu6Rp+nueaOgEdLJUUDNLRauIO3EB7iH050=',NULL,0,'msc_student108@epita.fr','John108','Johnson','','2018-06-09 12:51:37.432000',1,0),(246,'pbkdf2_sha256$100000$mFL5iFpkbSEb$k1vOTw76DwdfjU39borOFBqGUIox5o3rHuTiU6NAMMQ=',NULL,0,'msc_student109@epita.fr','John109','Johnson','','2018-06-09 12:51:37.498000',1,0),(247,'pbkdf2_sha256$100000$tQ8CdsYjIJEM$YzZfY2p6mO/uoNtjrzHnNjPCaYga4lLa66taYsnZAIs=',NULL,0,'msc_student110@epita.fr','John110','Johnson','','2018-06-09 12:51:37.564000',1,0),(248,'pbkdf2_sha256$100000$ExeJMrQokQeW$VUL/WItU/4GHDxi7JwDRuLM6ia3MjctQc/jxMK7w9PI=',NULL,0,'msc_student111@epita.fr','John111','Johnson','','2018-06-09 12:51:37.628000',1,0),(249,'pbkdf2_sha256$100000$zAIs4SKf3B2m$m4aLshyBjij1ks1MImf2ngs4a+P1cuBJqlEy3kXCY7g=',NULL,0,'msc_student112@epita.fr','John112','Johnson','','2018-06-09 12:51:37.712000',1,0),(250,'pbkdf2_sha256$100000$85j5PiNwUdse$vARcKOWTU/uTpifGtim9C0LQ65rPFOLjsP3rYE3YJ94=',NULL,0,'msc_student113@epita.fr','John113','Johnson','','2018-06-09 12:51:37.777000',1,0),(251,'pbkdf2_sha256$100000$LCOHFzHUcl0B$v7BXvu6FhnGnjjFh1kzIsrIiK1hp7/eb1UWhvnpMYF8=',NULL,0,'msc_student114@epita.fr','John114','Johnson','','2018-06-09 12:51:37.841000',1,0),(252,'pbkdf2_sha256$100000$LWfPVWrLOq4B$e9hTsa+KJaO2DA/xBtEJe4aUblGIvu9VRTU3dQCVefc=',NULL,0,'msc_student115@epita.fr','John115','Johnson','','2018-06-09 12:51:37.905000',1,0),(253,'pbkdf2_sha256$100000$ket0jt9fGoWs$yUZpghAPjGFUeuPzzfRkmx/zngUgK/nUitREBX2URt0=',NULL,0,'msc_student116@epita.fr','John116','Johnson','','2018-06-09 12:51:37.964000',1,0),(254,'pbkdf2_sha256$100000$yUSJs2CCcS0N$G3KzS/wD8ToeVzNlKxV6seln0IWSRf+sFEY97ex9e9A=',NULL,0,'msc_student117@epita.fr','John117','Johnson','','2018-06-09 12:51:38.042000',1,0),(255,'pbkdf2_sha256$100000$yWjfZ3gf7zpf$EbzAYKjqb4k1bR77nGVFLzKY+k/zsVBGw+3mmGaB/QI=',NULL,0,'msc_student118@epita.fr','John118','Johnson','','2018-06-09 12:51:38.107000',1,0),(256,'pbkdf2_sha256$100000$TdOuNhpBSmhQ$GdpQnqfAGWZlrOkesGfQkLpR9lKTU7vnEM+Na9dwoAQ=',NULL,0,'msc_student119@epita.fr','John119','Johnson','','2018-06-09 12:51:38.172000',1,0),(257,'pbkdf2_sha256$100000$eBstBH4xdkaW$nsNh9zU4D/X/+ydJMYnhqXdHE7/SzNVmby/8xwtuxl8=',NULL,0,'msc_student120@epita.fr','John120','Johnson','','2018-06-09 12:51:38.236000',1,0),(258,'pbkdf2_sha256$100000$XB5XfZ6d06kI$ZDR5js1nBlIN4O+cJsErmRkfNqZqjIqPwSLfG5XWN9U=',NULL,0,'msc_student121@epita.fr','John121','Johnson','','2018-06-09 12:51:38.300000',1,0),(259,'pbkdf2_sha256$100000$VjYgIGHGFx1O$k+4jmkX85D9WN5j1o3Ubvg03w0xtADtG7xoQLV++nvI=',NULL,0,'msc_student122@epita.fr','John122','Johnson','','2018-06-09 12:51:38.387000',1,0),(260,'pbkdf2_sha256$100000$9EvpXEL3KtWO$uKfXAwQr3Mxhbbaz4CTt4vSqpEoqVoZb1qxHtLxpSvg=',NULL,0,'msc_student123@epita.fr','John123','Johnson','','2018-06-09 12:51:38.448000',1,0),(261,'pbkdf2_sha256$100000$iRnm1I2XuTo8$ztuyxVPkZ6mLCuT+WyfFmuYmYheVSWoYE2bkdfO+d3g=',NULL,0,'msc_student124@epita.fr','John124','Johnson','','2018-06-09 12:51:38.512000',1,0),(262,'pbkdf2_sha256$100000$JNYxXwtCgHYe$eM3MGl0bCkkd/VYzB0BdDoRTmAVe1SfqJ3WMLxekEdA=',NULL,0,'msc_student125@epita.fr','John125','Johnson','','2018-06-09 12:51:38.576000',1,0),(263,'pbkdf2_sha256$100000$afU9pTqQzMTX$eXruhCyo3FiqaOomj9y3tx9ij7qlLIhjauBPGIfJOCs=',NULL,0,'msc_student126@epita.fr','John126','Johnson','','2018-06-09 12:51:38.640000',1,0),(264,'pbkdf2_sha256$100000$zVbA2onSVwHg$n3ESkmG1yOef7Pzs4q10N/PzLWtwhsPqbP0gOdtg2y8=',NULL,0,'msc_student127@epita.fr','John127','Johnson','','2018-06-09 12:51:38.727000',1,0),(265,'pbkdf2_sha256$100000$drAggIn000DD$WJiXyEp5Oe1IPH/sSWMmG5/MWOOm1ssMWmZTPTEkdKo=',NULL,0,'msc_student128@epita.fr','John128','Johnson','','2018-06-09 12:51:38.792000',1,0),(266,'pbkdf2_sha256$100000$WJqxDUuju5kR$cnPmEFBl7m4USB8blXy1taBmPT4fGUwYq8ApICdmDz4=',NULL,0,'msc_student129@epita.fr','John129','Johnson','','2018-06-09 12:51:38.856000',1,0),(267,'pbkdf2_sha256$100000$dXkkO6Keal3X$eaeC5vmWvd88P5Nr80btm5d2rFEa5hqaA9Cu6DobOOs=',NULL,0,'msc_student130@epita.fr','John130','Johnson','','2018-06-09 12:51:38.946000',1,0),(268,'pbkdf2_sha256$100000$D84FMVIzLY5K$ACVsQ0XfFbKkDMF4kEp5+M3GjthD3Jc6FxRrAyUb1TE=',NULL,0,'msc_student131@epita.fr','John131','Johnson','','2018-06-09 12:51:39.007000',1,0),(269,'pbkdf2_sha256$100000$qybKCuX8QLUN$LuIfPAv4WmCL/fU+awlhqrfmB5sik5mG+vWJDPBT5eM=',NULL,0,'msc_student132@epita.fr','John132','Johnson','','2018-06-09 12:51:39.105000',1,0),(270,'pbkdf2_sha256$100000$ITO8pcRLufVT$JbYTgD7ublCGo+7/rWKmw0Dn9/tJiLsN6WEegxaq408=',NULL,0,'msc_student133@epita.fr','John133','Johnson','','2018-06-09 12:51:39.169000',1,0);
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add attendance',6,'add_attendance'),(17,'Can change attendance',6,'change_attendance'),(18,'Can delete attendance',6,'delete_attendance'),(19,'Can add course',7,'add_course'),(20,'Can change course',7,'change_course'),(21,'Can delete course',7,'delete_course'),(22,'Can add grades',8,'add_grades'),(23,'Can change grades',8,'change_grades'),(24,'Can delete grades',8,'delete_grades'),(25,'Can add professor',9,'add_professor'),(26,'Can change professor',9,'change_professor'),(27,'Can delete professor',9,'delete_professor'),(28,'Can add schedule',10,'add_schedule'),(29,'Can change schedule',10,'change_schedule'),(30,'Can delete schedule',10,'delete_schedule'),(31,'Can add student',11,'add_student'),(32,'Can change student',11,'change_student'),(33,'Can delete student',11,'delete_student'),(34,'Can add student course',12,'add_studentcourse'),(35,'Can change student course',12,'change_studentcourse'),(36,'Can delete student course',12,'delete_studentcourse'),(37,'Can add user',13,'add_user'),(38,'Can change user',13,'change_user'),(39,'Can delete user',13,'delete_user'),(40,'Can add Option',14,'add_multiplechoiceoption'),(41,'Can change Option',14,'change_multiplechoiceoption'),(42,'Can delete Option',14,'delete_multiplechoiceoption'),(43,'Can add question',15,'add_question'),(44,'Can change question',15,'change_question'),(45,'Can delete question',15,'delete_question'),(46,'Can add Quiz',16,'add_quiz'),(47,'Can change Quiz',16,'change_quiz'),(48,'Can delete Quiz',16,'delete_quiz'),(49,'Can add quiz progression',17,'add_quizprogression'),(50,'Can change quiz progression',17,'change_quizprogression'),(51,'Can delete quiz progression',17,'delete_quizprogression'),(52,'Can add multiple choice question',18,'add_multiplechoicequestion'),(53,'Can change multiple choice question',18,'change_multiplechoicequestion'),(54,'Can delete multiple choice question',18,'delete_multiplechoicequestion'),(55,'Can add numeric scale question',19,'add_numericscalequestion'),(56,'Can change numeric scale question',19,'change_numericscalequestion'),(57,'Can delete numeric scale question',19,'delete_numericscalequestion'),(58,'Can add checkbox question',20,'add_checkboxquestion'),(59,'Can change checkbox question',20,'change_checkboxquestion'),(60,'Can delete checkbox question',20,'delete_checkboxquestion'),(61,'Can add room',21,'add_room'),(62,'Can change room',21,'change_room'),(63,'Can delete room',21,'delete_room');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-06-09 12:45:37.895000','2','John Professor',1,'[{\"added\": {}}]',13,1),(2,'2018-06-09 12:45:59.523000','1','Advanced C Programming',1,'[{\"added\": {}}]',7,1),(3,'2018-06-09 12:46:16.952000','2','Management Something or other',1,'[{\"added\": {}}]',7,1),(4,'2018-06-09 12:48:54.575000','3','Willy0 Williamson',3,'',13,1),(5,'2018-06-09 12:50:59.927000','5','Willy0 Williamson',3,'',13,1),(6,'2018-06-09 12:55:47.306000','1','Advanced C Programming 2018-06-09',1,'[{\"added\": {}}]',10,1),(7,'2018-06-09 12:55:53.801000','2','Management Something or other 2018-06-09',1,'[{\"added\": {}}]',10,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (13,'accounts','user'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(6,'epita','attendance'),(7,'epita','course'),(8,'epita','grades'),(9,'epita','professor'),(21,'epita','room'),(10,'epita','schedule'),(11,'epita','student'),(12,'epita','studentcourse'),(20,'quiz','checkboxquestion'),(14,'quiz','multiplechoiceoption'),(18,'quiz','multiplechoicequestion'),(19,'quiz','numericscalequestion'),(15,'quiz','question'),(16,'quiz','quiz'),(17,'quiz','quizprogression'),(5,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-06-11 12:59:30.867904'),(2,'contenttypes','0002_remove_content_type_name','2018-06-11 12:59:30.981546'),(3,'auth','0001_initial','2018-06-11 12:59:31.384164'),(4,'auth','0002_alter_permission_name_max_length','2018-06-11 12:59:31.403373'),(5,'auth','0003_alter_user_email_max_length','2018-06-11 12:59:31.424692'),(6,'auth','0004_alter_user_username_opts','2018-06-11 12:59:31.445689'),(7,'auth','0005_alter_user_last_login_null','2018-06-11 12:59:31.463376'),(8,'auth','0006_require_contenttypes_0002','2018-06-11 12:59:31.468761'),(9,'auth','0007_alter_validators_add_error_messages','2018-06-11 12:59:31.484462'),(10,'auth','0008_alter_user_username_max_length','2018-06-11 12:59:31.494197'),(11,'auth','0009_alter_user_last_name_max_length','2018-06-11 12:59:31.506364'),(12,'accounts','0001_initial','2018-06-11 12:59:31.996894'),(13,'admin','0001_initial','2018-06-11 12:59:32.216526'),(14,'admin','0002_logentry_remove_auto_add','2018-06-11 12:59:32.246489'),(15,'epita','0001_initial','2018-06-11 12:59:33.552252'),(16,'quiz','0001_initial','2018-06-11 12:59:34.667628'),(17,'sessions','0001_initial','2018-06-11 12:59:34.732723');
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
INSERT INTO `django_session` VALUES ('25qt1fekkcif46qsqjzzht1jshnsg9q4','Y2JjNDUzOGFjY2E3YjExOTAwZjgzMTI4MTRjYTE4MmIwZDFkMTI4Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5Y2ZmZDg2MTVmZDU5NjMxYTUxOGQ5NzZkYjVhNTZjNmQxMDVjNmI0In0=','2018-06-23 12:44:57.346000');
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
) ENGINE=InnoDB AUTO_INCREMENT=403 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epita_attendance`
--

LOCK TABLES `epita_attendance` WRITE;
/*!40000 ALTER TABLE `epita_attendance` DISABLE KEYS */;
INSERT INTO `epita_attendance` VALUES (1,2,'',NULL,1,1),(2,2,'',NULL,1,2),(3,2,'',NULL,1,3),(4,2,'',NULL,1,4),(5,2,'',NULL,1,5),(6,2,'',NULL,1,6),(7,2,'',NULL,1,7),(8,2,'',NULL,1,8),(9,2,'',NULL,1,9),(10,2,'',NULL,1,10),(11,2,'',NULL,1,11),(12,2,'',NULL,1,12),(13,2,'',NULL,1,13),(14,2,'',NULL,1,14),(15,2,'',NULL,1,15),(16,2,'',NULL,1,16),(17,2,'',NULL,1,17),(18,2,'',NULL,1,18),(19,2,'',NULL,1,19),(20,2,'',NULL,1,20),(21,2,'',NULL,1,21),(22,2,'',NULL,1,22),(23,2,'',NULL,1,23),(24,2,'',NULL,1,24),(25,2,'',NULL,1,25),(26,2,'',NULL,1,26),(27,2,'',NULL,1,27),(28,2,'',NULL,1,28),(29,2,'',NULL,1,29),(30,2,'',NULL,1,30),(31,2,'',NULL,1,31),(32,2,'',NULL,1,32),(33,2,'',NULL,1,33),(34,2,'',NULL,1,34),(35,2,'',NULL,1,35),(36,2,'',NULL,1,36),(37,2,'',NULL,1,37),(38,2,'',NULL,1,38),(39,2,'',NULL,1,39),(40,2,'',NULL,1,40),(41,2,'',NULL,1,41),(42,2,'',NULL,1,42),(43,2,'',NULL,1,43),(44,2,'',NULL,1,44),(45,2,'',NULL,1,45),(46,2,'',NULL,1,46),(47,2,'',NULL,1,47),(48,2,'',NULL,1,48),(49,2,'',NULL,1,49),(50,2,'',NULL,1,50),(51,2,'',NULL,1,51),(52,2,'',NULL,1,52),(53,2,'',NULL,1,53),(54,2,'',NULL,1,54),(55,2,'',NULL,1,55),(56,2,'',NULL,1,56),(57,2,'',NULL,1,57),(58,2,'',NULL,1,58),(59,2,'',NULL,1,59),(60,2,'',NULL,1,60),(61,2,'',NULL,1,61),(62,2,'',NULL,1,62),(63,2,'',NULL,1,63),(64,2,'',NULL,1,64),(65,2,'',NULL,1,65),(66,2,'',NULL,1,66),(67,2,'',NULL,1,67),(68,2,'',NULL,1,68),(69,2,'',NULL,1,69),(70,2,'',NULL,1,70),(71,2,'',NULL,1,71),(72,2,'',NULL,1,72),(73,2,'',NULL,1,73),(74,2,'',NULL,1,74),(75,2,'',NULL,1,75),(76,2,'',NULL,1,76),(77,2,'',NULL,1,77),(78,2,'',NULL,1,78),(79,2,'',NULL,1,79),(80,2,'',NULL,1,80),(81,2,'',NULL,1,81),(82,2,'',NULL,1,82),(83,2,'',NULL,1,83),(84,2,'',NULL,1,84),(85,2,'',NULL,1,85),(86,2,'',NULL,1,86),(87,2,'',NULL,1,87),(88,2,'',NULL,1,88),(89,2,'',NULL,1,89),(90,2,'',NULL,1,90),(91,2,'',NULL,1,91),(92,2,'',NULL,1,92),(93,2,'',NULL,1,93),(94,2,'',NULL,1,94),(95,2,'',NULL,1,95),(96,2,'',NULL,1,96),(97,2,'',NULL,1,97),(98,2,'',NULL,1,98),(99,2,'',NULL,1,99),(100,2,'',NULL,1,100),(101,2,'',NULL,1,101),(102,2,'',NULL,1,102),(103,2,'',NULL,1,103),(104,2,'',NULL,1,104),(105,2,'',NULL,1,105),(106,2,'',NULL,1,106),(107,2,'',NULL,1,107),(108,2,'',NULL,1,108),(109,2,'',NULL,1,109),(110,2,'',NULL,1,110),(111,2,'',NULL,1,111),(112,2,'',NULL,1,112),(113,2,'',NULL,1,113),(114,2,'',NULL,1,114),(115,2,'',NULL,1,115),(116,2,'',NULL,1,116),(117,2,'',NULL,1,117),(118,2,'',NULL,1,118),(119,2,'',NULL,1,119),(120,2,'',NULL,1,120),(121,2,'',NULL,1,121),(122,2,'',NULL,1,122),(123,2,'',NULL,1,123),(124,2,'',NULL,1,124),(125,2,'',NULL,1,125),(126,2,'',NULL,1,126),(127,2,'',NULL,1,127),(128,2,'',NULL,1,128),(129,2,'',NULL,1,129),(130,2,'',NULL,1,130),(131,2,'',NULL,1,131),(132,2,'',NULL,1,132),(133,2,'',NULL,1,133),(134,2,'',NULL,1,134),(135,2,'',NULL,2,1),(136,2,'',NULL,2,2),(137,2,'',NULL,2,3),(138,2,'',NULL,2,4),(139,2,'',NULL,2,5),(140,2,'',NULL,2,6),(141,2,'',NULL,2,7),(142,2,'',NULL,2,8),(143,2,'',NULL,2,9),(144,2,'',NULL,2,10),(145,2,'',NULL,2,11),(146,2,'',NULL,2,12),(147,2,'',NULL,2,13),(148,2,'',NULL,2,14),(149,2,'',NULL,2,15),(150,2,'',NULL,2,16),(151,2,'',NULL,2,17),(152,2,'',NULL,2,18),(153,2,'',NULL,2,19),(154,2,'',NULL,2,20),(155,2,'',NULL,2,21),(156,2,'',NULL,2,22),(157,2,'',NULL,2,23),(158,2,'',NULL,2,24),(159,2,'',NULL,2,25),(160,2,'',NULL,2,26),(161,2,'',NULL,2,27),(162,2,'',NULL,2,28),(163,2,'',NULL,2,29),(164,2,'',NULL,2,30),(165,2,'',NULL,2,31),(166,2,'',NULL,2,32),(167,2,'',NULL,2,33),(168,2,'',NULL,2,34),(169,2,'',NULL,2,35),(170,2,'',NULL,2,36),(171,2,'',NULL,2,37),(172,2,'',NULL,2,38),(173,2,'',NULL,2,39),(174,2,'',NULL,2,40),(175,2,'',NULL,2,41),(176,2,'',NULL,2,42),(177,2,'',NULL,2,43),(178,2,'',NULL,2,44),(179,2,'',NULL,2,45),(180,2,'',NULL,2,46),(181,2,'',NULL,2,47),(182,2,'',NULL,2,48),(183,2,'',NULL,2,49),(184,2,'',NULL,2,50),(185,2,'',NULL,2,51),(186,2,'',NULL,2,52),(187,2,'',NULL,2,53),(188,2,'',NULL,2,54),(189,2,'',NULL,2,55),(190,2,'',NULL,2,56),(191,2,'',NULL,2,57),(192,2,'',NULL,2,58),(193,2,'',NULL,2,59),(194,2,'',NULL,2,60),(195,2,'',NULL,2,61),(196,2,'',NULL,2,62),(197,2,'',NULL,2,63),(198,2,'',NULL,2,64),(199,2,'',NULL,2,65),(200,2,'',NULL,2,66),(201,2,'',NULL,2,67),(202,2,'',NULL,2,68),(203,2,'',NULL,2,69),(204,2,'',NULL,2,70),(205,2,'',NULL,2,71),(206,2,'',NULL,2,72),(207,2,'',NULL,2,73),(208,2,'',NULL,2,74),(209,2,'',NULL,2,75),(210,2,'',NULL,2,76),(211,2,'',NULL,2,77),(212,2,'',NULL,2,78),(213,2,'',NULL,2,79),(214,2,'',NULL,2,80),(215,2,'',NULL,2,81),(216,2,'',NULL,2,82),(217,2,'',NULL,2,83),(218,2,'',NULL,2,84),(219,2,'',NULL,2,85),(220,2,'',NULL,2,86),(221,2,'',NULL,2,87),(222,2,'',NULL,2,88),(223,2,'',NULL,2,89),(224,2,'',NULL,2,90),(225,2,'',NULL,2,91),(226,2,'',NULL,2,92),(227,2,'',NULL,2,93),(228,2,'',NULL,2,94),(229,2,'',NULL,2,95),(230,2,'',NULL,2,96),(231,2,'',NULL,2,97),(232,2,'',NULL,2,98),(233,2,'',NULL,2,99),(234,2,'',NULL,2,100),(235,2,'',NULL,2,101),(236,2,'',NULL,2,102),(237,2,'',NULL,2,103),(238,2,'',NULL,2,104),(239,2,'',NULL,2,105),(240,2,'',NULL,2,106),(241,2,'',NULL,2,107),(242,2,'',NULL,2,108),(243,2,'',NULL,2,109),(244,2,'',NULL,2,110),(245,2,'',NULL,2,111),(246,2,'',NULL,2,112),(247,2,'',NULL,2,113),(248,2,'',NULL,2,114),(249,2,'',NULL,2,115),(250,2,'',NULL,2,116),(251,2,'',NULL,2,117),(252,2,'',NULL,2,118),(253,2,'',NULL,2,119),(254,2,'',NULL,2,120),(255,2,'',NULL,2,121),(256,2,'',NULL,2,122),(257,2,'',NULL,2,123),(258,2,'',NULL,2,124),(259,2,'',NULL,2,125),(260,2,'',NULL,2,126),(261,2,'',NULL,2,127),(262,2,'',NULL,2,128),(263,2,'',NULL,2,129),(264,2,'',NULL,2,130),(265,2,'',NULL,2,131),(266,2,'',NULL,2,132),(267,2,'',NULL,2,133),(268,2,'',NULL,2,134),(269,2,'',NULL,2,135),(270,2,'',NULL,2,136),(271,2,'',NULL,2,137),(272,2,'',NULL,2,138),(273,2,'',NULL,2,139),(274,2,'',NULL,2,140),(275,2,'',NULL,2,141),(276,2,'',NULL,2,142),(277,2,'',NULL,2,143),(278,2,'',NULL,2,144),(279,2,'',NULL,2,145),(280,2,'',NULL,2,146),(281,2,'',NULL,2,147),(282,2,'',NULL,2,148),(283,2,'',NULL,2,149),(284,2,'',NULL,2,150),(285,2,'',NULL,2,151),(286,2,'',NULL,2,152),(287,2,'',NULL,2,153),(288,2,'',NULL,2,154),(289,2,'',NULL,2,155),(290,2,'',NULL,2,156),(291,2,'',NULL,2,157),(292,2,'',NULL,2,158),(293,2,'',NULL,2,159),(294,2,'',NULL,2,160),(295,2,'',NULL,2,161),(296,2,'',NULL,2,162),(297,2,'',NULL,2,163),(298,2,'',NULL,2,164),(299,2,'',NULL,2,165),(300,2,'',NULL,2,166),(301,2,'',NULL,2,167),(302,2,'',NULL,2,168),(303,2,'',NULL,2,169),(304,2,'',NULL,2,170),(305,2,'',NULL,2,171),(306,2,'',NULL,2,172),(307,2,'',NULL,2,173),(308,2,'',NULL,2,174),(309,2,'',NULL,2,175),(310,2,'',NULL,2,176),(311,2,'',NULL,2,177),(312,2,'',NULL,2,178),(313,2,'',NULL,2,179),(314,2,'',NULL,2,180),(315,2,'',NULL,2,181),(316,2,'',NULL,2,182),(317,2,'',NULL,2,183),(318,2,'',NULL,2,184),(319,2,'',NULL,2,185),(320,2,'',NULL,2,186),(321,2,'',NULL,2,187),(322,2,'',NULL,2,188),(323,2,'',NULL,2,189),(324,2,'',NULL,2,190),(325,2,'',NULL,2,191),(326,2,'',NULL,2,192),(327,2,'',NULL,2,193),(328,2,'',NULL,2,194),(329,2,'',NULL,2,195),(330,2,'',NULL,2,196),(331,2,'',NULL,2,197),(332,2,'',NULL,2,198),(333,2,'',NULL,2,199),(334,2,'',NULL,2,200),(335,2,'',NULL,2,201),(336,2,'',NULL,2,202),(337,2,'',NULL,2,203),(338,2,'',NULL,2,204),(339,2,'',NULL,2,205),(340,2,'',NULL,2,206),(341,2,'',NULL,2,207),(342,2,'',NULL,2,208),(343,2,'',NULL,2,209),(344,2,'',NULL,2,210),(345,2,'',NULL,2,211),(346,2,'',NULL,2,212),(347,2,'',NULL,2,213),(348,2,'',NULL,2,214),(349,2,'',NULL,2,215),(350,2,'',NULL,2,216),(351,2,'',NULL,2,217),(352,2,'',NULL,2,218),(353,2,'',NULL,2,219),(354,2,'',NULL,2,220),(355,2,'',NULL,2,221),(356,2,'',NULL,2,222),(357,2,'',NULL,2,223),(358,2,'',NULL,2,224),(359,2,'',NULL,2,225),(360,2,'',NULL,2,226),(361,2,'',NULL,2,227),(362,2,'',NULL,2,228),(363,2,'',NULL,2,229),(364,2,'',NULL,2,230),(365,2,'',NULL,2,231),(366,2,'',NULL,2,232),(367,2,'',NULL,2,233),(368,2,'',NULL,2,234),(369,2,'',NULL,2,235),(370,2,'',NULL,2,236),(371,2,'',NULL,2,237),(372,2,'',NULL,2,238),(373,2,'',NULL,2,239),(374,2,'',NULL,2,240),(375,2,'',NULL,2,241),(376,2,'',NULL,2,242),(377,2,'',NULL,2,243),(378,2,'',NULL,2,244),(379,2,'',NULL,2,245),(380,2,'',NULL,2,246),(381,2,'',NULL,2,247),(382,2,'',NULL,2,248),(383,2,'',NULL,2,249),(384,2,'',NULL,2,250),(385,2,'',NULL,2,251),(386,2,'',NULL,2,252),(387,2,'',NULL,2,253),(388,2,'',NULL,2,254),(389,2,'',NULL,2,255),(390,2,'',NULL,2,256),(391,2,'',NULL,2,257),(392,2,'',NULL,2,258),(393,2,'',NULL,2,259),(394,2,'',NULL,2,260),(395,2,'',NULL,2,261),(396,2,'',NULL,2,262),(397,2,'',NULL,2,263),(398,2,'',NULL,2,264),(399,2,'',NULL,2,265),(400,2,'',NULL,2,266),(401,2,'',NULL,2,267),(402,2,'',NULL,2,268);
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
  `title` varchar(127) NOT NULL,
  `description` longtext NOT NULL,
  `semester` varchar(31) NOT NULL,
  `module` varchar(63) NOT NULL,
  `credits` int(11) NOT NULL,
  `slug` varchar(158) NOT NULL,
  `professor_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `epita_course_title_semester_0f03ea41_uniq` (`title`,`semester`),
  KEY `epita_course_slug_9390f506` (`slug`),
  KEY `epita_course_professor_id_id_c64bea89_fk_epita_professor_id` (`professor_id_id`),
  CONSTRAINT `epita_course_professor_id_id_c64bea89_fk_epita_professor_id` FOREIGN KEY (`professor_id_id`) REFERENCES `epita_professor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epita_course`
--

LOCK TABLES `epita_course` WRITE;
/*!40000 ALTER TABLE `epita_course` DISABLE KEYS */;
INSERT INTO `epita_course` VALUES (1,'Advanced C Programming','aegr','Fall 2019','Tech',3,'fall-2019-advanced-c-programming',1),(2,'Management Something or other','sdgfh','Fall 2019','Management',3,'fall-2019-management-something-or-other',1);
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epita_professor`
--

LOCK TABLES `epita_professor` WRITE;
/*!40000 ALTER TABLE `epita_professor` DISABLE KEYS */;
INSERT INTO `epita_professor` VALUES (1,'','',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epita_schedule`
--

LOCK TABLES `epita_schedule` WRITE;
/*!40000 ALTER TABLE `epita_schedule` DISABLE KEYS */;
INSERT INTO `epita_schedule` VALUES (1,'2018-06-09','14:55:45.000000','14:55:45.000000',1,1),(2,'2018-06-09','14:55:51.000000','14:55:52.000000',1,2);
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
  `photo_location` varchar(511) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `epita_student_user_id_529318c6_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epita_student`
--

LOCK TABLES `epita_student` WRITE;
/*!40000 ALTER TABLE `epita_student` DISABLE KEYS */;
INSERT INTO `epita_student` VALUES (1,'',1,2,'Spring 2017','Mexico','mx','','','',3),(2,'',1,2,'Spring 2017','Mexico','mx','','','',4),(3,'',1,2,'Spring 2017','Mexico','mx','','','',5),(4,'',1,2,'Spring 2017','Mexico','mx','','','',6),(5,'',1,2,'Spring 2017','Mexico','mx','','','',7),(6,'',1,2,'Spring 2017','Mexico','mx','','','',8),(7,'',1,2,'Spring 2017','Mexico','mx','','','',9),(8,'',1,2,'Spring 2017','Mexico','mx','','','',10),(9,'',1,2,'Spring 2017','Mexico','mx','','','',11),(10,'',1,2,'Spring 2017','Mexico','mx','','','',12),(11,'',1,2,'Spring 2017','Mexico','mx','','','',13),(12,'',1,2,'Spring 2017','Mexico','mx','','','',14),(13,'',1,2,'Spring 2017','Mexico','mx','','','',15),(14,'',1,2,'Spring 2017','Mexico','mx','','','',16),(15,'',1,2,'Spring 2017','Mexico','mx','','','',17),(16,'',1,2,'Spring 2017','Mexico','mx','','','',18),(17,'',1,2,'Spring 2017','Mexico','mx','','','',19),(18,'',1,2,'Spring 2017','Mexico','mx','','','',20),(19,'',1,2,'Spring 2017','Mexico','mx','','','',21),(20,'',1,2,'Spring 2017','Mexico','mx','','','',22),(21,'',1,2,'Spring 2017','Mexico','mx','','','',23),(22,'',1,2,'Spring 2017','Mexico','mx','','','',24),(23,'',1,2,'Spring 2017','Mexico','mx','','','',25),(24,'',1,2,'Spring 2017','Mexico','mx','','','',26),(25,'',1,2,'Spring 2017','Mexico','mx','','','',27),(26,'',1,2,'Spring 2017','Mexico','mx','','','',28),(27,'',1,2,'Spring 2017','Mexico','mx','','','',29),(28,'',1,2,'Spring 2017','Mexico','mx','','','',30),(29,'',1,2,'Spring 2017','Mexico','mx','','','',31),(30,'',1,2,'Spring 2017','Mexico','mx','','','',32),(31,'',1,2,'Spring 2017','Mexico','mx','','','',33),(32,'',1,2,'Spring 2017','Mexico','mx','','','',34),(33,'',1,2,'Spring 2017','Mexico','mx','','','',35),(34,'',1,2,'Spring 2017','Mexico','mx','','','',36),(35,'',1,2,'Spring 2017','Mexico','mx','','','',37),(36,'',1,2,'Spring 2017','Mexico','mx','','','',38),(37,'',1,2,'Spring 2017','Mexico','mx','','','',39),(38,'',1,2,'Spring 2017','Mexico','mx','','','',40),(39,'',1,2,'Spring 2017','Mexico','mx','','','',41),(40,'',1,2,'Spring 2017','Mexico','mx','','','',42),(41,'',1,2,'Spring 2017','Mexico','mx','','','',43),(42,'',1,2,'Spring 2017','Mexico','mx','','','',44),(43,'',1,2,'Spring 2017','Mexico','mx','','','',45),(44,'',1,2,'Spring 2017','Mexico','mx','','','',46),(45,'',1,2,'Spring 2017','Mexico','mx','','','',47),(46,'',1,2,'Spring 2017','Mexico','mx','','','',48),(47,'',1,2,'Spring 2017','Mexico','mx','','','',49),(48,'',1,2,'Spring 2017','Mexico','mx','','','',50),(49,'',1,2,'Spring 2017','Mexico','mx','','','',51),(50,'',1,2,'Spring 2017','Mexico','mx','','','',52),(51,'',1,2,'Spring 2017','Mexico','mx','','','',53),(52,'',1,2,'Spring 2017','Mexico','mx','','','',54),(53,'',1,2,'Spring 2017','Mexico','mx','','','',55),(54,'',1,2,'Spring 2017','Mexico','mx','','','',56),(55,'',1,2,'Spring 2017','Mexico','mx','','','',57),(56,'',1,2,'Spring 2017','Mexico','mx','','','',58),(57,'',1,2,'Spring 2017','Mexico','mx','','','',59),(58,'',1,2,'Spring 2017','Mexico','mx','','','',60),(59,'',1,2,'Spring 2017','Mexico','mx','','','',61),(60,'',1,2,'Spring 2017','Mexico','mx','','','',62),(61,'',1,2,'Spring 2017','Mexico','mx','','','',63),(62,'',1,2,'Spring 2017','Mexico','mx','','','',64),(63,'',1,2,'Spring 2017','Mexico','mx','','','',65),(64,'',1,2,'Spring 2017','Mexico','mx','','','',66),(65,'',1,2,'Spring 2017','Mexico','mx','','','',67),(66,'',1,2,'Spring 2017','Mexico','mx','','','',68),(67,'',1,2,'Spring 2017','Mexico','mx','','','',69),(68,'',1,2,'Spring 2017','Mexico','mx','','','',70),(69,'',1,2,'Spring 2017','Mexico','mx','','','',71),(70,'',1,2,'Spring 2017','Mexico','mx','','','',72),(71,'',1,2,'Spring 2017','Mexico','mx','','','',73),(72,'',1,2,'Spring 2017','Mexico','mx','','','',74),(73,'',1,2,'Spring 2017','Mexico','mx','','','',75),(74,'',1,2,'Spring 2017','Mexico','mx','','','',76),(75,'',1,2,'Spring 2017','Mexico','mx','','','',77),(76,'',1,2,'Spring 2017','Mexico','mx','','','',78),(77,'',1,2,'Spring 2017','Mexico','mx','','','',79),(78,'',1,2,'Spring 2017','Mexico','mx','','','',80),(79,'',1,2,'Spring 2017','Mexico','mx','','','',81),(80,'',1,2,'Spring 2017','Mexico','mx','','','',82),(81,'',1,2,'Spring 2017','Mexico','mx','','','',83),(82,'',1,2,'Spring 2017','Mexico','mx','','','',84),(83,'',1,2,'Spring 2017','Mexico','mx','','','',85),(84,'',1,2,'Spring 2017','Mexico','mx','','','',86),(85,'',1,2,'Spring 2017','Mexico','mx','','','',87),(86,'',1,2,'Spring 2017','Mexico','mx','','','',88),(87,'',1,2,'Spring 2017','Mexico','mx','','','',89),(88,'',1,2,'Spring 2017','Mexico','mx','','','',90),(89,'',1,2,'Spring 2017','Mexico','mx','','','',91),(90,'',1,2,'Spring 2017','Mexico','mx','','','',92),(91,'',1,2,'Spring 2017','Mexico','mx','','','',93),(92,'',1,2,'Spring 2017','Mexico','mx','','','',94),(93,'',1,2,'Spring 2017','Mexico','mx','','','',95),(94,'',1,2,'Spring 2017','Mexico','mx','','','',96),(95,'',1,2,'Spring 2017','Mexico','mx','','','',97),(96,'',1,2,'Spring 2017','Mexico','mx','','','',98),(97,'',1,2,'Spring 2017','Mexico','mx','','','',99),(98,'',1,2,'Spring 2017','Mexico','mx','','','',100),(99,'',1,2,'Spring 2017','Mexico','mx','','','',101),(100,'',1,2,'Spring 2017','Mexico','mx','','','',102),(101,'',1,2,'Spring 2017','Mexico','mx','','','',103),(102,'',1,2,'Spring 2017','Mexico','mx','','','',104),(103,'',1,2,'Spring 2017','Mexico','mx','','','',105),(104,'',1,2,'Spring 2017','Mexico','mx','','','',106),(105,'',1,2,'Spring 2017','Mexico','mx','','','',107),(106,'',1,2,'Spring 2017','Mexico','mx','','','',108),(107,'',1,2,'Spring 2017','Mexico','mx','','','',109),(108,'',1,2,'Spring 2017','Mexico','mx','','','',110),(109,'',1,2,'Spring 2017','Mexico','mx','','','',111),(110,'',1,2,'Spring 2017','Mexico','mx','','','',112),(111,'',1,2,'Spring 2017','Mexico','mx','','','',113),(112,'',1,2,'Spring 2017','Mexico','mx','','','',114),(113,'',1,2,'Spring 2017','Mexico','mx','','','',115),(114,'',1,2,'Spring 2017','Mexico','mx','','','',116),(115,'',1,2,'Spring 2017','Mexico','mx','','','',117),(116,'',1,2,'Spring 2017','Mexico','mx','','','',118),(117,'',1,2,'Spring 2017','Mexico','mx','','','',119),(118,'',1,2,'Spring 2017','Mexico','mx','','','',120),(119,'',1,2,'Spring 2017','Mexico','mx','','','',121),(120,'',1,2,'Spring 2017','Mexico','mx','','','',122),(121,'',1,2,'Spring 2017','Mexico','mx','','','',123),(122,'',1,2,'Spring 2017','Mexico','mx','','','',124),(123,'',1,2,'Spring 2017','Mexico','mx','','','',125),(124,'',1,2,'Spring 2017','Mexico','mx','','','',126),(125,'',1,2,'Spring 2017','Mexico','mx','','','',127),(126,'',1,2,'Spring 2017','Mexico','mx','','','',128),(127,'',1,2,'Spring 2017','Mexico','mx','','','',129),(128,'',1,2,'Spring 2017','Mexico','mx','','','',130),(129,'',1,2,'Spring 2017','Mexico','mx','','','',131),(130,'',1,2,'Spring 2017','Mexico','mx','','','',132),(131,'',1,2,'Spring 2017','Mexico','mx','','','',133),(132,'',1,2,'Spring 2017','Mexico','mx','','','',134),(133,'',1,2,'Spring 2017','Mexico','mx','','','',135),(134,'',1,2,'Spring 2017','Mexico','mx','','','',136),(135,'',2,1,'Fall 2017','USA','us','','','',137),(136,'',2,1,'Fall 2017','USA','us','','','',138),(137,'',2,1,'Fall 2017','USA','us','','','',139),(138,'',2,1,'Fall 2017','USA','us','','','',140),(139,'',2,1,'Fall 2017','USA','us','','','',141),(140,'',2,1,'Fall 2017','USA','us','','','',142),(141,'',2,1,'Fall 2017','USA','us','','','',143),(142,'',2,1,'Fall 2017','USA','us','','','',144),(143,'',2,1,'Fall 2017','USA','us','','','',145),(144,'',2,1,'Fall 2017','USA','us','','','',146),(145,'',2,1,'Fall 2017','USA','us','','','',147),(146,'',2,1,'Fall 2017','USA','us','','','',148),(147,'',2,1,'Fall 2017','USA','us','','','',149),(148,'',2,1,'Fall 2017','USA','us','','','',150),(149,'',2,1,'Fall 2017','USA','us','','','',151),(150,'',2,1,'Fall 2017','USA','us','','','',152),(151,'',2,1,'Fall 2017','USA','us','','','',153),(152,'',2,1,'Fall 2017','USA','us','','','',154),(153,'',2,1,'Fall 2017','USA','us','','','',155),(154,'',2,1,'Fall 2017','USA','us','','','',156),(155,'',2,1,'Fall 2017','USA','us','','','',157),(156,'',2,1,'Fall 2017','USA','us','','','',158),(157,'',2,1,'Fall 2017','USA','us','','','',159),(158,'',2,1,'Fall 2017','USA','us','','','',160),(159,'',2,1,'Fall 2017','USA','us','','','',161),(160,'',2,1,'Fall 2017','USA','us','','','',162),(161,'',2,1,'Fall 2017','USA','us','','','',163),(162,'',2,1,'Fall 2017','USA','us','','','',164),(163,'',2,1,'Fall 2017','USA','us','','','',165),(164,'',2,1,'Fall 2017','USA','us','','','',166),(165,'',2,1,'Fall 2017','USA','us','','','',167),(166,'',2,1,'Fall 2017','USA','us','','','',168),(167,'',2,1,'Fall 2017','USA','us','','','',169),(168,'',2,1,'Fall 2017','USA','us','','','',170),(169,'',2,1,'Fall 2017','USA','us','','','',171),(170,'',2,1,'Fall 2017','USA','us','','','',172),(171,'',2,1,'Fall 2017','USA','us','','','',173),(172,'',2,1,'Fall 2017','USA','us','','','',174),(173,'',2,1,'Fall 2017','USA','us','','','',175),(174,'',2,1,'Fall 2017','USA','us','','','',176),(175,'',2,1,'Fall 2017','USA','us','','','',177),(176,'',2,1,'Fall 2017','USA','us','','','',178),(177,'',2,1,'Fall 2017','USA','us','','','',179),(178,'',2,1,'Fall 2017','USA','us','','','',180),(179,'',2,1,'Fall 2017','USA','us','','','',181),(180,'',2,1,'Fall 2017','USA','us','','','',182),(181,'',2,1,'Fall 2017','USA','us','','','',183),(182,'',2,1,'Fall 2017','USA','us','','','',184),(183,'',2,1,'Fall 2017','USA','us','','','',185),(184,'',2,1,'Fall 2017','USA','us','','','',186),(185,'',2,1,'Fall 2017','USA','us','','','',187),(186,'',2,1,'Fall 2017','USA','us','','','',188),(187,'',2,1,'Fall 2017','USA','us','','','',189),(188,'',2,1,'Fall 2017','USA','us','','','',190),(189,'',2,1,'Fall 2017','USA','us','','','',191),(190,'',2,1,'Fall 2017','USA','us','','','',192),(191,'',2,1,'Fall 2017','USA','us','','','',193),(192,'',2,1,'Fall 2017','USA','us','','','',194),(193,'',2,1,'Fall 2017','USA','us','','','',195),(194,'',2,1,'Fall 2017','USA','us','','','',196),(195,'',2,1,'Fall 2017','USA','us','','','',197),(196,'',2,1,'Fall 2017','USA','us','','','',198),(197,'',2,1,'Fall 2017','USA','us','','','',199),(198,'',2,1,'Fall 2017','USA','us','','','',200),(199,'',2,1,'Fall 2017','USA','us','','','',201),(200,'',2,1,'Fall 2017','USA','us','','','',202),(201,'',2,1,'Fall 2017','USA','us','','','',203),(202,'',2,1,'Fall 2017','USA','us','','','',204),(203,'',2,1,'Fall 2017','USA','us','','','',205),(204,'',2,1,'Fall 2017','USA','us','','','',206),(205,'',2,1,'Fall 2017','USA','us','','','',207),(206,'',2,1,'Fall 2017','USA','us','','','',208),(207,'',2,1,'Fall 2017','USA','us','','','',209),(208,'',2,1,'Fall 2017','USA','us','','','',210),(209,'',2,1,'Fall 2017','USA','us','','','',211),(210,'',2,1,'Fall 2017','USA','us','','','',212),(211,'',2,1,'Fall 2017','USA','us','','','',213),(212,'',2,1,'Fall 2017','USA','us','','','',214),(213,'',2,1,'Fall 2017','USA','us','','','',215),(214,'',2,1,'Fall 2017','USA','us','','','',216),(215,'',2,1,'Fall 2017','USA','us','','','',217),(216,'',2,1,'Fall 2017','USA','us','','','',218),(217,'',2,1,'Fall 2017','USA','us','','','',219),(218,'',2,1,'Fall 2017','USA','us','','','',220),(219,'',2,1,'Fall 2017','USA','us','','','',221),(220,'',2,1,'Fall 2017','USA','us','','','',222),(221,'',2,1,'Fall 2017','USA','us','','','',223),(222,'',2,1,'Fall 2017','USA','us','','','',224),(223,'',2,1,'Fall 2017','USA','us','','','',225),(224,'',2,1,'Fall 2017','USA','us','','','',226),(225,'',2,1,'Fall 2017','USA','us','','','',227),(226,'',2,1,'Fall 2017','USA','us','','','',228),(227,'',2,1,'Fall 2017','USA','us','','','',229),(228,'',2,1,'Fall 2017','USA','us','','','',230),(229,'',2,1,'Fall 2017','USA','us','','','',231),(230,'',2,1,'Fall 2017','USA','us','','','',232),(231,'',2,1,'Fall 2017','USA','us','','','',233),(232,'',2,1,'Fall 2017','USA','us','','','',234),(233,'',2,1,'Fall 2017','USA','us','','','',235),(234,'',2,1,'Fall 2017','USA','us','','','',236),(235,'',2,1,'Fall 2017','USA','us','','','',237),(236,'',2,1,'Fall 2017','USA','us','','','',238),(237,'',2,1,'Fall 2017','USA','us','','','',239),(238,'',2,1,'Fall 2017','USA','us','','','',240),(239,'',2,1,'Fall 2017','USA','us','','','',241),(240,'',2,1,'Fall 2017','USA','us','','','',242),(241,'',2,1,'Fall 2017','USA','us','','','',243),(242,'',2,1,'Fall 2017','USA','us','','','',244),(243,'',2,1,'Fall 2017','USA','us','','','',245),(244,'',2,1,'Fall 2017','USA','us','','','',246),(245,'',2,1,'Fall 2017','USA','us','','','',247),(246,'',2,1,'Fall 2017','USA','us','','','',248),(247,'',2,1,'Fall 2017','USA','us','','','',249),(248,'',2,1,'Fall 2017','USA','us','','','',250),(249,'',2,1,'Fall 2017','USA','us','','','',251),(250,'',2,1,'Fall 2017','USA','us','','','',252),(251,'',2,1,'Fall 2017','USA','us','','','',253),(252,'',2,1,'Fall 2017','USA','us','','','',254),(253,'',2,1,'Fall 2017','USA','us','','','',255),(254,'',2,1,'Fall 2017','USA','us','','','',256),(255,'',2,1,'Fall 2017','USA','us','','','',257),(256,'',2,1,'Fall 2017','USA','us','','','',258),(257,'',2,1,'Fall 2017','USA','us','','','',259),(258,'',2,1,'Fall 2017','USA','us','','','',260),(259,'',2,1,'Fall 2017','USA','us','','','',261),(260,'',2,1,'Fall 2017','USA','us','','','',262),(261,'',2,1,'Fall 2017','USA','us','','','',263),(262,'',2,1,'Fall 2017','USA','us','','','',264),(263,'',2,1,'Fall 2017','USA','us','','','',265),(264,'',2,1,'Fall 2017','USA','us','','','',266),(265,'',2,1,'Fall 2017','USA','us','','','',267),(266,'',2,1,'Fall 2017','USA','us','','','',268),(267,'',2,1,'Fall 2017','USA','us','','','',269),(268,'',2,1,'Fall 2017','USA','us','','','',270);
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
) ENGINE=InnoDB AUTO_INCREMENT=403 DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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

-- Dump completed on 2018-06-11 15:05:52
