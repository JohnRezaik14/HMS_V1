const Sequelize = require("sequelize");
const sequelize = new Sequelize("hospital_2", "Node", "123456789*", {
  dialect: "mysql",
  host: "localhost",
  define: {
    freezeTableName: true,
  },
});

module.exports = sequelize;
