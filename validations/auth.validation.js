const Joi = require("joi");
const { password } = require("./custom.validation");
const register = {
  body: Joi.object().keys({
    email: Joi.string().required().email().messages({
      "string.email": "Email must be a valid email",
    }),
    password: Joi.string().required().custom(password).messages({
      "string.pattern.base":
        "Password must have at least one number and one character",
    }),
    username: Joi.string(),
    role: Joi.string().required().messages({
      "string.pattern.base":
        "Username must be either admin, doctor or patient",
    }).valid("admin", "doctor", "patient"),
  }),
};
const login = {
  body: Joi.object().keys({
    email: Joi.string().required().email().messages({
      "string.email": "Email must be a valid email",
    }),
    password: Joi.string().required().messages({
      "string.pattern.base":
        "Password must have at least one number and one character",
    }),
  }),
};
const logout = {
  body: Joi.object().keys({
    refreshToken: Joi.string().required(),
  }),
};
const refreshTokens = {
  body: Joi.object().keys({
    refreshToken: Joi.string().required(),
  }),
};
const forgotPassword = {
  body: Joi.object().keys({
    email: Joi.string().email().required(),
  }),
};
const resetPassword = {
  query: Joi.object().keys({
    token: Joi.string().required(),
  }),
  body: Joi.object().keys({
    password: Joi.string().required().custom(password),
  }),
};
const verifyEmail = {
  query: Joi.object().keys({
    token: Joi.string().required(),
  }),
};
module.exports = {
  register,
  login,
  logout,
  refreshTokens,
  forgotPassword,
  resetPassword,
  verifyEmail,
};
