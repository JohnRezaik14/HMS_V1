const { DataTypes ,Op} = require("sequelize");
const sequelize = require("../utils/DB");
const { tokenTypes } = require("../config/tokens");
const User = require("./user.model");
const Token = sequelize.define("Token", {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false,
  },
  token: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
    },
    User_Id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: 'user',
            key: 'User_Id',
      },
        foreignKey: 'User_Id',
    },
  type: {
    type: DataTypes.ENUM,
    values: [
      tokenTypes.REFRESH,
      tokenTypes.RESET_PASSWORD,
      tokenTypes.VERIFY_EMAIL,
    ],
    allowNull: false,
  },
  expires: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  blacklisted: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
});

// create association with User model

Token.belongsTo(User);

// Add toJSON method to convert model instance to plain JSON object
Token.prototype.toJSON = function () {
  const values = Object.assign({}, this.get());
  // delete values.createdAt;
  // delete values.updatedAt;
  return values;
};
// Token.sync().then((result) => {
//   console.log(result);
// }).catch((err) => {
//   console.log(err);
// });
module.exports = Token;
