const joi = require("joi");
// getDoctors,
//   getDoctorByUserId,
//   getDoctorByDoctorId,
//   getDoctorsByDepartmentName,
//   getDoctorByNationalId,
//   getDoctorsByFisrtName,
//   getDoctorsBySecondName,
//   getDoctorsByThirdName,
//   getDoctorsByLastName,
//   getDoctorByFisrtNameAndSecondName,
//   getDoctorByFisrtNameAndSecondNameAndThirdName,
//   getDoctorByFullName,
//   getDoctorsByHospitalName,
//   getDoctorsByHospitalNameAndDepartmentName,
//   getDoctorsByHighestNoOfPatients,
//   getDoctorsByHighestNoOfPatientsInHospital,
//   getDoctorsByHighestNoOfPatientsInDepartment,
//   getDoctorsByHighestNoOfPatientsInHospitalAndDepartment,
//   getDoctorsByHighestYearsOfExperience,
//   getDoctorsByHighestYearsOfExperienceInHospital,
// `doctorId` int NOT NULL AUTO_INCREMENT,
//   `userId` int NOT NULL,
//   `nationalId` char(14) DEFAULT NULL,
//   `fullName` varchar(600) DEFAULT NULL,
//   `firstName` varchar(150) NOT NULL,
//   `secondName` varchar(150) DEFAULT NULL,
//   `thirdName` varchar(150) DEFAULT NULL,
//   `lastName` varchar(150) NOT NULL,
//   `degree` int NOT NULL COMMENT 'Ref for Latest Scientific Degree\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n0 Bachelor بكالوريوس\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n1 Postgraduate Diploma دبلوم الدراسات العليا\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n2 Egyptian Associate degree درجة الزمالة المصرية\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n3 Fellowship الزمالة\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n4 Royal Membership عضوية الكلية الملكية\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n5 Master درجة الماجستير\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n6 PhD دكتوراه\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n',
//   `position` int NOT NULL COMMENT 'Ref for Position Level in the Department',
//   `departmentId` int NOT NULL,
//   `hospitalName` varchar(150) DEFAULT NULL,
//   `imageUrl` varchar(3000) DEFAULT NULL,
//   `imageHash` varchar(500) DEFAULT NULL,
//   `noOfPatients` int DEFAULT NULL,
//   `gradDate` date NOT NULL,
//   `aboutMe` text,
//   `yearsOfExperience` int DEFAULT NULL,
//   `note` text,

const getDoctorByDoctorId = {
  body: joi.object().keys({
    doctorId: joi.number().integer().required().messages({
      "any.required": "doctorId is required",
      "number.base": "doctorId must be a number",
    }),
  }),
};
const getDoctorByUserId = {
  body: joi.object().keys({
    userId: joi.number().integer().required().messages({
      "any.required": "userId is required",
      "number.base": "userId must be a number",
    }),
  }),
};
const getDoctorsByDepartmentName = {
  body: joi.object().keys({
    departmentName: joi.string().required().messages({
      "any.required": "departmentName is required",
    }),
  }),
};

const getDoctorByNationalId = {
  body: joi.object().keys({
    nationalId: joi.string().length(14).required().messages({
      "any.required": "nationalId is required",
      "string.length": "nationalId must be 14 characters",
    }),
  }),
};
const getDoctorsByFisrtName = {
  body: joi.object().keys({
    firstName: joi.string().required().messages({
      "any.required": "firstName is required",
    }),
  }),
};
const getDoctorsBySecondName = {
  body: joi.object().keys({
    secondName: joi.string().required().messages({
      "any.required": "secondName is required",
    }),
  }),
};
const getDoctorsByThirdName = {
  body: joi.object().keys({
    thirdName: joi.string().required().messages({
      "any.required": "thirdName is required",
    }),
  }),
};
const getDoctorsByLastName = {
  body: joi.object().keys({
    lastName: joi.string().required().messages({
      "any.required": "lastName is required",
    }),
  }),
};
const getDoctorsByFisrtNameAndSecondName = {
  body: joi.object().keys({
    firstName: joi.string().required().messages({
      "any.required": "firstName is required",
    }),
    secondName: joi.string().required().messages({
      "any.required": "secondName is required",
    }),
  }),
};
const getDoctorsByFisrtNameAndSecondNameAndThirdName = {
  body: joi.object().keys({
    firstName: joi.string().required().messages({
      "any.required": "firstName is required",
    }),
    secondName: joi.string().required().messages({
      "any.required": "secondName is required",
    }),
    thirdName: joi.string().required().messages({
      "any.required": "thirdName is required",
    }),
  }),
};
const getDoctorByFullName = {
  body: joi.object().keys({
    fullName: joi.string().required().messages({
      "any.required": "fullName is required",
    }),
  }),
};
const getDoctorsByHospitalName = {
  body: joi.object().keys({
    hospitalName: joi.string().required().messages({
      "any.required": "hospitalName is required",
    }),
  }),
};
const getDoctorsByHospitalNameAndDepartmentName = {
  body: joi.object().keys({
    hospitalName: joi.string().required().messages({
      "any.required": "hospitalName is required",
    }),
    departmentName: joi.string().required().messages({
      "any.required": "departmentName is required",
    }),
  }),
};
const getDoctorsByHighestNoOfPatients = {
  body: joi.object().keys({
    noOfPatients: joi.number().integer().required().messages({
      "any.required": "noOfPatients is required",
      "number.base": "noOfPatients must be a number",
    }),
  }),
};
const getDoctorsByHighestNoOfPatientsInHospital = {
  body: joi.object().keys({
    hospitalName: joi.string().required().messages({
      "any.required": "hospitalName is required",
    }),
    noOfPatients: joi.number().integer().required().messages({
      "any.required": "noOfPatients is required",
      "number.base": "noOfPatients must be a number",
    }),
  }),
};
const getDoctorsByHighestNoOfPatientsInDepartment = {
  body: joi.object().keys({
    departmentName: joi.string().required().messages({
      "any.required": "departmentName is required",
    }),
    noOfPatients: joi.number().integer().required().messages({
      "any.required": "noOfPatients is required",
      "number.base": "noOfPatients must be a number",
    }),
  }),
};
const getDoctorsByHighestNoOfPatientsInHospitalAndDepartment = {
  body: joi.object().keys({
    hospitalName: joi.string().required().messages({
      "any.required": "hospitalName is required",
    }),
    departmentName: joi.string().required().messages({
      "any.required": "departmentName is required",
    }),
    noOfPatients: joi.number().integer().required().messages({
      "any.required": "noOfPatients is required",
      "number.base": "noOfPatients must be a number",
    }),
  }),
};
const getDoctorsByHighestYearsOfExperience = {
  body: joi.object().keys({
    yearsOfExperience: joi.number().integer().required().messages({
      "any.required": "yearsOfExperience is required",
      "number.base": "yearsOfExperience must be a number",
    }),
  }),
};
const getDoctorsByHighestYearsOfExperienceInHospital = {
  body: joi.object().keys({
    hospitalName: joi.string().required().messages({
      "any.required": "hospitalName is required",
    }),
    yearsOfExperience: joi.number().integer().required().messages({
      "any.required": "yearsOfExperience is required",
      "number.base": "yearsOfExperience must be a number",
    }),
  }),
};
const getDoctorsByDegree = {
    body: joi.object().keys({
        degree: joi.number().integer().messages({
            "any.required": "degree is required",
            "number.base": "degree must be a number",
        }),
    }),
};
const getDoctorsByPosition = {
    body: joi.object().keys({
        position: joi.number().integer().messages({
            "any.required": "postion is required",
            "number.base": "postion must be a number",
        }),
    }),
};

// const getDoctorsByHighestYearsOfExperienceInDepartment = {
//     body: joi.object().keys({
//         departmentName: joi.string().required().messages({
//             "any.required": "departmentName is required",
//         }),
//         yearsOfExperience: joi.number().integer().required().messages({
//             "any.required": "yearsOfExperience is required",
//             "number.base": "yearsOfExperience must be a number",
//         }),
//     }),
// };
// const getDoctorsByHighestYearsOfExperienceInHospitalAndDepartment = {
//     body: joi.object().keys({
//         hospitalName: joi.string().required().messages({
//             "any.required": "hospitalName is required",
//         }),
//         departmentName: joi.string().required().messages({
//             "any.required": "departmentName is required",
//         }),

//     }),

// };
module.exports = {
  getDoctorByDoctorId,
  getDoctorByUserId,
  getDoctorsByDepartmentName,
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
  
  // getDoctorsByHighestYearsOfExperienceInDepartment,
  // getDoctorsByHighestYearsOfExperienceInHospitalAndDepartment,
};
