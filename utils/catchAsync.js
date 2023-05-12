const catchAsync = (fn) => (req, res, next) => {
    Promise.resolve(fn(req, res, next)).catch((err) => next(err));
  };
  
module.exports = catchAsync;
// catchAsync is a utility function that is used to handle errors in asynchronous functions.
// It is commonly used in Express.
// js middleware to catch any errors that occur during the execution of asynchronous route handlers. 
// The purpose of catchAsync is to avoid repetitive error handling code in each individual route handler.