const base = require('./base');

module.exports = (packages = []) => base('zypper', ['-n', 'install', ...packages], {requireRoot: true});
