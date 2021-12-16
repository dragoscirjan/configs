const {http, platforms} = require('@dragoscirjan/configs-pm-os');
const shell = require('@dragoscirjan/configs-shell-run');

module.exports = async (options = {}) => {
  const {
    version,
    logger: {error},
  } = {
    ...shell.defaultOptions,
    ...options,
  };

  if (process.platform === platforms.Windows) {
    error('Did not write the windows version yet. Please contribute');
    return;
  }

  return http(['https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh'], {
    callback: async (tempPath, options) => {
      const result = await shell('bash', [tempPath], options);
      if (typeof version === 'undefined') {
        return result;
      }

      const nvmSh = path.join(process.env.HOME, '.nvm', 'nvm.sh');

      await shell('bash', ['-c', `. ${nvmSh}; nvm --version`], options);
      await shell('bash', ['-c', `. ${nvmSh}; nvm install ${version}`], options);
      await shell('bash', ['-c', `. ${nvmSh}; nvm use ${version}`], options);
      await shell('bash', ['-c', `. ${nvmSh}; node --version`], options);
      return shell('bash', ['-c', `. ${nvmSh}; npm --version`], options);
    },
  });
};

// require('./src/http')([
//   [
//     'https://github.com/coreybutler/nvm-windows/releases',
//     (body) => {
//       return (
//         'https://github.com/' +
//         body
//           .match(/<a href="([^"]+nvm-setup.zip)"/gi)
//           .shift()
//           .split('href=')[1]
//           .slice(1, -1)
//       );
//     },
//   ],
// ]);
