-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital_2
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `authtoken`
--

DROP TABLE IF EXISTS `authtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `userId` int NOT NULL,
  `expiresAt` datetime NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `userId` (`userId`),
  CONSTRAINT `authtoken_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken`
--

LOCK TABLES `authtoken` WRITE;
/*!40000 ALTER TABLE `authtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case_dia`
--

DROP TABLE IF EXISTS `case_dia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_dia` (
  `caseDiaId` int NOT NULL,
  `doctorId` int NOT NULL,
  `diaLocation` int NOT NULL COMMENT '0 for ED ,\\\\\\\\n1 for Ops,\\\\\\\\n2 for Clinicss ,\\\\\\\\n3 for ICU,\\\\\\\\n4 for Ward,\\\\\\\\n5 for NICU\\\\\\\\n',
  `involvedDepartment` int NOT NULL,
  `patientComplaint` text,
  `dia` text NOT NULL,
  `diaImage` varchar(255) DEFAULT NULL,
  `diaDateTime` timestamp NOT NULL,
  `clinicalExamination` text,
  `clinicalExaminationImage` varchar(255) DEFAULT NULL,
  `doctorCallId` int NOT NULL,
  `note` text,
  `patientApptId` int NOT NULL,
  `hospitalName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`caseDiaId`),
  UNIQUE KEY `Case_Dia_Id_UNIQUE` (`caseDiaId`),
  KEY `Case_Dia_Idx_1` (`doctorCallId`),
  KEY `fk_Case_Dia_Patient_Appt1_Idx` (`patientApptId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Case summary on the Patient''''s condition written by Doctor.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_dia`
--

LOCK TABLES `case_dia` WRITE;
/*!40000 ALTER TABLE `case_dia` DISABLE KEYS */;
/*!40000 ALTER TABLE `case_dia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinicss_skd`
--

DROP TABLE IF EXISTS `clinicss_skd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinicss_skd` (
  `skdId` int NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `dayOfWeek` int NOT NULL,
  `isAvaiLable` tinyint(1) NOT NULL,
  `doctorId` int NOT NULL,
  `note` text,
  PRIMARY KEY (`skdId`),
  KEY `Clinicss_Skd_Idx_1` (`doctorId`),
  CONSTRAINT `ClinicssSkdDoctor` FOREIGN KEY (`doctorId`) REFERENCES `doctor` (`doctorId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinicss_skd`
--

LOCK TABLES `clinicss_skd` WRITE;
/*!40000 ALTER TABLE `clinicss_skd` DISABLE KEYS */;
INSERT INTO `clinicss_skd` VALUES (1,'00:00:01','00:00:01',-2147483648,1,1,NULL),(2,'00:00:02','00:00:02',-2147483647,1,2,NULL),(3,'00:00:03','00:00:03',-2147483646,0,3,NULL),(4,'00:00:04','00:00:04',-2147483645,0,4,NULL),(5,'00:00:05','00:00:05',-2147483644,1,5,NULL),(6,'00:00:06','00:00:06',-2147483643,1,6,NULL),(7,'00:00:07','00:00:07',-2147483642,0,7,NULL);
/*!40000 ALTER TABLE `clinicss_skd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `doctorId` int NOT NULL,
  `userId` int NOT NULL,
  `nationalId` char(14) DEFAULT NULL,
  `fullName` varchar(600) DEFAULT NULL,
  `firstName` varchar(150) NOT NULL,
  `secondName` varchar(150) DEFAULT NULL,
  `thirdName` varchar(150) DEFAULT NULL,
  `lastName` varchar(150) NOT NULL,
  `degree` int NOT NULL COMMENT 'Ref for Latest Scientific Degree\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n0 Bachelor بكالوريوس\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n1 Postgraduate Diploma دبلوم الدراسات العليا\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n2 Egyptian Associate degree درجة الزمالة المصرية\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n3 Fellowship الزمالة\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n4 Royal Membership عضوية الكلية الملكية\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n5 Master درجة الماجستير\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n6 PhD دكتوراه\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n',
  `position` int NOT NULL COMMENT 'Ref for Position Level in the Department',
  `departmentId` int NOT NULL,
  `hospitalName` varchar(150) DEFAULT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `imageHash` varchar(255) DEFAULT NULL,
  `noOfPatients` int DEFAULT NULL,
  `gradDate` date NOT NULL,
  `aboutMe` text,
  `yearsOfExperience` int DEFAULT NULL,
  `note` text,
  `createdAt` timestamp NULL DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  `doctorPP` varchar(255) DEFAULT NULL,
  `doctorPPHash` varchar(255) CHARACTER SET armscii8 COLLATE armscii8_general_ci DEFAULT NULL,
  PRIMARY KEY (`doctorId`),
  UNIQUE KEY `userId_UNIQUE` (`userId`),
  CONSTRAINT `User_Doctor` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (1,125,'26005012875284','Shasta Abbott Isidro Abbott','Shasta','Abbott','Isidro','Abbott',0,0,0,NULL,NULL,NULL,NULL,'1985-01-02',NULL,38,NULL,NULL,NULL,NULL,NULL),(2,126,'27912015338112','Josie Abel Louie Abel','Josie','Abel','Louie','Abel',1,1,1,NULL,NULL,NULL,NULL,'2005-12-17',NULL,17,NULL,NULL,NULL,NULL,NULL),(3,127,'28107027310150','Weston Abernathy Stewart Abernathy','Weston','Abernathy','Stewart','Abernathy',2,2,2,NULL,NULL,NULL,NULL,'2007-09-23',NULL,15,NULL,NULL,NULL,NULL,NULL),(4,128,'28411009558004','Arthur Abney Harlan Abney','Arthur','Abney','Harlan','Abney',3,3,3,NULL,NULL,NULL,NULL,'2011-06-20',NULL,11,NULL,NULL,NULL,NULL,NULL),(5,129,'27610023247150','Felica Abraham Jordan Abraham','Felica','Abraham','Jordan','Abraham',4,4,4,NULL,NULL,NULL,NULL,'2002-03-23',NULL,21,NULL,NULL,NULL,NULL,NULL),(6,130,'28002010966464','Wilbert Abrams Britt Abrams','Wilbert','Abrams','Britt','Abrams',5,5,5,NULL,NULL,NULL,NULL,'2007-09-24',NULL,15,NULL,NULL,NULL,NULL,NULL),(7,131,'27806019668031','Ross Abreu M Abreu','Ross','Abreu','M','Abreu',6,6,6,NULL,NULL,NULL,NULL,'2005-12-18',NULL,17,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_call`
--

DROP TABLE IF EXISTS `doctor_call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_call` (
  `callId` int NOT NULL,
  `admDCTicketId` int NOT NULL,
  `callerDoctorId` int NOT NULL COMMENT 'The ED Doctor who Call the needed specific Departments Doctor.',
  `responderDocotorId` int NOT NULL,
  `reportingDateTime` timestamp NOT NULL COMMENT 'Now / Current Time',
  `reportDeliveryDateTime` timestamp NOT NULL,
  `debateDateTime` timestamp NOT NULL,
  `followUpDateTime` timestamp NOT NULL,
  `note` text,
  PRIMARY KEY (`callId`),
  KEY `Doctor_Call_Idx_1` (`admDCTicketId`),
  CONSTRAINT `Dr_Call_Adm_Disc` FOREIGN KEY (`admDCTicketId`) REFERENCES `er_adm_and_dc` (`Ticket_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='This table represents the Doctor Call for a Patient in the ED.\\\\nThe ED Doctor Call specific needed Departments for each Patient after his initial examination.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_call`
--

LOCK TABLES `doctor_call` WRITE;
/*!40000 ALTER TABLE `doctor_call` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_call` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emerg_skd`
--

DROP TABLE IF EXISTS `emerg_skd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emerg_skd` (
  `Department_Id` int NOT NULL,
  `Day_of_the_Week` int NOT NULL COMMENT 'Ref for list of days of the Weeks',
  `Seniority_Level` int NOT NULL COMMENT '0 for junior,\\\\n1 for senior,\\\\n2 for Head of Senior',
  `Doctor_Id` int NOT NULL,
  `Note` text,
  PRIMARY KEY (`Seniority_Level`,`Day_of_the_Week`,`Department_Id`),
  KEY `Emerg_Skd_Idx_1` (`Doctor_Id`),
  CONSTRAINT `Dr_Emerg_Skd` FOREIGN KEY (`Doctor_Id`) REFERENCES `doctor` (`doctorId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emerg_skd`
--

LOCK TABLES `emerg_skd` WRITE;
/*!40000 ALTER TABLE `emerg_skd` DISABLE KEYS */;
/*!40000 ALTER TABLE `emerg_skd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emerg_skd_call_jct`
--

DROP TABLE IF EXISTS `emerg_skd_call_jct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emerg_skd_call_jct` (
  `Emerg_Skd_Call_JCT_Id` int NOT NULL,
  `Doctor_Call_Id` int NOT NULL,
  `Emerg_Skd_Seniority_Level` int NOT NULL,
  `Emerg_Skd_Day_of_the_Week` int NOT NULL,
  `Emerg_Skd_Department_Id` int NOT NULL,
  PRIMARY KEY (`Emerg_Skd_Call_JCT_Id`),
  KEY `Emerg_Skd_Call_JCT_Idx_1` (`Doctor_Call_Id`),
  KEY `Emerg_Skd_Call_JCT_Idx_2` (`Emerg_Skd_Seniority_Level`,`Emerg_Skd_Day_of_the_Week`,`Emerg_Skd_Department_Id`),
  CONSTRAINT `Call_JCT_Dr_Call` FOREIGN KEY (`Doctor_Call_Id`) REFERENCES `doctor_call` (`callId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Emerg_Skd_Junc_Emerg_Skd` FOREIGN KEY (`Emerg_Skd_Seniority_Level`, `Emerg_Skd_Day_of_the_Week`, `Emerg_Skd_Department_Id`) REFERENCES `emerg_skd` (`Seniority_Level`, `Day_of_the_Week`, `Department_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emerg_skd_call_jct`
--

LOCK TABLES `emerg_skd_call_jct` WRITE;
/*!40000 ALTER TABLE `emerg_skd_call_jct` DISABLE KEYS */;
/*!40000 ALTER TABLE `emerg_skd_call_jct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `er_adm_and_dc`
--

DROP TABLE IF EXISTS `er_adm_and_dc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `er_adm_and_dc` (
  `Ticket_Id` int NOT NULL AUTO_INCREMENT,
  `Patient_Id` int NOT NULL,
  `Relative_Full_Name` varchar(600) DEFAULT NULL COMMENT 'Composite attribute',
  `Relative_First_Name` varchar(150) DEFAULT NULL,
  `Relative_Second_Name` varchar(150) DEFAULT NULL,
  `Relative_Third_Name` varchar(150) DEFAULT NULL,
  `Relative_Last_Name` varchar(150) DEFAULT NULL,
  `Relative_phone_Number` varchar(50) DEFAULT NULL,
  `Relative_Address` varchar(300) DEFAULT NULL COMMENT 'Composite attribute',
  `Relative_Address_Governorate` varchar(50) DEFAULT NULL,
  `Relative_Address_District` varchar(50) DEFAULT NULL,
  `Relaive_Address_Street` varchar(50) DEFAULT NULL,
  `Relative_Address_Building_Number` varchar(3) DEFAULT NULL,
  `Adm_DateTime` timestamp NOT NULL,
  `DC_DateTime` timestamp NULL DEFAULT NULL,
  `Stay_Duration` decimal(6,2) DEFAULT NULL COMMENT 'Duration of stay in hours. ',
  `Adm_Type` int NOT NULL COMMENT '0 for ED\\\\n1 for Clinics\\\\n2 for Another hospital',
  `Fees_Type` int NOT NULL COMMENT '0 for Free\\\\n1 for Full Price\\\\n2 for Med Insurance',
  `provisional_Dia` text NOT NULL COMMENT 'ED Doctor (Internship Doctor) Dia',
  `DC_Patient_Type` int DEFAULT NULL COMMENT '0 for Cured\\\\n1  for Got Better\\\\n2 for DIdn''''t get better\\\\n3 for Died before 48 hours\\\\n4 Died after 48 hours',
  `Note` text,
  `Realtive_City` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Ticket_Id`),
  KEY `Adm_and_DC_Idx_1` (`Patient_Id`),
  CONSTRAINT `Adm_Disc_Pat` FOREIGN KEY (`Patient_Id`) REFERENCES `patient` (`patientId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `er_adm_and_dc`
--

LOCK TABLES `er_adm_and_dc` WRITE;
/*!40000 ALTER TABLE `er_adm_and_dc` DISABLE KEYS */;
/*!40000 ALTER TABLE `er_adm_and_dc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `error`
--

DROP TABLE IF EXISTS `error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `error` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` varchar(255) NOT NULL,
  `status` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `error`
--

LOCK TABLES `error` WRITE;
/*!40000 ALTER TABLE `error` DISABLE KEYS */;
/*!40000 ALTER TABLE `error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icu_adm_dc`
--

DROP TABLE IF EXISTS `icu_adm_dc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `icu_adm_dc` (
  `ICU_Ticket_Id` int NOT NULL,
  `Patient_Id` int NOT NULL,
  `ICU_Adm_DateTime` timestamp NOT NULL,
  `ICU_DC_DateTime` timestamp NULL DEFAULT NULL,
  `Referred_from` int NOT NULL COMMENT '0 for ED ,\\\\n1 for OR ,\\\\n2 for SUrgery room ,\\\\n3 for IMD,\\\\n4 Another hospital',
  `Stay_Relative_Full_Name` varchar(600) DEFAULT NULL,
  `Stay_Relative_First_Name` varchar(150) DEFAULT NULL,
  `Stay_Relative_Second_Name` varchar(150) DEFAULT NULL,
  `Stay_Relative_Third_Name` varchar(150) DEFAULT NULL,
  `Stay_Relative_Last_Name` varchar(150) DEFAULT NULL,
  `Stay_Relative_phone_Number` varchar(50) DEFAULT NULL,
  `Stay_Relative_Address` varchar(300) DEFAULT NULL COMMENT 'Composite attribute',
  `Stay_Relative_Address_Governorate` varchar(50) DEFAULT NULL,
  `Stay_Relative_Address_District` varchar(50) DEFAULT NULL,
  `Stay_Relaive_Address_Street` varchar(50) DEFAULT NULL,
  `Stay_Relative_Address_Building_Number` int DEFAULT NULL,
  `DC_Condition` varchar(300) NOT NULL,
  `Note` text,
  `Stay_Realtive_City` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ICU_Ticket_Id`),
  KEY `ICU_Adm_DC_Idx_1` (`Patient_Id`),
  CONSTRAINT `ICU_Adm_Disc_Pat` FOREIGN KEY (`Patient_Id`) REFERENCES `patient` (`patientId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icu_adm_dc`
--

LOCK TABLES `icu_adm_dc` WRITE;
/*!40000 ALTER TABLE `icu_adm_dc` DISABLE KEYS */;
/*!40000 ALTER TABLE `icu_adm_dc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icu_doctor_visit`
--

DROP TABLE IF EXISTS `icu_doctor_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `icu_doctor_visit` (
  `Doctor_Visit_Id` int NOT NULL,
  `Doctor_Id` int NOT NULL,
  `Visit_DateTime` timestamp NOT NULL,
  `Visit_Note` text NOT NULL,
  `ICU_Follow_Up_Sheet_Id` int NOT NULL,
  PRIMARY KEY (`Doctor_Visit_Id`),
  KEY `ICU_Doctor_Visit_Idx_1` (`Doctor_Id`),
  KEY `ICU_Doctor_Visit_Idx_2` (`ICU_Follow_Up_Sheet_Id`),
  CONSTRAINT `Drs_ICU_Drs_Visit` FOREIGN KEY (`Doctor_Id`) REFERENCES `doctor` (`doctorId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ICU_Drs_Visit_ICU_Fol_Up` FOREIGN KEY (`ICU_Follow_Up_Sheet_Id`) REFERENCES `icu_follow_up_sheet` (`ICU_Follow_Up_Sheet_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icu_doctor_visit`
--

LOCK TABLES `icu_doctor_visit` WRITE;
/*!40000 ALTER TABLE `icu_doctor_visit` DISABLE KEYS */;
/*!40000 ALTER TABLE `icu_doctor_visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icu_follow_up_sheet`
--

DROP TABLE IF EXISTS `icu_follow_up_sheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `icu_follow_up_sheet` (
  `ICU_Follow_Up_Sheet_Id` int NOT NULL,
  `DateTime_of_measurment_value` timestamp NOT NULL,
  `Shift` int NOT NULL COMMENT '0 for Morning ,\\\\n1 for Evenging ,\\\\n2 for Night',
  `Temprature` int NOT NULL,
  `Heat_rate` int NOT NULL,
  `Blood_sugar` int NOT NULL,
  `Oxygen_Saturation` int NOT NULL,
  `Blood_pressure` int NOT NULL,
  `Respiratory_rate` int NOT NULL,
  `Urine_Output` int NOT NULL,
  `Eye_opening` int NOT NULL COMMENT '4  for Spontaneous ,\\\\n3 for To speech ,\\\\n2 for To Pain ,\\\\n1 for None',
  `Verbal_communication_Non_Intubated` int NOT NULL COMMENT '5 for oerineted ,\\\\n4 for Confused converstation,\\\\n3 for Inapropriate words ,\\\\n2 for Incompehensible sound,\\\\n1 for None',
  `Verbal_communication_Intubated` int NOT NULL,
  `Response` int NOT NULL,
  `Consciousness_Score` int NOT NULL COMMENT 'Derived Score',
  `Has_Fallen` int NOT NULL COMMENT '25 for yes ,\\\\n0 for No',
  `Accompaning_Dias` int NOT NULL COMMENT '15 for Yes ,\\\\n0 for No',
  `Tool_AIds` int NOT NULL COMMENT '0 for nevous systems ,\\\\n15 for cane ,\\\\n30 for Wheel chair /Bed lieutenant',
  `intravenous_injection` int NOT NULL COMMENT '20 for Yes ,\\\\n0 for No',
  `Movment` int NOT NULL COMMENT '20 for Dysfunctional ,\\\\n10 for weak ,\\\\n0 for Normal /No movment /Bed lieutenant',
  `Nervous_state` int NOT NULL COMMENT '15 for unaware of the dimensions ,\\\\n0 for aware of the dimensions',
  `Morse_Score` int NOT NULL COMMENT 'Derived Score',
  `Actions_taken` text NOT NULL,
  `ICU_Ticket_Id` int NOT NULL,
  `Note` text,
  PRIMARY KEY (`ICU_Follow_Up_Sheet_Id`),
  KEY `ICU_Follow_Up_Sheet_Idx_1` (`ICU_Ticket_Id`),
  CONSTRAINT `ICU_Fol_Up_ICU_Adm_Disc` FOREIGN KEY (`ICU_Ticket_Id`) REFERENCES `icu_adm_dc` (`ICU_Ticket_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icu_follow_up_sheet`
--

LOCK TABLES `icu_follow_up_sheet` WRITE;
/*!40000 ALTER TABLE `icu_follow_up_sheet` DISABLE KEYS */;
/*!40000 ALTER TABLE `icu_follow_up_sheet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icu_relative_visit`
--

DROP TABLE IF EXISTS `icu_relative_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `icu_relative_visit` (
  `Relative_Name` varchar(200) NOT NULL,
  `Visit_DateTime` timestamp NOT NULL,
  `ICU_Follow_Up_Sheet_Id` int NOT NULL,
  PRIMARY KEY (`Relative_Name`,`Visit_DateTime`),
  KEY `ICU_Relative_Visit_Idx_1` (`ICU_Follow_Up_Sheet_Id`),
  CONSTRAINT `Realative_Visit_ICU_Follow_Up_Sheet` FOREIGN KEY (`ICU_Follow_Up_Sheet_Id`) REFERENCES `icu_follow_up_sheet` (`ICU_Follow_Up_Sheet_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icu_relative_visit`
--

LOCK TABLES `icu_relative_visit` WRITE;
/*!40000 ALTER TABLE `icu_relative_visit` DISABLE KEYS */;
/*!40000 ALTER TABLE `icu_relative_visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_test`
--

DROP TABLE IF EXISTS `lab_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_test` (
  `Lab_test_Id` int NOT NULL,
  `Sample_Type` int NOT NULL COMMENT '0 for EDITA Blood,\\\\n1 for Citrated Blood,\\\\n2 for Serum,\\\\n3 for Urine,\\\\n4 for Biologica fluId\\\\n',
  `Lab_worker_Name` varchar(150) NOT NULL COMMENT 'Name of the technician who took the sample from the Patient',
  `Lap_branch` varchar(150) NOT NULL,
  `Lap_location` varchar(50) NOT NULL,
  `Lap_Number` int NOT NULL,
  `Result_image_link` varchar(2050) NOT NULL,
  `Request_sample_DateTime` timestamp NOT NULL COMMENT 'DateTime for taking the sample from the Patient.',
  `Recieve_sample_DateTime` timestamp NOT NULL COMMENT 'DateTime for taking the sample from the lap.',
  `Involved_Department` int NOT NULL,
  `Case_Dia_Id` int NOT NULL,
  `Note` text,
  PRIMARY KEY (`Lab_test_Id`),
  KEY `Lab_Test_Idx_1` (`Case_Dia_Id`),
  CONSTRAINT `Lab_Test_Case_Dia` FOREIGN KEY (`Case_Dia_Id`) REFERENCES `case_dia` (`caseDiaId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_test`
--

LOCK TABLES `lab_test` WRITE;
/*!40000 ALTER TABLE `lab_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `lab_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `old_history`
--

DROP TABLE IF EXISTS `old_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `old_history` (
  `Old_History_Id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `Type` int NOT NULL COMMENT '0 for Disease  ,\\\\n1 for Family Disease ,\\\\n2 for opeartion ,\\\\n3 for Drug ,\\\\n4 for  Vaccine ,\\\\n5 for Lab Test ,\\\\n6 for Radiology Test',
  `Name` varchar(200) NOT NULL,
  `Start_Date` date NOT NULL,
  `End_Date` date DEFAULT NULL,
  `Dose` varchar(150) DEFAULT NULL,
  `Image_link` varchar(2050) DEFAULT NULL,
  `Old_Doctor_Name` varchar(200) DEFAULT NULL,
  `Old_Doctor_Phone_Number` varchar(50) NOT NULL,
  `Patient_Id` int NOT NULL,
  `Disease_Category` int DEFAULT NULL COMMENT 'Ref list for Disease category\\\\n0 Heart disease\\\\n1 Cancer\\\\n2 Chronic lung disease\\\\n3 Stroke\\\\n4 Alzheimer''''s disease\\\\n5 Diabetes\\\\n6 Chronic kIdney disease\\\\n',
  `Note` text,
  PRIMARY KEY (`Old_History_Id`,`Type`),
  UNIQUE KEY `Old_History_Id` (`Old_History_Id`),
  KEY `Old_history_Idx_1` (`Patient_Id`),
  KEY `Patient_Id_Idx` (`Patient_Id`),
  CONSTRAINT `Old_History_Pat` FOREIGN KEY (`Patient_Id`) REFERENCES `patient` (`patientId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `old_history`
--

LOCK TABLES `old_history` WRITE;
/*!40000 ALTER TABLE `old_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `old_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op`
--

DROP TABLE IF EXISTS `op`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `op` (
  `Op_Id` int NOT NULL,
  `Op_Name` varchar(200) NOT NULL,
  `Reasons_for_Op` text NOT NULL,
  `Involved_Department_Id` int NOT NULL,
  `Anaestheric_Doctor_Id` int NOT NULL,
  `Sergeon_Id` int NOT NULL,
  `First_Doctor_Assistant_Id` int NOT NULL,
  `Second_Doctor_Assistance_Id` int DEFAULT NULL,
  `First_Nurse_Id` int NOT NULL,
  `Second_nurse_Id` int DEFAULT NULL,
  `Preparation_nurse_Id` int NOT NULL,
  `Anethetic_Used` varchar(100) NOT NULL,
  `Op_Date` date NOT NULL,
  `Op_Begin_DateTime` timestamp NOT NULL,
  `Op_End_DateTime` timestamp NOT NULL,
  `Op_Deatils` text NOT NULL,
  `Op_Result` text NOT NULL,
  `Op_complications` text NOT NULL,
  `Patient_Status_After_Op` text NOT NULL,
  `Case_Dia_Id` int NOT NULL,
  `Note` text,
  `Op_History_Id` int NOT NULL,
  `Location_Department` int NOT NULL,
  PRIMARY KEY (`Op_Id`),
  KEY `Op_Idx_1` (`Case_Dia_Id`),
  CONSTRAINT `Ope_Case_Dia` FOREIGN KEY (`Case_Dia_Id`) REFERENCES `case_dia` (`caseDiaId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op`
--

LOCK TABLES `op` WRITE;
/*!40000 ALTER TABLE `op` DISABLE KEYS */;
/*!40000 ALTER TABLE `op` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op_data`
--

DROP TABLE IF EXISTS `op_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `op_data` (
  `Op_Data_Id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `Op_Id` int NOT NULL,
  `Doctor_Id` int NOT NULL,
  PRIMARY KEY (`Op_Data_Id`),
  UNIQUE KEY `Op_Data_Id` (`Op_Data_Id`),
  KEY `Op_Data_Idx_1` (`Op_Id`),
  KEY `Op_Data_Idx_2` (`Doctor_Id`),
  CONSTRAINT `Op_Data_Op` FOREIGN KEY (`Op_Id`) REFERENCES `op` (`Op_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `OpDataDoctor` FOREIGN KEY (`Doctor_Id`) REFERENCES `doctor` (`doctorId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op_data`
--

LOCK TABLES `op_data` WRITE;
/*!40000 ALTER TABLE `op_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `op_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `patientId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `nationalId` char(14) NOT NULL,
  `fullName` varchar(600) DEFAULT NULL COMMENT 'Composite attribute',
  `firstName` varchar(150) NOT NULL,
  `secondName` varchar(150) NOT NULL,
  `thirdName` varchar(150) NOT NULL,
  `lastName` varchar(150) NOT NULL,
  `birthDate` date NOT NULL,
  `age` int DEFAULT NULL,
  `religion` int DEFAULT NULL COMMENT 'o for Muslem ,\\\\\\\\\\\\\\\\n1 for Christian\\\\\\\\\\\\\\\\n2 for Jewish',
  `gender` int NOT NULL COMMENT '0 represent Males ,\\\\\\\\n1 represent Females',
  `maritalStatus` int DEFAULT NULL COMMENT '0 for  Single ,\\\\\\\\\\\\\\\\n1 for Married \\\\\\\\\\\\\\\\n2 for Divorced \\\\\\\\\\\\\\\\n3 for WIdower',
  `nationality` int NOT NULL COMMENT 'Reference from a List of all Nationalities',
  `bloodType` int DEFAULT NULL COMMENT '0 for  A+ ,\\\\\\\\n1 for A- ,\\\\\\\\n2 for B+ ,\\\\\\\\n3 for B- ,\\\\\\\\n4 for O+ ,\\\\\\\\n5 for O- ,\\\\\\\\n6 for AB+ ,\\\\\\\\n7 for AB- ,',
  `address` varchar(255) DEFAULT ' ',
  `country` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `city` varchar(50) DEFAULT ' ',
  `street` varchar(50) NOT NULL DEFAULT ' ',
  `buildingNumber` varchar(10) NOT NULL DEFAULT ' ',
  `appartment` int NOT NULL DEFAULT '1',
  `birthPlace` varchar(150) DEFAULT ' ' COMMENT 'Composite attribute',
  `birthCountry` varchar(50) DEFAULT ' ' COMMENT 'Governate',
  `birthState` varchar(50) DEFAULT ' ',
  `birthCity` varchar(50) DEFAULT ' ',
  `phoneNumber` varchar(50) NOT NULL,
  `height` decimal(5,2) DEFAULT NULL COMMENT 'Height in cm',
  `weight` decimal(5,2) DEFAULT NULL COMMENT 'Weight in Kg',
  `job` varchar(50) DEFAULT NULL,
  `jobAddress` varchar(150) DEFAULT ' ' COMMENT 'Composite attribute',
  `jobCountry` varchar(50) DEFAULT ' ',
  `jobState` varchar(50) DEFAULT ' ',
  `jobCity` varchar(50) DEFAULT ' ',
  `note` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `patientPP` varchar(255) DEFAULT NULL,
  `patientPPHash` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`patientId`),
  UNIQUE KEY `Patient_Id_UNIQUE` (`patientId`),
  UNIQUE KEY `National_Id_Card_UNIQUE` (`nationalId`),
  UNIQUE KEY `User_Id_UNIQUE` (`userId`),
  KEY `max_Patient_id_idx` (`patientId` DESC),
  CONSTRAINT `User_Patient` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (21,10,'30012090201054','John Lamei Shahin Rezaik','John','Lamei','Shahin','Rezaik','2000-12-08',22,1,0,0,53,0,'Egypt, Alexandria, , 211, 6, 1','Egypt','Alexandria','','211','6',1,NULL,'',NULL,'','01029182175',0.00,0.00,'','  ','','','','','2023-04-28 09:06:39','2023-05-11 20:50:59',NULL,NULL),(22,11,'30012090661122','Ahmed Fathy Hagag Abdallah','Ahmed','Fathy','Hagag','Abdallah','2000-05-08',23,0,0,0,53,1,'Egypt, Cairo, , 64, 8, 6','Egypt','Cairo','','64','8',6,NULL,'',NULL,'','01029182698',0.00,0.00,'','Egypt, Alexandria, ','Egypt','Alexandria','','','2023-04-28 13:02:00','2023-05-11 21:03:38',NULL,NULL),(23,9,'30012090661121','Badieh Nader Naeim El masry','Badieh','Nader','Naeim','El masry','2000-10-09',22,1,0,0,53,2,'Egypt, Alexandria, keliopatra, 11, 4, 3','Egypt','Alexandria','keliopatra','11','4',3,NULL,'Egypt',NULL,NULL,'01029182633',NULL,NULL,'Dev','Germany, Berlin, City','Germany','Berlin','City',NULL,'2023-05-11 12:18:12','2023-05-11 21:05:58',NULL,NULL),(24,102,'12345678901234','محمد علي مصطفى محمود','محمد','علي','مصطفى','محمود','1990-01-01',33,NULL,0,NULL,1,NULL,'مصر القاهرة  شارع العباسية 123 1','مصر','القاهرة','','شارع العباسية','123',1,'  ','','','','0123456789',NULL,NULL,NULL,'  ','','','',NULL,'2023-05-12 14:40:09','2023-05-12 14:40:09','https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80',NULL),(25,99,'98765432109876','null محمد عبدالله حسين','null','محمد','عبدالله','حسين','1985-05-15',38,NULL,1,NULL,1,NULL,'مصر, الجيزة,  , شارع الهرم, 789, 1','مصر','الجيزة',' ','شارع الهرم','789',1,'     ',' ',' ',' ','0123456789',NULL,NULL,NULL,' ,  ,  ',' ',' ',' ',NULL,'2023-05-12 14:47:09','2023-05-15 04:22:41','https://images.unsplash.com/photo-1673841525999-16a4621db0de?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=674&q=80',NULL);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_appt`
--

DROP TABLE IF EXISTS `patient_appt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_appt` (
  `apptId` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `report` text NOT NULL,
  `apptState` enum('upcoming','canceled','completed') DEFAULT 'upcoming',
  `patientId` int NOT NULL,
  `clinicssSkdId` int NOT NULL,
  `note` text,
  `createdAt` timestamp NULL DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`apptId`),
  KEY `Patient_Appt_Idx_1` (`patientId`),
  KEY `Patient_Appt_Idx_2` (`clinicssSkdId`),
  CONSTRAINT `Patient_Appt_Clinicss_Skd` FOREIGN KEY (`clinicssSkdId`) REFERENCES `clinicss_skd` (`skdId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Patient_Appt_Patient` FOREIGN KEY (`patientId`) REFERENCES `patient` (`patientId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_appt`
--

LOCK TABLES `patient_appt` WRITE;
/*!40000 ALTER TABLE `patient_appt` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_appt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radiology_test`
--

DROP TABLE IF EXISTS `radiology_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `radiology_test` (
  `Radiology_test_Id` int NOT NULL,
  `Test_Type` int NOT NULL COMMENT 'Ref from a list of avaiLable tests.',
  `Result_image_link` varchar(2050) NOT NULL,
  `Request_test_DateTime` timestamp NOT NULL,
  `Recieve_test_DateTime` timestamp NOT NULL,
  `Involved_Department_Id` int NOT NULL,
  `Case_Dia_Id` int NOT NULL,
  `Note` text,
  PRIMARY KEY (`Radiology_test_Id`),
  KEY `Radiology_test_Idx_1` (`Case_Dia_Id`),
  CONSTRAINT `Radiolgy_Test_Case_Dia` FOREIGN KEY (`Case_Dia_Id`) REFERENCES `case_dia` (`caseDiaId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radiology_test`
--

LOCK TABLES `radiology_test` WRITE;
/*!40000 ALTER TABLE `radiology_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `radiology_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `userId` int NOT NULL,
  `type` enum('refresh','resetPassword','verifyEmail','access') NOT NULL,
  `expires` datetime NOT NULL,
  `blacklisted` tinyint(1) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `token_user` (`userId`),
  CONSTRAINT `token_user` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (7,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjczLCJpYXQiOjE2ODM3MTM0NzUsImV4cCI6MTY4NjMwNTQ3NSwidHlwZSI6InJlZnJlc2gifQ.i_20j9Cjl6TLdnitp7msV-349H1CTEaGIcyHykGBgmw',73,'refresh','2023-06-09 10:11:15',0,'2023-05-10 10:11:15','2023-05-10 10:11:15'),(8,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjc0LCJpYXQiOjE2ODM3MTM4NjQsImV4cCI6MTY4NjMwNTg2NCwidHlwZSI6InJlZnJlc2gifQ.Eu_wnwrX1y2f4I3n05YCL8pVUgTqtCK92VdIA_wGoHo',74,'refresh','2023-06-09 10:17:44',0,'2023-05-10 10:17:44','2023-05-10 10:17:44'),(9,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjc2LCJpYXQiOjE2ODM3MTM5ODcsImV4cCI6MTY4NjMwNTk4NywidHlwZSI6InJlZnJlc2gifQ.kC0uy8NpAYgVdF2JbApo1vnadqkbD8ZPBLCnCSUPVGQ',76,'refresh','2023-06-09 10:19:47',0,'2023-05-10 10:19:47','2023-05-10 10:19:47'),(10,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjc5LCJpYXQiOjE2ODM3MTQwNjUsImV4cCI6MTY4NjMwNjA2NSwidHlwZSI6InJlZnJlc2gifQ.GNgl0zD4ZZkuBv0mHKg7OvIBGIxdMFSfWd_pRNZ7KLo',79,'refresh','2023-06-09 10:21:05',0,'2023-05-10 10:21:05','2023-05-10 10:21:05'),(11,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjgxLCJpYXQiOjE2ODM3MTQxODcsImV4cCI6MTY4NjMwNjE4NywidHlwZSI6InJlZnJlc2gifQ.JahFsFUEoS7EwQ5shdVZ1E0w4bOA6o8raVi1Tew68Nw',81,'refresh','2023-06-09 10:23:07',0,'2023-05-10 10:23:07','2023-05-10 10:23:07'),(12,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjgyLCJpYXQiOjE2ODM3MTQyNzUsImV4cCI6MTY4NjMwNjI3NSwidHlwZSI6InJlZnJlc2gifQ.EOHjQbsf0CkKtun90BwHu2GypPFuomt0_frO8C8mfeM',82,'refresh','2023-06-09 10:24:35',0,'2023-05-10 10:24:35','2023-05-10 10:24:35'),(13,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjgzLCJpYXQiOjE2ODM3MTQ2NTYsImV4cCI6MTY4NjMwNjY1NiwidHlwZSI6InJlZnJlc2gifQ.3TR_JV7fCk47mZC1q2hmZzhQ3MNVMVp4zxhkDVnqlHg',83,'refresh','2023-06-09 10:30:56',0,'2023-05-10 10:30:56','2023-05-10 10:30:56'),(14,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg0LCJpYXQiOjE2ODM3MTUwOTUsImV4cCI6MTY4NjMwNzA5NSwidHlwZSI6InJlZnJlc2gifQ.9K9fZCUPZYFLTPXsg1FkTJpWuUgNZZZw_H8nVqfT2zc',84,'refresh','2023-06-09 10:38:15',0,'2023-05-10 10:38:15','2023-05-10 10:38:15'),(15,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg1LCJpYXQiOjE2ODM3MTUyNjYsImV4cCI6MTY4NjMwNzI2NiwidHlwZSI6InJlZnJlc2gifQ.xOxKRrRZLnQ8kSnEw_EmD_7YVtsNsqCglV5AbVNV-JM',85,'refresh','2023-06-09 10:41:06',0,'2023-05-10 10:41:06','2023-05-10 10:41:06'),(16,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg2LCJpYXQiOjE2ODM3MTU0NTYsImV4cCI6MTY4NjMwNzQ1NiwidHlwZSI6InJlZnJlc2gifQ.jUqkYODx03HwxuufB-GpnxUDYjlEVICDmFhJIIsQ2aw',86,'refresh','2023-06-09 10:44:16',0,'2023-05-10 10:44:16','2023-05-10 10:44:16'),(17,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg2LCJpYXQiOjE2ODM3MTU0ODMsImV4cCI6MTY4NjMwNzQ4MywidHlwZSI6InJlZnJlc2gifQ.nuOwozx__CHxmSU1FI6V1Lv_Vkxz_hwqP25QRhzQevg',86,'refresh','2023-06-09 10:44:43',0,'2023-05-10 10:44:43','2023-05-10 10:44:43'),(18,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg4LCJpYXQiOjE2ODM3NDgwODksImV4cCI6MTY4NjM0MDA4OSwidHlwZSI6InJlZnJlc2gifQ.-VHhrwdxZULyCOazuGnDTakSmvgsdl2xbst9CCF8sl8',88,'refresh','2023-06-09 19:48:09',0,'2023-05-10 19:48:09','2023-05-10 19:48:09'),(19,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg4LCJpYXQiOjE2ODM3NDgxMzUsImV4cCI6MTY4NjM0MDEzNSwidHlwZSI6InJlZnJlc2gifQ.q2dDD7DjAnQAL1muzVVkiL8Qm1HgM-4lT0RBamj1PxQ',88,'refresh','2023-06-09 19:48:55',0,'2023-05-10 19:48:55','2023-05-10 19:48:55'),(20,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg4LCJpYXQiOjE2ODM3NDg5NDMsImV4cCI6MTY4NjM0MDk0MywidHlwZSI6InJlZnJlc2gifQ.MOSj4BhRnPNZhwG5pxn2XnnTPkOTG8wSpfjfQs_jDHo',88,'refresh','2023-06-09 20:02:23',0,'2023-05-10 20:02:23','2023-05-10 20:02:23'),(21,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg4LCJpYXQiOjE2ODM3NTA5NTcsImV4cCI6MTY4NjM0Mjk1NywidHlwZSI6InJlZnJlc2gifQ.M1D2tnX2vTlx1EMSfhSKlWguvAozB0W9DgnYqZ1M7ec',88,'refresh','2023-06-09 20:35:57',0,'2023-05-10 20:35:57','2023-05-10 20:35:57'),(23,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg4LCJpYXQiOjE2ODM3NTUyOTksImV4cCI6MTY4ODkzOTI5OSwidHlwZSI6InJlZnJlc2gifQ.aqt7DMDkHlyoKc8-L2VfQNmZBHDCgSdb1LoSYojpZF0',88,'refresh','2023-07-09 21:48:19',0,'2023-05-10 21:48:19','2023-05-10 21:48:19'),(24,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjI4LCJpYXQiOjE2ODM3NTU1ODEsImV4cCI6MTY4Mzc1NjE4MSwidHlwZSI6InJlc2V0UGFzc3dvcmQifQ.vqt_yzOC6qGGaa1xxSCPcdrRMSUfRYQEEr-MCfmDPGo',28,'resetPassword','2023-05-10 22:03:01',0,'2023-05-10 21:53:01','2023-05-10 21:53:01'),(25,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODM3OTgyMzEsImV4cCI6MTY4ODk4MjIzMSwidHlwZSI6InJlZnJlc2gifQ.iFG75ehPOERJkYXtXc_H-tTQJbulyHbZh-lBbeN-CMo',89,'refresh','2023-07-10 09:43:51',0,'2023-05-11 09:43:51','2023-05-11 09:43:51'),(26,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODM3OTgzMTEsImV4cCI6MTY4ODk4MjMxMSwidHlwZSI6InJlZnJlc2gifQ.TYDxaKU2vReJQfXhjVVf5xzdW1F-hZwVHUGu550NziQ',89,'refresh','2023-07-10 09:45:11',0,'2023-05-11 09:45:11','2023-05-11 09:45:11'),(27,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjkwLCJpYXQiOjE2ODM4OTA5NDgsImV4cCI6MTY4OTA3NDk0OCwidHlwZSI6InJlZnJlc2gifQ.pefUZd5TFcpKjbe_nKS5F1W7RrhYWNSj55XTBeFMv1E',90,'refresh','2023-07-11 11:29:08',0,'2023-05-12 11:29:08','2023-05-12 11:29:08'),(28,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjkxLCJpYXQiOjE2ODM4OTExMjMsImV4cCI6MTY4OTA3NTEyMywidHlwZSI6InJlZnJlc2gifQ.DZ-taFizZzUyWOmY69zJSekm9b4wCV_YK66ZjfQsgog',91,'refresh','2023-07-11 11:32:03',0,'2023-05-12 11:32:03','2023-05-12 11:32:03'),(29,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjk0LCJpYXQiOjE2ODM4OTExNjksImV4cCI6MTY4OTA3NTE2OSwidHlwZSI6InJlZnJlc2gifQ.G0h2VzsdU6_e9VyRMDMzhsiWt8rufSh08Xim4-idpMA',94,'refresh','2023-07-11 11:32:49',0,'2023-05-12 11:32:49','2023-05-12 11:32:49'),(30,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjk4LCJpYXQiOjE2ODM4OTE1NjAsImV4cCI6MTY4OTA3NTU2MCwidHlwZSI6InJlZnJlc2gifQ.syIfQlKbweHHnBZptMQJY-Xz2OmnAtvGjykB1NK0QOo',98,'refresh','2023-07-11 11:39:20',0,'2023-05-12 11:39:20','2023-05-12 11:39:20'),(31,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjk5LCJpYXQiOjE2ODM4OTE2NTYsImV4cCI6MTY4OTA3NTY1NiwidHlwZSI6InJlZnJlc2gifQ.WjC8ienUeA4ATubQybrUFkJIKmg-F35o0SMKZA55JPA',99,'refresh','2023-07-11 11:40:56',0,'2023-05-12 11:40:56','2023-05-12 11:40:56'),(32,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwMCwiaWF0IjoxNjgzODkxODM0LCJleHAiOjE2ODkwNzU4MzQsInR5cGUiOiJyZWZyZXNoIn0.fJ2uj5YSgaHzHMyr_wVMbVBEd-Q13oy5Kzk3zSaX5ps',100,'refresh','2023-07-11 11:43:54',0,'2023-05-12 11:43:54','2023-05-12 11:43:54'),(33,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwMCwiaWF0IjoxNjgzODkxODM0LCJleHAiOjE2ODM4OTM2MzQsInR5cGUiOiJhY2Nlc3MifQ.VNE-4ytdvMr_OXZ-nqdv71ENxV4465NYWM5yy4h0nt8',100,'access','2023-05-12 12:13:54',0,'2023-05-12 11:43:54','2023-05-12 11:43:54'),(34,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwMSwiaWF0IjoxNjgzODkxODc1LCJleHAiOjE2ODkwNzU4NzUsInR5cGUiOiJyZWZyZXNoIn0.l_Wedq1e8zT7pt1cMf1YMhEhQ9UKRIYJMC1-pUEY5_s',101,'refresh','2023-07-11 11:44:35',0,'2023-05-12 11:44:35','2023-05-12 11:44:35'),(35,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwMSwiaWF0IjoxNjgzODkxODc1LCJleHAiOjE2ODM4OTM2NzUsInR5cGUiOiJhY2Nlc3MifQ.jyGiQhtblZ8tsQEkW2XdZc7v-ko6xqVghWo_XU_5VUc',101,'access','2023-05-12 12:14:35',0,'2023-05-12 11:44:35','2023-05-12 11:44:35'),(36,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwMiwiaWF0IjoxNjgzODkxODgzLCJleHAiOjE2ODkwNzU4ODMsInR5cGUiOiJyZWZyZXNoIn0.SQY044xuJfLaDmQLoVkYzSMBAKVz8U_gTf0IEH4cuwY',102,'refresh','2023-07-11 11:44:43',0,'2023-05-12 11:44:43','2023-05-12 11:44:43'),(37,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwMiwiaWF0IjoxNjgzODkxODgzLCJleHAiOjE2ODM4OTM2ODMsInR5cGUiOiJhY2Nlc3MifQ.7T5ahV2aiLJJjLS3AXnI6tQ38B9deE_y-ErPYM1elBI',102,'access','2023-05-12 12:14:43',0,'2023-05-12 11:44:43','2023-05-12 11:44:43'),(38,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODM4OTIwNDYsImV4cCI6MTY4OTA3NjA0NiwidHlwZSI6InJlZnJlc2gifQ.H-gpj4sxZ2MD6zHsFdHlWdpDI1J4xEQs-UF7C0OOBKo',89,'refresh','2023-07-11 11:47:26',0,'2023-05-12 11:47:26','2023-05-12 11:47:26'),(39,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODM4OTIwNDYsImV4cCI6MTY4Mzg5Mzg0NiwidHlwZSI6ImFjY2VzcyJ9.Egqx6j2MNRzQS55djsy6KPaMJSE54_X402dkb0QNGSU',89,'access','2023-05-12 12:17:26',0,'2023-05-12 11:47:26','2023-05-12 11:47:26'),(40,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODM4OTIyOTMsImV4cCI6MTY4OTA3NjI5MywidHlwZSI6InJlZnJlc2gifQ.c0I1pJaqTHRoEsErC8dsyFiGa-3ti9i0DQxgpp-1li4',89,'refresh','2023-07-11 11:51:33',0,'2023-05-12 11:51:33','2023-05-12 11:51:33'),(41,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODM4OTIyOTMsImV4cCI6MTY4Mzg5NDA5MywidHlwZSI6ImFjY2VzcyJ9.Izyqn4G06_Sdii540-260fp_WW8eXwnI2cmIpjcs5vQ',89,'access','2023-05-12 12:21:33',0,'2023-05-12 11:51:33','2023-05-12 11:51:33'),(43,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODM4OTI0MzksImV4cCI6MTY4Mzg5NDIzOSwidHlwZSI6ImFjY2VzcyJ9.eAwF2UQbNPTY0ndV8KpNUUm84iW0CbX0Jy9IWXQu07Q',89,'access','2023-05-12 12:23:59',0,'2023-05-12 11:53:59','2023-05-12 11:53:59'),(45,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODM4OTI0NzcsImV4cCI6MTY4Mzg5NDI3NywidHlwZSI6ImFjY2VzcyJ9.gpQCrGAOQcqmWYzgk6Gq8UYNV3PsDztZOlJzVOAfn5w',89,'access','2023-05-12 12:24:37',0,'2023-05-12 11:54:37','2023-05-12 11:54:37'),(47,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODM4OTI1NjcsImV4cCI6MTY4Mzg5NDM2NywidHlwZSI6ImFjY2VzcyJ9.E1wGb9dH5Oz-m9iW6G7BfCFhubiuxpmDTgZZHXtZMrE',89,'access','2023-05-12 12:26:07',0,'2023-05-12 11:56:07','2023-05-12 11:56:07'),(48,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODM4OTMwMDEsImV4cCI6MTY4OTA3NzAwMSwidHlwZSI6InJlZnJlc2gifQ.X91LKxbbEmw2caxWV1QWjP7I2y7e0KEYixEP6OARf0w',89,'refresh','2023-07-11 12:03:21',0,'2023-05-12 12:03:21','2023-05-12 12:03:21'),(49,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODM4OTMwMDEsImV4cCI6MTY4Mzg5NDgwMSwidHlwZSI6ImFjY2VzcyJ9.5HArIl8WcGadz2j-kFH_eHPaNwbv3NfnmEgQFUE9TXI',89,'access','2023-05-12 12:33:21',0,'2023-05-12 12:03:21','2023-05-12 12:03:21'),(50,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODQwMTA5MjYsImV4cCI6MTY4OTE5NDkyNiwidHlwZSI6InJlZnJlc2gifQ.TTVhT8zd78UbhDXeVCycCwJTwBNPNYHXyb66HR21f_A',89,'refresh','2023-07-12 20:48:46',0,'2023-05-13 20:48:46','2023-05-13 20:48:46'),(51,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg5LCJpYXQiOjE2ODQwMTA5MjYsImV4cCI6MTY4NDAxMjcyNiwidHlwZSI6ImFjY2VzcyJ9.oxlu4fxFg8uBo0ZAGLYbknr8B0zolvVUIX3CG8lH7zM',89,'access','2023-05-13 21:18:46',0,'2023-05-13 20:48:46','2023-05-13 20:48:46'),(52,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwMywiaWF0IjoxNjg0MDExMDYxLCJleHAiOjE2ODkxOTUwNjEsInR5cGUiOiJyZWZyZXNoIn0.buq9WOixnQKKuagkauiG9b8VGmfMNBnSjFKD5KfYwSk',103,'refresh','2023-07-12 20:51:01',0,'2023-05-13 20:51:01','2023-05-13 20:51:01'),(53,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwMywiaWF0IjoxNjg0MDExMDYxLCJleHAiOjE2ODQwMTI4NjEsInR5cGUiOiJhY2Nlc3MifQ.Be8fbrYCGI4WIC7ddyFYnlqiey3BD2GuYRbTpRJzsGc',103,'access','2023-05-13 21:21:01',0,'2023-05-13 20:51:01','2023-05-13 20:51:01'),(55,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwMywiaWF0IjoxNjg0MDExMDgwLCJleHAiOjE2ODQwMTI4ODAsInR5cGUiOiJhY2Nlc3MifQ.H8GhvBk6liPVi1vEzay45UaNnZ_bfE5WWrDwKeL6NFg',103,'access','2023-05-13 21:21:20',0,'2023-05-13 20:51:20','2023-05-13 20:51:20'),(56,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwMywiaWF0IjoxNjg0MDExMTU0LCJleHAiOjE2ODkxOTUxNTQsInR5cGUiOiJyZWZyZXNoIn0.kLy9z0y_eaHdLjK77LOVAWaM1Cq8_x8nyOvxqo2WG44',103,'refresh','2023-07-12 20:52:34',0,'2023-05-13 20:52:34','2023-05-13 20:52:34'),(57,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwMywiaWF0IjoxNjg0MDExMTU0LCJleHAiOjE2ODQwMTI5NTQsInR5cGUiOiJhY2Nlc3MifQ.HjH7o8UOrnkelHqDF7SOmH8iNh5e6VphJ24ZwIsqSrs',103,'access','2023-05-13 21:22:34',0,'2023-05-13 20:52:34','2023-05-13 20:52:34'),(58,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwNSwiaWF0IjoxNjg0MDcwODI0LCJleHAiOjE2ODkyNTQ4MjQsInR5cGUiOiJyZWZyZXNoIn0.RJ7YAgGvTf5XUVqZhmkSZMbqGsObKdA2y_I8qbm4S3c',105,'refresh','2023-07-13 13:27:04',0,'2023-05-14 13:27:04','2023-05-14 13:27:04'),(59,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwNSwiaWF0IjoxNjg0MDcwODI0LCJleHAiOjE2ODQwNzI2MjQsInR5cGUiOiJhY2Nlc3MifQ.ST7RgJ6TxFxa_3gE1593kOxlP2pGkTd2cF7EVqAyWGg',105,'access','2023-05-14 13:57:04',0,'2023-05-14 13:27:04','2023-05-14 13:27:04'),(60,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwNywiaWF0IjoxNjg0MDcxMzg3LCJleHAiOjE2ODkyNTUzODcsInR5cGUiOiJyZWZyZXNoIn0.4OASn244EBQ4xUkPMy0DJR6fnGiRHajIXefA2hbPi40',107,'refresh','2023-07-13 13:36:27',0,'2023-05-14 13:36:27','2023-05-14 13:36:27'),(61,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwNywiaWF0IjoxNjg0MDcxMzg3LCJleHAiOjE2ODQwNzMxODcsInR5cGUiOiJhY2Nlc3MifQ.JdumRDfbfZMVxnj5eV80Jy-sDEYO3dZrpa6pAfDveb4',107,'access','2023-05-14 14:06:27',0,'2023-05-14 13:36:27','2023-05-14 13:36:27'),(62,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwOCwiaWF0IjoxNjg0MDcxNDE3LCJleHAiOjE2ODkyNTU0MTcsInR5cGUiOiJyZWZyZXNoIn0.I0mVfXP8iBhDo5drpswjo4uYCWWsJxRCdsghPsahITg',108,'refresh','2023-07-13 13:36:57',0,'2023-05-14 13:36:57','2023-05-14 13:36:57'),(63,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEwOCwiaWF0IjoxNjg0MDcxNDE3LCJleHAiOjE2ODQwNzMyMTcsInR5cGUiOiJhY2Nlc3MifQ.-dYBWj9bBjrRlXKBtF8cy1QWu1Z2EI4njQaZ1s5sLrM',108,'access','2023-05-14 14:06:57',0,'2023-05-14 13:36:57','2023-05-14 13:36:57'),(64,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjExMCwiaWF0IjoxNjg0MDcxNDQ0LCJleHAiOjE2ODkyNTU0NDQsInR5cGUiOiJyZWZyZXNoIn0.UTbo88vq_1WSQs0nZLikgKL4ZUba4OtNZhLO40yQ_MY',110,'refresh','2023-07-13 13:37:24',0,'2023-05-14 13:37:24','2023-05-14 13:37:24'),(65,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjExMSwiaWF0IjoxNjg0MDcyNjc0LCJleHAiOjE2ODkyNTY2NzQsInR5cGUiOiJyZWZyZXNoIn0.I3INyPZNPYx4DdnxsOLqw7zv_f_LonWuV4x_LW2Oz5o',111,'refresh','2023-07-13 13:57:54',0,'2023-05-14 13:57:54','2023-05-14 13:57:54'),(66,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjExMSwiaWF0IjoxNjg0MDcyNjc0LCJleHAiOjE2ODQwNzQ0NzQsInR5cGUiOiJhY2Nlc3MifQ.RVsd2UU0x0hAfxKvFn6ur4DbhwmfL5RsrzN_xhbUxu8',111,'access','2023-05-14 14:27:54',0,'2023-05-14 13:57:54','2023-05-14 13:57:54'),(67,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyMCwiaWF0IjoxNjg0MDc3MDE2LCJleHAiOjE2ODkyNjEwMTYsInR5cGUiOiJyZWZyZXNoIn0.1rmoO_R1x_ev-Bn2IMNBW4CEP1jya6xx3P1bkez4Ouc',120,'refresh','2023-07-13 15:10:16',0,'2023-05-14 15:10:16','2023-05-14 15:10:16'),(68,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyMCwiaWF0IjoxNjg0MDc3MDE2LCJleHAiOjE2ODQwNzg4MTYsInR5cGUiOiJhY2Nlc3MifQ.wazkeQba7fhPOFXffTUuF6jQMxB01K4mPFx54OIanRw',120,'access','2023-05-14 15:40:16',0,'2023-05-14 15:10:16','2023-05-14 15:10:16'),(69,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyMSwiaWF0IjoxNjg0MDc4MDIxLCJleHAiOjE2ODkyNjIwMjEsInR5cGUiOiJyZWZyZXNoIn0.a8ubL8l8H9t6jXJS4wGwCKiS64aUsHlPJNiwEwexdAw',121,'refresh','2023-07-13 15:27:01',0,'2023-05-14 15:27:01','2023-05-14 15:27:01'),(70,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyMSwiaWF0IjoxNjg0MDc4MDIxLCJleHAiOjE2ODQwNzk4MjEsInR5cGUiOiJhY2Nlc3MifQ.G7Jcaj6BcxcODR2yNm8BqIN69j8d38jSJMa9HZ9-4io',121,'access','2023-05-14 15:57:01',0,'2023-05-14 15:27:01','2023-05-14 15:27:01'),(71,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyMiwiaWF0IjoxNjg0MTI1MTc2LCJleHAiOjE2ODkzMDkxNzYsInR5cGUiOiJyZWZyZXNoIn0.yddLzcQ4l1jnJYpJbGFZXpRAbaHicZV6cyhtbmv4hcM',122,'refresh','2023-07-14 04:32:56',0,'2023-05-15 04:32:56','2023-05-15 04:32:56'),(72,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyMiwiaWF0IjoxNjg0MTI1MTc2LCJleHAiOjE2ODQxMjY5NzYsInR5cGUiOiJhY2Nlc3MifQ.oyI6wY4mYBOMYejerqx6O8qtkNkxR8wOwAbbY1M6ibI',122,'access','2023-05-15 05:02:56',0,'2023-05-15 04:32:56','2023-05-15 04:32:56'),(73,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyMywiaWF0IjoxNjg0MTI1NTY5LCJleHAiOjE2ODkzMDk1NjksInR5cGUiOiJyZWZyZXNoIn0.2mW9MSPoN3y3EBe2XPPhtyDhrCZIM3t-5vmGiHUjsxo',123,'refresh','2023-07-14 04:39:29',0,'2023-05-15 04:39:29','2023-05-15 04:39:29'),(74,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyMywiaWF0IjoxNjg0MTI1NTY5LCJleHAiOjE2ODQxMjczNjksInR5cGUiOiJhY2Nlc3MifQ.YAFiN7xGmv-Vbcb6myW9MaRfrFRIs5GYQWWYsz-VHWs',123,'access','2023-05-15 05:09:29',0,'2023-05-15 04:39:29','2023-05-15 04:39:29'),(75,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyNCwiaWF0IjoxNjg0MTI1NzQ3LCJleHAiOjE2ODkzMDk3NDcsInR5cGUiOiJyZWZyZXNoIn0.wFqmni-FCearsnC9OJaxtnMVUibE_qlzO8HNkDnm65I',124,'refresh','2023-07-14 04:42:27',0,'2023-05-15 04:42:27','2023-05-15 04:42:27'),(76,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyNCwiaWF0IjoxNjg0MTI1NzQ3LCJleHAiOjE2ODQxMjc1NDcsInR5cGUiOiJhY2Nlc3MifQ.m6tGLyGkIIIA6smdwfZWNYAZEHAQJxKtnYRthkJdHkU',124,'access','2023-05-15 05:12:27',0,'2023-05-15 04:42:27','2023-05-15 04:42:27'),(77,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyNSwiaWF0IjoxNjg0MTI4MzQ3LCJleHAiOjE2ODkzMTIzNDcsInR5cGUiOiJyZWZyZXNoIn0.yE6nmBEAeT6wo-Y_vLvNW6MHKtPlbp8f9m1oEee6qc8',125,'refresh','2023-07-14 05:25:47',0,'2023-05-15 05:25:47','2023-05-15 05:25:47'),(78,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyNSwiaWF0IjoxNjg0MTI4MzQ3LCJleHAiOjE2ODQxMzAxNDcsInR5cGUiOiJhY2Nlc3MifQ.jzsxC9_QxKA9buUdYpxgnK-i2qBWmLobWQ9f5GHhJSc',125,'access','2023-05-15 05:55:47',0,'2023-05-15 05:25:47','2023-05-15 05:25:47'),(79,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyNiwiaWF0IjoxNjg0MTI4MzcwLCJleHAiOjE2ODkzMTIzNzAsInR5cGUiOiJyZWZyZXNoIn0.xYoTsyH7QnZSs0Oz7wHmKcDsRVUta_8hVP1Z3gnzgMs',126,'refresh','2023-07-14 05:26:10',0,'2023-05-15 05:26:10','2023-05-15 05:26:10'),(80,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyNiwiaWF0IjoxNjg0MTI4MzcwLCJleHAiOjE2ODQxMzAxNzAsInR5cGUiOiJhY2Nlc3MifQ.HNj4I2Xsi8k7RVjHbeCwGlaAeOSdOa39gw-sJ5TfuSE',126,'access','2023-05-15 05:56:10',0,'2023-05-15 05:26:10','2023-05-15 05:26:10'),(81,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyNywiaWF0IjoxNjg0MTI4Mzc5LCJleHAiOjE2ODkzMTIzNzksInR5cGUiOiJyZWZyZXNoIn0.9jof_X1ieQ64mA5BNM8ElYConW7dDt3oFuOgDtgS2tI',127,'refresh','2023-07-14 05:26:19',0,'2023-05-15 05:26:19','2023-05-15 05:26:19'),(82,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyNywiaWF0IjoxNjg0MTI4Mzc5LCJleHAiOjE2ODQxMzAxNzksInR5cGUiOiJhY2Nlc3MifQ.LtQgfsVEWaQnChepDOxld7FauyWlhLJqWXD80gM28L0',127,'access','2023-05-15 05:56:19',0,'2023-05-15 05:26:19','2023-05-15 05:26:19'),(83,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyOCwiaWF0IjoxNjg0MTI4Mzg3LCJleHAiOjE2ODkzMTIzODcsInR5cGUiOiJyZWZyZXNoIn0.uipmBMkBxsGvKDojyVK-3J6KEr4Tv6PDkhn9oQKcMyA',128,'refresh','2023-07-14 05:26:27',0,'2023-05-15 05:26:27','2023-05-15 05:26:27'),(84,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyOCwiaWF0IjoxNjg0MTI4Mzg3LCJleHAiOjE2ODQxMzAxODcsInR5cGUiOiJhY2Nlc3MifQ.3UdnWhXrnESIVepnM6P1ANTXsZnSHgVZJKyhsMeJP54',128,'access','2023-05-15 05:56:27',0,'2023-05-15 05:26:27','2023-05-15 05:26:27'),(85,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyOSwiaWF0IjoxNjg0MTI4Mzk0LCJleHAiOjE2ODkzMTIzOTQsInR5cGUiOiJyZWZyZXNoIn0.n_EgwvHm3cSrp1wy1L5Oum13jWDeHxJYR4orqo2gn8c',129,'refresh','2023-07-14 05:26:34',0,'2023-05-15 05:26:34','2023-05-15 05:26:34'),(86,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEyOSwiaWF0IjoxNjg0MTI4Mzk0LCJleHAiOjE2ODQxMzAxOTQsInR5cGUiOiJhY2Nlc3MifQ.mCfHHDUIM72YCaoHx7qqRcS0uDqwjgdz7WHFWzfouyk',129,'access','2023-05-15 05:56:34',0,'2023-05-15 05:26:34','2023-05-15 05:26:34'),(87,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEzMCwiaWF0IjoxNjg0MTI4NDAxLCJleHAiOjE2ODkzMTI0MDEsInR5cGUiOiJyZWZyZXNoIn0.vmEL3EmfpicvCt9zIGJa5t8OVjnpjLzRwISfdKDBciQ',130,'refresh','2023-07-14 05:26:41',0,'2023-05-15 05:26:41','2023-05-15 05:26:41'),(88,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEzMCwiaWF0IjoxNjg0MTI4NDAxLCJleHAiOjE2ODQxMzAyMDEsInR5cGUiOiJhY2Nlc3MifQ.m6PwtN78EXqpOv03pKR8fCIQwqPmOw2i1AphKPoKa4U',130,'access','2023-05-15 05:56:41',0,'2023-05-15 05:26:41','2023-05-15 05:26:41'),(89,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEzMSwiaWF0IjoxNjg0MTI4NDA5LCJleHAiOjE2ODkzMTI0MDksInR5cGUiOiJyZWZyZXNoIn0.4svrh2Yu_ngvj1AKkC4TVhsB3c9iDgrMdDLssN4zd18',131,'refresh','2023-07-14 05:26:49',0,'2023-05-15 05:26:49','2023-05-15 05:26:49'),(90,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEzMSwiaWF0IjoxNjg0MTI4NDA5LCJleHAiOjE2ODQxMzAyMDksInR5cGUiOiJhY2Nlc3MifQ.-5tAKcABszstBj2vbtzcsxXHSkcLEl6P2YHbsQx9W2E',131,'access','2023-05-15 05:56:49',0,'2023-05-15 05:26:49','2023-05-15 05:26:49');
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trt_medication`
--

DROP TABLE IF EXISTS `trt_medication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trt_medication` (
  `medicationId` int NOT NULL AUTO_INCREMENT,
  `newMedication` varchar(200) NOT NULL,
  `medicationStartDate` date NOT NULL,
  `medicationEndDate` date NOT NULL,
  `specialInstructions` varchar(500) NOT NULL,
  `labInvestigation` varchar(500) NOT NULL,
  `Case_Dia_Id` int NOT NULL,
  `Note` text,
  PRIMARY KEY (`medicationId`),
  KEY `Trt_Medication_Idx_1` (`Case_Dia_Id`),
  CONSTRAINT `Trt_Med_Case_Dia` FOREIGN KEY (`Case_Dia_Id`) REFERENCES `case_dia` (`caseDiaId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trt_medication`
--

LOCK TABLES `trt_medication` WRITE;
/*!40000 ALTER TABLE `trt_medication` DISABLE KEYS */;
/*!40000 ALTER TABLE `trt_medication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` char(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Ryan','123456789','ryan123@gmail.com','patient','2023-04-29 08:59:46','2023-04-29 08:59:46'),(2,'Maryrose','123456789','Maryrose@gmail.com','patient','2023-04-29 09:10:30','2023-04-29 09:10:30'),(3,'Danae','123456789','Danae@gmail.com','patient','2023-04-29 09:11:23','2023-04-29 09:11:23'),(4,'Kamel','123456789','Kamel@gmail.com','patient','2023-04-29 09:12:01','2023-04-29 09:12:01'),(5,'ahmed','123456789','ahmed1@gmail.com','patient','2023-04-29 09:12:14','2023-04-29 09:12:14'),(6,'Mohamed','123456789','Mohamed1@gmail.com','patient','2023-04-29 09:12:20','2023-04-29 09:12:20'),(7,'ali','123456789','ali1@gmail.com','patient','2023-04-29 09:12:23','2023-04-29 09:12:23'),(8,'Holton','123456789','Holton@gmail.com','patient','2023-04-29 09:12:25','2023-04-29 09:12:25'),(9,'Badieh','123456789','Badieh@gmail.com','admin','2023-04-29 09:12:27','2023-04-29 09:12:27'),(10,'John','123456789','John.lamei.12@gmail.com','admin','2023-04-29 09:12:29','2023-04-29 09:12:29'),(11,'Fathy','123456789','Fathy@gmail.com','patient','2023-04-29 09:12:32','2023-04-29 09:12:32'),(26,NULL,'123456789','Badieh2@gmail.com',NULL,'2023-05-06 09:58:34','2023-05-06 09:58:34'),(28,NULL,'123456789','Badieh3@gmail.com','admin','2023-05-06 10:06:18','2023-05-06 10:06:18'),(33,NULL,'123456789','Badieh4@gmail.com','admin','2023-05-06 10:12:12','2023-05-06 10:12:12'),(34,NULL,'123456789','Badieh5@gmail.com','admin','2023-05-06 10:23:51','2023-05-06 10:23:51'),(43,NULL,'temp','Badieh6@gmail.com',NULL,'2023-05-06 10:41:00','2023-05-06 10:41:00'),(45,NULL,'$2a$10$cxnU8jaThx1EPDtNX8vNsOgRfFF4QGf/wsdftoBXDLAbtfVaeww96','Badieh7@gmail.com',NULL,'2023-05-06 10:43:06','2023-05-06 10:43:06'),(47,NULL,'$2a$10$TRXFqMP4OuljeOL0l8B.7eRZ7r6l.vn3WyfASETSxtsXdgEDjgHoK','Badieh8@gmail.com',NULL,'2023-05-06 11:14:48','2023-05-06 11:14:48'),(49,NULL,'$2a$10$StdlVAHxSVcUJtGuZbUVZes/FhC9Dw3cb/WJ1wtvv.h.SehZSa1b2','Badieh9@gmail.com',NULL,'2023-05-06 11:19:10','2023-05-06 11:19:10'),(51,NULL,'$2a$10$RfcTdqsDq0PX/j0ahooF9.zO8yBwSwN8EHWDkd48RU9tl4caB0l.m','Badieh01@gmail.com',NULL,'2023-05-06 11:56:03','2023-05-06 11:56:03'),(53,NULL,'$2a$10$GLd5cPtGLMBL1V9m44dIeelb2yWTV9vnwwKXfhVPyW60l.tXDfKtW','Badieh02@gmail.com',NULL,'2023-05-06 12:08:43','2023-05-06 12:08:43'),(54,NULL,'$2a$10$mNbjYnCYqK/8fvc/2WihY.4ubr3k/tjMIwHLPK0JvVSUJBPNnV8NG','Badieh03@gmail.com',NULL,'2023-05-06 12:08:55','2023-05-06 12:08:55'),(56,NULL,'$2a$10$tFm.CDfNLMWVVX8sYItr3OadDLcZIeBhgGC9zaMhX5Wxv0c2SZPXK','Badieh04@gmail.com',NULL,'2023-05-06 12:42:00','2023-05-06 12:42:00'),(58,NULL,'$2a$10$lC/Z2lE.kkNc401GEy6WYesjaIGTzQdozHhfqNy0tRO1KqBDlKBCK','Badieh05@gmail.com',NULL,'2023-05-06 12:45:46','2023-05-06 12:45:46'),(59,NULL,'$2a$08$2eJdBfBmQyZ0oXdguWbJa.R35YOT.SDgwPQWw9mVL37K.dASCoO1C','Badieh80@gmail.com',NULL,'2023-05-09 07:44:29','2023-05-09 07:44:29'),(62,NULL,'$2a$08$xZYb6qEAsSryCJjssujVn.SX0ywC0Z9cDSZITO4xtVLEiz0SWLPBC','Badieh81@gmail.com',NULL,'2023-05-09 08:34:38','2023-05-09 08:34:38'),(64,NULL,'$2a$08$GViBJbFOnrLPjzstnS.Nj.0dgVGyJruNB6fK9JwAdQ65.xgywg4D.','Badieh82@gmail.com',NULL,'2023-05-09 08:35:00','2023-05-09 08:35:00'),(65,NULL,'$2a$08$jxVjVHvN2ZU1waTtzbbnMOmFLhut4wjJQPoxi64/CoE0ALLhDaaRa','Badieh83@gmail.com',NULL,'2023-05-09 08:40:29','2023-05-09 08:40:29'),(67,NULL,'$2a$08$b/pnlQvRngn6uQfyZMGHQOAaZrUZUUlzvaSp5G1tZGjkYZmEHq.3u','Badieh84@gmail.com',NULL,'2023-05-09 08:44:27','2023-05-09 08:44:27'),(68,NULL,'$2a$08$J/LCVcpcpi4RxQU2/WgLheJBFpx8WkjQbydUR8xlys/CV5OJNUFIO','Badieh74@gmail.com',NULL,'2023-05-09 09:01:26','2023-05-09 09:01:26'),(69,NULL,'$2a$08$iNEh3NxRNLlgLiqWmwriKOAUY4qk51ZUmkbsG68lF2HszQHPxq4MW','Badieh75@gmail.com','admin','2023-05-10 09:38:26','2023-05-10 09:38:26'),(71,NULL,'$2a$08$Z.ifIguG6fZBr84WnApJeOhu/bZiO6Fu4aKWrBjCRrxtfxbbNrc7G','Badieh76@gmail.com','admin','2023-05-10 09:41:10','2023-05-10 09:41:10'),(72,NULL,'$2a$08$KP7i3mdLVdu2FfXS8KVqpuz9kOQe8xWlxNu56WsnD26hXOCP1GVuG','John76@gmail.com','admin','2023-05-10 09:57:49','2023-05-10 09:57:49'),(73,NULL,'$2a$08$f5.o3MbJuO6YXLl5LZQYAOmGm4fRxA8gD78tKIjzhXgMEFfRlmAF.','John77@gmail.com','admin','2023-05-10 10:11:15','2023-05-10 10:11:15'),(74,NULL,'$2a$08$wM0NX2gINGDe9ggQxph2mOjCuWGER1O2HgCpgYgjM8uwQD23v3ggy','John78@gmail.com','admin','2023-05-10 10:17:43','2023-05-10 10:17:43'),(76,NULL,'$2a$08$gK2PTCR0w6jOEwS9v.J0kOofqa/RhaO8rQuiLHysykjCgr.w8htYe','John79@gmail.com','admin','2023-05-10 10:19:47','2023-05-10 10:19:47'),(79,NULL,'$2a$08$L57UnBmheZr6A8IelVkw.O3gUD7JgUHJBd1vwj3XQjQYuRn12BTEi','John80@gmail.com','admin','2023-05-10 10:21:05','2023-05-10 10:21:05'),(81,NULL,'$2a$08$jWPDW1ZlSzGIIWDy1Pl.uOs7oBnAIJj2JLukksyXf68g76ygXOXBG','John81@gmail.com','admin','2023-05-10 10:23:07','2023-05-10 10:23:07'),(82,NULL,'$2a$08$1Pg1478.QpDSeJXBI2/9guGv3jrFHpruDwG6GMGY568nzQi1mBSS6','John82@gmail.com','admin','2023-05-10 10:24:34','2023-05-10 10:24:34'),(83,NULL,'$2a$08$.2UMdVLy0gagN1LPfDmLyuc.cIvbiesoJdeRyrYeDr4U7vJQyswW2','John83@gmail.com','admin','2023-05-10 10:30:56','2023-05-10 10:30:56'),(84,NULL,'$2a$08$qRNgMMK7C7wCL/NckJGYl.FxDBbhC.mcH0dw8tKCIn58zRspqd/au','John84@gmail.com','admin','2023-05-10 10:38:15','2023-05-10 10:38:15'),(85,NULL,'$2a$08$T5S5Cq/.S2.kUUIuIp1XN.T4b1VUfK0kAJoRJ8HVTuikifKm4slM2','John85@gmail.com','admin','2023-05-10 10:41:06','2023-05-10 10:41:06'),(86,NULL,'$2a$12$3N0teZxpIhA7fHI3TANj2eBaOcKGH3LAvK4Fu0WKaY75tB37gP4JG','John86@gmail.com','admin','2023-05-10 10:44:16','2023-05-10 10:44:16'),(88,NULL,'$2a$12$/U4F5fZSIKHF9Zi0W5iFa.TzDvX/FOiq8NVZIuLz6hECgwWpXOca.','John87@gmail.com','admin','2023-05-10 19:48:09','2023-05-10 19:48:09'),(89,NULL,'$2a$12$EF2SgUeVeVAAWw.aDC7W0eC0NfrdLpF1T4vjtycKbeBQ.p.5HuFDG','John88@gmail.com','admin','2023-05-11 09:43:51','2023-05-11 09:43:51'),(90,NULL,'$2a$12$h75G2d8CrFR1jXngAc3YuuFgVEXGhZ7zw3aM7WQXU1BUwv4qFBI/q','John89@gmail.com','admin','2023-05-12 11:29:08','2023-05-12 11:29:08'),(91,NULL,'$2a$12$Xjx07nlqXyRTTOXkUptAeOm7T7xxTFba0Cnx89DM6qH/kchyqZivS','John90@gmail.com','admin','2023-05-12 11:32:03','2023-05-12 11:32:03'),(94,NULL,'$2a$12$NHEER0i7oaTAocoLPdRxMuNFIhBpr8DCdue3HhdbUtgtoRrKgP3oW','John91@gmail.com','admin','2023-05-12 11:32:49','2023-05-12 11:32:49'),(95,NULL,'$2a$12$vXqLINyNu7Ktc0TVJlUOr.JhpKnxMfqJRuywamRwjOIfxKNlA6mrS','John92@gmail.com','admin','2023-05-12 11:37:06','2023-05-12 11:37:06'),(96,NULL,'$2a$12$NCo06fSoqMAruyDOmCBcQ.Qbk9eQLw9IjzAWNmGER4dr3QrAANa/u','John93@gmail.com','admin','2023-05-12 11:38:14','2023-05-12 11:38:14'),(98,NULL,'$2a$12$K3HVMxh/.VgET74BmMWP.uMWRXQUm1xmGCDy8hNVk/JdknUUFfdRu','John94@gmail.com','admin','2023-05-12 11:39:20','2023-05-12 11:39:20'),(99,NULL,'$2a$12$T47nCtuES.s.eLt0xz5XmeMU075FnGnoVoGW5P6lQcC9aiBlDVbOO','John95@gmail.com','patient','2023-05-12 11:40:56','2023-05-12 11:40:56'),(100,NULL,'$2a$12$u2PNwxgQt3Ll7se/uy0XruHn4MlJvdWzKHDaS1YmJiLFyAEvuWxV6','John96@gmail.com','doctor','2023-05-12 11:43:54','2023-05-12 11:43:54'),(101,NULL,'$2a$12$HKc89suBr4888GY1d3rXJOMpj8.gOSmg206JR2Jy19Z7I0.z8EW0O','John97@gmail.com','admin','2023-05-12 11:44:35','2023-05-12 11:44:35'),(102,NULL,'$2a$12$J8zW1OVQfCNvTQeHkisA3uu48docGSH6Ha0ra2YkESrTeALfnUHXe','John98@gmail.com','patient','2023-05-12 11:44:43','2023-05-12 11:44:43'),(103,NULL,'$2a$12$fQWwiXK5YWXR7tuBOz1myONoG5W53qH3Yimt0MXiTCkbdDSmVgqAG','John99@gmail.com','patient','2023-05-13 20:51:01','2023-05-13 20:51:01'),(105,NULL,'$2a$12$dTSdkqnoCtb/PnDXrsASJeO6O2qeRAvdCb5Y.ZHRLTJ6Ff7YU1v6m','John100@gmail.com','patient','2023-05-14 13:27:04','2023-05-14 13:27:04'),(107,NULL,'$2a$12$.HSUwfAJZn4/FFx4UM7.c..KB70XdkJ3sNXHtllbrr/kIzr7qOmV2','badieh22@gmail.com','patient','2023-05-14 13:36:27','2023-05-14 13:36:27'),(108,NULL,'$2a$12$8NnIRh01t5sHTkgXawVm5OfbdMh9zkgPQTWkboeE9Wc/EBKKvA5Wq','badieh33@gmail.com','patient','2023-05-14 13:36:57','2023-05-14 13:36:57'),(110,NULL,'$2a$12$tUSmzZ80VA1nty6/ysWcf.TshQQcssTGc.ksoPdRbC4d5mULjbX2K','badieh34@gmail.com','patient','2023-05-14 13:37:24','2023-05-14 13:37:24'),(111,NULL,'$2a$12$M7Uw.TAwtzM1Fwopp3VRw.SJH45TNNuS3X2yHGEIhxdNqP.NTB/xS','yarab@gmail.com','patient','2023-05-14 13:57:54','2023-05-14 13:57:54'),(120,NULL,'$2a$12$btgEfaittSv7DJC2oOlgMepLbg.x0.qZrdzyRMWZWTQszA4hpSEAG','yarab11@gmail.com','patient','2023-05-14 15:10:16','2023-05-14 15:10:16'),(121,NULL,'$2a$12$NSJy5dfryQgIQLUJgUdhZe/gTSNBADxckfx1yI/01h9xMJsYGhCqC','yarab111@gmail.com','patient','2023-05-14 15:27:01','2023-05-14 15:27:01'),(122,NULL,'$2a$12$rnEYEyeRo0RByDXuGw39WumoxLMrbANHR0QjTM9x2Bz9oizqd4Wy.','111@outlook.com','patient','2023-05-15 04:32:56','2023-05-15 04:32:56'),(123,NULL,'$2a$12$ne61QzoGHJjRP4eg3UNHte9Id2lA5PVC.ee1yzKzta3hPakv1ogoy','1111@outlook.com','patient','2023-05-15 04:39:29','2023-05-15 04:39:29'),(124,NULL,'$2a$12$oK1Uw4gRqI.07XaVso7h6e7z3.VXLiu9qD.aPYEjGKv9K6zOANNTK','11111@outlook.com','patient','2023-05-15 04:42:27','2023-05-15 04:42:27'),(125,NULL,'$2a$12$N.fplY2PwEwwKj3jphdn1O0M9ZlQExHk.t/.weNZpZpKtM8aNMnV6','doc2@outlook.com','doctor','2023-05-15 05:25:47','2023-05-15 05:25:47'),(126,NULL,'$2a$12$0SCepDxhGo40CEjcVprutunm9E.bb0gHLHCkBGQ3PQ0pzxPCSFjl.','doc3@outlook.com','doctor','2023-05-15 05:26:10','2023-05-15 05:26:10'),(127,NULL,'$2a$12$3GBfRGeCba97WuTbgZsRDeF56MdGpDo2XKvmlkdFg.T7w3ovlSVvu','doc4@outlook.com','doctor','2023-05-15 05:26:19','2023-05-15 05:26:19'),(128,NULL,'$2a$12$e5Bj1ZBpI69vGgPcko6Bw.IRc3wen54ZXp8QQRWfFs8SbzBkm44Sa','doc6@outlook.com','doctor','2023-05-15 05:26:27','2023-05-15 05:26:27'),(129,NULL,'$2a$12$LhQMbKjSseR/oZqyTYf4qO/fCpoU2Zb7BFRF7wBLxBdFOSAG0ivq6','doc7@outlook.com','doctor','2023-05-15 05:26:34','2023-05-15 05:26:34'),(130,NULL,'$2a$12$LdfnWdMrXdMmpVYuAVYXjebJh7nq1orHG1gMU1PE1J9E4fl4wAGWC','doc8@outlook.com','doctor','2023-05-15 05:26:41','2023-05-15 05:26:41'),(131,NULL,'$2a$12$I7vcI4HqLUulh5AZUi8x2.dWUTFxDcesmJ.Xh2GRDAZMg/wzyRlnu','doc9@outlook.com','doctor','2023-05-15 05:26:49','2023-05-15 05:26:49');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-15  8:26:54
