const sequelize = require("../utils/DB");
const validator = require("validator");
const Sequelize = require("sequelize");
const bcrypt = require("bcryptjs");
const {Op}  = require("sequelize");
// const { toJSON, paginate } = require("./plugins");
const User = sequelize.define(
  "User",
  {
    userId: {
      type: Sequelize.INTEGER,
      required: true,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
      minvalue: 12,
    },
    username: {
      type: Sequelize.STRING,
      required: false,
      allowNull: true,
      unique: true,
      trim: true,
    },
    password: {
      type: Sequelize.STRING,
      allowNull: false,
      required: true,
      trim: true,
      minlength: 8,
      validate(value) {
        if (!value.match(/\d/) || !value.match(/[a-zA-Z]/)) {
          throw new Error(
            "Password must contain at least one letter and one number"
          );
        }
      },
      private: true, // used by the toJSON plugin
      // the private option can be used to make attribute
      // does not be included in the results returned by queries.
    },

    email: {
      type: Sequelize.STRING,
      allowNull: false,
      unique: true,
      required: true,
      trim: true,
      validate(value) {
        if (!validator.isEmail(value)) {
          throw new Error("Invalid email");
        }
      },
    },
    role: {
      type: Sequelize.STRING,
      enum: ["admin", "doctor", "patient"],
      default: "patient",
    },
    // is_Email_Verified: {
    //   tybe: Sequelize.BOOLEAN,
    //   default: false,
    // },
  },

  // {
  //   hooks: {
  //     beforeCreate: async (user) => {
  //       if (user.password) {
  //         user.password = await bcrypt.hash(user.password, 8);
  //       }
  //     },
  //     beforeUpdate: async (user) => {
  //       if (user.password) {
  //         user.password = await bcrypt.hash(user.password, 8);
  //       }
  //     },
  //   },
  // },
  {
    tableName: "user",
  },
  {
    freezeTableName: true, // Set this to true to use a singular table name
  },
  {
    timestamps: true,
  },
  console.log("User table created successfully")
);

User.isEmailTaken = async function (Email, excludeUserId) {
  // isEmailTaken is a static method that can be called directly from the model
  // isEmailTaken is a custom class method added to a Sequelize model.
  const User = await this.findOne({
    where: { Email, User_Id: { [Op.ne]: excludeUserId } },
    
    
  });
  return !!User;
};
console.log("passed isEmailTaken in user.model.js");
// The [Sequelize.Op.ne] syntax is used to generate a "not equal" query operator for the id field.
// It's an example of using an operator in Sequelize's Object syntax
// , where you can use Sequelize.Op to get the operators.
// This syntax allows for more advanced and flexible querying in Sequelize.

User.isPasswordMatch = async function (password,hashedPassword) {
  // const User = this;
  console.log("passed isPasswordMatch in user.model.js");
  return bcrypt.compare(password, hashedPassword)
};
User.prototype.toJSON = function() {
  const values = Object.assign({}, this.get());
  delete values.Password;
  console.log("passed toJSON in user.model.js");
  return values;
};
module.exports = User;
