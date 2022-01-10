const base = require('./base');

module.exports = (packages = []) => base('pacman', ['-S', '--noconfirm', ...packages], {requireRoot: true});
