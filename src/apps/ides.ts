import {platform} from 'os';
import {Apps, createBrewInstaller, createChocoInstaller, createScoopInstaller, createWingetInstaller, installMultiple, installSingle} from '../lib/installer';
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
      createChocoInstaller(['clion-ide']),
      createScoopInstaller(['extras/clion']),
      createWingetInstaller(['JetBrains.CLion'])
      //
    ],
  },
  {
    name: 'fleet',
    installers: [
      {
        platform: 'custom',
        name: 'fleet-custom-installer',
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
      createChocoInstaller(['goland']),
      createScoopInstaller(['extras/idea-ultimate']),
      createWingetInstaller(['JetBrains.GoLand'])
    ],
  },
  {
    name: 'idea',
    installers: [
      createBrewInstaller(['intellij-idea'], ['--cask']),
      createChocoInstaller(['intellijidea-ultimate']),
      createScoopInstaller(['extras/goland']),
      createWingetInstaller(['JetBrains.IntelliJIDEA.Ultimate'])
    ],
  },
  {
    name: 'idea-ce',
    installers: [
      createBrewInstaller(['intellij-idea-ce'], ['--cask']),
      createChocoInstaller(['intellijidea-community']),
      createScoopInstaller(['extras/idea']),
      createWingetInstaller(['JetBrains.IntelliJIDEA.Community'])
    ],
  },
  {
    name: 'neovim',
    installers: [
      {
        platform: 'custom',
        name: 'neovim-custom-installer',
        spawn: async (update?: boolean): Promise<void> => {
          // nerdfont
          await installNeovimDependencies(update);
          // neovim
          await installSingle(
            {
              name: 'neovim',
              installers: [
                createBrewInstaller(['neovim', 'neovim-qt']),
                createChocoInstaller(['neovim']),
                createScoopInstaller(['main/neovim', 'main/neovim-qt']),
                createWingetInstaller(['Neovim.Neovim'])
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
      createChocoInstaller(['phpstorm']),
      createScoopInstaller(['extras/phpstorm']),
      createWingetInstaller(['JetBrains.PHPStorm'])
    ],
  },
  {
    name: 'pycharm',
    installers: [
      createBrewInstaller(['pycharm'], ['--cask']),
      createChocoInstaller(['pycharm']),
      createScoopInstaller(['extras/pycharm-professional']),
      createWingetInstaller(['JetBrains.PyCharm.Professional'])
    ],
  },
  {
    name: 'pycharm-ce',
    installers: [
      createBrewInstaller(['pycharm-ce'], ['--cask']),
      createChocoInstaller(['pycharm-community']),
      createScoopInstaller(['extras/pycharm']),
      createWingetInstaller(['JetBrains.PyCharm.Community'])
    ],
  },
  {
    name: 'rider',
    installers: [
      createBrewInstaller(['rider'], ['--cask']),
      createChocoInstaller(['jetbrains-rider', 'resharper']),
      createScoopInstaller(['extras/rider', 'main/resharper-clt']),
      createWingetInstaller(['JetBrains.Rider', 'JetBrains.ReSharper'])
    ],
  },
  {
    name: 'rustrover',
    installers: [
      createBrewInstaller(['rustrover'], ['--cask']),
      createChocoInstaller(['rustrover'])
    ],
  },
  {
    name: 'sublime',
    installers: [
      createBrewInstaller(['sublime-text'], ['--cask']),
      createChocoInstaller(['sublimetext4'], ['--pre']),
      createScoopInstaller(['extras/sublime-text']),
      createWingetInstaller(['SublimeHQ.SublimeText.4'])
    ],
  },
  {
    name: 'visual-studio',
    installers: [
      createChocoInstaller(['visualstudio2022community']),
      createWingetInstaller(['Microsoft.VisualStudio.2022.Enterprise.Preview'])
    ],
  },
  {
    name: 'visual-studio-ce',
    installers: [
      createChocoInstaller(['visualstudio2022community']),
      createWingetInstaller(['Microsoft.VisualStudio.2022.Community.Preview'])
    ],
  },
  {
    name: 'vscode',
    installers: [
      createBrewInstaller(['visual-studio-code'], ['--cask']),
      createChocoInstaller(['vscode']),
      createScoopInstaller(['extras/vscode']),
      createWingetInstaller(['Microsoft.VisualStudioCode'])
    ],
  },
  {
    name: 'vscodium',
    installers: [
      createBrewInstaller(['vscodium'], ['--cask']),
      createScoopInstaller(['extras/vscodium']),
      createWingetInstaller(['VSCodium.VSCodium'])
    ],
  },
  {
    name: 'webstorm',
    installers: [
      createBrewInstaller(['webstorm'], ['--cask']),
      createChocoInstaller(['webstorm']),
      createScoopInstaller(['extras/webstorm']),
      createWingetInstaller(['JetBrains.WebStorm'])
    ],
  },
  {
    name: 'zed',
    installers: [
      createBrewInstaller(['zed'], ['--cask']),
    ],
  },
];

export default ides;
