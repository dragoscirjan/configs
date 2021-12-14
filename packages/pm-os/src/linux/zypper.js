const base = require('./base');

module.exports = (packages = [], options = {}) =>
  base(packages, {
    args: ['-n'],
    command: 'install',
    pm: 'zypper',
    requireRoot: true,
    ...options,
  });

module.exports = (packages = []) => base('zypper', ['-n', 'install', ...packages], {requireRoot: true});
