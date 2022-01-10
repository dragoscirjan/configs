const base = require('./base');

module.exports = async (packages = [], workingDirectory = process.cwd(), args = []) =>
  base(
    packages,
    workingDirectory,
    ['yarn', packages.length > 0 ? 'add' : 'install', ...args].filter((c) => c),
  );
