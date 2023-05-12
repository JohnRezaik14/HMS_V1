const User = require("./user.model");
const sequelize = require("../utils/DB");
const { Op, Sequelize } = require("sequelize");
const Patient = sequelize.define(
  "patient",

  {
    patientId: {
      type: Sequelize.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
      // `patientId` int NOT NULL AUTO_INCREMENT,
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
    fullName: {
      // `fullName` varchar(600) DEFAULT NULL COMMENT 'Composite attribute',
      type: Sequelize.STRING,
      defaultValue: null,
    },
    firstName: {
      // `firstName` varchar(150) NOT NULL,
      type: Sequelize.STRING,
      allowNull: false,
    },
    secondName: {
      // `secondName` varchar(150) NOT NULL,
      type: Sequelize.STRING,
      allowNull: false,
    },
    thirdName: {
      // `thirdName` varchar(150) NOT NULL,
      type: Sequelize.STRING,
      allowNull: false,
    },
    lastName: {
      // `lastName` varchar(150) NOT NULL,
      type: Sequelize.STRING,
      allowNull: false,
    },
    nationalId: {
      // `nationalId` char(14) NOT NULL,
      type: Sequelize.CHAR(14),
      allowNull: false,
      minLength: 14,
    },
    birthDate: {
      // `birthDate` date NOT NULL,
      type: Sequelize.DATE,
      allowNull: false,
    },
    gender: {
      // `gender` int NOT NULL COMMENT '0 represent Males ,\\\\\\\\n1 represent Females',
      type: Sequelize.INTEGER,
      allowNull: false,
      validate(value) {
        if (value < 0 || value > 2) {
          throw new Error("Gender value must be between 0 and 2");
        }
      },
    },
    nationality: {
      // `nationality` int NOT NULL COMMENT 'Reference from a List of all Nationalities',
      type: Sequelize.STRING,
      allowNull: false,
    },
    phoneNumber: {
      // `phoneNumber` varchar(50) NOT NULL,
      type: Sequelize.BIGINT,
      allowNull: false,
    },
    religion: {
      // `religion` int DEFAULT NULL COMMENT 'o for Muslem ,\\\\\\\\\\\\\\\\n1 for Christian\\\\\\\\\\\\\\\\n2 for Jewish',
      type: Sequelize.INTEGER,
      defaultValue: 0,
    },
    maritalStatus: {
      // `maritalStatus` int DEFAULT NULL COMMENT '0 for  Single ,\\\\\\\\\\\\\\\\n1 for Married \\\\\\\\\\\\\\\\n2 for Divorced \\\\\\\\\\\\\\\\n3 for WIdower',
      type: Sequelize.INTEGER,
      defaultValue: 0,
      validate(value) {
        if (value < 0 || value > 3) {
          throw new Error("maritalStatus value must be between 0 and 3");
        }
      },
    },
    bloodType: {
      // `bloodType` int DEFAULT NULL COMMENT '0 for  A+ ,\\\\\\\\n1 for A- ,\\\\\\\\n2 for B+ ,\\\\\\\\n3 for B- ,\\\\\\\\n4 for O+ ,\\\\\\\\n5 for O- ,\\\\\\\\n6 for AB+ ,\\\\\\\\n7 for AB- ,',
      type: Sequelize.INTEGER,
      defaultValue: 0,
      validate(value) {
        if (value < 0 || value > 7) {
          throw new Error("bloodType value must be between 0 and 7");
        }
      },
    },
    age: {
      // `age` int DEFAULT NULL,
      type: Sequelize.INTEGER,
      defaultValue: null,
    },
    address: {
      // `address` varchar(255) DEFAULT ' ',
      type: Sequelize.STRING,
      defaultValue: "  ",
    },
    country: {
      // `country` varchar(50) NOT NULL,
      type: Sequelize.STRING,
      allowNull: false,
    },
    state: {
      // `state` varchar(50) NOT NULL,
      type: Sequelize.STRING,
      allowNull: false,
    },
    city: {
      // `city` varchar(50) NOT NULL,
      type: Sequelize.STRING,
      allowNull: false,
    },
    street: {
      // `street` varchar(50) NOT NULL,
      type: Sequelize.STRING,
      allowNull: false,
    },
    buildingNumber: {
      // `buildingNumber` varchar(10) NOT NULL,
      type: Sequelize.STRING,
      allowNull: false,
    },
    appartment: {
      // `appartment` int NOT NULL,
      type: Sequelize.INTEGER,
      allowNull: false,
    },
    birthPlace: {
      // `birthPlace` varchar(150) DEFAULT NULL COMMENT 'Composite attribute',
      type: Sequelize.STRING,
      defaultValue: "  ",
    },
    birthCountry: {
      // `birthCountry` varchar(50) DEFAULT NULL COMMENT 'Governate',
      type: Sequelize.STRING,
      defaultValue: "  ",
    },
    birthState: {
      //   `birthState` varchar(50) DEFAULT NULL,
      type: Sequelize.STRING,
      defaultValue: "  ",
    },
    birthCity: {
      //   `birthCity` varchar(50) DEFAULT NULL,
      type: Sequelize.STRING,
      defaultValue: "  ",
    },
    height: {
      //   `height` decimal(5,2) DEFAULT NULL COMMENT 'Height in cm',
      type: Sequelize.DECIMAL(5, 2),
      defaultValue: null,
    },
    weight: {
      //   `weight` decimal(5,2) DEFAULT NULL COMMENT 'Weight in Kg',
      type: Sequelize.DECIMAL(5, 2),
      defaultValue: null,
    },
    job: {
      //   `job` varchar(50) DEFAULT NULL,
      type: Sequelize.STRING,
      defaultValue: null,
    },
    jobAddress: {
      //   `jobAddress` varchar(150) DEFAULT ' ' COMMENT 'Composite attribute',
      type: Sequelize.STRING,
      defaultValue: "  ",
    },
    jobCountry: {
      //   `jobCountry` varchar(50) DEFAULT' ',
      type: Sequelize.STRING,
      defaultValue: "  ",
    },
    jobState: {
      //   `jobState` varchar(50) DEFAULT ' ',
      type: Sequelize.STRING,
      defaultValue: "  ",
    },
    jobCity: {
      //   `jobCity` varchar(50) DEFAULT ' ',
      type: Sequelize.STRING,
      defaultValue: "  ",
    },
    note: {
      //   `note` text,
      type: Sequelize.TEXT,
      defaultValue: null,
    },
    patientPP: {
      //   `patientPP` varchar(255) DEFAULT NULL,
      type: Sequelize.STRING,
      defaultValue: null,
    },
    patientPPHash: {
      //   `patientPPHash` varchar(45) DEFAULT NULL,
      type: Sequelize.STRING,
      defaultValue: null,
    },
  },
  {
    tableName: "patient",
  },
  {
    timestamps: false,
  }
);
Patient.isNationalIdTaken = async (nationalId) => {
  const patient = await Patient.findOne({
    where: { nationalId: nationalId },
  });
  if (patient) {
    return true;
  }
};
// Patient.isUserIdTaken = async (userId) => {
//   const user = await User.findOne({
//     where: { [Op.and]: [{ userId: userId }, { role: "patient" }] },
//   });
//   if (user) {
//     return true;
//   }
// };

// need to blur hash the image

module.exports = Patient;
