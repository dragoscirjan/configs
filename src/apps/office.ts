import {Apps, createBrewInstaller} from '../lib/installer';

const office: Apps = [
  {
    name: 'libreoffice',
    installers: [
      createBrewInstaller(['libreoffice'], ['--cask']),
      //
    ],
  },
  {
    name: 'notion',
    installers: [
      createBrewInstaller(['notion'], ['--cask']),
      //
    ],
  },
  {
    name: 'openoffice',
    installers: [
      createBrewInstaller(['openoffice'], ['--cask']),
      //
    ],
  },
  {
    name: 'wpsoffice',
    installers: [
      createBrewInstaller(['wpsoffice'], ['--cask']),
      //
    ],
  },
];

export default office;
