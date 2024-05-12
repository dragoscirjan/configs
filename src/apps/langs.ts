import { platform } from 'os';
import { Apps, createChocoInstaller, createScoopInstaller, createWingetInstaller, installMultiple } from '../lib/installer';
import { createBrewInstaller } from '../lib/installer';
import { githubListReleases } from '../lib/github';
import { logger } from '../lib/logger';
import { runPlatformInstaller, which } from '../lib/spawn';
import { download } from '../lib/axios';

const nvmShInstall = async (_update?: boolean): Promise<void> => {
  logger.info('Installing nvm-sh');

  const version = await githubListReleases('nvm-sh/nvm', {latest: true})
    .then((result: string[]) => result.filter((item) => item))
    .then((result: string[]) => result.pop());
  logger.debug(`Latest NVM version: ${version}`);

  const nvmScript = '/tmp/nvm.sh';

  logger.info(`Downloading installer...`);
  await download(`https://raw.githubusercontent.com/nvm-sh/nvm/v${version}/install.sh`, nvmScript);

  logger.info(`Installing...`);
  const bashBinary = await which('bash');
  await runPlatformInstaller([bashBinary, nvmScript]);

  logger.info('nvm-sh installed');
  logger.info('Open a new terminal and type `nvm --version` to verify the installation');
};

const ims: Apps = [
  {
    name: 'clang',
    installers: [
      createBrewInstaller(['llvm']),
      createChocoInstaller(['llvm']),
      createScoopInstaller(['llvm']),
      createWingetInstaller(['clangd']),
      //
    ],
  },
  {
    name: 'dotnet',
    installers: [
      createBrewInstaller(['dotnet']),
      createChocoInstaller(['dotnetcore']),
      createScoopInstaller(['dotnet-sdk']),
      // TODO: needs periodic check for updates => https://winget.run/search?query=dotnet%20core, https://learn.microsoft.com/en-us/dotnet/core/install/windows?tabs=net80
      createWingetInstaller(['Microsoft.DotNet.SDK.8']),
      //
    ],
  },
  {
    name: 'go',
    installers: [
      createBrewInstaller(['go']),
      createChocoInstaller(['golang']),
      createScoopInstaller(['go']),
      // TODO: needs periodic check for updates => https://winget.run/search?query=go%20lang
      createWingetInstaller(['GoLang.Go.1.20']),
      //
    ],
  },
  {
    name: 'nodejs',
    installers: [
      {
        platform: 'custom',
        name: 'nvm.sh-custom-installer',
        spawn: async (update?: boolean): Promise<void> => {
          if (platform() === 'win32') {
            logger.info('Windows platform has it\'s own installers')
          }

          return nvmShInstall(update);
        },
      },
      createChocoInstaller(['nvm']),
      createScoopInstaller(['nvm']),
      createWingetInstaller(['CoreyButler.NVMforWindows'])
    ],
  },
  {
    name: 'java',
    installers: [
      {
        platform: 'custom',
        name: 'java-custom-installer',
        spawn: async (_update?: boolean): Promise<void> => {
          logger.error('Not implemented');
          process.exit(0);
        },
      },
    ],
  },
  {
    name: 'php',
    installers: [
      createBrewInstaller(['php']),
      createChocoInstaller(['php']),
      createScoopInstaller(['main/php'])
      //
    ],
  },
  {
    name: 'python',
    installers: [
      createBrewInstaller(['python']),
      createChocoInstaller(['python']),
      createScoopInstaller(['main/python']),
      // TODO: needs periodic check for updates => https://winget.run/search?query=python
      createWingetInstaller(['Python.Python.3.11'])
      //
    ],
  },
  {
    name: 'ruby',
    installers: [
      createBrewInstaller(['ruby']),
      createChocoInstaller(['ruby']),
      createScoopInstaller(['main/ruby']),
      // TODO: needs periodic check for updates => https://winget.run/search?query=ruby
      createWingetInstaller(['RubyInstallerTeam.Ruby.3.1'])
      //
    ],
  },
  {
    name: 'rust',
    installers: [
      createBrewInstaller(['rustup-init']),
      createChocoInstaller(['rustup']),
      createScoopInstaller(['main/rustup']),
      createWingetInstaller(['Rustlang.Rustup'])
      //
    ],
  },
  {
    name: 'swift',
    installers: [
      createBrewInstaller(['swift']),
      createScoopInstaller(['main/swift']),
      createWingetInstaller(['Swift.Toolchain'])
      //
    ],
  },
  {
    name: 'zig',
    installers: [
      createBrewInstaller(['zig']),
      createChocoInstaller(['zig']),
      createScoopInstaller(['main/zig'])
      //
    ],
  },
];

export default ims;
