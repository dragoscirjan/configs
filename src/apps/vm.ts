import {Apps, createBrewInstaller} from '../lib/installer';

const vms: Apps = [
  {
    name: 'docker',
    installers: [
      createBrewInstaller(['docker', 'docker-completion', 'docker-compose']),
      //
    ],
  },
  {
    name: 'qemu',
    installers: [
      createBrewInstaller(['qemu']),
      //
    ],
  },
  {
    name: 'vagrant',
    installers: [
      createBrewInstaller(['vagrant'], ['--cask']),
      //
    ],
  },
  {
    name: 'virtualbox',
    installers: [
      createBrewInstaller(['virtualbox'], ['--cask']),
      //
    ],
  },
];

export default vms;
