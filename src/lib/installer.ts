import {runPlatformInstaller, which} from './spawn';
import {platform} from 'os';
import {logger} from './logger';

export type App = {
  name: string;
  installers: Installer[];
};

export type Apps = App[];

export type Installer = {
  platform: 'custom' | 'darwin' | 'linux' | 'win32';
  spawn: (update?: boolean) => Promise<any>;
};

export const createAptInstaller = (packages: string[], args?: string[]): Installer => ({
  platform: 'linux',
  spawn: async (update?: boolean) => {
    const binary = await which('apt');
    return runPlatformInstaller([
      'sudo',
      binary,
      'install',
      ...(update ? ['--only-upgrade'] : []),
      '-yf',
      ...packages,
      ...(args ?? []),
    ]);
  },
});

export const createAptGetInstaller = (packages: string[], args?: string[]): Installer => ({
  platform: 'linux',
  spawn: async (update?: boolean) => {
    const binary = await which('apt-get');
    return runPlatformInstaller(['sudo', binary, ...(update ? [] : ['install', '-yf']), ...packages, ...(args ?? [])]);
  },
});

export const createBrewInstaller = (packages: string[], args?: string[]): Installer => ({
  platform: 'darwin',
  spawn: async (update?: boolean) => {
    const binary = await which('brew');
    try {
      await runPlatformInstaller(
        [binary, `${update ? 're' : ''}install`, '--force', ...packages, ...(args ?? [])],
        true,
      );
    } catch (e) {
      if (update) {
        logger.warn(`brew install failed, trying to upgrade ${packages.join(' ')}`);
        // await spawn([binary, 'upgrade', ...packages, ...(args ?? [])], {stdio: 'inherit'});
        await runPlatformInstaller([binary, 'uninstall', ...packages]);
        await runPlatformInstaller([binary, 'install', ...(update ? ['--force'] : []), ...packages, ...(args ?? [])]);
      } else {
        throw e;
      }
    }
  },
});

export const createChocoInstaller = (packages: string[], args?: string[]): Installer => ({
  platform: 'win32',
  spawn: async (update?: boolean) => {
    let index = 0;
    const binary = await which('choco');
    for (const item of packages) {
      await runPlatformInstaller([binary, 'install', ...(update ? ['--force'] : []), ...(args ?? []), item]);
      index++;
    }
  },
});

export const installSingle = async (app: App, update?: boolean): Promise<void> => {
  const osInstallers = app.installers.filter((installer) => installer.platform === platform());
  if (osInstallers.length > 0) {
    for (const installer of osInstallers) {
      try {
        return installer.spawn(update);
      } catch (e) {
        // TODO: log error and info
      }
    }
  } else {
    const customInstaller = app.installers.find((installer) => installer.platform === 'custom');
    if (customInstaller) {
      return customInstaller.spawn(update);
    }
  }
};

export const installMultiple = async (apps: Apps, update?: boolean): Promise<void> => {
  for (const app of apps) {
    await installSingle(app, update);
  }
};
