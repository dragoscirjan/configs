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
  {workingDirectory} = {
    workingDirectory: process.cwd(),
  },
) => {
  const spawnOptions = {
    stdio: 'inherit',
    cwd: workingDirectory,
  };
  return new Promise((resolve, reject) => {
    spawn(command, [...args], spawnOptions)
      .on('close', resolve)
      .on('error', reject);
  });
};
