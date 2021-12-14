const base = require('./base');

module.exports = (packages = [], options = {}) =>
  base(packages, {
    args: ['-y', '-f'],
    command: 'install',
    pm: 'apt',
    requireRoot: true,
    ...options,
  });
