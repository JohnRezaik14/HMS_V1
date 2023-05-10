const httpStatus = require("http-status");
const { Doctor } = require("../models");
const ApiError = require("../utils/ApiError");
const express = require("express");

const queryDoctors = async () => {
    return Doctor.findAll();
}
module.exports = {
    queryDoctors,
};