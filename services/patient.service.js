const httpStatus = require("http-status");
const { User, Patient } = require("../models");
const { Op } = require("sequelize");
const ApiError = require("../utils/ApiError");
const userService = require("./user.service");

const createPatient = async (patientBody) => {
  const userId = patientBody.userId; // `userId` int NOT NULL,
  const user = await userService.getUserById(userId);
  if ((await userId) == undefined || null) {
    throw new ApiError(httpStatus.BAD_REQUEST, "userId must have value");
  } else if (await Patient.findOne({
    where: { userId: userId  }
  })) {
    throw new ApiError(httpStatus.BAD_REQUEST, "userId already is taken");
  } else if (!user) {
    throw new ApiError(
      httpStatus.BAD_REQUEST,
      "User doesn't exist , you must create user first"
    );
  } else if (user.role != "patient") {
      throw new ApiError(
          httpStatus.BAD_REQUEST,
          "User role must be patient"
      );
    }

  const nationalId = patientBody.nationalId; // `nationalId` char(14) NOT NULL,
  if (await Patient.isNationalIdTaken(nationalId)) {
    throw new ApiError(httpStatus.BAD_REQUEST, "nationalId already taken");
  }

  const phoneNumber = patientBody.phoneNumber; // `phoneNumber` varchar(50) NOT NULL

  const fullName = patientBody.fullName; // `fullName` varchar(600) DEFAULT NULL
  if ((await fullName) == null || undefined) {
    fullName = " ";
  }

  const firstName = patientBody.firstName; // `firstName` varchar(150) NOT NULL,
  const secondName = patientBody.secondName; // `secondName` varchar(150) NOT NULL,
  const thirdName = patientBody.thirdName; // `thirdName` varchar(150) NOT NULL,
  const lastName = patientBody.lastName; // `lastName` varchar(150) NOT NULL,

  const birthDate = patientBody.birthDate; // `birthDate` date NOT NULL,
  const gender = patientBody.gender; // `gender` int NOT NULL
  const nationality = patientBody.nationality; // `nationality` int NOT NULL

  const religion = patientBody.religion; // `religion` int DEFAULT NULL
  const maritalStatus = patientBody.maritalStatus; // `maritalStatus` int DEFAULT NULL
  const bloodType = patientBody.bloodType; // `bloodType` int DEFAULT NULL

  const address = patientBody.address; // `address` varchar(255) DEFAULT ' '
  if (address == undefined || null) {
    address = " ";
  }
  const country = patientBody.country; // `country` varchar(50) NOT NULL
  const state = patientBody.state; // `state` varchar(50) NOT NULL
  const city = patientBody.city; // `city` varchar(50) DEFAULT ' '
  const street = patientBody.street; // `street` varchar(50) NOT NULL DEFAULT ' '
  const buildingNumber = patientBody.buildingNumber; // `buildingNumber` varchar(10) NOT NULL DEFAULT ' '
  const appartment = patientBody.appartment; // `appartment` int NOT NULL DEFAULT '1'

  const birthPlace = patientBody.birthPlace; // `birthPlace` varchar(150) DEFAULT ' '
  if (birthPlace == undefined || null) {
    birthPlace = " ";
  }
  const birthCountry = patientBody.birthCountry; // `birthCountry` varchar(50) DEFAULT ' '
  const birthState = patientBody.birthState; // `birthState` varchar(50) DEFAULT ' '
  const birthCity = patientBody.birthCity; // `birthCity` varchar(50) DEFAULT ' '

  const height = patientBody.height; // `height` decimal(5,2) DEFAULT NULL
  const weight = patientBody.weight; // `weight` decimal(5,2) DEFAULT NULL
  const job = patientBody.job; // `job` varchar(50) DEFAULT NULL
  const jobAddress = patientBody.jobAddress; // `jobAddress` varchar(150) DEFAULT ' '
  if (jobAddress == undefined || null) {
    jobAddress = " ";
  }
  const jobCountry = patientBody.jobCountry; // `jobCountry` varchar(50) DEFAULT ' '
  const jobState = patientBody.jobState; // `jobState` varchar(50) DEFAULT ' '
  const jobCity = patientBody.jobCity; // `jobCity` varchar(50) DEFAULT ' '
  const note = patientBody.note; // `note` text,
  const patientPP = patientBody.patientPP; // `patientPP` varchar(255) DEFAULT NULL,
  const patientPPHash = patientBody.patientPPHash; // `patientPPHash` varchar(45) DEFAULT NULL,

  return await Patient.create({
    userId: userId,
    nationalId: nationalId,
    phoneNumber: phoneNumber,
    fullName: fullName,
    firstName: firstName,
    secondName: secondName,
    thirdName: thirdName,
    lastName: lastName,
    birthDate: birthDate,
    gender: gender,
    nationality: nationality,
    religion: religion,
    maritalStatus: maritalStatus,
    bloodType: bloodType,
    address: address,
    country: country,
    state: state,
    city: city,
    street: street,
    buildingNumber: buildingNumber,
    appartment: appartment,
    birthPlace: birthPlace,
    birthCountry: birthCountry,
    birthState: birthState,
    birthCity: birthCity,
    height: height,
    weight: weight,
    job: job,
    jobAddress: jobAddress,
    jobCountry: jobCountry,
    jobState: jobState,
    jobCity: jobCity,
    note: note,
    patientPP: patientPP,
    patientPPHash: patientPPHash,
  });
};

const getPatientByUserId = async (userId) => {
  const patient = await Patient.findOne({ where: { userId: userId } });
  return patient;
};

const updatePatientByUserId = async (userId, updateBody) => {
  const patient = await getPatientByUserId(userId);
  if (!patient) {
    throw new ApiError(httpStatus.NOT_FOUND, "patient not found");
  }
  Object.assign(patient, updateBody);
  await patient.save();
  return patient;
};

module.exports = {
  createPatient,
  getPatientByUserId,
  updatePatientByUserId,
};
