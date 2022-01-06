const {platforms} = require('./base');
const bashrc = require('./bashrc');
const http = require('./http');
const apt = require('./linux/apt');

module.exports = {
  apt,
  bashrc,
  http,
  platforms,
};
