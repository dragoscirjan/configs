import {
  Apps,
  createAptGetInstaller,
  createAptInstaller,
  createBrewInstaller,
  createChocoInstaller,
} from '../lib/installer';

const browsers: Apps = [
  {
    name: 'arc',
    installers: [
      createBrewInstaller(['arc'], ['--cask']),
      //
    ],
  },
  {
    name: 'brave',
    installers: [
      createBrewInstaller(['brave-browser'], ['--cask']),

      createChocoInstaller(['brave']),
      // ['scoop', 'win32', 'brave'],
      // ['winget', 'win32', 'brave'],
    ],
  },
  {
    name: 'chrome',
    installers: [
      createBrewInstaller(['google-chrome'], ['--cask']),
      // ['choco', 'win32', 'GoogleChrome'],
      // ['winget', 'win32', 'Google.Chrome'],
    ],
  },
  {
    name: 'chromium',
    installers: [
      createBrewInstaller(['chromium'], ['--cask']),
      // ['choco', 'win32', 'chromium'],
      // ['scoop', 'win32', 'chromium'],
      // ['winget', 'win32', 'Hibbiki.Chromium'],
    ],
  },
  {
    name: 'edge',
    installers: [
      createBrewInstaller(['microsoft-edge'], ['--cask']),
      // ['choco', 'win32', 'microsoft-edge'],
    ],
  },
  {
    name: 'firefox',
    installers: [
      createAptInstaller(['firefox']),
      createAptGetInstaller(['firefox']),

      createBrewInstaller(['firefox']),

      createChocoInstaller(['firefox']),
    ],
  },
  {
    name: 'opera',
    installers: [
      createBrewInstaller(['opera'], ['--cask']),
      //
    ],
  },
  {
    name: 'vivaldi',
    installers: [
      createBrewInstaller(['vivaldi'], ['--cask']),
      //
    ],
  },
];

export default browsers;
