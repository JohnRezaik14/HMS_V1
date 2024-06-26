const sequelize = require("../utils/DB");
const validator = require("validator");
const Sequelize = require("sequelize");
const doctor = sequelize.define(
  "doctor",
  {
    doctorId: {
      type: Sequelize.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    userId: {
      // `userId` int NOT NULL,
      type: Sequelize.INTEGER,
      allowNull: false,
      references: {
        model: "user",
        key: "userId",
      },
      foreignKey: "userId",
    },
    nationalId: {
      type: Sequelize.CHAR(14),
      allowNull: false,
      trim: true,
      minlength: 14,
      maxlength: 14,
    },
    fullName: {
      type: Sequelize.STRING,
      allowNull: true,
      trim: true,
    },
    firstName: {
      type: Sequelize.STRING,
      allowNull: false,
      trim: true,
    },
    secondName: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    thirdName: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    lastName: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    degree: {
      type: Sequelize.INTEGER,
      validate(value) {
        if (value < 0 && value > 6) {
          throw new Error("Degree must be between 0 and 6");
        }
      },
      allowNull: false,
    },
    position: {
      type: Sequelize.INTEGER,
      allowNull: false,
      validate(value) {
        if (value < 0 && value > 8) {
          throw new Error("Position must be between 0 and 8");
        }
      },
    },
    departmentId: {
      type: Sequelize.INTEGER,
      allowNull: false,
      validate(value) {
        if (value < 0 && value > 8) {
          throw new Error("Position must be between 0 and 8");
        }
      },
    },
    hospitalName: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    imageUrl: {
      type: Sequelize.STRING(3000),
      allowNull: false,
    },
    imageHash: {
      type: Sequelize.STRING(500),
      allowNull: true,
    },
    noOfPatients: {
      type: Sequelize.INTEGER,
      allowNull: false,
    },
    gradDate: {
      type: Sequelize.DATE,
      allowNull: false,
    },

    yearsOfExperience: {
      type: Sequelize.INTEGER,
      allowNull: true,
    },
    aboutMe: {
      type: Sequelize.STRING,
      allowNull: true,
    },
    note: {
      type: Sequelize.STRING,
      allowNull: true,
    },
    departmentImageUrl: {
      type: Sequelize.STRING(3000),
    },
    departmentImageHash: {
      type: Sequelize.STRING(500),
    },
  },

  {
    tableName: "doctor",
  },
  {
    freezeTableName: true, // Set this to true to use a singular table name
  },
  {
    timestamps: true,
  }
  //   console.log("doctor table  success")
);
module.exports = doctor;
