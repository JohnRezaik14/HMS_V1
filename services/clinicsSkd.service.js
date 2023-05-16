const statusCode = require("http-status");
const { Doctor, ClinicsSkd } = require("../models");
const { Op } = require("sequelize");
const ApiError = require("../utils/ApiError");
const userService = require("./user.service");
const doctorService = require("./doctor.service");

const createClinicsSkd = async (clinicsSkdBody) => {
  const doctorId = await clinicsSkdBody.doctorId; 
  const doctor = await userService.getDoctorById(doctorId);
  if ((await doctorId) == undefined || null) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor Id not valid");
  }
  if (!(await doctor)) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor not found");
  }
  const skdId = clinicsSkdBody.skdId;
  const startTime = clinicsSkdBody.startTime;
  const endTime = clinicsSkdBody.endTime;
  const day = clinicsSkdBody.dayOfWeek;
  const isAvaiLable = clinicsSkdBody.isAvaiLable;
  const note = clinicsSkdBody.note;
  return await ClinicsSkd.create({
    skdId: skdId,
    startTime: startTime,
      endTime: endTime,
    doctorId: doctorId,
    dayOfWeek: day,
    isAvaiLable: isAvaiLable,
    note: note,
  });
};

const queryClinicsSkdByDoctorId = async (doctorId) => {
    const DoctorId = doctorId; 
    const doctor = await userService.getDoctorById(DoctorId);
    
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
const getClinicsSkdById = async (clinicsSkdId) => {
    return await ClinicsSkd.findByPk(clinicsSkdId);
};
const updateClinicsSkd = async (clinicsSkdId, clinicsSkdBody) => {
    const clinicsSkd = await getClinicsSkdById(clinicsSkdId);
  if (!clinicsSkd) {
    throw new ApiError(statusCode.NOT_FOUND, "clinics schedule not found");
  }
  Object.assign(clinicsSkd, clinicsSkdBody);
  await ClinicsSkd.save();
  return ClinicsSkd;
};
const getClinicsSkdByDayAndDoctorId = async (day,doctorId) => {
  
   const clinicsSkds =await ClinicsSkd.findAll({
        where: {
            dayOfWeek: dayOfWeek,
            doctorId: DoctorId,
        },
   });
    return clinicsSkds;
};
const getAvaiLableClinicsSkdByDoctorId = async ( doctorId) => {
    const isAvaiLable = 1;
    return await ClinicsSkd.findAll({
        where: {
            isAvaiLable: isAvaiLable,
            doctorId: doctorId,
        },
    });
};

const deleteClinicsSkdById = async (clinicsSkdId) => {
    const clinicsSkd = await getClinicsSkdById(clinicsSkdId);
    if (!clinicsSkd) {
        throw new ApiError(statusCode.NOT_FOUND, "clinics schedule not found");
    }
    await ClinicsSkd.destroy();
    return clinicsSkd;
};

module.exports = {  
    createClinicsSkd,
    // get
    queryClinicsSkdByDoctorId,
    getClinicsSkdById,
    getClinicsSkdByDayAndDoctorId,
    getAvaiLableClinicsSkdByDoctorId,
    // update
    updateClinicsSkd,
    // delete
    deleteClinicsSkdById,
};