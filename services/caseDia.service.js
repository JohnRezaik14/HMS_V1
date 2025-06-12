const statusCode = require("http-status");
const { Patient, Doctor, ClinicsSkd, PatientAppt } = require("../models");
const { Op, STRING } = require("sequelize");
const ApiError = require("../utils/ApiError");

