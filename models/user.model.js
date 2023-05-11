const sequelize = require("../utils/DB");
const validator = require("validator");
const Sequelize = require("sequelize");
// const bcrypt = require("bcryptjs");
const { Op, Model } = require("sequelize");
// const { use } = require("passport");

const user = sequelize.define(
  "user",
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
    
  },

  // {
  //  
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

user.isEmailTaken = async function (email, excludeUserId) {
  // isEmailTaken is a static method that can be called directly from the model
  // isEmailTaken is a custom class method added to a Sequelize model.
  const user = await this.findOne({
    where: { email, userId: { [Op.ne]: excludeUserId } },
  });
  return !!user;
};
console.log("passed isEmailTaken in user.model.js");

// user.isPasswordMatch = async (email, password) => {
  
//   const user = this;
//   console.log(user + " " + password + " " + "user.model.js.101");
//   console.log(JSON.stringify(email) + " " + JSON.stringify(password));
//   // console.log("passed isPasswordMatch in user.model.js");
//   return bcrypt.compare(password, user.password);
// };


user.prototype.toJSON = function () {
  const values = Object.assign({}, this.get());
  delete values.password;
  // console.log("passed toJSON in user.model.js");
  return values;
};
module.exports = user;
