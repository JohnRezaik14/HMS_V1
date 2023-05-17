const express = require("express");
// const auth = require("../../middlewares/auth");
const validate = require("../../middlewares/validate");
const clinicsSkdValidation = require("../../validations/clinicsSkd.validation");
const clinicsSkdController = require("../../controllers/clinicsSkd.controller");
const router = express.Router();

router
  .route("/create")
  .post(
    validate(clinicsSkdValidation.createClinicsSkd),
    clinicsSkdController.createClinicsSkd
  );
router
  .route("/get")
  .get(
    validate(clinicsSkdValidation.queryClinicsSkdById),
    clinicsSkdController.queryClinicsSkdById
  );
router
  .route("/AVL/doctor")
  .get(
    validate(clinicsSkdValidation.queryAvaiLableClinicsSkdsByDoctorId),
    clinicsSkdController.queryAvaiLableClinicsSkdsByDoctorId
  );
router
  .route("/doctor")
  .get(
    validate(clinicsSkdValidation.queryClinicsSkdsByDoctorId),
    clinicsSkdController.queryClinicsSkdsByDoctorId
  );
router
  .route("/doctor/day")
  .get(
    validate(clinicsSkdValidation.queryClinicsSkdsByDayDoctorId),
    clinicsSkdController.queryClinicsSkdsByDayDoctorId
  );
router
  .route("/update")
  .patch(
    validate(clinicsSkdValidation.updateClinicsSkd),
    clinicsSkdController.updateClinicsSkd
  );
router
  .route("/delete")
  .delete(
    validate(clinicsSkdValidation.deleteClinicsSkd),
    clinicsSkdController.deleteClinicsSkd
  );
module.exports = router;
// createClinicsSkd,
// queryClinicsSkdById,
// queryClinicsSkdsByDoctorId,
// queryClinicsSkdsByDayDoctorId,
// queryAvaiLableClinicsSkdsByDoctorId,
// updateClinicsSkd,
// deleteClinicsSkd,

// createClinicsSkd,
// queryClinicsSkdById,
// queryClinicsSkdsByDoctorId,
// queryClinicsSkdsByDayDoctorId,
// queryAvaiLableClinicsSkdsByDoctorId,
// updateClinicsSkd,
// deleteClinicsSkd,
