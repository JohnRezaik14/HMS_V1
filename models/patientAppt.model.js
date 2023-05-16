const Sequelize = require("sequelize");
const validator = require("validator");
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
      allowNull: false,
    },
    apptState: {
      //   `apptState` enum('upcoming','canceled','completed') DEFAULT 'upcoming',
      type: Sequelize.ENUM("upcoming", "canceled", "completed"),
      defaultValue: "upcoming",
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
        model: "clinics_Skd",
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
  },
  {
    timestamps: true,
  }
);

module.exports = patientAppt;
