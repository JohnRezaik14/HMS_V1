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
