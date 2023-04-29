const Sequelize = require("sequelize");

const seq1 = require("../util/DB");

const Patient = seq1.define(
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
