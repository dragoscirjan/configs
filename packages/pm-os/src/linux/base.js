'use strict';

const {spawn} = require('child_process');
const any = require('promise.any');

const base = require('../base');

const logger = require('../../../logger');

let answer = null;

const defaultOptions = {
  ...base.defaultOptions,
  args: [],
  command: 'install',
  pm: 'apt',
  pwd: '',
  sudo: true,
};

module.exports = async (packages = [], options = {}) => {
  options = {
    ...defaultOptions,
    ...options,
  };
  const {args, command, pm} = options;

  return base(pm, [command, ...args, ...packages], options);
};

module.exports.defaultOptions = defaultOptions;

const managers = {
  apk: 'apk',
  aptGet: 'apt-get',
  apt: 'apt',
  dnf: 'dnf',
  emerge: 'emerge',
  nixShell: 'nix-shell',
  pacman: 'pacman',
  snap: 'snap',
  yum: 'yum',
  zypper: 'zypper',
};

module.exports.managers = managers;

const distros = {
  alpine: {
    match: 'Alpine Linux',
    managers: [managers.apk],
  },
  amazon: {
    match: /Amazon Linux( AMI)?/,
    managers: [managers.yum],
  },
  arch: {
    match: 'Arch Linux',
    managers: [managers.pacman, managers.snap],
  },
  centos: {
    match: 'CentOS Linux',
    managers: [managers.yum],
  },
  debian: {
    match: 'Debian GNU/Linux',
    managers: [managers.aptGet, managers.snap, managers.yum],
  },
  fedora: {
    match: 'Fedora',
    managers: [managers.dnf, managers.snap, managers.yum],
  },
  gentoo: {
    match: 'Gentoo',
    managers: [managers.emerge],
  },
  mint: {
    match: 'Linux Mint',
    managers: [managers.aptGet, managers.snap, managers.yum],
  },
  nix: {
    match: 'NixOS',
    managers: [managers.nixShell],
  },
  oracle: {
    match: 'Oracle Linux Server',
    managers: [managers.dnf, managers.yum],
  },
  rhel: {
    match: 'RHEL Linux',
    managers: [managers.yum],
  },
  suse: {
    match: /openSUSE (Leap|Tumbleweed)/,
    managers: [managers.zipper, managers.snap],
  },
  ubuntu: {
    match: 'Ubuntu',
    managers: [managers.apt, managers.aptGet, managers.snap, managers.yum],
  },
};

module.exports.distros = distros;

const lsbRelease = async () =>
  new Promise((resolve, reject) => {
    let stdout = '';

    const child = spawn('sh', ['-c', 'cat /etc/*release'])
      .on('close', (code) => {
        resolve({stdout, code});
      })
      .on('error', reject);
    child.stdout.on('data', (data) => {
      stdout += data;
    });
  });

module.exports.distro = async () => {
  const lsb = await lsbRelease();
  const distros = module.exports.distros;
  const osKeys = Object.keys(distros).filter((key) =>
    typeof distros[key].match === 'string'
      ? lsb.stdout.indexOf(distros[key].match) > -1
      : distros[key].match.test(lsb.stdout),
  );
  return osKeys.length > 0 ? osKeys.pop() : undefined;
};

const which = async (cmd) =>
  new Promise((resolve, reject) => {
    spawn('which', [cmd.split(' ')[0]])
      .on('close', (code) => (code === 0 ? resolve(cmd) : reject(code)))
      .on('error', reject);
  });

module.exports.managers = async (tag) => {
  return Promise.all(
    distros[tag].managers.map((pm) =>
      which(pm)
        .then((x) => x)
        .catch((e) => null),
    ),
  ).then((list) => list.filter((m) => m !== null));
};
