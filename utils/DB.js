const Sequelize = require('sequelize');
const Seq1 = new Sequelize("hospital_2", "Node", "123456789*", { dialect: "mysql", host: "localhost" });

module.exports = Seq1;