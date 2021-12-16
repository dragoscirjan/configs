const {spawn} = require('child_process');
const password = require('@inquirer/password');

const logger = require('@dragoscirjan/configs-logger');

let answer = '';

const defaultOptions = {
  catchOutput: false,
  dryRun: false,
  logger,
  sudo: false,
  sudoPwd: '',
  workingDirectory: process.cwd(),
};

const pspawn = (command, args, spawnOptions) => {
  let stderr = '';
  let stdout = '';

  return new Promise((resolve, reject) => {
    const child = spawn(command, [...args], spawnOptions)
      .on('close', (code) => resolve({code, stderr, stdout}))
      .on('error', (code) => reject({code, stderr, stdout}));

    if (spawnOptions.stdio !== 'inherit') {
      child.stdout.on('data', (data) => {
        stdout += data.toString('utf-8');
      });
      child.stderr.on('data', (data) => {
        stderr += data.toString('utf-8');
      });
    }
  });
};

const pspawnDebug = (command, args, options) => {
  const {
    logger: {debug},
    sudo,
  } = options;
  debug(`${command} ${args.join(' ')}`.replace(`"${answer}"`, '"********"'), {
    ...options,
    ...(sudo ? {sudoPwd: '********'} : {}),
    logger: null,
  });
};

const pspawnOptions = (options) => ({
  cwd: options.workingDirectory,
  ...(!options.catchOutput ? {stdio: 'inherit'} : {}),
});

const sudoPassword = async (sudoPwd) => {
  if (sudoPwd) {
    answer = sudoPwd;
  }
  if (!answer) {
    answer = await password({
      message: 'Please provide root password',
      mask: '*',
      name: 'password',
      type: 'password',
    });
  }
};

const wrapSudo = async (command, args = [], options = {}) => {
  const dryRunCmd = await base(command, args, {...options, dryRun: true, sudo: false});

  await sudoPassword(options.sudoPwd);

  console.log(dryRunCmd);

  return {args: ['-c', `echo "${answer}" | sudo -S bash -c "${dryRunCmd}"`], command: 'sh'};
};

/**
 *
 * @param {string[]} command
 * @param {string[]} args
 * @param {string} workingDirectory
 * @returns {Promise<number>}
 */
const base = async (command, args = [], options = {}) => {
  options = {
    ...defaultOptions,
    ...options,
  };
  const {dryRun, sudo} = options;

  ({args, command} = sudo ? await wrapSudo(command, args, options) : {args, command});

  pspawnDebug(command, args, options);

  if (dryRun) {
    return [command, ...args].join(' ');
  }

  return pspawn(command, args, pspawnOptions(options));
};

module.exports = base;
module.exports.defaultOptions = defaultOptions;
