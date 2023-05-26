const findAllByOne = (model, key, value) => {
    // const { model } = require("../models");
    const { Op, STRING } = require("sequelize");
  const doctors =  model.findAll({
        where: {
            [key]: value,
        },
    });
    return doctors;
};
module.exports = {
    findAllByOne,
};