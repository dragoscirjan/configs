const {spawn} = require('child_process');
const logger = require('@dragoscirjan/configs-logger');

const defaultOptions = {
  catchOutput: false,
  dryRun: false,
  logger,
  workingDirectory: process.cwd(),
};

const pspawn = (command, args, spawnOptions, catchOutput) => {
  let stderr = '';
  let stdout = '';

  return new Promise((resolve, reject) => {
    const child = spawn(command, [...args], spawnOptions)
      .on('close', (code) => resolve({code, stderr, stdout}))
      .on('error', (code) => reject({code, stderr, stdout}));

    if (catchOutput) {
      child.stdout.on('data', (data) => {
        stdout += data.toString('utf-8');
      });
      child.stderr.on('data', (data) => {
        stderr += data.toString('utf-8');
      });
    }
  });
};

/**
 *
 * @param {string[]} command
 * @param {string[]} args
 * @param {string} workingDirectory
 * @returns {Promise<number>}
 */
module.exports = async (command, args = [], options = {}) => {
  const {
    catchOutput,
    dryRun,
    logger: {debug},
    workingDirectory,
  } = {
    ...defaultOptions,
    ...options,
  };

  debug(`${command} ${args.join(' ')} ; #${JSON.stringify(options)}`);

  const spawnOptions = {
    cwd: workingDirectory,
    ...(!catchOutput ? {stdio: 'inherit'} : {}),
  };

  if (dryRun) {
    return [command, ...args].join(' ');
  }

  return pspawn(command, args, spawnOptions, catchOutput);
};

module.exports.defaultOptions = defaultOptions;
