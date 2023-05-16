const statusCode = require("http-status");
const pick = require("../utils/pick");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const patientService = require("../services/patient.service");

const createPatient = catchAsync(async (req, res) => {
  const reqPatient = await patientService.createPatient(req.body);
  const patient = await patientService.getPatientByUserId(reqPatient.userId);
  res
    .status(statusCode.CREATED)
    .send({
      patient,
      statusCode: 201,
      message: "Patient account created successfully",
    });
});

const getPatient = catchAsync(async (req, res) => {
  const patient = await patientService.getPatientByUserId(req.body.userId);
  if (!patient) {
    throw new ApiError(statusCode.NOT_FOUND, "Patient not found");
  }
  res.send({
    patient,
    statusCode: 200,
    message: "Patient data retrieved successfully",
  });
});

const updatePatient = catchAsync(async (req, res) => {
  const reqPatient = await patientService.updatePatientByUserId(
    req.body.userId,
    req.body
  );
  const patient = await patientService.getPatientByUserId(reqPatient.userId);
  res.send({
    patient,
    statusCode: 200,
    message: "Patient updated successfully",
  });
});
module.exports = {
  createPatient,
  getPatient,
  updatePatient,
};
