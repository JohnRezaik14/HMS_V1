const statusCode = require("http-status");
const pick = require("../utils/pick");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const userService = require("../services");
const parser = require("body-parser");
const createUser = catchAsync(async (req, res) => {
  if (typeof req.body === 'object' && req.body !== null && Object.keys(req.body).length > 0) {
    // req.body is defined properly
    throw new ApiError("body is defined properly");
  } else {
    // req.body is not defined properly
    console.log("body is not defined properly");
  }
  const user = await userService.createUser(req.body);
  res.status(statusCode.CREATED).send(user);
  console.log(req);
});

const getUsers = catchAsync(async (req, res) => {
  const filter = pick(req.query, ["username", "role"]);
  const page = parseInt(req.query.page) || 1;
  const pageSize = parseInt(req.query.pageSize) || 10;
  const result = await userService.queryUsers(filter, page, pageSize);
  res.send(result);
});

const getUser = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.params.userId);
  if (!user) {
    throw new ApiError(statusCode.NOT_FOUND, "User not found");
  }
  res.send(user);
});

const updateUser = catchAsync(async (req, res) => {
  const user = await userService.updateUserById(req.params.userId, req.body);
  res.send(user);
});

const deleteUser = catchAsync(async (req, res) => {
  await userService.deleteUserById(req.params.userId);
  res.status(statusCode.NO_CONTENT).send();
});

const getUserByEmail = catchAsync(async (req, res) => {
  const user = await userService.getUserByEmail(req.params.email);
  if (!user) {
    throw new ApiError(statusCode.NOT_FOUND, "User not found");
  }
  res.send(user);
});
module.exports = {
  createUser,
  getUsers,
  getUser,
  updateUser,
  deleteUser,
  getUserByEmail,
};
