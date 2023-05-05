const { DataTypes } = require("sequelize");
const sequelize = require("../utils/DB");
const { User } = require("./user.model");

const AuthToken = sequelize.define("AuthToken", {
  token: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
  userId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: "User",
      key: "User_Id",
    },
    foreignKey: "User_Id",
  },
  expiresAt: {
    type: DataTypes.DATE,
    allowNull: false,
  },
});
// AuthToken.belongsTo(User, { foreignKey: "User_Id" });
module.exports = AuthToken;
