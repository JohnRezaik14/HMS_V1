const statusCode = require("http-status");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const doctorService = require("../services/doctor.service");
const getDoctors = catchAsync(async (req, res) => {
  const result = await doctorService.queryDoctors();
  res.status(statusCode.OK).send(result);
});
const getDoctorparam = catchAsync(async (req, res) => {
  const doctor = await doctorService.queryDoctorsDepartment(req.body.departmentId);
  if (!doctor) {
    throw new ApiError(httpStatus.NOT_FOUND, "doctor not found");
  }
  res.send(doctor);
});
module.exports = {
  getDoctors,
  getDoctorparam,
};
