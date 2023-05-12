const express = require('express');
const auth = require('../../middlewares/auth');
const validate = require('../../middlewares/validate');
// const patientValidation = require('../../validations/patient.validation');
const patientController = require('../../controllers/patient.controller');

const router = express.Router();

router
    .route('/')
    // .post( validate(patientValidation.createPatient), patientController.createPatient)
    // .get( validate(patientValidation.getPatients), patientController.getPatients);

router
    .route('/:patientId')
    // .get( validate(patientValidation.getPatient), patientController.getPatient)
    // .patch( validate(patientValidation.updatePatient), patientController.updatePatient)
    // .delete( validate(patientValidation.deletePatient), patientController.deletePatient);

module.exports = router;

