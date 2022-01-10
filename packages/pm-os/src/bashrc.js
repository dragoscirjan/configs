const fs = require('fs');
const path = require('path');

const rcFiles = [path.join(process.env.HOME, '.bash_profile'), path.join(process.env.HOME, '.bashrc')];

/**
 *
 * @param {string} newContent
 * @param {object} options
 */
module.exports = (newContent, options = {}) => {
  const {
    logger: {error},
  } = options;

  const rcFile = rcFiles.find((f) => {
    try {
      const stats = fs.statSync(f);
      if (stats.isFile()) {
        return true;
      }
    } catch (e) {}
    return false;
  });

  if (!rcFile) {
    error('No rc file discovered');
    process.exit(1);
  }

  let content = fs.readFileSync(rcFile, 'utf8').toString();

  if (content.indexOf(newContent.split('\n')[0]) < 0) {
    content = `${content}

${newContent}`;
  }

  fs.writeFileSync(rcFile, content);
};
