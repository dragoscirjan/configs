const base = require('./base');

module.exports = (packages = [], options = {}) =>
  base(packages, {
    args: [],
    command: '',
    pm: 'emerge',
    requireRoot: true,
    ...options,
  });
