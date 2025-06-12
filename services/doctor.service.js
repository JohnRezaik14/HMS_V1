const statusCode = require("http-status");
const { User, Doctor } = require("../models");
const ApiError = require("../utils/ApiError");
const { Op, STRING } = require("sequelize");
const findModel = require("../utils/model.find");
const departmentMapping = {
  Anesthetics: 0,
  Cardiology: 1,
  ENT: 2,
  Gastroenterology: 3,
  "General Surgery": 4,
  Gynecology: 5,
  Hematology: 6,
  "Neonatal Unit": 7,
  Neurology: 8,
  "Nutrition and dietetics": 9,
  "Obstetrics and gynecology units": 10,
  Oncology: 11,
  Ophthalmology: 12,
  Orthopedics: 13,
  Physiotherapy: 14,
  "Renal Unit": 15,
  "Sexual Health": 16,
  Urology: 17,
  Dentistry: 18,
  neorocycatric: 19,
  Cardiothorac: 20,
};
// create doctor
const createDoctor = async (doctorBody) => {
  const nationalId = await doctorBody.nationalId;
  if (await Doctor.findOne({ where: { nationalId: nationalId } })) {
    throw new ApiError(statusCode.BAD_REQUEST, "National Id already exists");
  }
  const userId = await doctorBody.userId;
  if (await Doctor.findOne({ where: { userId: userId } })) {
    throw new ApiError(statusCode.BAD_REQUEST, "User Id already exists");
  }
  const fullName = await doctorBody.fullName;
  if (await Doctor.findOne({ where: { fullName: fullName } })) {
    throw new ApiError(statusCode.BAD_REQUEST, "Full Name already exists");
  }
  const firstName = await doctorBody.firstName;
  const secondName = await doctorBody.secondName;
  const thirdName = await doctorBody.thirdName;
  const lastName = await doctorBody.lastName;
  const degree = await doctorBody.degree;
  const position = await doctorBody.position;
  const departmentId = await departmentMapping[doctorBody.departmentName];
  const hospitalName = await doctorBody.hospitalName;
  const imageUrl = await doctorBody.imageUrl;
  const imageHash = await doctorBody.imageHash;
  const noOfPatients = await doctorBody.noOfPatients;
  const gradDate = await doctorBody.gradDate;
  const aboutMe = await doctorBody.aboutMe;
  const yearsOfExperience = await doctorBody.yearsOfExperience;
  const note = await doctorBody.note;
  const doctor = await Doctor.create({
    nationalId,
    userId,
    fullName,
    firstName,
    secondName,
    thirdName,
    lastName,
    degree,
    position,
    departmentId,
    hospitalName,
    imageUrl,
    imageHash,
    noOfPatients,
    gradDate,
    aboutMe,
    yearsOfExperience,
    note,
  });
  return doctor;
};

// All get methods
// const getDoctors = async () => {
//   const doctors = await Doctor.findAll();
//   return doctors;
// };
const findAllByOne = (model, key, value) => {
  // const { model } = require("../models");
  const { Op, STRING } = require("sequelize");
const doctors =  model.findAll({
      where: {
          [key]: value,
      },
  });
  return doctors;
};
const getDoctors = async () => {
  const doctors = await findModel.findAllByOne(Doctor, "doctorId", 1);
  return doctors;
};
const getDoctorsByDegree = async (degree) => {
  const doctors = await Doctor.findAll({ where: { degree: degree } });
  return doctors;
};
const getDoctorsByPosition = async (position) => {
  const doctors = await Doctor.findAll({ where: { position: position } });
  return doctors;
};
const getDoctorsByDepartmentId = async (departmentId) => {
  const doctors = await Doctor.findAll({
    where: { departmentId: departmentId },
  });
  return doctors;
};
const getDoctorByDoctorId = async (doctorId) => {
  const doctor = await Doctor.findByPk(doctorId);
  if (!doctor) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor Not Found");
  }
  return doctor;
};
const getDoctorByUserId = async (userId) => {
  const doctor = await Doctor.findOne({ where: { userId: userId } });
  if (!doctor) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor Not Found");
  }
  return doctor;
};
const getDoctorByNationalId = async (nationalId) => {
  const doctor = await Doctor.findOne({ where: { nationalId: nationalId } });
  if (!doctor) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor Not Found");
  }
  return doctor;
};
const getDoctorsByFisrtName = async (firstName) => {
  const doctors = await Doctor.findAll({ where: { firstName: firstName } });
  return doctors;
};
const getDoctorsBySecondName = async (secondName) => {
  const doctors = await Doctor.findAll({ where: { secondName: secondName } });
  return doctors;
};
const getDoctorsByThirdName = async (thirdName) => {
  const doctors = Doctor.findAll({ where: { thirdName: thirdName } });
  return doctors;
};
const getDoctorsByLastName = async (lastName) => {
  const doctors = Doctor.findAll({ where: { lastName: lastName } });
  return doctors;
};
const getDoctorsByFisrtNameAndSecondName = async (firstName, secondName) => {
  const doctors = Doctor.findAll({
    where: { firstName: firstName, secondName: secondName },
  });
  return doctors;
};
const getDoctorsByFisrtNameAndSecondNameAndThirdName = async (
  firstName,
  secondName,
  thirdName
) => {
  const doctors = Doctor.findAll({
    where: {
      firstName: firstName,
      secondName: secondName,
      thirdName: thirdName,
    },
  });
  return doctors;
};

const getDoctorByFullName = async (
  firstName,
  secondName,
  thirdName,
  lastName
) => {
  const doctor = Doctor.findOne({
    where: {
      firstName: firstName,
      secondName: secondName,
      thirdName: thirdName,
      lastName: lastName,
    },
  });
  if (!doctor) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor Not Found");
  }
  return doctor;
};

const getDoctorsByHospitalName = async (hospitalName) => {
  const doctors = Doctor.findAll({
    where: { hospitalName: hospitalName },
  });
  return doctors;
};
const getDoctorsByHospitalNameAndDepartmentName = async (
  hospitalName,
  departmentName
) => {
  const doctors = Doctor.findAll({
    where: { hospitalName: hospitalName, departmentName: departmentName },
  });
  return doctors;
};

const getDoctorsByHighestNoOfPatients = async () => {
  const doctors = Doctor.findAll({
    order: [["noOfPatients", "DESC"]],
  });
  return doctors;
};
const getDoctorsByHighestNoOfPatientsInHospital = async (hospitalName) => {
  const doctors = Doctor.findAll({
    where: { hospitalName: hospitalName },
    order: [["noOfPatients", "DESC"]],
  });
  return doctors;
};
const getDoctorsByHighestNoOfPatientsInDepartment = async (departmentName) => {
  const doctors = Doctor.findAll({
    where: { departmentName: departmentName },
    order: [["noOfPatients", "DESC"]],
  });
  return doctors;
};
const getDoctorsByHighestNoOfPatientsInHospitalAndDepartment = async (
  hospitalName,
  departmentName
) => {
  const doctors = Doctor.findAll({
    where: { hospitalName: hospitalName, departmentName: departmentName },
    order: [["noOfPatients", "DESC"]],
  });
  return doctors;
};
const getDoctorsByHighestYearsOfExperience = async () => {
  const doctors = Doctor.findAll({
    order: [["yearsOfExperience", "DESC"]],
  });
  return doctors;
};
const getDoctorsByHighestYearsOfExperienceInHospital = async (hospitalName) => {
  const doctors = Doctor.findAll({
    where: { hospitalName: hospitalName },
    order: [["yearsOfExperience", "DESC"]],
  });
  return doctors;
};
// All update methods
const updateDoctor = async (doctorId, doctorBody) => {
  const doctor = await getDoctorByDoctorId(doctorId);
  if (!doctor) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor Not Found");
  }
  doctor.departmentId = await departmentMapping[doctorBody.departmentName];
  Object.assign(doctor, doctorBody);
  await doctor.save();
  return doctor;
};
const updateDoctorByUserId = async (userId, doctorBody) => {
  const doctor = await getDoctorByUserId(userId);
  if (!doctor) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor Not Found");
  }
  doctor.departmentId = await departmentMapping[doctorBody.departmentName];
  Object.assign(doctor, doctorBody);
  await doctor.save();
  return doctor;
};
// all delete methods
const deleteDoctor = async (doctorId) => {
  const doctor = await getDoctorByDoctorId(doctorId);
  if (!doctor) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor Not Found");
  }
  await doctor.destroy();
  return doctor;
};
const deleteDoctorByUserId = async (userId) => {
  const doctor = await getDoctorByUserId(userId);
  if (!doctor) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor Not Found");
  }
  await doctor.destroy();
  return doctor;
};

module.exports = {
  getDoctors,
  getDoctorsByDepartmentId,
  getDoctorByDoctorId,
  getDoctorByUserId,
  getDoctorByNationalId,
  getDoctorsByFisrtName,
  getDoctorsBySecondName,
  getDoctorsByThirdName,
  getDoctorsByLastName,
  getDoctorsByFisrtNameAndSecondName,
  getDoctorsByFisrtNameAndSecondNameAndThirdName,
  getDoctorByFullName,
  getDoctorsByHospitalName,
  getDoctorsByHospitalNameAndDepartmentName,
  getDoctorsByHighestNoOfPatients,
  getDoctorsByHighestNoOfPatientsInHospital,
  getDoctorsByHighestNoOfPatientsInDepartment,
  getDoctorsByHighestNoOfPatientsInHospitalAndDepartment,
  getDoctorsByHighestYearsOfExperience,
  getDoctorsByHighestYearsOfExperienceInHospital,
  getDoctorsByDegree,
  getDoctorsByPosition,
  createDoctor,
  updateDoctor,
  updateDoctorByUserId,
  deleteDoctor,
  deleteDoctorByUserId,
  findAllByOne
};
