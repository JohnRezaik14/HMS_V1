const statusCode = require("http-status");
const { Doctor, ClinicsSkd } = require("../models");
const { Op } = require("sequelize");
const ApiError = require("../utils/ApiError");
const userService = require("./user.service");
const doctorService = require("./doctor.service");
const createClinicsSkd = async (clinicsSkdBody) => {
    const doctorId = await clinicsSkdBody.doctorId; // `doctorId` int NOT NULL,
    const doctor = await userService.getDoctorById(doctorId);
    if ((await doctorId) == undefined || null) {
        throw new ApiError(statusCode.NOT_FOUND, "Doctor Id not valid");
    }
    if (!(await doctor)) {
        throw new ApiError(statusCode.NOT_FOUND, "Doctor not found");
    }
    const clinicsSkd = await ClinicsSkd.create(clinicsSkdBody);
    return clinicsSkd;
};
