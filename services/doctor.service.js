const statusCode = require("http-status");
const { User, Doctor } = require("../models");
const ApiError = require("../utils/ApiError");


const getDoctors = async () => {
  const doctors = await Doctor.findAll();
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
const getDoctorsByFisrtNameAndSecondNameAndThirdName = async(
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

const getDoctorByFullName = async (firstName, secondName, thirdName, lastName) => {
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
const getDoctorsByHospitalNameAndDepartmentName = async(
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
const getDoctorsByHighestNoOfPatientsInHospitalAndDepartment = async(
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
};


