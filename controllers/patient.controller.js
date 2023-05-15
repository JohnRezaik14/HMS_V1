const httpStatus = require("http-status");
const pick = require("../utils/pick");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const patientService = require("../services/patient.service");

const createPatient = catchAsync(async (req, res) => {
  const patient = await patientService.createPatient(req.body);
  const savedPatient = await patientService.getPatientByUserId(patient.userId);
  res.status(httpStatus.CREATED).send({ savedPatient, httpStatus: 201, message: "Patient account created successfully" });
});

const getPatient = catchAsync(async (req, res) => {
  const patient = await patientService.getPatientByUserId(req.params.userId);
  if (!patient) {
    throw new ApiError(httpStatus.NOT_FOUND, "Patient not found");
  }
  res.send(patient);
});

const updatePatient = catchAsync(async (req, res) => {
  const patient = await patientService.updatePatientByUserId(
    req.params.userId,
    req.body
  );
  res.send({ patient, httpStatus: 200, message: "Patient updated successfully" });
});
module.exports = {
  createPatient,
  getPatient,
  updatePatient,
};
