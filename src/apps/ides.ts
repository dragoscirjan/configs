import {platform} from 'os';
import {Apps, createBrewInstaller, installMultiple, installSingle} from '../lib/installer';
import langsList from './langs';
import {which} from '../lib/spawn';
import {logger} from '../lib/logger';

const installNeovimDependencies = async (update?: boolean): Promise<void> => {
  try {
    await which('clang');
  } catch (e) {
    logger.warn('clang not found, installing clang');
    await installSingle(langsList.filter((item) => item.name === 'clang')?.[0], update);
  }

  logger.warn('installing ripgrep and/or fd');
  await installMultiple([{name: 'deps', installers: [createBrewInstaller(['fd', 'ripgrep'])]}], update);
  await installMultiple([{name: 'deps', installers: [createBrewInstaller(['wget'])]}], update);
};

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
    installers: [
      {
        platform: 'custom',
        spawn: async (_update?: boolean): Promise<void> => {
          throw new Error('Not implemented');
        },
      },
    ],
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
        spawn: async (update?: boolean): Promise<void> => {
          // nerdfont
          await installNeovimDependencies(update);
          // neovim
          await installSingle(
            {
              name: 'neovim',
              installers: [
                createBrewInstaller(['neovim', 'neovim-qt']),
                //
              ],
            },
            update,
          );

          switch (platform()) {
            case 'linux':
              throw new Error('Not implemented');
            case 'darwin':
              return;
            case 'win32':
              throw new Error('Not implemented');
            default:
              throw new Error('Not implemented');
          }
        },
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
