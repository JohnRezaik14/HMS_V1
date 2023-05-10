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
  `Case_Dia_Id` int NOT NULL,
  `Doctor_Id` int NOT NULL,
  `Dia_Location` int NOT NULL COMMENT '0 for ED ,\\\\n1 for Ops,\\\\n2 for Clinicss ,\\\\n3 for ICU,\\\\n4 for Ward,\\\\n5 for NICU\\\\n',
  `Involved_Department` int NOT NULL,
  `Patient_Complaint` text NOT NULL,
  `Dia` text NOT NULL,
  `Dia_DateTime` timestamp NOT NULL,
  `Clinicsal_examination` text NOT NULL,
  `Doctor_Call_Id` int NOT NULL,
  `Note` text,
  `Patient_Appt_Id` int NOT NULL,
  PRIMARY KEY (`Case_Dia_Id`),
  UNIQUE KEY `Case_Dia_Id_UNIQUE` (`Case_Dia_Id`),
  KEY `Case_Dia_Idx_1` (`Doctor_Call_Id`),
  KEY `fk_Case_Dia_Patient_Appt1_Idx` (`Patient_Appt_Id`),
  CONSTRAINT `Case_Dia_Doctor_Call` FOREIGN KEY (`Doctor_Call_Id`) REFERENCES `doctor_call` (`Call_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Case_Dia_Patient_Appt` FOREIGN KEY (`Patient_Appt_Id`) REFERENCES `patient_appt` (`Appt_Id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `Id` int NOT NULL,
  `Start_Time` time NOT NULL,
  `End_Time` time NOT NULL,
  `Day_of_the_Week` int NOT NULL,
  `Is_AvaiLable` tinyint(1) NOT NULL,
  `Doctor_Id` int NOT NULL,
  `Note` text,
  PRIMARY KEY (`Id`),
  KEY `Clinicss_Skd_Idx_1` (`Doctor_Id`),
  CONSTRAINT `ClinicssSkdDoctor` FOREIGN KEY (`Doctor_Id`) REFERENCES `doctor` (`doctorId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinicss_skd`
--

LOCK TABLES `clinicss_skd` WRITE;
/*!40000 ALTER TABLE `clinicss_skd` DISABLE KEYS */;
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
  `nationalId` char(15) DEFAULT NULL,
  `fullName` varchar(600) DEFAULT NULL,
  `firstName` varchar(150) DEFAULT NULL,
  `secondName` varchar(150) DEFAULT NULL,
  `thirdName` varchar(150) DEFAULT NULL,
  `lastName` varchar(150) DEFAULT NULL,
  `degree` int DEFAULT NULL COMMENT 'Ref for Latest Scientific Degree\\\\\\\\\\\\\\\\n0 Bachelor بكالوريوس\\\\\\\\\\\\\\\\n1 Postgraduate Diploma دبلوم الدراسات العليا\\\\\\\\\\\\\\\\n2 Egyptian Associate degree درجة الزمالة المصرية\\\\\\\\\\\\\\\\n3 Fellowship الزمالة\\\\\\\\\\\\\\\\n4 Royal Membership عضوية الكلية الملكية\\\\\\\\\\\\\\\\n5 Master درجة الماجستير\\\\\\\\\\\\\\\\n6 PhD دكتوراه\\\\\\\\\\\\\\\\n',
  `position` int DEFAULT NULL COMMENT 'Ref for Position Level in the Department',
  `departmentId` int DEFAULT NULL,
  `hospitalName` varchar(150) DEFAULT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `imageHash` varchar(255) DEFAULT NULL,
  `noOfPatients` int DEFAULT NULL,
  `gradDate` date DEFAULT NULL,
  `aboutMe` text,
  `yearsOfExperience` int DEFAULT NULL,
  `note` text,
  `createdAt` timestamp NULL DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`doctorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (1,'26610020604062',NULL,'Ali','Farag',NULL,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_call`
--

DROP TABLE IF EXISTS `doctor_call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_call` (
  `Call_Id` int NOT NULL,
  `Adm_and_DC_Ticket_Id` int NOT NULL,
  `Caller_Doctor_Id` int NOT NULL COMMENT 'The ED Doctor who Call the needed specific Departments Doctor.',
  `Responder_Docotor_Id` int NOT NULL,
  `Reporting_DateTime` timestamp NOT NULL COMMENT 'Now / Current Time',
  `Report_Delivery_DateTime` timestamp NOT NULL,
  `Debate_DateTime` timestamp NOT NULL,
  `Follow_Up_DateTime` timestamp NOT NULL,
  `Note` text,
  PRIMARY KEY (`Call_Id`),
  KEY `Doctor_Call_Idx_1` (`Adm_and_DC_Ticket_Id`),
  CONSTRAINT `Dr_Call_Adm_Disc` FOREIGN KEY (`Adm_and_DC_Ticket_Id`) REFERENCES `er_adm_and_dc` (`Ticket_Id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  CONSTRAINT `Call_JCT_Dr_Call` FOREIGN KEY (`Doctor_Call_Id`) REFERENCES `doctor_call` (`Call_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
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
  CONSTRAINT `Lab_Test_Case_Dia` FOREIGN KEY (`Case_Dia_Id`) REFERENCES `case_dia` (`Case_Dia_Id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  CONSTRAINT `Ope_Case_Dia` FOREIGN KEY (`Case_Dia_Id`) REFERENCES `case_dia` (`Case_Dia_Id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `country` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `buildingNumber` varchar(3) DEFAULT NULL,
  `appartment` int DEFAULT NULL,
  `birthPlace` varchar(150) DEFAULT NULL COMMENT 'Composite attribute',
  `birthCountry` varchar(50) DEFAULT NULL COMMENT 'Governate',
  `birthState` varchar(50) DEFAULT NULL,
  `birthCity` varchar(50) DEFAULT NULL,
  `Phone_Number` varchar(50) NOT NULL,
  `Height` decimal(5,2) DEFAULT NULL COMMENT 'Height in cm',
  `Weight` decimal(5,2) DEFAULT NULL COMMENT 'Weight in Kg',
  `Job` varchar(50) DEFAULT NULL,
  `Job_Address` varchar(150) DEFAULT NULL COMMENT 'Composite attribute',
  `Job_Address_Governorate` varchar(50) DEFAULT NULL,
  `Job_Address_District` varchar(50) DEFAULT NULL,
  `Job_Address_Building_Number` varchar(50) DEFAULT NULL,
  `Note` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`patientId`),
  UNIQUE KEY `Patient_Id_UNIQUE` (`patientId`),
  UNIQUE KEY `National_Id_Card_UNIQUE` (`nationalId`),
  UNIQUE KEY `User_Id_UNIQUE` (`userId`),
  KEY `max_Patient_id_idx` (`patientId` DESC),
  CONSTRAINT `User_Patient` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (21,10,'30012090201054','John Lamei Shahin Rezaik','John','Lamei','Shahin','Rezaik','2000-12-08',0,0,0,0,53,0,'    ','','','','','',NULL,'','',NULL,'','01029182175',0.00,0.00,'','','','','','','2023-04-28 09:06:39','2023-04-29 08:32:17'),(22,11,'30012090661122','Ahmed Fathy Hagag Abdallah','Ahmed','Fathy','Hagag','Abdallah','2000-05-08',0,0,0,0,53,0,'    ','','','','','',NULL,'','',NULL,'','01029182698',0.00,0.00,'','','','','','','2023-04-28 13:02:00','2023-04-29 08:32:17');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_appt`
--

DROP TABLE IF EXISTS `patient_appt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_appt` (
  `Appt_Id` int NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Start_Time` time NOT NULL,
  `End_Time` time NOT NULL,
  `Report` text NOT NULL,
  `Patient_Id` int NOT NULL,
  `Clinicss_Skd_Id` int NOT NULL,
  `Note` text,
  PRIMARY KEY (`Appt_Id`),
  KEY `Patient_Appt_Idx_1` (`Patient_Id`),
  KEY `Patient_Appt_Idx_2` (`Clinicss_Skd_Id`),
  CONSTRAINT `Patient_Appt_Clinicss_Skd` FOREIGN KEY (`Clinicss_Skd_Id`) REFERENCES `clinicss_skd` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Patient_Appt_Patient` FOREIGN KEY (`Patient_Id`) REFERENCES `patient` (`patientId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  CONSTRAINT `Radiolgy_Test_Case_Dia` FOREIGN KEY (`Case_Dia_Id`) REFERENCES `case_dia` (`Case_Dia_Id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `type` enum('refresh','resetPassword','verifyEmail') NOT NULL,
  `expires` datetime NOT NULL,
  `blacklisted` tinyint(1) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `token_user` (`userId`),
  CONSTRAINT `token_user` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (6,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjcyLCJpYXQiOjE2ODM3MTI2NjksImV4cCI6MTY4NjMwNDY2OSwidHlwZSI6InJlZnJlc2gifQ._H7YCNIS8_SwctYYyxG4qsWfJZsraYrqPFRRMPJboFY',72,'refresh','2023-06-09 09:57:49',0,'2023-05-10 09:57:49','2023-05-10 09:57:49'),(7,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjczLCJpYXQiOjE2ODM3MTM0NzUsImV4cCI6MTY4NjMwNTQ3NSwidHlwZSI6InJlZnJlc2gifQ.i_20j9Cjl6TLdnitp7msV-349H1CTEaGIcyHykGBgmw',73,'refresh','2023-06-09 10:11:15',0,'2023-05-10 10:11:15','2023-05-10 10:11:15'),(8,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjc0LCJpYXQiOjE2ODM3MTM4NjQsImV4cCI6MTY4NjMwNTg2NCwidHlwZSI6InJlZnJlc2gifQ.Eu_wnwrX1y2f4I3n05YCL8pVUgTqtCK92VdIA_wGoHo',74,'refresh','2023-06-09 10:17:44',0,'2023-05-10 10:17:44','2023-05-10 10:17:44'),(9,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjc2LCJpYXQiOjE2ODM3MTM5ODcsImV4cCI6MTY4NjMwNTk4NywidHlwZSI6InJlZnJlc2gifQ.kC0uy8NpAYgVdF2JbApo1vnadqkbD8ZPBLCnCSUPVGQ',76,'refresh','2023-06-09 10:19:47',0,'2023-05-10 10:19:47','2023-05-10 10:19:47'),(10,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjc5LCJpYXQiOjE2ODM3MTQwNjUsImV4cCI6MTY4NjMwNjA2NSwidHlwZSI6InJlZnJlc2gifQ.GNgl0zD4ZZkuBv0mHKg7OvIBGIxdMFSfWd_pRNZ7KLo',79,'refresh','2023-06-09 10:21:05',0,'2023-05-10 10:21:05','2023-05-10 10:21:05'),(11,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjgxLCJpYXQiOjE2ODM3MTQxODcsImV4cCI6MTY4NjMwNjE4NywidHlwZSI6InJlZnJlc2gifQ.JahFsFUEoS7EwQ5shdVZ1E0w4bOA6o8raVi1Tew68Nw',81,'refresh','2023-06-09 10:23:07',0,'2023-05-10 10:23:07','2023-05-10 10:23:07'),(12,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjgyLCJpYXQiOjE2ODM3MTQyNzUsImV4cCI6MTY4NjMwNjI3NSwidHlwZSI6InJlZnJlc2gifQ.EOHjQbsf0CkKtun90BwHu2GypPFuomt0_frO8C8mfeM',82,'refresh','2023-06-09 10:24:35',0,'2023-05-10 10:24:35','2023-05-10 10:24:35'),(13,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjgzLCJpYXQiOjE2ODM3MTQ2NTYsImV4cCI6MTY4NjMwNjY1NiwidHlwZSI6InJlZnJlc2gifQ.3TR_JV7fCk47mZC1q2hmZzhQ3MNVMVp4zxhkDVnqlHg',83,'refresh','2023-06-09 10:30:56',0,'2023-05-10 10:30:56','2023-05-10 10:30:56'),(14,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg0LCJpYXQiOjE2ODM3MTUwOTUsImV4cCI6MTY4NjMwNzA5NSwidHlwZSI6InJlZnJlc2gifQ.9K9fZCUPZYFLTPXsg1FkTJpWuUgNZZZw_H8nVqfT2zc',84,'refresh','2023-06-09 10:38:15',0,'2023-05-10 10:38:15','2023-05-10 10:38:15'),(15,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg1LCJpYXQiOjE2ODM3MTUyNjYsImV4cCI6MTY4NjMwNzI2NiwidHlwZSI6InJlZnJlc2gifQ.xOxKRrRZLnQ8kSnEw_EmD_7YVtsNsqCglV5AbVNV-JM',85,'refresh','2023-06-09 10:41:06',0,'2023-05-10 10:41:06','2023-05-10 10:41:06'),(16,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg2LCJpYXQiOjE2ODM3MTU0NTYsImV4cCI6MTY4NjMwNzQ1NiwidHlwZSI6InJlZnJlc2gifQ.jUqkYODx03HwxuufB-GpnxUDYjlEVICDmFhJIIsQ2aw',86,'refresh','2023-06-09 10:44:16',0,'2023-05-10 10:44:16','2023-05-10 10:44:16'),(17,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg2LCJpYXQiOjE2ODM3MTU0ODMsImV4cCI6MTY4NjMwNzQ4MywidHlwZSI6InJlZnJlc2gifQ.nuOwozx__CHxmSU1FI6V1Lv_Vkxz_hwqP25QRhzQevg',86,'refresh','2023-06-09 10:44:43',0,'2023-05-10 10:44:43','2023-05-10 10:44:43'),(18,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg4LCJpYXQiOjE2ODM3NDgwODksImV4cCI6MTY4NjM0MDA4OSwidHlwZSI6InJlZnJlc2gifQ.-VHhrwdxZULyCOazuGnDTakSmvgsdl2xbst9CCF8sl8',88,'refresh','2023-06-09 19:48:09',0,'2023-05-10 19:48:09','2023-05-10 19:48:09'),(19,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg4LCJpYXQiOjE2ODM3NDgxMzUsImV4cCI6MTY4NjM0MDEzNSwidHlwZSI6InJlZnJlc2gifQ.q2dDD7DjAnQAL1muzVVkiL8Qm1HgM-4lT0RBamj1PxQ',88,'refresh','2023-06-09 19:48:55',0,'2023-05-10 19:48:55','2023-05-10 19:48:55'),(20,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg4LCJpYXQiOjE2ODM3NDg5NDMsImV4cCI6MTY4NjM0MDk0MywidHlwZSI6InJlZnJlc2gifQ.MOSj4BhRnPNZhwG5pxn2XnnTPkOTG8wSpfjfQs_jDHo',88,'refresh','2023-06-09 20:02:23',0,'2023-05-10 20:02:23','2023-05-10 20:02:23'),(21,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg4LCJpYXQiOjE2ODM3NTA5NTcsImV4cCI6MTY4NjM0Mjk1NywidHlwZSI6InJlZnJlc2gifQ.M1D2tnX2vTlx1EMSfhSKlWguvAozB0W9DgnYqZ1M7ec',88,'refresh','2023-06-09 20:35:57',0,'2023-05-10 20:35:57','2023-05-10 20:35:57'),(23,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjg4LCJpYXQiOjE2ODM3NTUyOTksImV4cCI6MTY4ODkzOTI5OSwidHlwZSI6InJlZnJlc2gifQ.aqt7DMDkHlyoKc8-L2VfQNmZBHDCgSdb1LoSYojpZF0',88,'refresh','2023-07-09 21:48:19',0,'2023-05-10 21:48:19','2023-05-10 21:48:19'),(24,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjI4LCJpYXQiOjE2ODM3NTU1ODEsImV4cCI6MTY4Mzc1NjE4MSwidHlwZSI6InJlc2V0UGFzc3dvcmQifQ.vqt_yzOC6qGGaa1xxSCPcdrRMSUfRYQEEr-MCfmDPGo',28,'resetPassword','2023-05-10 22:03:01',0,'2023-05-10 21:53:01','2023-05-10 21:53:01');
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trt_medication`
--

DROP TABLE IF EXISTS `trt_medication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trt_medication` (
  `Medication_Id` int NOT NULL,
  `New_Medication` varchar(100) NOT NULL,
  `Medication_Start_Date` date NOT NULL,
  `Medication_end_Date` date NOT NULL,
  `Special_Instructions` varchar(500) NOT NULL,
  `Lab_investigation` varchar(500) NOT NULL,
  `Case_Dia_Id` int NOT NULL,
  `Note` text,
  PRIMARY KEY (`Medication_Id`),
  KEY `Trt_Medication_Idx_1` (`Case_Dia_Id`),
  CONSTRAINT `Trt_Med_Case_Dia` FOREIGN KEY (`Case_Dia_Id`) REFERENCES `case_dia` (`Case_Dia_Id`) ON DELETE CASCADE ON UPDATE CASCADE
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
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Ryan','123456789','ryan123@gmail.com','patient','2023-04-29 08:59:46','2023-04-29 08:59:46'),(2,'Maryrose','123456789','Maryrose@gmail.com','patient','2023-04-29 09:10:30','2023-04-29 09:10:30'),(3,'Danae','123456789','Danae@gmail.com','patient','2023-04-29 09:11:23','2023-04-29 09:11:23'),(4,'Kamel','123456789','Kamel@gmail.com','patient','2023-04-29 09:12:01','2023-04-29 09:12:01'),(5,'ahmed','123456789','ahmed1@gmail.com','patient','2023-04-29 09:12:14','2023-04-29 09:12:14'),(6,'Mohamed','123456789','Mohamed1@gmail.com','patient','2023-04-29 09:12:20','2023-04-29 09:12:20'),(7,'ali','123456789','ali1@gmail.com','patient','2023-04-29 09:12:23','2023-04-29 09:12:23'),(8,'Holton','123456789','Holton@gmail.com','patient','2023-04-29 09:12:25','2023-04-29 09:12:25'),(9,'Badieh','123456789','Badieh@gmail.com','admin','2023-04-29 09:12:27','2023-04-29 09:12:27'),(10,'John','123456789','John.lamei.12@gmail.com','admin','2023-04-29 09:12:29','2023-04-29 09:12:29'),(11,'Fathy','123456789','Fathy@gmail.com','patient','2023-04-29 09:12:32','2023-04-29 09:12:32'),(26,NULL,'123456789','Badieh2@gmail.com',NULL,'2023-05-06 09:58:34','2023-05-06 09:58:34'),(28,NULL,'123456789','Badieh3@gmail.com','admin','2023-05-06 10:06:18','2023-05-06 10:06:18'),(33,NULL,'123456789','Badieh4@gmail.com','admin','2023-05-06 10:12:12','2023-05-06 10:12:12'),(34,NULL,'123456789','Badieh5@gmail.com','admin','2023-05-06 10:23:51','2023-05-06 10:23:51'),(43,NULL,'temp','Badieh6@gmail.com',NULL,'2023-05-06 10:41:00','2023-05-06 10:41:00'),(45,NULL,'$2a$10$cxnU8jaThx1EPDtNX8vNsOgRfFF4QGf/wsdftoBXDLAbtfVaeww96','Badieh7@gmail.com',NULL,'2023-05-06 10:43:06','2023-05-06 10:43:06'),(47,NULL,'$2a$10$TRXFqMP4OuljeOL0l8B.7eRZ7r6l.vn3WyfASETSxtsXdgEDjgHoK','Badieh8@gmail.com',NULL,'2023-05-06 11:14:48','2023-05-06 11:14:48'),(49,NULL,'$2a$10$StdlVAHxSVcUJtGuZbUVZes/FhC9Dw3cb/WJ1wtvv.h.SehZSa1b2','Badieh9@gmail.com',NULL,'2023-05-06 11:19:10','2023-05-06 11:19:10'),(51,NULL,'$2a$10$RfcTdqsDq0PX/j0ahooF9.zO8yBwSwN8EHWDkd48RU9tl4caB0l.m','Badieh01@gmail.com',NULL,'2023-05-06 11:56:03','2023-05-06 11:56:03'),(53,NULL,'$2a$10$GLd5cPtGLMBL1V9m44dIeelb2yWTV9vnwwKXfhVPyW60l.tXDfKtW','Badieh02@gmail.com',NULL,'2023-05-06 12:08:43','2023-05-06 12:08:43'),(54,NULL,'$2a$10$mNbjYnCYqK/8fvc/2WihY.4ubr3k/tjMIwHLPK0JvVSUJBPNnV8NG','Badieh03@gmail.com',NULL,'2023-05-06 12:08:55','2023-05-06 12:08:55'),(56,NULL,'$2a$10$tFm.CDfNLMWVVX8sYItr3OadDLcZIeBhgGC9zaMhX5Wxv0c2SZPXK','Badieh04@gmail.com',NULL,'2023-05-06 12:42:00','2023-05-06 12:42:00'),(58,NULL,'$2a$10$lC/Z2lE.kkNc401GEy6WYesjaIGTzQdozHhfqNy0tRO1KqBDlKBCK','Badieh05@gmail.com',NULL,'2023-05-06 12:45:46','2023-05-06 12:45:46'),(59,NULL,'$2a$08$2eJdBfBmQyZ0oXdguWbJa.R35YOT.SDgwPQWw9mVL37K.dASCoO1C','Badieh80@gmail.com',NULL,'2023-05-09 07:44:29','2023-05-09 07:44:29'),(62,NULL,'$2a$08$xZYb6qEAsSryCJjssujVn.SX0ywC0Z9cDSZITO4xtVLEiz0SWLPBC','Badieh81@gmail.com',NULL,'2023-05-09 08:34:38','2023-05-09 08:34:38'),(64,NULL,'$2a$08$GViBJbFOnrLPjzstnS.Nj.0dgVGyJruNB6fK9JwAdQ65.xgywg4D.','Badieh82@gmail.com',NULL,'2023-05-09 08:35:00','2023-05-09 08:35:00'),(65,NULL,'$2a$08$jxVjVHvN2ZU1waTtzbbnMOmFLhut4wjJQPoxi64/CoE0ALLhDaaRa','Badieh83@gmail.com',NULL,'2023-05-09 08:40:29','2023-05-09 08:40:29'),(67,NULL,'$2a$08$b/pnlQvRngn6uQfyZMGHQOAaZrUZUUlzvaSp5G1tZGjkYZmEHq.3u','Badieh84@gmail.com',NULL,'2023-05-09 08:44:27','2023-05-09 08:44:27'),(68,NULL,'$2a$08$J/LCVcpcpi4RxQU2/WgLheJBFpx8WkjQbydUR8xlys/CV5OJNUFIO','Badieh74@gmail.com',NULL,'2023-05-09 09:01:26','2023-05-09 09:01:26'),(69,NULL,'$2a$08$iNEh3NxRNLlgLiqWmwriKOAUY4qk51ZUmkbsG68lF2HszQHPxq4MW','Badieh75@gmail.com','admin','2023-05-10 09:38:26','2023-05-10 09:38:26'),(71,NULL,'$2a$08$Z.ifIguG6fZBr84WnApJeOhu/bZiO6Fu4aKWrBjCRrxtfxbbNrc7G','Badieh76@gmail.com','admin','2023-05-10 09:41:10','2023-05-10 09:41:10'),(72,NULL,'$2a$08$KP7i3mdLVdu2FfXS8KVqpuz9kOQe8xWlxNu56WsnD26hXOCP1GVuG','John76@gmail.com','admin','2023-05-10 09:57:49','2023-05-10 09:57:49'),(73,NULL,'$2a$08$f5.o3MbJuO6YXLl5LZQYAOmGm4fRxA8gD78tKIjzhXgMEFfRlmAF.','John77@gmail.com','admin','2023-05-10 10:11:15','2023-05-10 10:11:15'),(74,NULL,'$2a$08$wM0NX2gINGDe9ggQxph2mOjCuWGER1O2HgCpgYgjM8uwQD23v3ggy','John78@gmail.com','admin','2023-05-10 10:17:43','2023-05-10 10:17:43'),(76,NULL,'$2a$08$gK2PTCR0w6jOEwS9v.J0kOofqa/RhaO8rQuiLHysykjCgr.w8htYe','John79@gmail.com','admin','2023-05-10 10:19:47','2023-05-10 10:19:47'),(79,NULL,'$2a$08$L57UnBmheZr6A8IelVkw.O3gUD7JgUHJBd1vwj3XQjQYuRn12BTEi','John80@gmail.com','admin','2023-05-10 10:21:05','2023-05-10 10:21:05'),(81,NULL,'$2a$08$jWPDW1ZlSzGIIWDy1Pl.uOs7oBnAIJj2JLukksyXf68g76ygXOXBG','John81@gmail.com','admin','2023-05-10 10:23:07','2023-05-10 10:23:07'),(82,NULL,'$2a$08$1Pg1478.QpDSeJXBI2/9guGv3jrFHpruDwG6GMGY568nzQi1mBSS6','John82@gmail.com','admin','2023-05-10 10:24:34','2023-05-10 10:24:34'),(83,NULL,'$2a$08$.2UMdVLy0gagN1LPfDmLyuc.cIvbiesoJdeRyrYeDr4U7vJQyswW2','John83@gmail.com','admin','2023-05-10 10:30:56','2023-05-10 10:30:56'),(84,NULL,'$2a$08$qRNgMMK7C7wCL/NckJGYl.FxDBbhC.mcH0dw8tKCIn58zRspqd/au','John84@gmail.com','admin','2023-05-10 10:38:15','2023-05-10 10:38:15'),(85,NULL,'$2a$08$T5S5Cq/.S2.kUUIuIp1XN.T4b1VUfK0kAJoRJ8HVTuikifKm4slM2','John85@gmail.com','admin','2023-05-10 10:41:06','2023-05-10 10:41:06'),(86,NULL,'$2a$12$3N0teZxpIhA7fHI3TANj2eBaOcKGH3LAvK4Fu0WKaY75tB37gP4JG','John86@gmail.com','admin','2023-05-10 10:44:16','2023-05-10 10:44:16'),(88,NULL,'$2a$12$/U4F5fZSIKHF9Zi0W5iFa.TzDvX/FOiq8NVZIuLz6hECgwWpXOca.','John87@gmail.com','admin','2023-05-10 19:48:09','2023-05-10 19:48:09');
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

-- Dump completed on 2023-05-11  0:23:13
