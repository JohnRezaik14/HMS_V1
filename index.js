const express = require("express");
const bodyParser = require("body-parser");
const helmet = require('helmet');
const xss = require('xss-clean');
const config = require('./config/config');
const morgan = require('./config/morgan');
const compression = require('compression');
const cors = require('cors');
const passport = require('passport');
const httpStatus = require('http-status');
const path = require("path");
const { jwtStrategy } = require('./config/passport');
const { authLimiter } = require('./middlewares/rateLimiter');
const routes = require('./routes/v1');
const { errorConverter, errorHandler } = require('./middlewares/error');
const ApiError = require('./utils/ApiError');

const app = express();

// console.log(config.jwt)

if (config.env !== 'test') {
  app.use(morgan.successHandler);
  app.use(morgan.errorHandler);
}


// Security**********************************************************************************************************************
// set security HTTP headers
app.use(helmet());
// xss() is middleware used to prevent cross-site scripting (XSS) attacks in a Node.js/Express application.
app.use(xss());
// *******************************************************************************************************************************


// gzip compression
app.use(compression());


// enable cors
// cors is  standard for access control for cross-origin resource sharing (CORS) 
// on various browsers. It allows a server to indicate any other origins (domain, scheme, or port)
app.use(cors());
app.options('*', cors());

// app.use((req, res, next) => {
//   res.setHeader('Access-Control-Allow-Origin', '*');
//   res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
//   res.setHeader('Access-Control-Expose-Methods', 'OPTIONS, GET, POST, PUT, PATCH, DELETE');
// });
  

// jwt authentication
app.use(passport.initialize());
passport.use('jwt', jwtStrategy);


// parse json request body
app.use(express.json());

// parse urlencoded request body
app.use(express.urlencoded({ extended: true })); //x-www-form-urlencoded <form>

app.use(bodyParser.json());

// v1 api routes
app.use('/v1', routes);

// send back a 404 error for any unknown api request
app.use((req, res, next) => {
  next(new ApiError(httpStatus.NOT_FOUND, 'Not found'));
});

// convert error to ApiError, if needed
app.use(errorConverter);

// handle error
app.use(errorHandler);

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`listening on port ${port}`);
});




// end of file******************************************************************************************************************






const User = require("./models/user.model");
// const Patient = require("./models/patient.model");
// const seq1 = require("./utils/DB");

// const getUserByEmail = async (email) => {

//   return User.findOne({
//     where: {
//       Email: email,
//     }
//   });
// };
// getUserByEmail("John.lamei.12@gmail.com").then((result) => {
//   console.log(result);
// }).catch((err) => {
//   console.log(err);
// });

// AuthToken.sync().then((result) => {
//   console.log(result);
// }).catch((err) => {
//   console.log(err);
// });

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
// Patient.findByPk(8).then((result) => {
//   console.log(result);
// });

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
// User.create({  "Username":"Badieh",
//     "Email": "Badieh@gmail.com",
//     "Password":"123456789"}).then((result) => {
//   console.log(result);
// }).catch((err) => {
//   console.log(err);
// });
