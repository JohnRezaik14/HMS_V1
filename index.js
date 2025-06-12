const express = require("express");
// const bodyParser = require("body-parser");
const helmet = require("helmet");
const xss = require("xss-clean");
const config = require("./config/config");
const morgan = require("./config/morgan");
const compression = require("compression");
const cors = require("cors");
const passport = require("passport");
const statusCode = require("http-status");
// const path = require("path");
const { jwtStrategy } = require("./config/passport");
const routes = require("./routes/v1");
const { errorConverter, errorHandler } = require("./middlewares/error");
const ApiError = require("./utils/ApiError");
const app = express();

if (config.env !== "test") {
  app.use(morgan.successHandler);
  app.use(morgan.errorHandler);
}

// Security**********************************************************************************************************************
// set security HTTP headers
app.use(helmet());
// xss() is middleware used to prevent cross-site scripting (XSS) attacks in a Node.js/Express application.
app.use(xss());
// *******************************************************************************************************************************
// parse json request body
app.use(express.json());

// gzip compression
app.use(compression());

// enable cors
// cors is  standard for access control for cross-origin resource sharing (CORS)
// on various browsers. It allows a server to indicate any other origins (domain, scheme, or port)
app.use(cors());
app.options("*", cors());

// jwt authentication
app.use(passport.initialize());
passport.use("jwt", jwtStrategy);

// parse urlencoded request body
app.use(express.urlencoded({ extended: true })); //x-www-form-urlencoded <form>
// app.use(bodyParser.json());

// app.use(bodyParser.json());

// v1 api routes
app.use("/v1", routes);
app.use((err, req, res, next) => {
  const error = err;
  const statusCode = error.statusCode || 500;
  const message = error.message || "Internal Server Error";
  const isOperational = error.isOperational || false;
  const stack = error.stack || undefined;
  if (err instanceof ApiError) {
    res.status(err.statusCode).json({
      statusCode, // Change "code" to "statusCode"
      message ,
      isOperational ,
      stack ,
    });
    console.log({ message, statusCode, isOperational, stack });
  } else {
    // Handle other types of errors or fallback to a generic error response
    res.status(500).json({
      statusCode: 500,
      message: "Internal Server Error",
      isOperational: false,
      stack: err.stack,
    });
    console.log({ message, statusCode, isOperational, stack });
  }
});
// send back a 404 error for any unknown api request
app.use((req, res, next) => {
  next(new ApiError(statusCode.NOT_FOUND, "Not found"));
});

// convert error to ApiError, if needed
app.use(errorConverter);
// handle error
app.use(errorHandler);
const port = process.env.PORT || 3000;
const ip = "localhost";
// '10.5.150.83' ||
app.listen(port, ip,() => {
  console.log(`listening on http://${ip}:${port}`);
});

// end of file******************************************************************************************************************

// app.use((req, res, next) => {
//   res.setHeader('Access-Control-Allow-Origin', '*');
//   res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
//   res.setHeader('Access-Control-Expose-Methods', 'OPTIONS, GET, POST, PUT, PATCH, DELETE');
// });

// const Patient = require("./models/patient.model");
// const User = require("./models/user.model");
// const Doctor = require("./models/doctor.model");
// const patientAppt = require("./models/patientAppt.model");
// const { where } = require("sequelize");
// const clinicsSkd = require("./models/clinicsSkd.model");
// clinicsSkd.findAll().then((result) => {
//   console.log(result);
// });


// patientAppt.update({
//   "startTime": "14:20",
//   "endTime":"14:55",
//   "date":'2023-10-12',
// "report": "report",
//   "apptState": "cancele",
//   "patientId": 21,
//       "clinicssSkdId": 1,
// },
//   { where: { ApptId: 6 } }).then((result) => {
//   console.log(result);
// }).catch((err) => {
//   console.log(err);
// });

// const getuser = async (userId) => {
//   const user = await Doctor.findAll({ where: { departmentId: userId } });
//   return user;

// };
// getuser(3).then((result) => {
//   console.log(result);
// }).catch((err) => {
//   console.log(err);
// });

// const seq1 = require("./utils/DB");
// Doctor.create().then((result) => {
//   console.log(result);
// }).catch((err) => {
//   console.log(err);
// });
// const getUserByEmail = async (email) => {

//   return User.findOne({
//     where: {
//       email: email,
//     }
//   });
// };
// getUserByEmail("John.lamei.12@gmail.com").then((result) => {
//   console.log(result);
// }).catch((err) => {
//   console.log(err);
// });

// // const user=require("/models/index.User")

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
// Patient.findByPk(8).then((result) => {
//   console.log(result);
// });

// Patient.belongsTo(User, {
//   foreignKey: "userId",
//   targetKey: "userId",
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
