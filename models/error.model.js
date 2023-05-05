const { DataTypes } = require('sequelize');
const sequelize = require('../utils/DB');

const Error = sequelize.define('Error', {
  message: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  status: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
});


module.exports = Error;