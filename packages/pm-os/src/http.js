const path = require('path');
const url = require('url');

const base = require('./base');

const {fetch, status, text, toFile} = require('@dragoscirjan/configs-fetch');

const defaultOptions = {
  ...base.defaultOptions,
  callback: () => {},
};

/**
 *
 * @param {string | [string, callback|regexp?]} package
 * @param {*} options
 * @returns
 */
module.exports = async (package, options = {}) => {
  const {callback} = options;
  if (typeof package === 'string') {
    package = [package];
  }

  const stringUrl =
    package.length > 1
      ? await fetch(package[0])
          .then(status(200, 301))
          .then(text)
          .then((body) => (typeof package[1] === 'function' ? package[1](body) : body.match(package[1]).pop()))
      : package[0];

  const parsedUrl = url.parse(stringUrl);
  const fileName = path.basename(parsedUrl.pathname);
  const tempPath = path.join('/tmp', fileName);

  await fetch(stringUrl).then(status(200, 301)).then(toFile(tempPath));

  const result = await callback(tempPath, options);

  fs.unlinkSync(tempPath);

  return result;
};
