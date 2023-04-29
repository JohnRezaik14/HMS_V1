const express = require("express");

const app = express();

const path = require("path");

const User = require("./models/User.model");
const Patient = require("./models/patient.model");


const seq1 = require("./utils/DB");


const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`listening on port ${port}`)
});
// const user=require("/models/index.User")


  // User..then((result) => {
  //   console.log(result);
    
  //   });
  // })
  // .catch((err) => {
  //   console.log(err);
  // })

  Patient.findAll().then((result) => {
    console.log(result);
    
    });