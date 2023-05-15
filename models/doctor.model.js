const sequelize = require("../utils/DB");
const validator = require("validator");
const Sequelize = require("sequelize");
const doctor = sequelize.define(
    "doctor", {
    doctorId: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            allowNull: false,
    },
    
    nationalId: {
        type: Sequelize.CHAR(14),
        allowNull: true,
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
        allowNull: true,
        trim: true,
      
    },
    secondName: {
        type: Sequelize.STRING,
        allowNull: true,
    },
    thirdName: {
    
        type: Sequelize.STRING,
        allowNull: true,
    },
    lastName: {
        type: Sequelize.STRING,
        allowNull: true,
    },
    degree: {
        type: Sequelize.INTEGER,
        validate(value) {
            if (value < 0 && value > 6) {
                throw new Error("Degree must be between 0 and 6");
            }
        },
        allowNull: true,
    },
    position: {
        type: Sequelize.INTEGER,
        allowNull: true,
        validate(value) {
            if (value < 0 && value > 8) {
                throw new Error("Position must be between 0 and 8");
            }
        }
    },
    departmentId: {
        type: Sequelize.INTEGER,
        allowNull: true,
        validate(value) {
            if (value < 0 && value > 8) {
                throw new Error("Position must be between 0 and 8");
            }
        }
        },
        hospitalName: {
            type: Sequelize.STRING,
            allowNull: true,
        },
        imageUrl: {
            type: Sequelize.STRING,
            allowNull: true,
        },
        imageHash: {
            type: Sequelize.STRING,
            allowNull: true,
        },
        noOfPatients: {
            type: Sequelize.INTEGER,
            allowNull: true,
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
        }
},
  
  {
    tableName: "doctor",
  },
  {
    freezeTableName: true, // Set this to true to use a singular table name
  },
  {
    timestamps: true,
    },
//   console.log("doctor table  success")
);
module.exports = doctor;