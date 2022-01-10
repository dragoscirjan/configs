const {bashrc, http, platforms} = require('@dragoscirjan/configs-pm-os');
const shell = require('@dragoscirjan/configs-shell-run');
const path = require('path');

const windowsInstall = async (tempPath, options) => shell('powershell', ['-File', tempPath], options);

const nixInstall = async (tempPath, options) => shell('bash', [tempPath], options);

/**
 * @link https://deno.land/#installation
 * @param {shell.Options} options
 * @returns {shell.Result}
 */
module.exports = async (options = {}) => {
  options = {
    ...shell.defaultOptions,
    ...options,
  };

  if (process.platform === platforms.Windows) {
    return http('https://deno.land/install.ps1', {
      ...options,
      callback: windowsInstall,
    });
  }

  const result = await http('https://deno.land/install.sh', {
    ...options,
    callback: nixInstall,
  });

  if (result.code === 0) {
    bashrc(
      `export DENO_INSTALL="/home/dragosc/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"`,
      options,
    );
  }

  return result;
};
