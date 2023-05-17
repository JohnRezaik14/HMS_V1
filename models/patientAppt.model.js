const Sequelize = require("sequelize");
const sequelize = require("../utils/DB");

const patientAppt = sequelize.define(
  "patient_appt",
  {
    apptId: {
      type: Sequelize.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
      // `apptId` int NOT NULL AUTO_INCREMENT,
    },
    date: {
      type: Sequelize.DATE,
      allowNull: false,
      //         `date` date NOT NULL,
    },
    startTime: {
      type: Sequelize.TIME,
      allowNull: false,
      //   `startTime` time NOT NULL,
    },
    endTime: {
      //   `endTime` time NOT NULL,
      type: Sequelize.TIME,
      allowNull: false,
    },
    report: {
      //   `report` text NOT NULL,
      type: Sequelize.TEXT,
      allowNull: true,
    },
    apptState: {
      //   `apptState` enum('upcoming','canceled','completed') DEFAULT 'upcoming',
      type: Sequelize.ENUM("upcoming", "canceled", "completed"),
      defaultValue: "upcoming",
      allowNull: false,
    },
    patientId: {
      //   `patientId` int NOT NULL,
      type: Sequelize.INTEGER,
      allowNull: false,
      references: {
        model: "patient",
        key: "patientId",
      },
      foreignKey: "patientId",
    },
    clinicssSkdId: {
      //   `clinicssSkdId` int NOT NULL,
      type: Sequelize.INTEGER,
      allowNull: false,
      references: {
        model: "clinics_skd",
        key: "clinicssSkdId",
      },
      foreignKey: "clinicssSkdId",
    },
    note: {
      //   `note` text,
      type: Sequelize.TEXT,
      allowNull: true,
      //
    },
    doctorName: {
      //   `doctorName` varchar(500) DEFAULT NULL,
      type: Sequelize.STRING(500),
      allowNull: true,
      defaultValue: null,
    },
    hospitalName: {
      //   `hospitalName` varchar(255) DEFAULT NULL,
      type: Sequelize.STRING(255),
      allowNull: true,
      defaultValue: null,
    },
    department: {
      //   `department` varchar(255) DEFAULT NULL,
      type: Sequelize.STRING(255),
      allowNull: true,
      defaultValue: null,
    },
    doctorImageUrl: {
      //   `doctorImageUrl` varchar(3000) DEFAULT NULL,
      type: Sequelize.STRING(3000),
      allowNull: true,
      defaultValue: null,
    },
    doctorImageHash: {
      //   `doctorImageHash` varchar(500) DEFAULT NULL,
      type: Sequelize.STRING(500),
      allowNull: true,
      defaultValue: null,
    },  
    cancelReason: {
      //   `cancelReason` text,
      type: Sequelize.TEXT,
      allowNull: true,
      defaultValue: null,
    },
    patientComplaint: {
      //   `patientComplaint` text,
      type: Sequelize.TEXT,
      allowNull: true,
      defaultValue: null,
    },



  },
  {
    timestamps: true,
  }
);

module.exports = patientAppt;

// `apptId` int NOT NULL AUTO_INCREMENT,
//   `patientId` int NOT NULL,
//   `clinicssSkdId` int NOT NULL,
//   `date` date NOT NULL,
//   `startTime` time NOT NULL,
//   `endTime` time NOT NULL,
//   `apptState` enum('upcoming','canceled','completed') NOT NULL DEFAULT 'upcoming',
//   `report` text,
//   `doctorName` varchar(500) DEFAULT NULL,
//   `hospitalName` varchar(255) DEFAULT NULL,
//   `department` varchar(255) DEFAULT NULL,
//   `doctorImageUrl` varchar(3000) DEFAULT NULL,
//   `doctorImageHash` varchar(500) DEFAULT NULL,
//   `cancelReason` text,
//   `patientComplaint` text,
//   `note` text,
//   `createdAt` timestamp NULL DEFAULT NULL,
//   `updatedAt` timestamp NULL DEFAULT NULL,
//   PRIMARY KEY (`apptId`),
//   KEY `Patient_Appt_Idx_1` (`patientId`),
//   KEY `Patient_Appt_Idx_2` (`clinicssSkdId`),
//   CONSTRAINT `Patient_Appt_Clinicss_Skd` FOREIGN KEY (`clinicssSkdId`) REFERENCES `clinics_skd` (`skdId`) ON DELETE CASCADE ON UPDATE CASCADE,
//   CONSTRAINT `Patient_Appt_Patient` FOREIGN KEY (`patientId`) REFERENCES `patient` (`patientId`) ON DELETE CASCADE ON UPDATE CASCADE