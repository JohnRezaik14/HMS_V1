const httpStatus = require("http-status");
const { User } = require("../models");
const ApiError = require("../utils/ApiError");
const express = require("express");
const bcrypt = require("bcryptjs");
const saltRounds = 10;
const sequelize = require("sequelize");
/**
 * Create a user
 * @param {Object} userBody
 * @returns {Promise<User>}
 */
const createUser = async (userBody) => {
  let password = userBody.password;

  const email = userBody.email;
  if (email == undefined) {
    throw new ApiError(httpStatus.BAD_REQUEST, "email is undefined");
  }
  if (await User.isEmailTaken(email)) {
    throw new ApiError(httpStatus.BAD_REQUEST, "Email already taken");
  }
  const hash = await bcrypt.hash(password, saltRounds);

  return User.create({
    email: userBody.email,
    password: hash,
  });
};

/**
 * Query for users
 * @param {Object} filter - Mongo filter
 * @param {Object} options - Query options
 * @param {string} [options.sortBy] - Sort option in the format: sortField:(desc|asc)
 * @param {number} [options.limit] - Maximum number of results per page (default = 10)
 * @param {number} [options.page] - Current page (default = 1)
 * @returns {Promise<QueryResult>}
 */
/*
The page and pageSize parameters specify the current page and the number of records to return per page.
The where option is used to filter the records based on the provided filter parameter.
*/
const queryUsers = async (filter, page, pageSize) => {
  const { rows, count } = await user.findAndCountAll({
    where: filter,
    limit: pageSize,
    offset: (page - 1) * pageSize,
  });
  return {
    total: count,
    page: page,
    pageSize: pageSize,
    data: rows,
  };
};

/**
 * Get user by id
 * @param {ObjectId} id
 * @returns {Promise<User>}
 */
const getUserById = async (User_Id) => {
  const user = await User.findByPk(User_Id);
  return user;
};

/**
 * Get user by email
 * @param {string} email
 * @returns {Promise<User>}
 */
const getUserByEmail = async (email) => {
  return User.findOne({
    // attributes: [
    //   [
    //     sequelize.fn(
    //       "max",
    //       sequelize.col("userId", "email", "role", "password")
    //     ),
    //     "userId",
    //     "email",
    //     "role",
    //     "password",
    //   ],
    // ],
    raw: true,
    where: {
      Email: email,
    },
  });
};
/**
 * Update user by id
 * @param {ObjectId} userId
 * @param {Object} updateBody
 * @returns {Promise<User>}
 */
const updateUserById = async (User_Id, updateBody) => {
  const user = await getUserById(User_Id);
  if (!user) {
    throw new ApiError(httpStatus.NOT_FOUND, "User not found");
  }
  //   if (updateBody.Email && (await User.isEmailTaken(updateBody.email, userId))) {
  //     throw new ApiError(httpStatus.BAD_REQUEST, 'Email already taken');
  //     }
  if (
    updateBody.email &&
    (await User.findOne({
      where: { email: updateBody.email, userId: { [Op.ne]: userId } },
    }))
  ) {
    throw new ApiError(httpStatus.BAD_REQUEST, "Email already taken");
  }
  Object.assign(user, updateBody);
  await user.save();
  return user;
};

/**
 * Delete user by id
 * @param {ObjectId} userId
 * @returns {Promise<User>}
 */
const deleteUserById = async (userId) => {
  const user = await findByPk(userId);
  if (!user) {
    throw new ApiError(httpStatus.NOT_FOUND, "User not found");
  }
  await user.destroy();
  return user;
};

const isPasswordMatch = async (email,password) => {
  const user = await getUserByEmail(email);
  const hash = JSON.stringify(user.password);
console.log(hash+" "+password+" "+"user service 137");
  return await bcrypt.compare(password, hash);
};
module.exports = {
  createUser,
  queryUsers,
  getUserById,
  getUserByEmail,
  updateUserById,
  deleteUserById,
  isPasswordMatch,
};
