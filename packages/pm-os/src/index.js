const {platforms} = require('./base');
const http = require('./http');
const apt = require('./linux/apt');

module.exports = {
  apt,
  http,
  platforms,
};
