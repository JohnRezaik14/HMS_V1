const Joi = require('joi');
const httpStatus = require('http-status');
const pick = require('../utils/pick');
const ApiError = require('../utils/ApiError');

const validate = (schema) => (req, res, next) => {
  const validSchema = pick(schema, ['params', 'query', 'body']);
  const object = pick(req, Object.keys(validSchema));
  const { value, error } = Joi.compile(validSchema)
    .prefs({ errors: { label: 'key' }, abortEarly: false })
    .validate(object);

  if (error) {
    const errorMessage = error.details.map((details) => details.message).join(', ');
    if (errorMessage) {
      console.log(errorMessage+"in validate.js");
    }
    return next(new ApiError(httpStatus.BAD_REQUEST, errorMessage));
  }
  Object.assign(req, value);
  return next();
};

module.exports = validate;


// **************************************************************************************************


// This code exports a middleware function called validate,
//  which takes in a Joi schema as a parameter and returns a middleware function
//   that can be used to validate the request object.

// The validate middleware function extracts the relevant data from the request object
//  based on the keys of the validSchema object, 
// which is created using the pick utility function
//  from the../ utils / pick module.The validSchema object contains the schema definition for the request parameters, 
// query string parameters, and request body.

// The Joi.compile function is then used to compile the validSchema object into a single validation schema 
// that is used to validate the extracted data from the request object.
// The prefs method is used to set some preferences for the validation,
// such as the format for the error messages and whether to abort on the first validation error or to continue and collect all errors.

// If any validation errors occur, the error message is extracted from the error object and combined into a single string message.
//  The ApiError utility function is used to create a custom error object with a BAD_REQUEST HTTP status code and the error message.

// If validation succeeds, the validated data is assigned to the req object and 
// the middleware calls next() to pass control to the next middleware function in the stack.

// Overall, this middleware function is used to validate incoming requests to ensure 
// that they conform to a specified schema,
//  making it easier to handle requests and respond with appropriate error messages when the request data is incorrect.
