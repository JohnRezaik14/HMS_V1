const httpStatus = require("http-status");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const doctorService = require("../services/doctor.service");
const getDoctors = catchAsync(async (req, res) => {
  const result = await doctorService.queryDoctors();
  res.status(httpStatus.OK).send(result);
});
module.exports = {
  getDoctors,
};
