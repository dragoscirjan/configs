const base = require('./base');

module.exports = (packages = [], options = {}) =>
  base(packages, {
    args: ['-n'],
    command: 'install',
    pm: 'zypper',
    sudo: true,
    ...options,
  });

module.exports = (packages = []) => base('zypper', ['-n', 'install', ...packages], {sudo: true});
