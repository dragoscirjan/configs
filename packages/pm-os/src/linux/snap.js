const base = require('./base');

module.exports = (packages = [], options = {}) =>
  base(packages, {
    command: 'install',
    pm: 'snap',
    sudo: true,
    ...options,
  });
