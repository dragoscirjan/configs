const base = require('./base');

module.exports = (packages = []) => base('emerge', [...packages], {requireRoot: true});
