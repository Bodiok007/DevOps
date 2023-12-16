CREATE DATABASE  IF NOT EXISTS `devops` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `devops`;
-- MySQL dump 10.13  Distrib 8.0.33, for macos13 (x86_64)
--
-- Host: localhost    Database: devops
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `EmployeeID` int NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Position` varchar(50) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (1,'John','Doe','Project Manager','john.doe@example.com'),(2,'Jane','Smith','Developer','jane.smith@example.com'),(3,'Bob','Johnson','Tester','bob.johnson@example.com'),(4,'Alice','Williams','Designer','alice.williams@example.com'),(5,'Charlie','Brown','Analyst','charlie.brown@example.com'),(6,'Eva','Miller','DevOps Engineer','eva.miller@example.com'),(7,'David','Clark','Database Administrator','david.clark@example.com'),(8,'Grace','Davis','Project Coordinator','grace.davis@example.com'),(9,'Samuel','Moore','Software Engineer','samuel.moore@example.com'),(10,'Olivia','Taylor','QA Engineer','olivia.taylor@example.com');
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Project`
--

DROP TABLE IF EXISTS `Project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Project` (
  `ProjectID` int NOT NULL,
  `ProjectName` varchar(100) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `ProjectManagerID` int DEFAULT NULL,
  PRIMARY KEY (`ProjectID`),
  KEY `ProjectManagerID` (`ProjectManagerID`),
  CONSTRAINT `Project_ibfk_1` FOREIGN KEY (`ProjectManagerID`) REFERENCES `Employee` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Project`
--

LOCK TABLES `Project` WRITE;
/*!40000 ALTER TABLE `Project` DISABLE KEYS */;
INSERT INTO `Project` VALUES (1,'Project A','2023-01-01','2023-03-31',1),(2,'Project B','2023-02-01','2023-04-30',2),(3,'Project C','2023-03-01','2023-05-31',3),(4,'Project D','2023-04-01','2023-06-30',4),(5,'Project E','2023-05-01','2023-07-31',5),(6,'Project F','2023-06-01','2023-08-31',6),(7,'Project G','2023-07-01','2023-09-30',7),(8,'Project H','2023-08-01','2023-10-31',8),(9,'Project I','2023-09-01','2023-11-30',9),(10,'Project J','2023-10-01','2023-12-31',10);
/*!40000 ALTER TABLE `Project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Task`
--

DROP TABLE IF EXISTS `Task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Task` (
  `TaskID` int NOT NULL,
  `ProjectID` int DEFAULT NULL,
  `TaskName` varchar(100) DEFAULT NULL,
  `Description` text,
  `DueDate` date DEFAULT NULL,
  `AssignedToID` int DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`TaskID`),
  KEY `ProjectID` (`ProjectID`),
  KEY `AssignedToID` (`AssignedToID`),
  CONSTRAINT `Task_ibfk_1` FOREIGN KEY (`ProjectID`) REFERENCES `Project` (`ProjectID`),
  CONSTRAINT `Task_ibfk_2` FOREIGN KEY (`AssignedToID`) REFERENCES `Employee` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Task`
--

LOCK TABLES `Task` WRITE;
/*!40000 ALTER TABLE `Task` DISABLE KEYS */;
INSERT INTO `Task` VALUES (1,1,'Task 1','Implement feature X','2023-02-15',2,'In Progress'),(2,1,'Task 2','Test functionality Y','2023-03-01',3,'Pending'),(3,2,'Task 3','Design user interface','2023-03-15',1,'Completed'),(4,2,'Task 4','Code review','2023-04-01',4,'In Progress'),(5,3,'Task 5','Database optimization','2023-04-15',5,'Pending'),(6,3,'Task 6','UI testing','2023-05-01',6,'Completed'),(7,4,'Task 7','Deploy updates','2023-05-15',7,'In Progress'),(8,4,'Task 8','Performance analysis','2023-06-01',8,'Pending'),(9,5,'Task 9','Bug fixing','2023-06-15',9,'Completed'),(10,5,'Task 10','Documentation','2023-07-01',10,'In Progress');
/*!40000 ALTER TABLE `Task` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-16 20:35:50
