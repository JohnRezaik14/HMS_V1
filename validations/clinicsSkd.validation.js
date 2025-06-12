const joi = require("joi");
// `skdId` int NOT NULL,
// `startTime` time NOT NULL,
// `endTime` time NOT NULL,
// `dayOfWeek` int NOT NULL,
// `isAvaiLable` tinyint(1) NOT NULL,
// `doctorId` int NOT NULL,
// `note` text,
// `createdAt` timestamp NULL DEFAULT NULL,
// `updatedAt` timestamp NULL DEFAULT NULL,
// createClinicsSkd,
// queryClinicsSkdById,
// queryClinicsSkdsByDoctorId,
// queryClinicsSkdsByDayDoctorId,
// queryAvaiLableClinicsSkdsByDoctorId,
// updateClinicsSkd,
// deleteClinicsSkd,
const createClinicsSkd = {
  body: joi.object().keys({
    startTime: joi
      .string()
      .required()
      .regex(/^([01][0-9]|2[0-3])\:([0-5][0-9])\:([0-5][0-9])$/)
      .messages({
        "string.empty": "Start time is required",
        "string.pattern.base":
          "Start time must be in the format hh:mm:ss (max 23:59:59)",
      }),
    endTime: joi
      .string()
      .required()
      .regex(/^([01][0-9]|2[0-3])\:([0-5][0-9])\:([0-5][0-9])$/)
      .messages({
        "string.empty": "End time is required",
        "string.pattern.base":
          "End time must be in the format hh:mm:ss (max 23:59:59)",
      }),
    dayOfWeek: joi.number().valid(1, 2, 3, 4, 5, 6, 7).required().messages({
      "number.base": "Day of week must be a number",
      "number.valid": "Day of week must be a valid value (1-7)",
      "any.required": "Day of week is required",
    }),
    isAvaiLable: joi.boolean().required().allow(1, 0).messages({
      "boolean.base": "Availability must be a boolean value",
      "any.required": "Availability is required",
    }),
    doctorId: joi.number().required().messages({
      "number.base": "Doctor ID must be a number",
      "any.required": "Doctor ID is required",
    }),
    note: joi.string().allow(null).messages({
      "string.base": "Note must be a string",
    }),
  }),
};

const queryClinicsSkdById = {
  body: joi.object().keys({
    skdId: joi.number().required().messages({
      "number.base": "Schedule ID must be a number",
      "any.required": "Schedule ID is required",
    }),
  }),
};

const queryClinicsSkdsByDoctorId = {
  body: joi.object().keys({
    doctorId: joi.number().required().messages({
      "number.base": "Doctor ID must be a number",
      "any.required": "Doctor ID is required",
    }),
  }),
};
const queryClinicsSkdsByDayDoctorId = {
  body: joi.object().keys({
    doctorId: joi.number().required().messages({
      "number.base": "Doctor ID must be a number",
      "any.required": "Doctor ID is required",
    }),
    dayOfWeek: joi.number().valid(1, 2, 3, 4, 5, 6, 7).required().messages({
      "number.base": "Day of week must be a number",
      "number.valid": "Day of week must be a valid value (1-7)",
      "any.required": "Day of week is required",
    }),
  }),
};
const queryAvaiLableClinicsSkdsByDoctorId = {
  body: joi.object().keys({
    doctorId: joi.number().required().messages({
      "number.base": "Doctor ID must be a number",
      "any.required": "Doctor ID is required",
    }),
  }),
};
const updateClinicsSkd = {
  body: joi.object().keys({
    skdId: joi.number().required().messages({
      "number.base": "Schedule ID must be a number",
      "any.required": "Schedule ID is required",
    }),
    startTime: joi
      .string()
      .required()
      .regex(/^([01][0-9]|2[0-3])\:([0-5][0-9])\:([0-5][0-9])$/)
      .messages({
        "string.empty": "Start time is required",
        "string.pattern.base":
          "Start time must be in the format hh:mm:ss (max 23:59:59)",
      }),
    endTime: joi
      .string()
      .required()
      .regex(/^([01][0-9]|2[0-3])\:([0-5][0-9])\:([0-5][0-9])$/)
      .messages({
        "string.empty": "End time is required",
        "string.pattern.base":
          "End time must be in the format hh:mm:ss (max 23:59:59)",
      }),
    dayOfWeek: joi.number().valid(1, 2, 3, 4, 5, 6, 7).required().messages({
      "number.base": "Day of week must be a number",
      "number.valid": "Day of week must be a valid value (1-7)",
      "any.required": "Day of week is required",
    }),
    isAvaiLable: joi.boolean().required().allow(1, 0).messages({
      "boolean.base": "Availability must be a boolean value",
      "any.required": "Availability is required",
    }),
    doctorId: joi.number().required().messages({
      "number.base": "Doctor ID must be a number",
      "any.required": "Doctor ID is required",
    }),
    note: joi.string().allow(null),
  }),
};
const deleteClinicsSkd = {
  body: joi.object().keys({
    skdId: joi.number().required().messages({
      "number.base": "Schedule ID must be a number",
      "any.required": "Schedule ID is required",
    }),
  }),
};
module.exports = {
  createClinicsSkd,
  queryClinicsSkdById,
  queryClinicsSkdsByDoctorId,
  queryClinicsSkdsByDayDoctorId,
  queryAvaiLableClinicsSkdsByDoctorId,
  updateClinicsSkd,
  deleteClinicsSkd,
};
