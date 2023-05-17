const statusCode = require("http-status");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const doctorService = require("../services/doctor.service");

const doctorQueries = [
  doctorService.getDoctors,
  doctorService.getDoctorsByDepartmentId,
  doctorService.getDoctorByDoctorId,
  doctorService.getDoctorByUserId,
  doctorService.getDoctorByNationalId,
  doctorService.getDoctorsByFisrtName,
  doctorService.getDoctorsBySecondName,
  doctorService.getDoctorsByThirdName,
  doctorService.getDoctorsByLastName,
  doctorService.getDoctorsByFisrtNameAndSecondName,
  doctorService.getDoctorsByFisrtNameAndSecondNameAndThirdName,
  doctorService.getDoctorByFullName,
  doctorService.getDoctorsByHospitalName,
  doctorService.getDoctorsByHospitalNameAndDepartmentName,
  doctorService.getDoctorsByHighestNoOfPatients,
  doctorService.getDoctorsByHighestNoOfPatientsInHospital,
  doctorService.getDoctorsByHighestNoOfPatientsInDepartment,
  doctorService.getDoctorsByHighestNoOfPatientsInHospitalAndDepartment,
  doctorService.getDoctorsByHighestYearsOfExperience,
  doctorService.getDoctorsByHighestYearsOfExperienceInHospital,
  doctorService.getDoctorsByDegree,
  doctorService.getDoctorsByPosition,
];
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

const getDoctors = catchAsync(async (req, res) => {
  const doctors = await doctorQueries[0]();
  res.send({ doctors, statusCode: 200, message: "All Doctors" });
});
const getDoctorsByDepartmentName = catchAsync(async (req, res) => {
  const doctors = await doctorQueries[1](
    departmentMapping[req.body.departmentName]
  );
  res.send({ doctors, statusCode: 200, message: "Doctors By Department Id" });
});

const getDoctorByDoctorId = catchAsync(async (req, res) => {
  const doctor = await doctorQueries[2](req.body.doctorId);
  if (doctor.length === 0) {
    throw new ApiError(statusCode.NOT_FOUND, "Doctor Not Found");
  }
  res.send({ doctor, statusCode: 200, message: "Doctor By Doctor Id" });
});

const getDoctorByUserId = catchAsync(async (req, res) => {
  const doctor = await doctorQueries[3](req.body.userId);
  res.send({ doctor, statusCode: 200, message: "Doctor By User Id" });
});

const getDoctorByNationalId = catchAsync(async (req, res) => {
  const doctor = await doctorQueries[4](req.body.nationalId);
  res.send({ doctor, statusCode: 200, message: "Doctor By National Id" });
});

const getDoctorsByFisrtName = catchAsync(async (req, res) => {
  const doctor = await doctorQueries[5](req.body.firstName);
  res.send({ doctor, statusCode: 200, message: "Doctors By First Name" });
});

const getDoctorsBySecondName = catchAsync(async (req, res) => {
  const doctors = await doctorQueries[6](req.body.secondName);
  res.send({ doctors, statusCode: 200, message: "Doctors By Second Name" });
});

const getDoctorsByThirdName = catchAsync(async (req, res) => {
  const doctors = await doctorQueries[7](req.body.thirdName);
  res.send({ doctors, statusCode: 200, message: "Doctors By Third Name" });
});

const getDoctorsByLastName = catchAsync(async (req, res) => {
  const doctors = await doctorQueries[8](req.body.lastName);
  res.send({ doctors, statusCode: 200, message: "Doctors By Last Name" });
});

const getDoctorsByFisrtNameAndSecondName = catchAsync(async (req, res) => {
  const doctors = await doctorQueries[9](
    req.body.firstName,
    req.body.secondName
  );
  res.send({
    doctors,
    statusCode: 200,
    message: "Doctor By First Name And Second Name",
  });
});

const getDoctorsByFisrtNameAndSecondNameAndThirdName = catchAsync(
  async (req, res) => {
    const doctor = await doctorQueries[10](
      req.body.firstName,
      req.body.secondName,
      req.body.thirdName
    );
    res.send({
      doctor,
      statusCode: 200,
      message: "Doctor By First Name And Second Name And Third Name",
    });
  }
);

const getDoctorByFullName = catchAsync(async (req, res) => {
  const doctor = await doctorQueries[11](
    req.body.firstName,
    req.body.secondName,
    req.body.thirdName,
    req.body.lastName
  );
  res.send({ doctor, statusCode: 200, message: "Doctor By Full Name" });
});

const getDoctorsByHospitalName = catchAsync(async (req, res) => {
  const doctors = await doctorQueries[12](req.body.hospitalName);
  res.send({ doctors, statusCode: 200, message: "Doctors By Hospital Name" });
});

const getDoctorsByHospitalNameAndDepartmentName = catchAsync(
  async (req, res) => {
    const doctors = await doctorQueries[13](
      req.body.hospitalName,
      departmentMapping[req.body.departmentName]
    );
    res.send({
      doctors,
      statusCode: 200,
      message: "Doctors By Hospital Name And Department Name",
    });
  }
);

const getDoctorsByHighestNoOfPatients = catchAsync(async (req, res) => {
  const doctors = await doctorQueries[14]();
  res.send({
    doctors,
    statusCode: 200,
    message: "Doctors By Highest No Of Patients",
  });
});

const getDoctorsByHighestNoOfPatientsInHospital = catchAsync(
  async (req, res) => {
    const doctors = await doctorQueries[15](req.body.hospitalName);
    res.send({
      doctors,
      statusCode: 200,
      message: "Doctors By Highest No Of Patients In Hospital",
    });
  }
);

const getDoctorsByHighestNoOfPatientsInDepartment = catchAsync(
  async (req, res) => {
    const doctors = await doctorQueries[16](
      departmentMapping[req.body.departmentName]
    );

    res.send({
      doctors,
      statusCode: 200,
      message: "Doctors By Highest No Of Patients In Department",
    });
  }
);

const getDoctorsByHighestNoOfPatientsInHospitalAndDepartment = catchAsync(
  async (req, res) => {
    const doctors = await doctorQueries[17](
      req.body.hospitalName,
      departmentMapping[req.body.departmentName]
    );
    res.send({
      doctors,
      statusCode: 200,
      message: "Doctors By Highest No Of Patients In Hospital And Department",
    });
  }
);

const getDoctorsByHighestYearsOfExperience = catchAsync(async (req, res) => {
  const doctors = await doctorQueries[18]();
  res.send({
    doctors,
    statusCode: 200,
    message: "Doctors By Highest Years Of Experience",
  });
});

const getDoctorsByHighestYearsOfExperienceInHospital = catchAsync(
  async (req, res) => {
    const doctors = await doctorQueries[19](req.body.hospitalName);
    res.send({
      doctors,
      statusCode: 200,
      message: "Doctors By Highest Years Of Experience In Hospital",
    });
  }
);
const getDoctorsByDegree = catchAsync(async (req, res) => {
  const doctors = await doctorQueries[20](req.body.degree);
  res.send({
    doctors,
    statusCode: 200,
    message: "Doctors By Degree",
  });
});

const getDoctorsByPosition = catchAsync(async (req, res) => {
  const doctors = await doctorQueries[21](req.body.position);
  res.send({
    doctors,
    statusCode: 200,
    message: "Doctors By Position",
  });
});

// const getDoctorsByHighestYearsOfExperienceInDepartment = catchAsync(async (req, res) => {
//   const result = await doctorQueries[21](req.body.departmentName);
//   res.send({ result, statusCode: 200, message: "Doctors By Highest Years Of Experience In Department" });
// });

// const getDoctorsByHighestYearsOfExperienceInHospitalAndDepartment = catchAsync(async (req, res) => {
//   const result = await doctorQueries[22](req.body.hospitalName, req.body.departmentName);
//   res.send({ result, statusCode: 200, message: "Doctors By Highest Years Of Experience In Hospital And Department" });
// });

// const getDoctorsByHighestNoOfPatientsAndHighestYearsOfExperience = catchAsync(async (req, res) => {
//   const result = await doctorQueries[23]();
//   res.send({ result, statusCode: 200, message: "Doctors By Highest No Of Patients And Highest Years Of Experience" });
// });

// const getDoctorsByHighestNoOfPatientsAndHighestYearsOfExperienceInHospital = catchAsync(async (req, res) => {
//   const result = await doctorQueries[24](req.body.hospitalName);
//   res.send({ result, statusCode: 200, message: "Doctors By Highest No Of Patients And Highest Years Of Experience In Hospital" });
// });

module.exports = {
  getDoctors,
  getDoctorByUserId,
  getDoctorByDoctorId,
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
  // getDoctorsByHighestYearsOfExperienceInDepartment,
  // getDoctorsByHighestYearsOfExperienceInHospitalAndDepartment,
  // getDoctorsByHighestNoOfPatientsAndHighestYearsOfExperience,
  // getDoctorsByHighestNoOfPatientsAndHighestYearsOfExperienceInHospital,
  getDoctorsByDegree,
  getDoctorsByPosition,
};
