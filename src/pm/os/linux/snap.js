const base = require('./base');

module.exports = (packages = []) => base('snap', ['install', ...packages], {requireRoot: true});
