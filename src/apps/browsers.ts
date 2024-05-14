import {
  Apps,
  createAptGetInstaller,
  createAptInstaller,
  createBrewInstaller,
  createChocoInstaller,
  createScoopInstaller,
  createWingetInstaller,
} from '../lib/installer';

const browsers: Apps = [
  {
    name: 'arc',
    installers: [
      createBrewInstaller(['arc'], ['--cask'])
      //
    ],
  },
  {
    name: 'brave',
    installers: [
      createBrewInstaller(['brave-browser'], ['--cask']),
      createChocoInstaller(['brave']),
      createScoopInstaller(['extras/brave']),
      createWingetInstaller(['Brave.Brave'])
    ],
  },
  {
    name: 'chrome',
    installers: [
      createBrewInstaller(['google-chrome'], ['--cask']),
      createChocoInstaller(['googlechrome']),
      createScoopInstaller(['extras/googlechrome']),
      createWingetInstaller(['Google.Chrome'])
    ],
  },
  {
    name: 'chromium',
    installers: [
      createBrewInstaller(['chromium'], ['--cask']),
      createChocoInstaller(['chromium']),
      createScoopInstaller(['extras/chromium']),
      createWingetInstaller(['Hibbiki.Chromium'])
    ],
  },
  {
    name: 'edge',
    installers: [
      createBrewInstaller(['microsoft-edge'], ['--cask']),
      createChocoInstaller(['microsoft-edge']),
      createWingetInstaller(['Microsoft.Edge'])
    ],
  },
  {
    name: 'firefox',
    installers: [
      createAptInstaller(['firefox']),
      createAptGetInstaller(['firefox']),

      createBrewInstaller(['firefox']),
      createChocoInstaller(['firefox']),
      createScoopInstaller(['extras/firefox']),
      createWingetInstaller(['Mozilla.Firefox'])
    ],
  },
  {
    name: 'opera',
    installers: [
      createBrewInstaller(['opera'], ['--cask']),
      createChocoInstaller(['opera']),
      createScoopInstaller(['extras/opera']),
      createWingetInstaller(['Opera.Opera'])
    ],
  },
  {
    name: 'vivaldi',
    installers: [
      createBrewInstaller(['vivaldi'], ['--cask']),
      createChocoInstaller(['vivaldi']),
      createScoopInstaller(['extras/vivaldi']),
      createWingetInstaller(['VivaldiTechnologies.Vivaldi'])
    ],
  },
];

export default browsers;
