import { platform } from 'os';
import { Apps } from '../lib/installer';
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
      //
    ],
  },
  {
    name: 'dotnet',
    installers: [
      createBrewInstaller(['dotnet']),
      //
    ],
  },
  {
    name: 'go',
    installers: [
      createBrewInstaller(['go']),
      //
    ],
  },
  {
    name: 'nodejs',
    installers: [
      {
        platform: 'custom',
        spawn: async (update?: boolean): Promise<void> => {
          if (platform() === 'win32') {
            throw new Error('Not implemented');
          }

          return nvmShInstall(update);
        },
      },
    ],
  },
  {
    name: 'java',
    installers: [
      {
        platform: 'custom',
        spawn: async (_update?: boolean): Promise<void> => {},
      },
    ],
  },
  {
    name: 'php',
    installers: [
      createBrewInstaller(['php']),
      //
    ],
  },
  {
    name: 'python',
    installers: [
      createBrewInstaller(['python']),
      //
    ],
  },
  {
    name: 'ruby',
    installers: [
      createBrewInstaller(['ruby']),
      //
    ],
  },
  {
    name: 'rust',
    installers: [
      createBrewInstaller(['rust']),
      //
    ],
  },
  {
    name: 'zig',
    installers: [
      createBrewInstaller(['zig']),
      //
    ],
  },
];

export default ims;
