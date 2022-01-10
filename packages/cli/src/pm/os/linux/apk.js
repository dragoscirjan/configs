const base = require('./base');

module.exports = (packages = []) => base(['apk'], ['add', ...packages], {requireRoot: true});
