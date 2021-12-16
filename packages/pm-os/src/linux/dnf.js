const base = require('./base');

module.exports = (packages = [], options = {}) =>
  base(packages, {
    args: ['-y', '-f'],
    command: 'install',
    pm: 'dnf',
    sudo: true,
    ...options,
  });
