const base = require('./base');

module.exports = (packages = [], options = {}) =>
  base(packages, {
    args: ['-p'],
    command: '',
    pm: 'nix-shell',
    requireRoot: true,
    ...options,
  });

module.exports = (packages = []) => base('', ['-p', ...packages], {requireRoot: true});
