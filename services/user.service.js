const httpStatus = require("http-status");
const { User } = require("../models");
const ApiError = require("../utils/ApiError");
const express = require("express");
const bcrypt = require("bcryptjs");
const saltRounds = 10;
/**
 * Create a user
 * @param {Object} userBody
 * @returns {Promise<User>}
 */
const createUser = async (userBody) => {
  let password = userBody.password;
  const role = userBody.role;
  const email = userBody.email;
  if (email == undefined) {
    throw new ApiError(httpStatus.BAD_REQUEST, "email is undefined");
  }
  if (await User.isEmailTaken(email)) {
    throw new ApiError(httpStatus.BAD_REQUEST, "Email already taken");
  }
  const hash = await bcrypt.hash(password, saltRounds);
  // console.log(password + " " + hash + " " + email + " user service 24");
  // console.log(email + " " + password + " " + role + " user service 25");
  
  return await User.create({
    email: email,
    password: hash,
    role: role,
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
  const { rows, count } = await User.findAndCountAll({
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
const getUserById = async (userId) => {
  const user = await User.findByPk(userId);
  return user;
};

/**
 * Get user by email
 * @param {string} email
 * @returns {Promise<User>}
 */
const getUserByEmail = async (email) => {

  return User.findOne({
    where: {
      email: email,
    }
  });
};
/**
 * Update user by id
 * @param {ObjectId} userId
 * @param {Object} updateBody
 * @returns {Promise<User>}
 */
const updateUserById = async (userId, updateBody) => {
  const user = await getUserById(userId);
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
const isPasswordMatch = async (email, password) => {
  const user = await getUserByEmail(email);
  const hash =  user.password;

  // console.log(user + " " + "user service 136");
  // console.log(hash + " " + password + " " + "user service 137");
  // console.log(
  //   await bcrypt.compare(
  //     "1234567B",
  //     "$2a$10$HplwFSxEyymxo1hVeqFQR.zar4oyl7iqoiXxJ6Sl5xdZ9PHlfYy.C"
  //   )
  // );
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
