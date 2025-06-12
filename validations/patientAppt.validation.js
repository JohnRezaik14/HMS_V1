const joi = require("joi");
// createAppointment,
//     getUpcomingAppointments,
//     getCompletedAppointments,
//     getCancelledAppointments,
//     cancelAppointment,
//     updateAppointment,
//     deleteAppointment,
//     getAppointmentsByDoctorId

const createAppointment = {
  body: joi.object().keys({
    userId: joi.number().integer().min(1).required().messages({
      "number.base": `userId should be a type of 'number'`,
      "number.empty": `userId cannot be an empty field`,
      "number.min": `userId should have a minimum value of {#limit}`,
      "any.required": `userId is a required field`,
    }),
    clinicsSkdId: joi.number().integer().min(1).required().messages({
      "number.base": `clinicsSkdId should be a type of 'number'`,
      "number.empty": `clinicsSkdId cannot be an empty field`,
      "number.min": `clinicsSkdId should have a minimum value of {#limit}`,
      "any.required": `clinicsSkdId is a required field`,
    }),
    date: joi.date().required().messages({
      "date.base": `date should be a type of 'date'`,
      "date.empty": `date cannot be an empty field`,
      "any.required": `date is a required field`,
    }),
    patientComplaint: joi.string().allow(null).messages({
      "string.base": `Patient Complaint should be a type of 'string'`,
      "string.empty": `Patient Complaint cannot be an empty field`,
    }),
    note: joi.string().allow(null).messages({
      "string.base": `Note should be a type of 'string'`,
      "string.empty": `Note cannot be an empty field`,
    }),
  }),
};

const getUpcomingAppointments = {
  body: joi.object().keys({
    userId: joi.number().integer().min(1).required().messages({
      "number.base": `userId should be a type of 'number'`,
      "number.empty": `userId cannot be an empty field`,
      "number.min": `userId should have a minimum value of {#limit}`,
      "any.required": `userId is a required field`,
    }),
  }),
};

const getCompletedAppointments = {
  body: joi.object().keys({
    userId: joi.number().integer().min(1).required().messages({
      "number.base": `userId should be a type of 'number'`,
      "number.empty": `userId cannot be an empty field`,
      "number.min": `userId should have a minimum value of {#limit}`,
      "any.required": `userId is a required field`,
    }),
  }),
};

const getCancelledAppointments = {
  body: joi.object().keys({
    userId: joi.number().integer().min(1).required().messages({
      "number.base": `userId should be a type of 'number'`,
      "number.empty": `userId cannot be an empty field`,
      "number.min": `userId should have a minimum value of {#limit}`,
      "any.required": `userId is a required field`,
    }),
  }),
};

const cancelAppointment = {
  body: joi.object().keys({
    apptId: joi.number().integer().min(1).required().messages({
      "number.base": `apptId should be a type of 'number'`,
      "number.empty": `apptId cannot be an empty field`,
      "number.min": `apptId should have a minimum value of {#limit}`,
      "any.required": `apptId is a required field`,
    }),
    cancelReason: joi.string().allow(null).messages({
      "string.base": `cancelReason should be a type of 'string'`,
      "string.empty": `cancelReason cannot be an empty field`,
    }),
  }),
};

const updateAppointment = {
  body: joi.object().keys({
    apptId: joi.number().integer().min(1).required().messages({
      "number.base": `apptId should be a type of 'number'`,
      "number.empty": `apptId cannot be an empty field`,
      "number.min": `apptId should have a minimum value of {#limit}`,
      "any.required": `apptId is a required field`,
    }),
    patientComplaint: joi.string().allow(null).messages({
      "string.base": `Patient Complaint should be a type of 'string'`,
      "string.empty": `Patient Complaint cannot be an empty field`,
    }),
    note: joi.string().allow(null).messages({
      "string.base": `Note should be a type of 'string'`,
      "string.empty": `Note cannot be an empty field`,
    }),
    cancelReason: joi.string().allow(null).messages({
      "string.base": `cancelReason should be a type of 'string'`,
      "string.empty": `cancelReason cannot be an empty field`,
    }),
    clinicsSkdId: joi.number().integer().min(1).messages({
      "number.base": `clinicsSkdId should be a type of 'number'`,
      "number.empty": `clinicsSkdId cannot be an empty field`,
      "number.min": `clinicsSkdId should have a minimum value of {#limit}`,
    }),
    date: joi.date().messages({
      "date.base": `date should be a type of 'date'`,
      "date.empty": `date cannot be an empty field`,
    }),
    apptState: joi
      .string()
      .valid("upcoming", "cancelled", "completed")
      .allow(null)
      .messages({
        "string.base": `apptState should be a type of 'string'`,
        "string.empty": `apptState cannot be an empty field`,
      }),
    patientId: joi.number().integer().min(1).messages({
      "number.base": `patientId should be a type of 'number'`,
      "number.empty": `patientId cannot be an empty field`,
      "number.min": `patientId should have a minimum value of {#limit}`,
    }),
  }),
};

const deleteAppointment = {
  body: joi.object().keys({
    apptId: joi.number().integer().min(1).required().messages({
      "number.base": `apptId should be a type of 'number'`,
      "number.empty": `apptId cannot be an empty field`,
      "number.min": `apptId should have a minimum value of {#limit}`,
      "any.required": `apptId is a required field`,
    }),
  }),
};

const getAppointmentsByDoctorId = {
  body: joi.object().keys({
    doctorId: joi.number().integer().min(1).required().messages({
      "number.base": `doctorId should be a type of 'number'`,
      "number.empty": `doctorId cannot be an empty field`,
      "number.min": `doctorId should have a minimum value of {#limit}`,
      "any.required": `doctorId is a required field`,
    }),
    option: joi.string().allow(null).messages({
      "string.base": `option should be a type of 'string'`,
      "string.empty": `option cannot be an empty field`,
    }),
  }),
};

module.exports = {
  createAppointment,
  getUpcomingAppointments,
  getCompletedAppointments,
  getCancelledAppointments,
  cancelAppointment,
  updateAppointment,
  deleteAppointment,
  getAppointmentsByDoctorId,
};
