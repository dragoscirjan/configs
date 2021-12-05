const base = require('../base');

const {fetch, status, json} = require('../../fetch');
const {verbose, warn} = require('../../logs');

const headers = {
  Accept: 'application/json',
  'Content-Type': 'application/json',
};

const latestVerNpms = async (packages = []) => {
  verbose(`Interrogating https://api.npms.io for ${JSON.stringify(packages)} versions`);
  return fetch(`https://api.npms.io/v2/package/mget`, {
    method: 'POST',
    body: JSON.stringify(packages),
    headers,
  })
    .then(status(200))
    .then(json)
    .then((info) =>
      Object.keys(info)
        .map((key) => ({[key]: `^${info[key].collected.metadata.version}`}))
        .reduce((a, b) => ({...a, ...b}), {}),
    );
};

const parseNpmjsData = (info) => {
  delete info.time.modified;
  delete info.time.created;
  const latest = Object.values(info.time).sort().pop();
  return {
    [info.name]: `^${Object.keys(info.time)
      .filter((ver) => info.time[ver] === latest)
      .pop()}`,
  };
};

const latestVerNpmjs = async (packages = []) => {
  verbose(`Interrogating https://registry.npmjs.org for ${JSON.stringify(packages)} versions`);
  return Promise.all(
    packages.map((p) =>
      fetch(`https://registry.npmjs.org/${p}`, {
        headers,
      })
        .then(status(200))
        .then(json)
        .then(parseNpmjsData),
    ),
  );
};

const latestVersions = async (packages = []) => {
  verbose(`Interrogating ${JSON.stringify(packages)} versions`);
  let versions = [];
  try {
    versions = await latestVerNpms(packages);
  } catch (e) {
    warn('Could not interrogate https://api.npms.io; turning to https://registry.npmjs.org');
    versions = await latestVerNpmjs(packages);
  }
  return Object.keys(versions).map((key) => `${key}@${versions[key]}`);
};

/**
 *
 * @param {*} packages
 * @param {*} workingDirectory
 * @param {*} command
 */
module.exports = async (packages = [], workingDirectory = process.cwd(), command = 'install') => {
  const versionedPackages = [];
  let unversionedPackages = [];

  for (const p of packages) {
    if (/.+@.+/.test(p)) {
      versionedPackages.push(p);
    } else {
      unversionedPackages.push(p);
    }
  }
  unversionedPackages = await latestVersions(unversionedPackages);

  return base(command, [...versionedPackages, ...unversionedPackages], workingDirectory);
};
