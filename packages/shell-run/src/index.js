const {spawn} = require('child_process');

/**
 *
 * @param {string[]} command
 * @param {string[]} args
 * @param {string} workingDirectory
 * @returns {Promise<number>}
 */
module.exports = async (
  command,
  args = [],
  options = {
    workingDirectory: process.cwd(),
    dryRun: false,
    catchOutput: false,
  },
) => {
  // console.log(command, args, options);
  const {workingDirectory, dryRun, catchOutput} = options;

  let stderr = '';
  let stdout = '';

  const spawnOptions = {
    cwd: workingDirectory,
    ...(!catchOutput ? {stdio: 'inherit'} : {}),
  };

  if (dryRun) {
    return [command, ...args].join(' ');
  }

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
