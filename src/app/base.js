const {managers, distro} = require(`../pm/os/${process.platform}/base`);
const {platforms} = require('../pm/os/base');
const logger = require('../logger');

const linuxInstall = async (plist) => {
  const tag = await distro();
  const mlist = await managers(tag);
  let status = 1;
  for (const manager of mlist) {
    for (const packages of plist) {
      status = await require(`../pm/os/${process.platform}/${manager}`)(packages);
      if (status === 0) {
        return status;
      } else {
        logger.warn(`Unable to install ${packages} using ${manager}`);
      }
    }
    if (status === 0) {
      return status;
    }
  }
  return status;
};

/**
 *
 * @param {Array<Array<string>>} plist
 * @returns {Promise<number>}
 */
module.exports = async (plist = []) => {
  if (process.platform === platforms.Linux) {
    return linuxInstall(plist);
  }
  // if (process.platform === platforms.Windows) {}
  // if (process.platform === platforms.Dawrin) {}
  return 10;
};
