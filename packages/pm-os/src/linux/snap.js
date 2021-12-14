const base = require('./base');

module.exports = (packages = [], options = {}) =>
  base(packages, {
    command: 'install',
    pm: 'apt',
    requireRoot: true,
    ...options,
  });
