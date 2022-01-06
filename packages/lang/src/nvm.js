const Lang = require('..');

const {fetch, status, text} = require('@dragoscirjan/configs-fetch');
const {http, platforms} = require('@dragoscirjan/configs-pm-os');
const shell = require('@dragoscirjan/configs-shell-run');
const path = require('path');

/**
 * @param {string} tempPath
 * @param {shell.Options} options
 * @returns {Promise<shell.Result>}
 */
const windowsInstall = async (tempPath, options) => {
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

/**
 * @param {shell.Options} options
 * @returns {Promise<shell.Result>}
 */
const windowsParse = async (options) => {
  return fetch('https://github.com/coreybutler/nvm-windows/releases')
    .then(status(200))
    .then(text)
    .then((body) => body.match(/href="([^"]+nvm-setup.zip)"/gi)[0].match(/href="([^"]+)"/i)[1])
    .then((url) =>
      http(`https://github.com${url}`, {
        ...options,
        callback: windowsInstall,
      }),
    );
};

/**
 * @param {string} tempPath
 * @param {shell.Options} options
 * @returns {Promise<shell.Result>}
 */
const windowsUnzip = async (tempPath, options) => {};

/**
 * @param {string} tempPath
 * @param {shell.Options} options
 * @returns {Promise<shell.Result>}
 */
const nixInstall = async (tempPath, options) => {
  await shell('bash', [tempPath], options);

  const nvmSh = path.join(process.env.HOME, '.nvm', 'nvm.sh');

  return shell('bash', ['-c', `. ${nvmSh}; nvm --version`], options);
};

/**
 * @param {shell.Options} options
 * @returns {Promise<shell.Result>}
 */
const nixParse = async (options) => {
  const re = 'href="/nvm-sh/nvm/releases/tag/([^"]+)"';
  return fetch('https://github.com/nvm-sh/nvm/releases')
    .then(status(200))
    .then(text)
    .then((body) => body.match(new RegExp(re, 'gi'))[0].match(new RegExp(re, 'i'))[1])
    .then((version) =>
      http([`https://raw.githubusercontent.com/nvm-sh/nvm/${version}/install.sh`], {
        ...options,
        callback: nixInstall,
      }),
    );
};

/**
 * @param {shell.Options} options
 * @returns {Promise<shell.Result>}
 */
module.exports = async (options = {}) => {
  options = {
    ...shell.defaultOptions,
    ...options,
  };

  if (process.platform === platforms.Windows) {
    return windowsParse(options);
  }

  return nixParse(options);
};
