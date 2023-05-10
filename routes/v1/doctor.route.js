const express = require('express');
const auth = require('../../middlewares/auth');
const validate = require('../../middlewares/validate');
// const doctorValidation = require('../../validations/user.validation');
const doctorController = require('../../controllers/doctor.controller');
const router = express.Router();
router.get('/fetch',doctorController.getDoctors);
module.exports = router;