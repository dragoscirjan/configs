// const Lang = require('..');

const base = require('@dragoscirjan/configs-pm-os/src/linux/base');
const {http, platforms} = require('@dragoscirjan/configs-pm-os');
const {fetch, status, text, toFile} = require('@dragoscirjan/configs-fetch');
const shell = require('@dragoscirjan/configs-shell-run');

/**
 * @type {Lang.Node.Options}
 */
const defaultOptions = {
  ...base.defaultOptions,
  useNvm: true,
  version: 'latest',
};

/**
 * @returns {Promise<shell.Result>}
 */
const darwinInstall = () => {
  error('We do not support individual NodeJs install on MacOS. Please refer to `useNvm` argument');
  return {code: 1};
};

/**
 * @returns {Promise<string>}
 */
const nodeLatestVersion = async () =>
  fetch('https://nodejs.org/dist')
    .then(status(200))
    .then(text)
    .then((body) => [...new Set(body.match(/latest-v\d+.x/gi))])
    .then((strings) => strings.map((v) => v.match(/\d+/)[0]).map((str) => parseInt(str)))
    .then((numbers) => numbers.sort((a, b) => (a < b ? -1 : a > b ? 1 : 0)))
    .then((versions) => versions.pop());

/**
 *
 * @param {string} version
 * @returns {Promise<string>}
 */
const nodeLatestVersionBy = async (version) =>
  fetch('https://nodejs.org/dist')
    .then(status(200))
    .then(text)
    .then((body) => [...new Set(body.match(new RegExp(`>(node-)?v${version}[^<]+`, 'gi')))])
    .then((strings) => strings.map((s) => s.match(/\d+\.\d+\.\d+/i)[0]))
    .then((versions) => versions.sort(require('semver/functions/compare')))
    .then((versions) => versions.pop());

/**
 * @link https://github.com/nodesource/distributions
 * @param {Lang.Node.Options} options
 * @returns {Promise<shell.Result>}
 */
const nodeSourceInstall = async (tempPath, options) => {
  await shell('bash', [tempPath], options);
  await shell('node', ['--version'], options);
  return shell('npm', ['--version'], options);
};

/**
 * @param {Lang.Node.Options} options
 * @returns {Promise<shell.Result>}
 */
const nodeSourceParse = (options) => {
  let {version} = options;
  return http([`https://deb.nodesource.com/setup_${version.split('.').shift()}.x`], {
    callback: nodeSourceInstall,
  });
};

/**
 * @param {Lang.Node.Options} options
 * @returns {Promise<shell.Result>}
 */
const nvmInstall = async (options) => {
  const {version} = options;

  const {code} = await require('./nvm')();
  if (code !== 0) {
    return code;
  }

  const commands = [`nvm install ${version}`, `nvm use ${version}`, `node --version`, `npm --version`].join('; ');

  if (process.platform === platforms.Windows) {
    return shell('powershell', ['-Command', commands], options);
  }

  const nvmSh = path.join(process.env.HOME, '.nvm', 'nvm.sh');

  return shell('bash', ['-c', `. ${nvmSh}; ${commands}`], options);
};

/**
 * @param {Lang.Node.Options} options
 * @returns {Promise<shell.Result>}
 */
const windowsInstallerDownload = async () => {
  return fetch('https://nodejs.org/dist/v17.3.0/node-v17.3.0-x64.msi')
    .then(status(200))
    .then((x) => {
      console.log(x);
      return x;
    });
};

/**
 * @param {Lang.Node.Options} options
 * @returns {Promise<shell.Result>}
 */
const windowsInstall = (options) => {
  // let versionChunk = 'latest';
  // if (version) {
  //   if (version.split('.').length > 1) {
  //     versionChunk = `v${version}`;
  //   } else {
  //     versionChunk = `latest-v${version}.x`;
  //   }
  // }
};

/**
 * @param {Lang.Node.Options} options
 * @returns {Lang.Node.Options}
 */
const buildOptions = async (options) => {
  options = {
    ...defaultOptions,
    ...options,
  };

  const {
    logger: {info},
  } = options;

  if (options.version.toLowerCase() === 'latest') {
    info('Determining node latest version.');
    options.version = await nodeLatestVersion();
    options.version = `${options.version}`;
    info(options.version);
  }

  if (options.version.split('.').length < 3) {
    info(`Determining node latest version for partial: ${options.version}`);
    options.version = await nodeLatestVersionBy(options.version);
    info(options.version);
  }

  return options;
};

/**
 *
 * @param {Lang.Node.Options} options
 * @returns {Promise<shell.Result>}
 */
module.exports = async (options = {}) => {
  const {
    logger: {error},
    useNvm,
  } = await buildOptions(options);

  if (useNvm) {
    return nvmInstall(options);
  }

  if (process.platform === platforms.Windows) {
    return windowsInstall(options);
  }

  if (process.platform === platforms.Darwin) {
    return darwinInstall();
  }

  const distro = await base.distro();

  if (['centos', 'debian', 'fedora', 'mint', 'oracle', 'rhel', 'ubuntu'].includes(distro)) {
    return nodeSourceParse(options);
  }

  // TODO: continue here from https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
  error(
    `Did not write the ${distro} version yet. Please read https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions and contribute`,
  );
};
