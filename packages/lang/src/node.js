const base = require('@dragoscirjan/configs-pm-os/src/linux/base');
const {http, platforms} = require('@dragoscirjan/configs-pm-os');
const shell = require('@dragoscirjan/configs-shell-run');

const darwin = () => {
  error('We do not support individual NodeJs install on MacOS. Please refer to nvm installer');
  return 1;
};

const windows = (options) => {
  // let versionChunk = 'latest';
  // if (version) {
  //   if (version.split('.').length > 1) {
  //     versionChunk = `v${version}`;
  //   } else {
  //     versionChunk = `latest-v${version}.x`;
  //   }
  // }
  error('Did not write the windows version yet. Please contribute');
};

/**
 * @link https://github.com/nodesource/distributions
 * @param {{}} options
 * @returns
 */
const nodeSource = async (options) => {
  let {version} = options;
  return http([`https://deb.nodesource.com/setup_${version.split('.').shift()}.x`], {
    callback: async (tempPath, opts) => {
      if (typeof version === 'undefined') {
        version = '16';
      }

      await shell('bash', [tempPath], opts);
      await shell('node', ['--version'], opts);
      return shell('npm', ['--version'], opts);
    },
  });
};

module.exports = async (options = {}) => {
  options = {
    ...base.defaultOptions,
    ...options,
  };
  const {
    logger: {error},
  } = options;

  if (process.platform === platforms.Windows) {
    return windows(options);
  }

  if (process.platform === platforms.Darwin) {
    return darwin();
  }

  const distro = await base.distro();

  if (['centos', 'debian', 'fedora', 'mint', 'oracle', 'rhel', 'ubuntu'].includes(distro)) {
    return nodeSource(options);
  }

  // TODO: continue here from https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
  error(
    `Did not write the ${distro} version yet. Please read https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions and contribute`,
  );
};
