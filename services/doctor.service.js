const statusCode = require("http-status");
const { Doctor } = require("../models");
const ApiError = require("../utils/ApiError");
const express = require("express");

const queryDoctors = async () => {
    return Doctor.findAll();
}
const queryDoctorsDepartment = async (departmentId) => {
    return Doctor.findAll({ where: { departmentId: departmentId } });
}
module.exports = {
    queryDoctors,
};