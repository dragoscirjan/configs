const {createWriteStream} = require('fs');
const path = require('path');
const {pipeline} = require('stream');
const url = require('url');
const {promisify} = require('util');

const base = require('./base');

const {fetch, status, text} = require('@dragoscirjan/configs-fetch');

const defaultOptions = {
  ...base.defaultOptions,
  callback: () => {},
};

module.exports = (packages = [], options = {}) => {
  const {callback} = options;

  return Promise.all(
    packages.map(async (package) => {
      const stringUrl = await fetch(package[0])
        .then(status(200, 301))
        .then(text)
        .then((body) => (typeof package[1] === 'function' ? package[1](body) : body.match(package[1]).pop()));

      const parsedUrl = url.parse(stringUrl);
      const fileName = path.basename(parsedUrl.pathname);
      const tempPath = path.join('/tmp', fileName);

      const streamPipeline = promisify(pipeline);
      const res = await fetch(stringUrl).then(status(200, 301));
      await streamPipeline(res.body, createWriteStream(tempPath));

      const result = callback([tempPath], options);

      fs.unlinkSync(tempPath);

      return result;
    }),
  );
};
// base(packages, {
//   args: ['-i'],
//   command: '',
//   pm: 'dpkg',
//   requireRoot: true,
//   ...options,
// });
