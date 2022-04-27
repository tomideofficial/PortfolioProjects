-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: shopracks
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `Customer_Name` varchar(50) NOT NULL,
  `Customer_Address` text,
  `Customer_Phone` varchar(15) NOT NULL,
  `Customer_Email` varchar(20) NOT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deficits`
--

DROP TABLE IF EXISTS `deficits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deficits` (
  `ProductID` int NOT NULL,
  `Product_Name` varchar(50) NOT NULL,
  `Product_CategoryID` int NOT NULL,
  `Quantity_lost` varchar(10) NOT NULL,
  `Date` date NOT NULL,
  `Time` timestamp NOT NULL,
  KEY `ProductID` (`ProductID`),
  KEY `Product_CategoryID` (`Product_CategoryID`),
  CONSTRAINT `deficits_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `inventory` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deficits_ibfk_2` FOREIGN KEY (`Product_CategoryID`) REFERENCES `product_category` (`CategoryID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deficits`
--

LOCK TABLES `deficits` WRITE;
/*!40000 ALTER TABLE `deficits` DISABLE KEYS */;
/*!40000 ALTER TABLE `deficits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `Product_Name` varchar(50) NOT NULL,
  `Product_CategoryID` int NOT NULL,
  `Product_image` blob,
  `Product_description` text,
  `Unit_price` int NOT NULL,
  `Quantity_available` varchar(10) NOT NULL,
  `Date` date NOT NULL,
  `Time` timestamp NOT NULL,
  PRIMARY KEY (`ProductID`,`Product_Name`,`Unit_price`),
  UNIQUE KEY `Unit_price` (`Unit_price`),
  KEY `Product_CategoryID` (`Product_CategoryID`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`Product_CategoryID`) REFERENCES `product_category` (`CategoryID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL,
  `ProductID` int NOT NULL,
  `Quantity_ordered` int NOT NULL,
  `Delivery_Status` varchar(20) NOT NULL,
  `CustomerID` int NOT NULL,
  `Order_Date` date NOT NULL,
  `Shipped_Date` date NOT NULL,
  `order_channel` varchar(20) NOT NULL,
  PRIMARY KEY (`OrderID`),
  UNIQUE KEY `Quantity_ordered` (`Quantity_ordered`),
  KEY `CustomerID` (`CustomerID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `inventory` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `CustomerID` int NOT NULL,
  `Payment_Status` varchar(20) NOT NULL,
  `Payment_Mode` varchar(10) NOT NULL,
  `Amount` int NOT NULL,
  `Payment_Date` date NOT NULL,
  KEY `CustomerID` (`CustomerID`),
  KEY `Amount` (`Amount`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`Amount`) REFERENCES `sales` (`Amount`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `Category_name` varchar(20) NOT NULL,
  `Category_description` text,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `SalesID` int NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `OrderID` int NOT NULL,
  `Product_Name` varchar(50) NOT NULL,
  `Quantity` int NOT NULL,
  `Amount` int NOT NULL,
  `Total` decimal(20,5) NOT NULL,
  `ProductID` int NOT NULL,
  `VAT` decimal(5,5) DEFAULT NULL,
  `Unit_Price` int NOT NULL,
  PRIMARY KEY (`SalesID`),
  UNIQUE KEY `Amount` (`Amount`),
  KEY `OrderID` (`OrderID`),
  KEY `ProductID` (`ProductID`),
  KEY `Quantity` (`Quantity`),
  KEY `Unit_Price` (`Unit_Price`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `inventory` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sales_ibfk_3` FOREIGN KEY (`Quantity`) REFERENCES `orders` (`Quantity_ordered`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sales_ibfk_4` FOREIGN KEY (`Unit_Price`) REFERENCES `inventory` (`Unit_price`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_business`
--

DROP TABLE IF EXISTS `user_business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_business` (
  `userID` int NOT NULL,
  `business_ID` int NOT NULL AUTO_INCREMENT,
  `business_name` varchar(50) NOT NULL,
  `website` varchar(20) DEFAULT NULL,
  `business_logo` blob,
  PRIMARY KEY (`business_ID`),
  KEY `userID` (`userID`),
  CONSTRAINT `user_business_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user_profile` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_business`
--

LOCK TABLES `user_business` WRITE;
/*!40000 ALTER TABLE `user_business` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profile` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `surname` varchar(20) NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `Phone_number` varchar(15) NOT NULL,
  `Password` varchar(8) NOT NULL,
  `profile_picture` blob,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile`
--

LOCK TABLES `user_profile` WRITE;
/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-14 16:13:44
