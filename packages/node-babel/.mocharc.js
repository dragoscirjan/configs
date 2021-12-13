// .mocharc.js

const mochaConfig = require('../../.mocharc');

module.exports = {
  ...mochaConfig,
  require: ['@babel/register', ...mochaConfig.require],
};
