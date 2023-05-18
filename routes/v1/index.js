const express = require("express");
const authRoute = require("./auth.route");
const userRoute = require("./user.route");
const docsRoute = require("./docs.route");
const config = require("../../config/config");
const doctorRoute = require("./doctor.route");
const patientRoute = require("./patient.route");
const clinicsSkdRoute = require("./clinicsSkd.route");
const patientApptRoute = require("./patientAppt.route");
const router = express.Router();

const defaultRoutes = [
  {
    path: "/auth",
    route: authRoute,
  },
  {
    path: "/users",
    route: userRoute,
  },
  {
    path: "/doctors",
    route: doctorRoute,
  },
  {
    path: "/patients",
    route: patientRoute,
  },
  {
    path: "/clinicsSkds",
    route: clinicsSkdRoute,
  },
  {
    path: "/Appts",
    route: patientApptRoute,
  },
];

const devRoutes = [
  // routes available only in development mode
  {
    path: "/docs",
    route: docsRoute,
  },
];

defaultRoutes.forEach((route) => {
  router.use(route.path, route.route);
});

/* istanbul ignore next */
if (config.env === "development") {
  devRoutes.forEach((route) => {
    router.use(route.path, route.route);
  });
}

module.exports = router;
