const statusCode = require("http-status");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const clinicsSkdService = require("../services/index").clinicsSkdService;
const doctorService = require("../services/index").doctorService;
const createClinicsSkd = catchAsync(async (req, res) => {
  const clinicsSkd = await clinicsSkdService.createClinicsSkd(req.body);
  res.status(statusCode.CREATED).send({
    clinicsSkd,
    statusCode: 201,
    message: "Clinics schedule created successfully",
  });
});

const queryClinicsSkdById = catchAsync(async (req, res) => {
//   qurey clincs schedule by  schedule id
    const clinicsSkd = await clinicsSkdService.getClinicsSkdBySkdId(req.body.skdId);
  if (!clinicsSkd) {
    throw new ApiError(statusCode.NOT_FOUND, "Clinics schedule not found");
  }
  res.send({
    clinicsSkd,
    statusCode: 200,
    message: "Clinics schedule data retrieved successfully",
  });
});

const queryClinicsSkdsByDoctorId = catchAsync(async (req, res) => {
//  group clincs schedules by doctor id
    const clinicsSkds = await clinicsSkdService.getClinicsSkdByDoctorId(
    req.body.doctorId
  );
  res.send({
    clinicsSkds,
    statusCode: 200,
    message: "Clinics schedules data retrieved successfully",
  });
});

const queryClinicsSkdsByDayDoctorId = catchAsync(async (req, res) => {
//    qurey clincs schedules by day and doctor id
    const clinicsSkds = await clinicsSkdService.getClinicsSkdsByDayAndDoctorId(
        req.body.dayOfWeek,
        req.body.doctorId
    );
    res.send({
        clinicsSkds,
        statusCode: 200,
        message: "Clinics schedules for this day",
    });
});

const queryAvaiLableClinicsSkdsByDoctorId = catchAsync(async (req, res) => {
//    qurey available clincs schedules by doctor id
    const clinicsSkds = await clinicsSkdService.getAvaiLableClinicsSkdsByDoctorId(
        req.body.doctorId
    );
    
    const doctor = await doctorService.getDoctorById(req.body.doctorId);
    res.send({
        clinicsSkds,
        statusCode: 200,
        message: (`"Here are AvaiLable Clinics schedule for doctor  ${doctor.fullName}"`),
    });
});

const updateClinicsSkd = catchAsync(async (req, res) => {
    const clinicsSkd = await clinicsSkdService.updateClinicsSkdById(
        req.body.skdId,
        req.body
    );
    res.send({
        clinicsSkd,
        statusCode: 200,
        message: "Clinics schedule data updated successfully",
    });
});

const deleteClinicsSkd = catchAsync(async (req, res) => {
    const clinicsSkd = await clinicsSkdService.deleteClinicsSkdById(
        req.body.skdId
    );
    res.send({
        clinicsSkd,
        statusCode: 200,
        message: "Clinics schedule data deleted successfully",
    });
}
);

module.exports = {
    createClinicsSkd,
    queryClinicsSkdById,
    queryClinicsSkdsByDoctorId,
    queryClinicsSkdsByDayDoctorId,
    queryAvaiLableClinicsSkdsByDoctorId,
    updateClinicsSkd,
    deleteClinicsSkd,
};