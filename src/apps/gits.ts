import {Apps, createBrewInstaller, installSingle} from '../lib/installer';
import {runPlatformInstaller} from '../lib/spawn';

const gitAfterInstall = async () => {
  for (const command of [
    'git config --global color.ui auto',
    'git config --global core.autocrlf false',
    'git config --global core.eol lf',
    'git config --global push.default matching',
  ]) {
    await runPlatformInstaller(command.split(' '));
  }
};

const gits: Apps = [
  {
    name: 'git',
    installers: [
      {
        platform: 'custom',
        name: 'git-custom-installer',
        spawn: async (update?: boolean): Promise<void> => {
          await installSingle(
            {
              name: 'git',
              installers: [createBrewInstaller(['git'], ['--cask'])],
            },
            update,
          );

          await gitAfterInstall();
        },
      },
    ],
  },
  {
    name: 'gitkraken',
    installers: [
      createBrewInstaller(['gitkraken'], ['--cask']),
      //
    ],
  },
  {
    name: 'gh',
    installers: [
      createBrewInstaller(['gh'], ['--cask']),
      //
    ],
  },
];

export default gits;
