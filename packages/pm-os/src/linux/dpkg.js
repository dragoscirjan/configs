const base = require('./base');

module.exports = (packages = [], options = {}) =>
  base(packages, {
    args: ['-i'],
    command: '',
    pm: 'dpkg',
    sudo: true,
    ...options,
  });
