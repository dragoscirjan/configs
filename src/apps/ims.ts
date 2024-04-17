import {Apps, createBrewInstaller} from '../lib/installer';

const ims: Apps = [
  {
    name: 'dircord',
    installers: [
      createBrewInstaller(['discord'], ['--cask']),
      //
    ],
  },
  {
    name: 'ferdium',
    installers: [
      createBrewInstaller(['ferdium'], ['--cask']),
      //
    ],
  },
  {
    name: 'rocket',
    installers: [
      createBrewInstaller(['rocket-chat'], ['--cask']),
      //
    ],
  },
  {
    name: 'slack',
    installers: [
      createBrewInstaller(['slack'], ['--cask']),
      //
    ],
  },
  {
    name: 'teams',
    installers: [
      createBrewInstaller(['microsoft-teams'], ['--cask']),
      //
    ],
  },
];

export default ims;
