const express = require("express");
// const auth = require('../../middlewares/auth');
const validate = require("../../middlewares/validate");
const doctorValidation = require("../../validations/doctor.validation");
const doctorController = require("../../controllers/doctor.controller");
const router = express.Router();
// getDoctors,
// getDoctorByUserId,
// getDoctorByDoctorId,
// getDoctorsByDepartmentName,
// getDoctorByNationalId,
// getDoctorsByFisrtName,
// getDoctorsBySecondName,
// getDoctorsByThirdName,
// getDoctorsByLastName,
// getDoctorByFisrtNameAndSecondName,
// getDoctorByFisrtNameAndSecondNameAndThirdName,
// getDoctorByFullName,
// getDoctorsByHospitalName,
// getDoctorsByHospitalNameAndDepartmentName,
// getDoctorsByHighestNoOfPatients,
// getDoctorsByHighestNoOfPatientsInHospital,
// getDoctorsByHighestNoOfPatientsInDepartment,
// getDoctorsByHighestNoOfPatientsInHospitalAndDepartment,
// getDoctorsByHighestYearsOfExperience,
// getDoctorsByHighestYearsOfExperienceInHospital,
router
  .route("/")
  .get(doctorController.getDoctors)
  .post(validate(doctorValidation.createDoctor), doctorController.createDoctor);
router
  .route("/doctorId")
  .get(
    validate(doctorValidation.getDoctorByDoctorId),
    doctorController.getDoctorByDoctorId
  );
// .patch(validate(doctorValidation.updateDoctor), doctorController.updateDoctor)
// .delete(validate(doctorValidation.deleteDoctor), doctorController.deleteDoctor);
router
  .route("/userId")
  .get(
    validate(doctorValidation.getDoctorByUserId),
    doctorController.getDoctorByUserId
  )
  .patch(
    validate(doctorValidation.updateDoctorByUserId),
    doctorController.updateDoctorByUserId
  )
  .delete(
    validate(doctorValidation.deleteDoctorByUserId),
    doctorController.deleteDoctorByUserId
  );
router
  .route("/nationalId")
  .get(
    validate(doctorValidation.getDoctorByNationalId),
    doctorController.getDoctorByNationalId
  );

router
  .route("/firstName")
  .get(
    validate(doctorValidation.getDoctorsByFisrtName),
    doctorController.getDoctorsByFisrtName
  );

router
  .route("/secondName")
  .get(
    validate(doctorValidation.getDoctorsBySecondName),
    doctorController.getDoctorsBySecondName
  );

router
  .route("/thirdName")
  .get(
    validate(doctorValidation.getDoctorsByThirdName),
    doctorController.getDoctorsByThirdName
  );

router
  .route("/lastName")
  .get(
    validate(doctorValidation.getDoctorsByLastName),
    doctorController.getDoctorsByLastName
  );

router
  .route("/firstName/secondName")
  .get(
    validate(doctorValidation.getDoctorsByFisrtNameAndSecondName),
    doctorController.getDoctorsByFisrtNameAndSecondName
  );

router
  .route("/firstName/secondName/thirdName")
  .get(
    validate(doctorValidation.getDoctorsByFisrtNameAndSecondNameAndThirdName),
    doctorController.getDoctorsByFisrtNameAndSecondNameAndThirdName
  );

router
  .route("/fullName")
  .get(
    validate(doctorValidation.getDoctorByFullName),
    doctorController.getDoctorByFullName
  );

router
  .route("/department")
  .get(
    validate(doctorValidation.getDoctorsByDepartmentName),
    doctorController.getDoctorsByDepartmentName
  );

router
  .route("/degree")
  .get(
    validate(doctorValidation.getDoctorsByDegree),
    doctorController.getDoctorsByDegree
  );
router
  .route("/position")
  .get(
    validate(doctorValidation.getDoctorsByPosition),
    doctorController.getDoctorsByPosition
  );
router
  .route("/hospital")
  .get(
    validate(doctorValidation.getDoctorsByHospitalName),
    doctorController.getDoctorsByHospitalName
  );

router
  .route("/hospital/department")
  .get(
    validate(doctorValidation.getDoctorsByHospitalNameAndDepartmentName),
    doctorController.getDoctorsByHospitalNameAndDepartmentName
  );

router
  .route("/No-Pat")
  .get(
    validate(doctorValidation.getDoctorsByHighestNoOfPatients),
    doctorController.getDoctorsByHighestNoOfPatients
  );

router
  .route("/No-Pat/hospital")
  .get(
    validate(doctorValidation.getDoctorsByHighestNoOfPatientsInHospital),
    doctorController.getDoctorsByHighestNoOfPatientsInHospital
  );

router
  .route("/No-Pat/department")
  .get(
    validate(doctorValidation.getDoctorsByHighestNoOfPatientsInDepartment),
    doctorController.getDoctorsByHighestNoOfPatientsInDepartment
  );

router
  .route("/No-Pat/hospital/department")
  .get(
    validate(
      doctorValidation.getDoctorsByHighestNoOfPatientsInHospitalAndDepartment
    ),
    doctorController.getDoctorsByHighestNoOfPatientsInHospitalAndDepartment
  );

router
  .route("/Exp")
  .get(
    validate(doctorValidation.getDoctorsByHighestYearsOfExperience),
    doctorController.getDoctorsByHighestYearsOfExperience
  );

router
  .route("/Exp/hospital")
  .get(
    validate(doctorValidation.getDoctorsByHighestYearsOfExperienceInHospital),
    doctorController.getDoctorsByHighestYearsOfExperienceInHospital
  );

module.exports = router;
