const base = require('./base');

module.exports = async (packages = [], options = {}) =>
  base(packages, {
    ...base.defaultOptions,
    ...options,
    command: packages.length > 0 ? 'add' : 'install',
    pm: 'pnpm',
  });
