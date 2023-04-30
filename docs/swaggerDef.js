const { version } = require('../../package.json');
const config = require('../config/config');

const swaggerDef = {
  openapi: '3.0.0',
  info: {
    title: 'hms_app',
    version: '1.0.0',
    license: {
      name: 'MIT',
      url: 'https://github.com/JohnRezaik14/HMS_V1/blob/main/LICENSE',
    },
  },
  servers: [
    {
      url: `http://localhost:${config.port}/v1`,
    },
  ],
};

module.exports = swaggerDef;
