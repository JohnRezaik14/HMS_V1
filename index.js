const express = require("express");

const app = express();

const path = require("path");

const User = require("./models/user.model");
const Patient = require("./models/patient.model");

const seq1 = require("./utils/DB");

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`listening on port ${port}`);
});
// const user=require("/models/index.User")

// User..then((result) => {
//   console.log(result);

//   });
// })
// .catch((err) => {
//   console.log(err);
// })

//   Patient.findAll().then((result) => {
//     console.log(result);

// });
Patient.findByPk(8).then((result) => {
  console.log(result);
});

// Patient.belongsTo(User, {
//   foreignKey: "User_Id",
//   targetKey: "User_Id",
//   constraints: true,
//   onDelete: "cascade",
//   onUpdate: "cascade",
// });
// User.hasOne(Patient);
// seq1.sync().then((result) => {
//   console.log(result);
// }).catch((err) => {
//   console.log(err);
// });
// Patient.create({ }).then((result) => {
//   console.log(result);
// }).catch((err) => {
//   console.log(err);
// });
