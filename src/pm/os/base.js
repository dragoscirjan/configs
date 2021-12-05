const base = require('../base');

/**
 * @link https://nodejs.org/api/process.html#processplatform
 */
const platforms = {
  AIX: 'aix',
  Darwin: 'darwin',
  FreeBSD: 'freebsd',
  Linux: 'linux',
  OpenBSD: 'openbsd',
  SunOS: 'sunos',
  Windows: 'win32',
};

module.exports = (...args) => base(...args);

module.exports.platforms = platforms;
