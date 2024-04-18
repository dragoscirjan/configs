import { Command } from 'commander';
import browsersList from './apps/browsers';
import gitsList from './apps/gits';
import idesList from './apps/ides';
import imsList from './apps/ims';
import langsList from './apps/langs';
import officeList from './apps/office';
import sslList from './apps/ssl';
import restList from './apps/rest';
import fontsList from './apps/fonts';
import { App, installMultiple } from './lib/installer';
import { platform } from 'os';

export default function run() {
  const program = new Command();

  /** broswers */
  program
    .command('browsers')
    .description('Install browsers')
    .argument(
      '<string...>',
      `Browsers to install: ${browsersList.map((b: App) => b.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'browsers'),
      [...(platform() !== 'linux' ? ['arc'] : []), 'brave', 'chrome', 'edge', 'firefox'],
    )
    .option('--update', 'Force update to the latest version')
    .action(async (browsers: string[], options: any) => {
      await installMultiple(
        browsersList.filter((item) => browsers.includes(item.name)),
        options.update,
      );
    });

  /** fonts */
  program
    .command('fonts')
    .description('Install fonts')
    .argument(
      '<string...>',
      `Fonts to install: ${fontsList.map((b: App) => b.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'fonts'),
      //[...(platform() !== 'linux' ? ['arc'] : []), 'brave', 'chrome', 'edge', 'firefox'],
    )
    .action(async (fonts: string[], options: any) => {
      await installMultiple(
        fontsList.filter((item) => fonts.includes(item.name)),
        options.update,
      );
    });


  /** gits */
  program
    .command('git')
    .description('Install Git utils')
    .argument(
      '<string...>',
      `Git stuff to install: ${gitsList.map((b: App) => b.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'gits'),
      gitsList.map((b: App) => b.name),
    )
    .option('--update', 'Force update to the latest version')
    .action(async (gits: string[], options: any) => {
      await installMultiple(
        gitsList.filter((item) => gits.includes(item.name)),
        options.update,
      );
    });

  /** ides */
  program
    .command('ides')
    .description('Install IDEs')
    .argument(
      '<string...>',
      `IDEs to install: ${idesList.map((i: App) => i.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'ides'),
      // [
      //   'clion',
      //   'goland',
      //   'idea',
      //   'neovim',
      //   'pycharm',
      //   'sublime',
      //   'vscode',
      //   ...(platform() === 'darwin' ? ['zed'] : []),
      // ],
    )
    .option('--update', 'Force update to the latest version')
    .action(async (ides: string[], options: any) => {
      await installMultiple(
        idesList.filter((item) => ides.includes(item.name)),
        options.update,
      );
    });

  /** ims */
  program
    .command('ims')
    .description('Install Instant Messengers')
    .argument(
      '<string...>',
      `IMs to install: ${imsList.map((i: App) => i.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'ides'),
      ['discord', 'ferdium'],
    )
    .option('--update', 'Force update to the latest version')
    .action(async (ims: string[], options: any) => {
      await installMultiple(
        imsList.filter((item) => ims.includes(item.name)),
        options.update,
      );
    });

  /** langs */
  program
    .command('langs')
    .description('Install Programming Languages')
    .argument(
      '<string...>',
      `Languages to install: ${langsList.map((i: App) => i.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'langs'),
      ['nodejs', 'clang', 'go'],
    )
    .option('--update', 'Force update to the latest version')
    .action(async (langs: string[], options: any) => {
      await installMultiple(
        langsList.filter((item) => langs.includes(item.name)),
        options.update,
      );
    });

  /** office */
  program
    .command('office')
    .description('Install SSL Tools')
    .argument(
      '<string...>',
      `SSL Tools to install: ${officeList.map((i: App) => i.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'office'),
    )
    .option('--update', 'Force update to the latest version')
    .action(async (office: string[], options: any) => {
      await installMultiple(
        officeList.filter((item) => office.includes(item.name)),
        options.update,
      );
    });

  /** rest */
  program
    .command('rest')
    .description('Install Rest Tools')
    .argument(
      '<string...>',
      `Tools to install: ${restList.map((i: App) => i.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'rest'),
      ['postman'],
    )
    .option('--update', 'Force update to the latest version')
    .action(async (rest: string[], options: any) => {
      await installMultiple(
        restList.filter((item) => rest.includes(item.name)),
        options.update,
      );
    });

  /** ssl */
  program
    .command('ssl')
    .description('Install SSL Tools')
    .argument(
      '<string...>',
      `SSL Tools to install: ${sslList.map((i: App) => i.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'ssl'),
    )
    .option('--update', 'Force update to the latest version')
    .action(async (ssl: string[], options: any) => {
      await installMultiple(
        sslList.filter((item) => ssl.includes(item.name)),
        options.update,
      );
    });

  program.parse();
}
