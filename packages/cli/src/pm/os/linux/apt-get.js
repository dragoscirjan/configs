const base = require('./base');

module.exports = (packages = []) => base(['apt-get'], ['install', '-y', ...packages], {requireRoot: true});
