const httpStatus = require("http-status");
const pick = require("../utils/pick");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const patientService = require("../services");

const createPatient = catchAsync(async (req, res) => {
    const patient = await patientService.createPatient(req.body);
    res.status(httpStatus.CREATED).send(patient);
}
);

const getPatient = catchAsync(async (req, res) => {
    const patient = await patientService.getPatientById(req.params.userId);
    if (!patient) {
        throw new ApiError(httpStatus.NOT_FOUND, "Patient not found");
    }
    res.send(patient);
}
);

const updatePatient = catchAsync(async (req, res) => {
    const patient = await patientService.updatePatientById(req.params.userId, req.body);
    res.send(patient);
}
);
module.exports = {
    createPatient,
    getPatient,
    updatePatient,
};