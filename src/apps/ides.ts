import {Apps, createBrewInstaller} from '../lib/installer';

const ides: Apps = [
  {
    name: 'clion',
    installers: [
      createBrewInstaller(['clion'], ['--cask']),
      //
    ],
  },
  {
    name: 'fleet',
    installers: [{platform: 'custom', spawn: async (_update?: boolean): Promise<void> => {}}],
  },
  {
    name: 'goland',
    installers: [
      createBrewInstaller(['goland'], ['--cask']),
      // ['choco', 'win32', 'brave'],
      // ['scoop', 'win32', 'brave'],
      // ['winget', 'win32', 'brave'],
    ],
  },
  {
    name: 'idea',
    installers: [
      createBrewInstaller(['intellij-idea'], ['--cask']),
      // ['choco', 'win32', 'GoogleChrome'],
      // ['winget', 'win32', 'Google.Chrome'],
    ],
  },
  {
    name: 'idea-ce',
    installers: [
      createBrewInstaller(['intellij-idea-ce'], ['--cask']),
      // ['choco', 'win32', 'chromium'],
      // ['scoop', 'win32', 'chromium'],
      // ['winget', 'win32', 'Hibbiki.Chromium'],
    ],
  },
  {
    name: 'neovim',
    installers: [
      {
        platform: 'custom',
        spawn: async (_update?: boolean): Promise<void> => {},
      },
    ],
  },
  {
    name: 'phpstorm',
    installers: [
      createBrewInstaller(['phpstorm'], ['--cask']),
      // ['choco', 'win32', 'firefox'],
      // ['scoop', 'win32', 'firefox'],
      // ['winget', 'win32', 'firefox'],
    ],
  },
  {
    name: 'pycharm',
    installers: [
      createBrewInstaller(['pycharm'], ['--cask']),
      //
    ],
  },
  {
    name: 'pycharm-ce',
    installers: [
      createBrewInstaller(['pycharm-ce'], ['--cask']),
      //
    ],
  },
  {
    name: 'rider',
    installers: [
      createBrewInstaller(['rider'], ['--cask']),
      //
    ],
  },
  {
    name: 'sublime',
    installers: [
      createBrewInstaller(['sublime-text'], ['--cask']),
      //
    ],
  },
  {
    name: 'vscode',
    installers: [
      createBrewInstaller(['visual-studio-code'], ['--cask']),
      //
    ],
  },
  {
    name: 'webstorm',
    installers: [
      createBrewInstaller(['webstorm'], ['--cask']),
      //
    ],
  },
  {
    name: 'zed',
    installers: [
      createBrewInstaller(['zed'], ['--cask']),
      //
    ],
  },
];

export default ides;
