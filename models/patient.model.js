const Sequelize = require("sequelize");

const sequelize = require("../utils/DB");

const Patient = sequelize.define(
  "patient",
  {
    Patient_Id: {
      type: Sequelize.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    First_Name: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    Second_Name: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    Third_Name: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    Last_Name: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    National_Id: {
      type: Sequelize.BIGINT,
        allowNull: false,
      minLength:14,
    },
    Birth_Date: {
      type: Sequelize.DATE,
      allowNull: false,
    },
    Gender: {
      type: Sequelize.INTEGER,
      allowNull: false,
    },
    Nationality: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    Phone_Number: {
      type: Sequelize.BIGINT,
      allowNull: false,
    },
  },
  {
    tableName: "patient",
  }, {
    timestamps: false
  }
);

module.exports = Patient;
// `patientId` int NOT NULL AUTO_INCREMENT,
// `userId` int NOT NULL,
// `nationalId` char(14) NOT NULL,
// `fullName` varchar(600) DEFAULT NULL COMMENT 'Composite attribute',
// `firstName` varchar(150) NOT NULL,
// `secondName` varchar(150) NOT NULL,
// `thirdName` varchar(150) NOT NULL,
// `lastName` varchar(150) NOT NULL,
// `birthDate` date NOT NULL,
// `age` int DEFAULT NULL,
// `religion` int DEFAULT NULL COMMENT 'o for Muslem ,\\\\\\\\\\\\\\\\n1 for Christian\\\\\\\\\\\\\\\\n2 for Jewish',
// `gender` int NOT NULL COMMENT '0 represent Males ,\\\\\\\\n1 represent Females',
// `maritalStatus` int DEFAULT NULL COMMENT '0 for  Single ,\\\\\\\\\\\\\\\\n1 for Married \\\\\\\\\\\\\\\\n2 for Divorced \\\\\\\\\\\\\\\\n3 for WIdower',
// `nationality` int NOT NULL COMMENT 'Reference from a List of all Nationalities',
// `bloodType` int DEFAULT NULL COMMENT '0 for  A+ ,\\\\\\\\n1 for A- ,\\\\\\\\n2 for B+ ,\\\\\\\\n3 for B- ,\\\\\\\\n4 for O+ ,\\\\\\\\n5 for O- ,\\\\\\\\n6 for AB+ ,\\\\\\\\n7 for AB- ,',
// `address` varchar(255) DEFAULT ' ',
// `country` varchar(50) DEFAULT NULL,
// `state` varchar(50) DEFAULT NULL,
// `city` varchar(50) DEFAULT NULL,
// `street` varchar(50) DEFAULT NULL,
// `buildingNumber` varchar(3) DEFAULT NULL,
// `appartment` int DEFAULT NULL,
// `birthPlace` varchar(150) DEFAULT NULL COMMENT 'Composite attribute',
// `birthCountry` varchar(50) DEFAULT NULL COMMENT 'Governate',
// `birthState` varchar(50) DEFAULT NULL,
// `birthCity` varchar(50) DEFAULT NULL,
// `Phone_Number` varchar(50) NOT NULL,
// `Height` decimal(5,2) DEFAULT NULL COMMENT 'Height in cm',
// `Weight` decimal(5,2) DEFAULT NULL COMMENT 'Weight in Kg',
// `Job` varchar(50) DEFAULT NULL,
// `Job_Address` varchar(150) DEFAULT NULL COMMENT 'Composite attribute',
// `Job_Address_Governorate` varchar(50) DEFAULT NULL,
// `Job_Address_District` varchar(50) DEFAULT NULL,
// `Job_Address_Building_Number` varchar(50) DEFAULT NULL,
// `Note` text,
// `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
// `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,