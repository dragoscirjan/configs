const base = require('./base');

module.exports = async (packages = [], options = {}) =>
  base(packages, {
    ...base.defaultOptions,
    ...options,
  });
