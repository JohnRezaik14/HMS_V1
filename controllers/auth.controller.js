const statusCode = require('http-status');
const catchAsync = require('../utils/catchAsync');
const { authService, userService, tokenService, emailService } = require('../services');
const { User } = require('../models');
const ApiError = require('../utils/ApiError');

const register = catchAsync(async (req, res) => {
  const user = await userService.createUser(req.body);
  // const fullUser = await User.findOne({ where: { email: req.body.email } });
  const tokens = await tokenService.generateAuthTokens(user);
  res.status(statusCode.CREATED).send({ user, tokens,statusCode:201,message:"Account created successfully" });
});

const login = catchAsync(async (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    throw new ApiError(statusCode.BAD_REQUEST, "Email and Password are required");
  } else {
    // console.log(email+" "+password+(typeof password)+" "+"auth.controller.js.19");
  }
  const fullUser = await authService.loginUserWithEmailAndPassword(email, password);
 const user = {
    userId: fullUser.userId,
    email: fullUser.email,
    // username: fullUser.username,
    role: fullUser.role,
  }
  const tokens = await tokenService.generateAuthTokens(user);
  res.send({ user, tokens ,statusCode:200,message:"Logged in successfully"});
});

const logout = catchAsync(async (req, res) => {
  await authService.logout(req.body.refreshToken);
  res.send({statusCode:204,message:"Logged out successfully"});
});

const refreshTokens = catchAsync(async (req, res) => {
  const tokens = await authService.refreshAuth(req.body.refreshToken);
  res.send({ ...tokens,statusCode:200,message:"Refreshed tokens successfully" });
});

// const forgotPassword = catchAsync(async (req, res) => {
//   const resetPasswordToken = await tokenService.generateResetPasswordToken(req.body.email);
//   await emailService.sendResetPasswordEmail(req.body.email, resetPasswordToken);
//   res.status(statusCode.NO_CONTENT,"").send({statusCode:204,message:"Password reset link sent successfully"});
// });

// const resetPassword = catchAsync(async (req, res) => {
//   await authService.resetPassword(req.query.token, req.body.password);
//   res.status(statusCode.NO_CONTENT).send({statusCode:204,message:"Password reset successfully"});
// });

// const sendVerificationEmail = catchAsync(async (req, res) => {
//   const verifyEmailToken = await tokenService.generateVerifyEmailToken(req.user);
//   await emailService.sendVerificationEmail(req.user.email, verifyEmailToken);
//   res.status(statusCode.NO_CONTENT).send({statusCode:204,message:"Verification email sent successfully"});
// });

// const verifyEmail = catchAsync(async (req, res) => {
//   await authService.verifyEmail(req.query.token);
//   res.status(statusCode.NO_CONTENT).send({statusCode:204,message:"Email verified successfully"});
// });

module.exports = {
  register,
  login,
  logout,
  refreshTokens,
  // forgotPassword,
  // resetPassword,
  // sendVerificationEmail,
  // verifyEmail,
};
