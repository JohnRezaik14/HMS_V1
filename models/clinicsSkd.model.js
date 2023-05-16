const { DataTypes ,Op} = require("sequelize");
const sequelize = require("../utils/DB");
const doctor = require("./doctor.model");
const clinicsSkd = sequelize.define("Token", {
    skdId: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false,
  },
  startTime: {
    type: DataTypes.TIME,
    allowNull: false,
    },
    endTime: {
    type: DataTypes.TIME,
    allowNull: false,
    },
    doctorId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
          model: 'doctor',
          key: 'doctorId',
    },
      foreignKey: 'doctorId',
  },
  dayOfWeek: {
    type: DataTypes.INTEGER,
    validate(value) {
        if (value < 1 && value > 7) {
          throw new Error("dayOfWeek must be between 1 and 7");
        }
      },
    allowNull: false,
  },
  isAvaiLable: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
  },
  note: {
    type: DataTypes.TEXT,
   allowNull: true,
  },
});

module.exports = clinicsSkd;