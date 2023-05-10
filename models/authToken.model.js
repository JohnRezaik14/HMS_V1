const { DataTypes } = require("sequelize");
const sequelize = require("../utils/DB");
const { User } = require("./index");

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
      key: "userId",
    },
    foreignKey: "userId",
  },
  expiresAt: {
    type: DataTypes.DATE,
    allowNull: false,
  },
});
// AuthToken.belongsTo(User, { foreignKey: "userId" });
module.exports = AuthToken;
