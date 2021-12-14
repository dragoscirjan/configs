const base = require('./base');

module.exports = (packages = [], options = {}) =>
  base(packages, {
    args: ['-S', '--noconfirm'],
    command: '',
    pm: 'pacman',
    requireRoot: true,
    ...options,
  });
