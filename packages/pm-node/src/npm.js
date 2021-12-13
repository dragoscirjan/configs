const base = require('./base');

module.exports = async (packages = [], workingDirectory = process.cwd(), args = []) =>
  base(
    packages,
    workingDirectory,
    ['npm', 'install', args].filter((c) => c),
  );
