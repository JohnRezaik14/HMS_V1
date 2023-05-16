const express = require("express");
const auth = require("../../middlewares/auth");
const validate = require("../../middlewares/validate");
// const clinicsSkdValidation = require('../../validations/clinicsSkd.validation');
const clinicsSkdController = require("../../controllers/clinicsSkd.controller");
const router = express.Router();
router.route("/create").post(clinicsSkdController.createClinicsSkd);
router.route("/get").get(clinicsSkdController.queryClinicsSkdById);
router.route("/AVL/doctor").get(clinicsSkdController.queryAvaiLableClinicsSkdsByDoctorId);
router.route("/doctorId").get(clinicsSkdController.queryClinicsSkdsByDoctorId);
router
  .route("/day/doctorId")
  .get(clinicsSkdController.queryClinicsSkdsByDayDoctorId);
router.route("/update").patch(clinicsSkdController.updateClinicsSkd);
router.route("/delete").delete(clinicsSkdController.deleteClinicsSkd);
module.exports = router;
// createClinicsSkd,
// queryClinicsSkdById,
// queryClinicsSkdsByDoctorId,
// queryClinicsSkdsByDayDoctorId,
// queryAvaiLableClinicsSkdsByDoctorId,
// updateClinicsSkd,
// deleteClinicsSkd,
