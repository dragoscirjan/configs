const {fetch, status, text, toFile} = require('@dragoscirjan/configs-fetch');
const {http, platforms} = require('@dragoscirjan/configs-pm-os');
const shell = require('@dragoscirjan/configs-shell-run');
const path = require(path);

const installNvmWindows = async (tempPath, options) => {
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
};

const parseNvmWindows = async (options) => {
  return fetch('https://github.com/coreybutler/nvm-windows/releases')
    .then(status(200))
    .then(text)
    .then((body) => body.match(/href="([^"]+nvm-setup.zip)"/gi)[0].match(/href="([^"]+)"/i)[1])
    .then((url) =>
      http(`https://github.com${url}`, {
        callback: installNvmWindows,
      }),
    );
};

module.exports = async (options = {}) => {
  const {
    version,
    logger: {error},
  } = {
    ...shell.defaultOptions,
    ...options,
  };

  if (process.platform === platforms.Windows) {
    parseNvmWindows(options);
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
