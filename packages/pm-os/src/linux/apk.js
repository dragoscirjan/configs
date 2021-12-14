const base = require('./base');

module.exports = (packages = [], options = {}) =>
  base(packages, {
    args: [],
    command: 'add',
    pm: 'apk',
    requireRoot: true,
    ...options,
  });
