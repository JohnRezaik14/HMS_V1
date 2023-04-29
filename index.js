const express = require("express");

const app = express();

const path = require("path");

const User = require("./models/User.model");
const patient = require("./models/patient.model");

const seq1 = require("./utils/DB");


const port = process.env.PORT || 3000;

// const user=require("/models/index.User")

patient.getUser({ where: { User_Id: Patient_Id } })
  .then((result) => {
    console.log(result);
    app.listen(port, () => {
      console.log(`listening on port ${port}`);
    });
  })
  .catch((err) => {
    console.log(err);
  });
