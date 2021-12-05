const base = require('./base');

module.exports = (packages = []) => base('dnf', ['install', '-y', ...packages], {requireRoot: true});
