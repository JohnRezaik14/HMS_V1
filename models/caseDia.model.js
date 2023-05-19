const { DataTypes, Op, Sequelize } = require("sequelize");
const sequelize = require("../utils/DB");

// `caseDiaId` int NOT NULL AUTO_INCREMENT,
//   `doctorId` int NOT NULL,
//   `patientApptId` int NOT NULL,
//   `doctorCallId` int DEFAULT NULL,
//   `involvedDepartment` int NOT NULL,
//   `diaLocation` int DEFAULT '2' COMMENT '0 for ED ,\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n1 for Ops,\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n2 for Clinicss ,\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n3 for ICU,\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n4 for Ward,\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n5 for NICU\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n',
//   `patientComplaint` text,
//   `dia` text NOT NULL,
//   `diaImage` varchar(3000) DEFAULT NULL,
//   `diaImageHash` varchar(500) DEFAULT NULL,
//   `clinicalExamination` text,
//   `clinicalExaminationImage` varchar(3000) DEFAULT NULL,
//   `clinicalExaminationImageHash` varchar(500) DEFAULT NULL,
//   `hospitalName` varchar(255) DEFAULT NULL,
//   `note` text,

const caseDia = sequelize.define(
  "case_dia",
  {
    caseDiaId: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    doctorId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "doctor",
        key: "doctorId",
      },
      foreignKey: "doctorId",
    },
    patientApptId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "patient_appt",
        key: "apptId",
      },
      foreignKey: "patientApptId",
    },
    doctorCallId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: "doctor_call",
        key: "callId",
      },
      foreignKey: "doctorCallId",
    },
    involvedDepartment: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    diaLocation: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 2,
    },
    patientComplaint: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    dia: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    diaImage: {
      type: DataTypes.STRING(3000),
      allowNull: true,
    },
    diaImageHash: {
      type: DataTypes.STRING(500),
      allowNull: true,
    },
    clinicalExamination: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    clinicalExaminationImage: {
      type: DataTypes.STRING(3000),
      allowNull: true,
    },
    clinicalExaminationImageHash: {
      type: DataTypes.STRING(500),
      allowNull: true,
    },
    hospitalName: {
      type: DataTypes.STRING(255),
      allowNull: true,
    },
    note: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
  },
  {
    tableName: "case_dia",
    timestamps: true,
  }
);

module.exports = caseDia;
