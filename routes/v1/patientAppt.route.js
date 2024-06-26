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

  .patch(
    validate(patientApptValidation.updateAppointment),
    patientApptController.updateAppointment
  )
  .delete(
    validate(patientApptValidation.deleteAppointment),
    patientApptController.deleteAppointment
  );
router
  .route("/doctorId")
  .post(
    validate(patientApptValidation.getAppointmentsByDoctorId),
    patientApptController.getAppointmentsByDoctorId
  );
router
  .route("/upcoming")
  .post(
    validate(patientApptValidation.getUpcomingAppointments),
    patientApptController.getUpcomingAppointments
  );

router
  .route("/completed")
  .post(
    validate(patientApptValidation.getCompletedAppointments),
    patientApptController.getCompletedAppointments
  );

router
  .route("/cancelled")
  .post(
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
