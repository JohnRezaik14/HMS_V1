const statusCode = require("http-status");
const {User, Doctor } = require("../models");
const ApiError = require("../utils/ApiError");
const express = require("express");

const queryDoctors = async () => {
    return Doctor.findAll();
}

const getDoctorById = async (doctorId) => {
    return Doctor.findByPk(doctorId);
}
const getDoctorByUserId = async (userId) => {
    return Doctor.findOne({ where: { userId: userId } });
}
const getDoctorByNationalId = async (nationalId) => {
    return Doctor.findOne({ where: { nationalId: nationalId } });
}
// const getDoctorByfisrtName = async (firstName) => {
//     return Doctor.findOne({ where: { firstName: firstName } });
// }
// const getDoctorBysecondName = async (secondName) => {
//     return Doctor.findOne({ where: { secondName: secondName } });
// }
// const getDoctorBythirdName = async (thirdName) => {
//     return Doctor.findOne({ where: { thirdName: thirdName } });
// }
// const getDoctorBylastName = async (lastName) => {
//     return Doctor.findOne({ where: { lastName: lastName } });
// }

module.exports = {
    queryDoctors,
    getDoctorById,
    getDoctorByUserId,
    getDoctorByNationalId,
    // getDoctorByfisrtName,
    // getDoctorBysecondName,
    // getDoctorBythirdName,
    // getDoctorBylastName,
};