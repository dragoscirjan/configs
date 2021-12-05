const base = require('./base');

module.exports = (packages = []) => base('nix-shell', ['-p', ...packages], {requireRoot: true});
