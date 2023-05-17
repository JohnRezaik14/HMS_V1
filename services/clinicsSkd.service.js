const statusCode = require("http-status");
const { Doctor, ClinicsSkd } = require("../models");
const { Op } = require("sequelize");
const ApiError = require("../utils/ApiError");
const doctorService = require("./doctor.service");

const createClinicsSkd = async (clinicsSkdBody) => {
  const doctorId = await clinicsSkdBody.doctorId;
  const doctor = await doctorService.getDoctorById(doctorId);
  if ((await doctorId) == undefined || null) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor Id not valid");
  }
  if (!(await doctor)) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor not found");
  }
 
  const startTime = clinicsSkdBody.startTime;
  const endTime = clinicsSkdBody.endTime;
  const day = clinicsSkdBody.dayOfWeek;
  const isAvaiLable = clinicsSkdBody.isAvaiLable;
  const note = clinicsSkdBody.note;
  return await ClinicsSkd.create({
    startTime: startTime,
    endTime: endTime,
    doctorId: doctorId,
    dayOfWeek: day,
    isAvaiLable: isAvaiLable,
    note: note,
  });
};

const getClinicsSkdBySkdId = async (clinicsSkdId) => {
  return await ClinicsSkd.findByPk(clinicsSkdId);
};
const getClinicsSkdByDoctorId = async (doctorId) => {
  const DoctorId = doctorId;
  const doctor = await doctorService.getDoctorById(DoctorId);

  if ((await doctorId) == undefined || null) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor Id not valid");
  }
  if (!(await doctor)) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor not found");
  }
  return await ClinicsSkd.findAll({
    where: {
      doctorId: doctorId,
    },
  });
};
const getAvaiLableClinicsSkdsByDoctorId = async (doctorId) => {
  const clinicsSkds = await ClinicsSkd.findAll({
    where: {
      isAvaiLable: 1,
      doctorId: doctorId,
    },
  });
  if (clinicsSkds.length > 0) {
    return clinicsSkds;
  } else {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor is not avaiLable");
  }
};
const getClinicsSkdsByDayAndDoctorId = async (day, doctorId) => {
  const clinicsSkds = await ClinicsSkd.findAll({
    where: {
      dayOfWeek: day,
      doctorId: doctorId,
    },
  });
  return clinicsSkds;
};

const updateClinicsSkdById = async (clinicsSkdId, clinicsSkdBody) => {
  const clinicsSkd = await getClinicsSkdBySkdId(clinicsSkdId);
  if (!clinicsSkd) {
    throw new ApiError(statusCode.NOT_FOUND, "clinics schedule not found");
  }
  Object.assign(clinicsSkd, clinicsSkdBody);
  await clinicsSkd.save();
  return clinicsSkd;
};
const deleteClinicsSkdById = async (clinicsSkdId) => {
  const clinicsSkd = await getClinicsSkdBySkdId(clinicsSkdId);
  if (clinicsSkd ) {
    await clinicsSkd.destroy();
    
  } else {
    throw new ApiError(statusCode.NOT_FOUND, "clinics schedule not found");
  }
};

module.exports = {
  createClinicsSkd,
  // get
  getClinicsSkdByDoctorId,
  getClinicsSkdBySkdId,
  getClinicsSkdsByDayAndDoctorId,
  getAvaiLableClinicsSkdsByDoctorId,
  // update
  updateClinicsSkdById,
  // delete
  deleteClinicsSkdById,
};
