const base = require('./base');

module.exports = (packages = []) => base('yum', ['install', '-y', ...packages], {requireRoot: true});
