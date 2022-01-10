const base = require('./base');

module.exports = (packages = []) => base(['apt'], ['install', '-y', ...packages], {requireRoot: true});
