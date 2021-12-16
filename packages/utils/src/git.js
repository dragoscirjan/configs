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

module.exports = async (options = {}) => {
  options = {
    ...base.defaultOptions,
    ...options,
  };
  const {
    logger: {warn},
  } = options;

  if (process.platform === platforms.Windows) {
    return windows(options);
  }

  if (process.platform === platforms.Darwin) {
    return darwin();
  }

  const distro = await base.distro();
  const managers = await base.managers(distro);

  for (const manager of managers) {
    const result = await import(`@dragoscirjan/configs-pm-os/src/linux/${manager}.js`).then(({default: pm}) =>
      pm(['git']),
    );
    if (result.code === 0) {
      return result.code;
    }
    warn(`Failed to install 'git', using ${manager}`);
  }
  return 1;
};
