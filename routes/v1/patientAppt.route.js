const patientApptController = require("../../controllers/patientAppt.controller");
const express = require("express");
const router = express.Router();
const validate = require("../../middlewares/validate");
const patientApptValidation = require("../../validations/patientAppt.validation");
// createAppointment,
// getAppointmentsByDoctorId
// updateAppointment,
// deleteAppointment,

// getUpcomingAppointments,
// getCompletedAppointments,
// getCancelledAppointments,
// cancelAppointment,
router
  .route("/")
  .post(
    validate(patientApptValidation.createAppointment),
    patientApptController.createAppointment
  )
  .get(
    validate(patientApptValidation.getAppointmentsByDoctorId),
    patientApptController.getAppointmentsByDoctorId
  )
  .patch(
    validate(patientApptValidation.updateAppointment),
    patientApptController.updateAppointment
  )
  .delete(
    validate(patientApptValidation.deleteAppointment),
    patientApptController.deleteAppointment
  );

router
  .route("/upcoming")
  .get(
    validate(patientApptValidation.getUpcomingAppointments),
    patientApptController.getUpcomingAppointments
  );

router
  .route("/completed")
  .get(
    validate(patientApptValidation.getCompletedAppointments),
    patientApptController.getCompletedAppointments
  );

router
  .route("/cancelled")
  .get(
    validate(patientApptValidation.getCancelledAppointments),
    patientApptController.getCancelledAppointments
  );

router
  .route("/cancel")
  .patch(
    validate(patientApptValidation.cancelAppointment),
    patientApptController.cancelAppointment
  );
module.exports = router;
